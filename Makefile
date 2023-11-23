.PHONY: help
help: 
	@echo "Supported commands"
	@echo "1. make drop-packets"
	@echo "2. make drop-packets-process"

.PHONY: drop-packets
drop-packets: generate drop-packets-build

.PHONY: drop-packets-process
drop-packets-process: generate drop-packets-process-build

generate: 
	go generate ./...

drop-packets-build:
	go build -o ./cmd/drop_packets/drop-4040-packets ./cmd/drop_packets/...

drop-packets-process-build:
	go build -o ./cmd/drop_packets_process_filter/drop-packets-process ./cmd/drop_packets_process_filter/...

.PHONY: test
test:
	clang -S -g -target bpf -I./libbpf/src -Wall -Werror -O2 -emit-llvm -c -o ./cmd/drop_packets_process_filter/bpf/drop_packets_process_kern.ll ./cmd/drop_packets_process_filter/bpf/drop_packets_process_kern.c
	llc -march=bpf -filetype=obj -O2 -o ./cmd/drop_packets_process_filter/bpf/drop_packets_process_kern.o ./cmd/drop_packets_process_filter/bpf/drop_packets_process_kern.ll
	bpftool net detach xdp dev wlp3s0
	rm -f /sys/fs/bpf/drop_packets_process
	bpftool prog load ./cmd/drop_packets_process_filter/bpf/drop_packets_process_kern.o /sys/fs/bpf/drop_packets_process
	bpftool net attach xdp pinned /sys/fs/bpf/drop_packets_process dev wlp3s0