array set config $cf	

set shaded_p $config(shaded_p)
set list_of_instance_ids $config(instance_id)
set data ""

if {[llength $list_of_instance_ids] == 1} {
    set one_instance_p 1
} else {
    set one_instance_p 0
}


foreach instance_id $list_of_instance_ids {
    
    set comm_url [dotlrn_community::get_url_from_package_id -package_id $instance_id]
    set comm_name [site_nodes::get_parent_name \
            -instance_id $instance_id
    ]
    
    set f_check [db_0or1row one_forum_check {select 1 from bboard_forums where bboard_id = :instance_id} ]

    if {!$one_instance_p && $f_check} {
        append data "<li>$comm_name"
        append data "<ul>"
    }

    db_foreach forums_select {
        select forum_id, short_name 
        from bboard_forums 
        where bboard_id = :instance_id
    } {
        append data "<li><a href=${comm_url}forum?forum_id=$forum_id>$short_name</a>"
    }
    
    if {!$one_instance_p && $f_check} {
        append data "</ul>"
    }
}

# portlets shouldn't disappear anymore (ben)
if {[empty_string_p $data]} {
    set no_forums_p "t"
} else {
    set no_forums_p "f"
}
