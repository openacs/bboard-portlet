ad_page_contract {
    The display logic for the bboard admin portlet
    
    @author Ben Adida (ben@openforce)
    @cvs_id $Id$
} -properties {
    
}

array set config $cf	

set list_of_instance_ids $config(instance_id)

if {[llength $list_of_instance_ids] > 1} {
    # We have a problem!
    return -code error "There should be only one instance of bboard for admin purposes"
}

set instance_id [lindex $list_of_instance_ids 0]

db_multirow forums select_forums "
select forum_id, short_name
from bboard_forums 
where bboard_id = :instance_id"

set url [dotlrn_community::get_url_from_package_id -package_id $instance_id]

ad_return_template
