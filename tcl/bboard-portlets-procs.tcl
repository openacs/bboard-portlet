# /packages/bboard-portlets/tcl/bboard-portlets-procs.tcl

ad_page_contract {

    Procedures to supports bboard portlets

    @author mbryzek@arsdigita.com
    @creation-date 2001-03-01
    @$Id$
}


ad_proc bboard_portlets_mount_application { 
    { -object_id "" } 
    { -node_id "" }
    { -package_id "" }
} {
    Mounts a bboard application beneath the portal associated with
    object_id. If no such portal exists, does nothing. This function is
    used as a callback in the acs-subsite group callback system

    @author mbryzek@arsdigita.com
    @creation-date Fri Feb  9 18:55:22 2001

    @return The package id of the newly mounted package, or the empty
    string if no package was mounted

} {
    if { [empty_string_p $object_id] } {
	error "Object ID must be specified"
    }

    # Find the node ID for the portal associated with this object 
    set node_id [portal_node_id_for_object $object_id]
    if { [empty_string_p $node_id] } {
	return ""
    }
    return [subsite::auto_mount_application -node_id $node_id bboard]
}
