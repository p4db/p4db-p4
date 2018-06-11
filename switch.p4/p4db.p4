field_list watch_list {
    ethernet;
    ipv4;
}

#define WATCH_LIST watch_list
#include "../lib/odb.p4"

table watch_1 {
    reads {
        ipv4.dstAddr : exact;
        ipv4.srcAddr : exact;
    }
    actions {
        gen_watch;
    }
    size: 1024;
}

table watch_2 {
    reads {
        ipv4.dstAddr : exact;
        ipv4.srcAddr : exact;
    }
    actions {
        gen_watch;
    }
    size: 512;
}

table watch_3 {
    reads {
        ipv4.dstAddr : exact;
        ipv4.srcAddr : exact;
    }
    actions {
        gen_watch;
    }
    size: 256;
}

table watch_4 {
    reads {
        ipv4.dstAddr : exact;
        ipv4.srcAddr : exact;
    }
    actions {
        gen_watch;
    }
    size: 1024;
}

field_list match_list {
    ethernet;
    ipv4;
    routing_metadata;
    odb_metadata.match_result;
}


#define MATCH_LIST match_list

table match_1 {
    reads {
        ipv4.dstAddr : lpm;
    }
    actions {
        gen_match;
    }
    size: 512;
}

field_list break_list {
    ethernet;
    ipv4;
    routing_metadata;
}

#define BREAK_LIST break_list

table break_1 {
    reads {
        ipv4.dstAddr : lpm;
    }
    actions {
        gen_break;
    }
    size: 512;
}

field_list action_list {
    ethernet;
    ipv4;
    routing_metadata;
    odb_metadata.action_id;
    odb_metadata.action_parameter1;
    odb_metadata.action_parameter2;
    odb_metadata.action_parameter3;
    odb_metadata.action_parameter4;
}

#define ACTION_LIST action_list

ACTION_WITH_1_PARAM(set_nhop, 1, id)
ACTION_WITHOUT_PARAM(_drop, 2)

table action_1 {
    reads {
        odb_metadata.action_id : exact;
    }
    actions {
        gen_action;
    }
    size: 512;
}

DAMPER_CONTROL(1, break_1)

table action_1 {
    reads {
        odb_metadata.action_id : exact;
    }
    actions {
        gen_action;
    }
    size: 512;
}

DAMPER_CONTROL(1, break_1)

table pipeline_1 {
    reads {
        odb_metadata.action_id : exact;
    }
    actions {
        gen_action;
    }
    size: 512;
}
