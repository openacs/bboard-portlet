# /packages/bboard-portlets/tcl/bboard-portlets-procs.tcl

ad_page_contract {

    Procedures to supports bboard portlets

    @author arjun@openforce.net
    @creation-date September 30 2001
    @$Id$
}

namespace eval bboard_portlet {


    ad_proc -private name {} {
	This datasource's name

	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
    return "bboard-portlet"
    }

    ad_proc add_self_to_page { page_id instance_id }  {
	Adds a bboard PE to the given page with the instance key being
	opaque data in the portal configuration.
    
	@param page_id The page to add self to
	@param instance_id The bboard instace to show
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Tell portal to add this element to the page
	set element_id [portal::add_element {$page_id [name]}]
	
	# The default param "instance_id" must be configured
	set key "instance_id"
	set value [portal::get_element_param $element_id $key]

	ns_log Notice "AKSbboard-portlet: instance_id's value: $value"
	
	portal::set_element_param $element_id $key $instance_id

    }
} # namespace
