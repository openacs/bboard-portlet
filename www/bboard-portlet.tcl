
array set config $cf	

set query  "
select message_id, 
forum_id,
title, 
num_replies,
first_names||' '||last_name as full_name,
to_char(last_reply_date,'MM/DD/YY hh12:Mi am') as last_updated
from bboard_messages_all b, persons, acs_objects ao
where b.forum_id = ao.object_id
and forum_id in (select forum_id 
from bboard_forums 
where bboard_id = :instance_id)
and person_id = sender
and reply_to is null
order by sent_date desc"

set shaded_query  "
select forum_id, short_name
from bboard_forums 
where bboard_id = :instance_id"


# Should be a list already! (ben)
set list_of_instance_ids $config(instance_id)

set forums [list]

# Added by Ben
foreach instance_id $list_of_instance_ids {
    
    set url [dotlrn_community::get_url_from_package_id -package_id $instance_id]
    
    # aks fold into site_nodes:: or dotlrn_community
    set comm_object_id [db_string select_name "select object_id from site_nodes where node_id= (select parent_id from site_nodes where object_id=:instance_id)" ]
    
    set name [db_string select_pretty_name "
    select instance_name 
    from apm_packages
    where package_id= :comm_object_id "]
    
    set one_forum_forums [list]
    
    db_foreach select_shaded $shaded_query {
        lappend one_forum_forums [list $forum_id $short_name]
    }
    
    set one_forum [list $name $url $one_forum_forums]
    lappend forums $one_forum
}

# return the template
ad_return_template	
