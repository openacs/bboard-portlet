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

ad_library {

    Procedures to supports bboard portlets

    @creation-date September 30 2001
    @author arjun@openforce.net 
    @version $Id$

}

namespace eval bboard_portlet {
    
    ad_proc -private get_my_name {
    } {
	return "bboard_portlet"
    }
    
    ad_proc -public get_pretty_name {
    } {
	return "Bboards"
    }

    ad_proc -private my_package_key {
    } {
        return "bboard-portlet"
    }

    ad_proc -public link {
    } {
	return ""
    }
    
    ad_proc -public add_self_to_page { 
	portal_id 
	bboard_instance_id 
    } {
	Adds a bboard PE to the given portal or appends the given bboard instance_id
        to the bboard PE that already on the portal
    } {

        return [portal::add_element_or_append_id \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -pretty_name [get_pretty_name] \
                -value_id $bboard_instance_id \
                -force_region [ad_parameter "bboard_portlet_region" [my_package_key]]
        ]        
    }
    

    ad_proc -public remove_self_from_page { 
	portal_id 
	bboard_instance_id 
    } {
	Removes a bboard PE from the given page or just the given bboard's instance_id
    } {
        portal::remove_element_or_remove_id \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -value_id $bboard_instance_id
    }

    ad_proc -public show { 
	cf 
    } {
    } {
        # no return call required with the helper proc
        portal::show_proc_helper \
                -package_key [my_package_key] \
                -config_list $cf \
                -template_src "bboard-portlet"
    }   

}
 

