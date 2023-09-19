#include <linux/bpf.h>
#include <bpf_helpers.h>
#include <linux/if_ether.h>
#include <linux/types.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <netinet/in.h>

#define TARGET_PORT 4040
#define MAX_MAP_ENTRIES 16

// struct to hold the ip address and packet counts
struct
{
	__uint(type, BPF_MAP_TYPE_LRU_HASH);
	__uint(max_entries, MAX_MAP_ENTRIES);
	__type(key, __u32);	  // source IP address
	__type(value, __u32); // packet count
} xdp_stats_map SEC(".maps");

SEC("xdp")
int xdp_packet_filter_4040(struct xdp_md *ctx)
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

	if (dst_port == TARGET_PORT) // we have recevied the packet hitting targeted port
	{
		__u32 source = iph->saddr;										 // get the source address from where request came
		__u32 *pkt_count = bpf_map_lookup_elem(&xdp_stats_map, &source); // get count for ip address from map
		if (!pkt_count)
		{
			// no entry in map for IP address yet, so set the initial value to 1.
			__u32 init_pkt_count = 1;
			bpf_map_update_elem(&xdp_stats_map, &source, &init_pkt_count, BPF_ANY);
		}
		else
		{
			// entry already exists for IP address, increment the packet counter for IP address
			__sync_fetch_and_add(pkt_count, 1);
		}
		// bpf_printk("Got TCP packet from %d to port %d", iph->saddr, dst_port);
		return XDP_DROP; // drop the packets as it is traffic on target port
	}

	return XDP_PASS; // pass the remaining traffic
}

char _license[] SEC("license") = "GPL";