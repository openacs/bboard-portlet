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
	return "bboard_portlet"
    }
    
    ad_proc -public get_pretty_name {
    } {
	return "Discussion Forums"
    }

    ad_proc -public link {
    } {
	return "forums"
    }
    
    ad_proc -public add_self_to_page { 
	portal_id 
	instance_id 
	args
    } {
	Adds a bboard PE to the given page with the instance key being
	opaque data in the portal configuration.
	
	@return element_id The new element's id
	@param portal_id The page to add self to
	@param instance_id The bboard instace to show
	@param args an arg string not used
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Add some smarts to only add one portlet for now when it's added multiple times (ben)
	# Find out if bboard already exists
	set element_id_list [portal::get_element_ids_by_ds $portal_id [my_name]]

	if {[llength $element_id_list] == 0} {
	    # Tell portal to add this element to the page
	    set element_id [portal::add_element $portal_id [my_name]]
	    # There is already a value for the param which must be overwritten
	    portal::set_element_param $element_id instance_id $instance_id
	    set package_id_list [list]
	} else {
	    set element_id [lindex $element_id_list 0]
	    # There are existing values which should NOT be overwritten
	    portal::add_element_param_value -element_id $element_id -key instance_id -value $instance_id
	}

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

        #
        # YES, I will clean this up! - aks
        #


	set whole_data "<table border=0 cellpadding=2 cellspacing=2 width=100%>"
	# Should be a list already! (ben)
	set list_of_instance_ids $config(instance_id)

	# Added by Ben
	foreach instance_id $list_of_instance_ids {
            
            set url [dotlrn_community::get_url_from_package_id -package_id $instance_id]

            # aks fold into site_nodes:: or dotlrn_community
            set comm_object_id [db_string select_name "select object_id from site_nodes where node_id= (select parent_id from site_nodes where object_id=:instance_id)" ]

            set name [db_string select_pretty_name "
                select instance_name 
                from apm_packages
                where package_id= :comm_object_id "]

	    append whole_data "<tr><td><a href=${url}><b>$name</b></a></td></tr>"

	    set data ""
	    set rowcount 0
            
# removed individual msg stuff
# 
#            if { $config(shaded_p) == "f" } {
#                
#                db_foreach select_messages $query {
#                    append data "<li><a href=${url}message?forum_id=${forum_id}&message_id=${message_id}>$title</a>, by <i>$full_name</i>\n"
#                    incr rowcount
#                }
#                
#                set template "<ul>$data</ul>"
#                
#                if {!$rowcount} {
#                    set template "<i>No messages</i>"
#                }
#                
#                append template "<p>"
#                
#            } else {
#                # shaded	
#
 
        set data ""		
        db_foreach select_shaded $shaded_query {
                if { $config(shaded_p) == "f" } {
                    append data "<tr><td>&nbsp;&nbsp;<a href=${url}forum?forum_id=${forum_id}>$short_name</a></td></tr>"
                } 
            incr rowcount
        }
    
    set template "$data"
    
    if {!$rowcount} {
        set template "<tr><td><i>No discussion forums</i></td></tr>"
    }
# }

append whole_data $template


}

append whole_data "</table>"

	set code [template::adp_compile -string $whole_data]
	
	set output [template::adp_eval code]
	
	return $output
	
    }   

    ad_proc -public edit { 
	element_id
    } {
	 Display the PE's edit page
    
	 @return HTML string
	 @param cf A config array
	 @author arjun@openforce.net
	 @creation-date Nov 2001
    } {
	return ""
    }


    ad_proc -public remove_self_from_page { 
	portal_id 
	instance_id 
    } {
	Removes a bboard PE from the given page 
	
	@param portal_id The page to remove self from
	@param instance_id
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# get the element IDs (could be more than one!)
	set element_ids [portal::get_element_ids_by_ds $portal_id [my_name]]

	# remove all elements
	db_transaction {
	    foreach element_id $element_ids {
		# Highly simplified (ben)
		portal::remove_element_param_value -element_id $element_id -key instance_id -value $instance_id

		# Check if we should really remove the element
		if {[llength [portal::get_element_param_list -element_id $element_id -key instance_id]] == 0} {
		    portal::remove_element $element_id
		}
	    }
	}
    }

    ad_proc -public make_self_available { 
	portal_id 
    } {
	Wrapper for the portal:: proc
	
	@param portal_id
	@author arjun@openforce.net
	@creation-date Nov 2001
    } {
	portal::make_datasource_available \
		$portal_id [portal::get_datasource_id [my_name]]
    }

    ad_proc -public make_self_unavailable { 
	portal_id 
    } {
	Wrapper for the portal:: proc
	
	@param portal_id
	@author arjun@openforce.net
	@creation-date Nov 2001
    } {
	portal::make_datasource_unavailable \
		$portal_id [portal::get_datasource_id [my_name]]
    }
}
 

