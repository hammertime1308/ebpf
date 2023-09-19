# EBPF packet filtering code

1. Dropping TCP packets for port 4040 and track the ip address with count of tcp packets received

## Running the code

### Drop packets on 4040 port

1. Run `make drop-packets` to generate code and build a executable binary named `drop-4040-packets` inside cmd/drop_packets.
2. `sudo ./cmd/drop_packets/drop-4040-packets {{interface_name}}` to run the binary. Replace the `{{interface_name}}` with the network interface to apply the filter. For example `wlp3s0`.
