--
-- packages/bboard-portlet/sql/bboard-portlet-sc-create.sql
--

-- Creates bboard datasources for portal portlets

-- Copyright (C) 2001 OpenForce, Inc.
-- @author Arjun Sanyal (arjun@openforce.net)
-- @creation-date 2001-30-09

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

-- implementation of the portal element service contract 
declare
	foo integer;
begin
	-- create the implementation
	foo := acs_sc_impl.new (
		'portal_datasource',
		'bboard_portlet',
		'bboard_portlet'
	);

	-- add all the hooks
	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'MyName',
	       'bboard_portlet::my_name',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'GetPrettyName',
	       'bboard_portlet::get_pretty_name',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'Link',
	       'bboard_portlet::link',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'AddSelfToPage',
	       'bboard_portlet::add_self_to_page',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'Show',
	       'bboard_portlet::show',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'Edit',
	       'bboard_portlet::edit',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'RemoveSelfFromPage',
	       'bboard_portlet::remove_self_from_page',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'MakeSelfAvailable',
	       'bboard_portlet::make_self_available',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'MakeSelfUnavailable',
	       'bboard_portlet::make_self_unavailable',
	       'TCL'
	);

	-- Add the binding
	acs_sc_binding.new (
	    contract_name => 'portal_datasource',
	    impl_name => 'bboard_portlet'
	);
end;
/
show errors

