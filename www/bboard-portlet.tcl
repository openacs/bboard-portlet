#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

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
    
    set f_count [db_string forum_count {select count(*) from bboard_forums where bboard_id = :instance_id} ]
    
    if {$f_count == 0} {
        set f_check 0
    } else {
        set f_check 1
    }


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
