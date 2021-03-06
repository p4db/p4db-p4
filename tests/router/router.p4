#include "../include/header.p4"
#include "../include/metadata.p4"
#include "../include/parser.p4"
#include "../include/checksum.p4"
#include "../include/actions.p4"

#include "../../lib/odb.p4"

table ipv4_nhop {
    reads {
        ipv4.dstAddr : lpm;
    }
    actions {
        set_nhop;
        _drop;
    }
    size: 1024;
}

table forward_table {
    reads {
        routing_metadata.nhop_ipv4 : exact;
    }
    actions {
        set_dmac;
        _drop;
    }
    size: 512;
}

table send_frame {
    reads {
        standard_metadata.egress_port: exact;
    }
    actions {
        set_smac;
        _drop;
    }
    size: 256;
}

control ingress {
    if(valid(ipv4) and ipv4.ttl > 0) {
        apply(ipv4_nhop);
        apply(forward_table);
        apply(send_frame);
    }
}
