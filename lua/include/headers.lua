local ffi = require "ffi"

-- structs
ffi.cdef[[
	// TODO: vlan support (which can be offloaded to the NIC to simplify scripts)
	union payload_t {
		uint8_t	uint8[0];
		uint32_t uint32[0];
		uint64_t uint64[0];
	};
	
	struct __attribute__ ((__packed__)) mac_address {
		uint8_t		uint8[6];
	};
	
	struct __attribute__((__packed__)) ethernet_header {
		struct mac_address	dst;
		struct mac_address	src;
		uint16_t		type;
	};

	union ipv4_address {
		uint8_t		uint8[4];
		uint32_t	uint32;
	};

	union ipv6_address {
		uint8_t 	uint8[16];
		uint32_t	uint32[4];
		uint64_t	uint64[2];
	};

	struct __attribute__((__packed__)) ipv4_header {
		uint8_t			verihl;
		uint8_t			tos;
		uint16_t		len;
		uint16_t		id;
		uint16_t		frag;
		uint8_t			ttl;
		uint8_t			protocol;
		uint16_t		cs;
		union ipv4_address	src;
		union ipv4_address	dst;
	 };

	struct __attribute__((__packed__)) ipv6_header {
		uint32_t 		vtf;
		uint16_t  		len;
		uint8_t   		nextHeader;
		uint8_t   		ttl;
		union ipv6_address 	src;
		union ipv6_address	dst;
	};

	struct __attribute__((__packed__)) udp_header {                                                             
		uint16_t	src;
		uint16_t	dst;
		uint16_t	len;
		uint16_t	cs;
	};

	struct __attribute__((__packed__)) tcp_header {
		uint16_t	src;
		uint16_t	dst;
		uint32_t	seq;
		uint32_t	ack;
		uint8_t 	offset;
		uint8_t 	flags;
		uint16_t	window;
		uint16_t	cs;
		uint16_t	urg;
		uint32_t	options[];
	};

	struct __attribute__((__packed__)) ip_packet {
		struct ethernet_header 	eth;
		struct ipv4_header	ip;
		union payload_t payload;
	};

	struct __attribute__((__packed__)) ip_v6_packet {
		struct ethernet_header 	eth;
		struct ipv6_header 	ip;
		union payload_t payload;
	};
	
	struct __attribute__((__packed__)) udp_packet {
		struct ethernet_header 	eth;
		struct ipv4_header 	ip;
		struct udp_header 	udp;
		union payload_t payload;
	};

	struct __attribute__((__packed__)) tcp_packet {
		struct ethernet_header 	eth;
		struct ipv4_header 	ip;
		struct tcp_header 	tcp;
		union payload_t payload;
	};

	struct __attribute__((__packed__)) ethernet_packet {
		struct ethernet_header 	eth;
		union payload_t payload;
	};

	struct __attribute__((__packed__)) udp_v6_packet {
		struct ethernet_header	eth;
		struct ipv6_header 	ip;
		struct udp_header 	udp;
		union payload_t payload;
	};
	
	struct __attribute__((__packed__)) tcp_v6_packet {
		struct ethernet_header	eth;
		struct ipv6_header 	ip;
		struct tcp_header 	tcp;
		union payload_t payload;
	};
]]

return ffi.C
