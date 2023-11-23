INTERFACE = ""

.PHONY: help
help:
	@echo "Supported commands:"
	@echo "1. sudo make INTERFACE=\"INTERFACE_NAME\" clean"
	@echo "2. sudo make INTERFACE=\"INTERFACE_NAME\" drop-packets"

.PHONY: drop-packets
drop-packets: build-ll build-object clean load-new

build-ll:
	clang -S -g -target bpf -I../libbpf/src -Wall -Werror -O2 -emit-llvm -c -o drop_packets_kern.ll drop_packets_kern.c

build-object:
	llc -march=bpf -filetype=obj -O2 -o drop_packets_kern.o drop_packets_kern.ll

.PHONY: clean
clean:
	bpftool net detach xdp dev $(INTERFACE)
	rm -f /sys/fs/bpf/drop_packets

load-new:
	bpftool prog load drop_packets_kern.o /sys/fs/bpf/drop_packets
	bpftool net attach xdp pinned /sys/fs/bpf/drop_packets dev ${INTERFACE}