# /packages/bboard-portlets/tcl/bboard-portlets-procs.tcl

ad_page_contract {

    Procedures to supports bboard portlets

    @author arjun@openforce.net
    @creation-date September 30 2001
    @$Id$
}

namespace eval bboard_portlet {


    ad_proc -private my_name {} {
	This datasource's name

	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
    return "bboard-portlet"
    }

    ad_proc -public add_self_to_page { page_id instance_id }  {
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
    ad_proc -public show { cf }  {
	Display the PE
    
	@param cf A config array
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {

	array set config $cf	

	return "<b>This is the instance_id $config(instance_id)</b>"

    }

    ad_proc -public remove_self_from_page { portal_id instance_id }  {
	Removes a bboard PE from the given page 
    
	@param page_id The page to remove self from
	@param instance_id
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Find out the element_id that corresponds to this instance_id
	if { [db0or1row get_element_id "
	select pem.element_id as element_id
	from portal_element_parameters pep, portal_element_map pem
	where pem.portal_id = $portal_id and
	pep.element_id = pem.element_id and
	pep.key = 'instance_id' and
	pep.value = $instance_id"]  } {
	    
	    # delete the params
	    # delete the element from the map
	    ns_log Notice "foo"

	} else {
	    ad_return_complaint 1 "bboard_portlet::remove_self_from_page: Invalid portal_id and/or instance_id given."
	    ad_script_abort
	}

	# this call removes the PEs params too
	set element_id [portal::remove_element {$portal_id $element_id}]
    }

    ad_proc -private dummy {} {
	This is very strange. If this proc is not here, the one above 
	dosen't show up.
    }
    {
	return 1
    }

} # namespace
