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

    Procedures to supports bboard admin portlets
    
    @creation-date September 30 2001
    @author arjun@openforce.net 
    @version $Id$
}

namespace eval bboard_admin_portlet {
    
    ad_proc -private get_my_name {
    } {
	return "bboard_admin_portlet"
    }
    
    ad_proc -public get_pretty_name {
    } {
	return "Bboard Administration"
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
        instance_id
    } {
	Adds a bboard admin PE to the admin portal
        
        @return new element_id
    } {
        # we use "portal::add_element" here since there is no
        # configuration necessary for this portlet (no params)
        set element_id [portal::add_element \
                -pretty_name [get_pretty_name] \
                -portal_id $portal_id \
                -portlet_name [get_my_name]
        ]

        # XXX AKS1 needs instance_id params???
        portal::set_element_param $element_id "instance_id" $instance_id
        return $element_id
    }
    
    ad_proc -public remove_self_from_page {
        portal_id
    } {
        Removes the bboard admin PE from the portal
    } {
        portal::remove_element \
                -portal_id $portal_id \
                -datasource_name [get_my_name]
    }
        
    ad_proc -public show { 
	cf 
    } {
    } {
        portal::show_proc_helper \
                -package_key [my_package_key] \
                -config_list $cf \
                -template_src "bboard-admin-portlet"
    }   
    
    ad_proc -public edit { 
        cf
    } {
    } {
	return ""
    }

}
 

