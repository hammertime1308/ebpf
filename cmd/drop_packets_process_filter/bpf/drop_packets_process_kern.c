#include <linux/bpf.h>
#include <bpf_helpers.h>
#include <linux/if_ether.h>
#include <linux/types.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <netinet/in.h>

#define ALLOWED_PORT 4040
#define ALLOWED_PROCESS "sample"

#define MAX_MAP_ENTRIES 1024
// struct to hold the port and process name
struct
{
	__uint(type, BPF_MAP_TYPE_HASH);
	__type(key, __u16);		 // port number
	__type(value, char[64]); // process name
	__uint(max_entries, MAX_MAP_ENTRIES);
} port_process_map SEC(".maps");

SEC("xdp")
int xdp_packet_filter_process_wise(struct xdp_md *ctx)
{
	void *data = (void *)(long)ctx->data;
	void *data_end = (void *)(long)ctx->data_end;

	struct ethhdr *eth = data;
	// check for valid ethernet header
	if (data + sizeof(struct ethhdr) > data_end)
		return XDP_ABORTED;

	// return if not an IP packet
	if (__builtin_bswap16(eth->h_proto) != ETH_P_IP)
		return XDP_PASS;

	// it is valid eth header, and it is IP packet
	struct iphdr *iph = data + sizeof(struct ethhdr); // points to iphdr
	if (data + sizeof(struct ethhdr) + sizeof(struct iphdr) > data_end)
		return XDP_ABORTED; // data length is smaller, does not contain eth header, ip header

	// process only tcp packets
	if (iph->protocol != IPPROTO_TCP)
		return XDP_PASS; // not a tcp packet

	struct tcphdr *tcph = data + sizeof(struct ethhdr) + sizeof(struct iphdr);
	if (data + sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct tcphdr) > data_end)
		return XDP_ABORTED;

	__u16 dst_port = __builtin_bswap16(tcph->dest);

	char *process_name = bpf_map_lookup_elem(&port_process_map, &dst_port);
	if (process_name)
	{
		bpf_printk("found request for process %s\n", process_name);
	}

	return XDP_PASS;
}

char _license[] SEC("license") = "GPL";