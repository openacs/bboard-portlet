# /packages/bboard-portlets/tcl/bboard-portlets-procs.tcl
ad_library {

Procedures to supports bboard portlets

Copyright Openforce, Inc.
Licensed under GNU GPL v2 

@creation-date September 30 2001
@author arjun@openforce.net 
@cvs-id $Id$

}

namespace eval bboard_portlet {
    
    ad_proc -private my_name {
    } {
	return "bboard-portlet"
    }
    
    ad_proc -public get_pretty_name {
    } {
	return "Discussion Forums"
    }
    
    ad_proc -public add_self_to_page { 
	page_id 
	instance_id 
    } {
	Adds a bboard PE to the given page with the instance key being
	opaque data in the portal configuration.
	
	@return element_id The new element's id
	@param page_id The page to add self to
	@param instance_id The bboard instace to show
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Tell portal to add this element to the page
	set element_id [portal::add_element $page_id [my_name]]
	
	# The default param "instance_id" must be configured
	set key "instance_id"
	set value [portal::get_element_param $element_id $key]
	
	portal::set_element_param $element_id $key $instance_id
	
	return $element_id
    }
    
    ad_proc -public show { 
	cf 
    } {
	Display the PE
	
	@return HTML string
	@param cf A config array
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	
	array set config $cf	
	
	set query  "
        select 	message_id, 
	title, 
	num_replies,
	first_names||' '||last_name as full_name,
	to_char(last_reply_date,'MM/DD/YY hh12:Mi am') as last_updated
	from bboard_messages_all b, persons, acs_objects ao
	where b.forum_id = ao.object_id
	and ao.bboard_id = $config(instance_id)
	and person_id = sender
	and reply_to is null
	order by sent_date desc"
	
	set data ""
	set rowcount 0
	
	db_foreach select_messages $query {
	    append data "<tr><td>$title</td><td>$full_name</td><td>$num_replies</td><td>$last_updated</td>"
	    incr rowcount
	} 
	
	set template "
	<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">
	<tr bgcolor=\"#ECECEC\">
	<th align=\"left\">Subject</th> 
	<th align=\"left\">Author</th>  
	<th align=\"left\">Replies</th>
	<th align=\"left\">Last update</th>
	</tr>
	$data
	</table>"
	
	ns_log notice "AKS31 got here $rowcount"
	
	if {!$rowcount} {
	    set template "<i>No messages</i>"
	}
	
	# Ben addition
	append template "<p><a href=bboard/>more...</a>"

	set code [template::adp_compile -string $template]
	
	set output [template::adp_eval code]
	ns_log notice "AKS32 got here $output"
	
	return $output
	
    }   
    
    ad_proc -public remove_self_from_page { 
	portal_id 
	instance_id 
    } {
	Removes a bboard PE from the given page 
	
	@param page_id The page to remove self from
	@param instance_id
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# get the element IDs (could be more than one!)
	set element_ids [portal::get_element_ids_by_ds $portal_id [my_name]]

	# remove all elements
	db_transaction {
	    foreach element_id $element_ids {
		portal::remove_element $element_id
	    }
	}
    }
    
}
 

