package main

import (
	"bufio"
	"fmt"
	"log"
	"net"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"time"

	"github.com/cilium/ebpf/link"
)

//go:generate go run github.com/cilium/ebpf/cmd/bpf2go -cc clang -cflags "-O2 -g -Wall -Werror" bpf bpf/drop_packets_process_kern.c -- -I../../libbpf/src

func getRunningProcess() (map[uint16]string, error) {
	// Execute netstat command to get a list of listening ports and associated processes
	cmd := exec.Command("netstat", "-tuln", "-p")
	output, err := cmd.Output()
	if err != nil {
		fmt.Println("Error running netstat:", err)
		return nil, err
	}

	// Parse the output to create a map of ports and processes
	portToProcess := make(map[uint16]string)
	scanner := bufio.NewScanner(strings.NewReader(string(output)))
	for scanner.Scan() {
		line := scanner.Text()
		fields := strings.Fields(line)
		if len(fields) >= 4 && fields[0] == "tcp" {
			// fmt.Println(fields)
			address := strings.Split(fields[3], ":")
			if len(address) < 2 {
				continue
			}
			value, err := strconv.ParseUint(address[1], 16, 16)
			if err != nil {
				continue
			}
			port := uint16(value)
			data := strings.Split(fields[len(fields)-1], "/")
			if len(data) < 2 {
				continue
			}
			process := data[1]
			portToProcess[port] = process
		}
	}

	return portToProcess, nil
}

func main() {
	if len(os.Args) < 2 {
		log.Fatalf("Please specify a network interface")
	}

	// Look up the network interface by name.
	ifaceName := os.Args[1]
	iface, err := net.InterfaceByName(ifaceName)
	if err != nil {
		log.Fatalf("lookup network iface %q: %s", ifaceName, err)
	}

	// Load pre-compiled programs into the kernel.
	objs := bpfObjects{}
	if err := loadBpfObjects(&objs, nil); err != nil {
		log.Fatalf("loading objects: %s", err)
	}
	defer objs.Close()

	// Attach the program.
	l, err := link.AttachXDP(link.XDPOptions{
		Program:   objs.XdpPacketFilterProcessWise,
		Interface: iface.Index,
	})
	if err != nil {
		log.Fatalf("could not attach XDP program: %s", err)
	}
	defer l.Close()

	log.Printf("Attached XDP program to iface %q (index %d)", iface.Name, iface.Index)
	log.Printf("Press Ctrl-C to exit and remove the program")

	// Print the contents map created by xdp code (source IP address -> packet count).
	ticker := time.NewTicker(1 * time.Second)
	defer ticker.Stop()
	for range ticker.C {
		portProcessMap, err := getRunningProcess()
		if err != nil {
			fmt.Printf("error fetching running process, err = %v", err)
			continue
		}

		for port, process := range portProcessMap {
			objs.PortProcessMap.Put(port, process)
		}
		fmt.Println("loadded process in map")
	}
}
