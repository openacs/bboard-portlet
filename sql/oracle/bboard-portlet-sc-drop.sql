--
-- packages/bboard-portlet/sql/bboard-portlet-sc-drop.sql
--

-- Drops bboard datasources for portal portlets

-- Copyright (C) 2001 OpenForce, Inc.
-- @author Arjun Sanyal (arjun@openforce.net)
-- @creation-date 2001-30-09

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

declare
	foo integer;
begin

	-- add all the hooks
	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'MyName'
	);

	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'GetPrettyName'
	);

	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'AddSelfToPage'
	);

	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'Show'
	);

	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'RemoveSelfFromPage'
	);

	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'MakeSelfAvailable'
	);

	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'MakeSelfUnavailable'
	);

	-- Drop the binding
	acs_sc_binding.delete (
	    contract_name => 'portal_datasource',
	    impl_name => 'bboard_portlet'
	);

	-- drop the impl
	foo := acs_sc_impl.delete (
		'portal_datasource',
		'bboard_portlet'
	);
end;
/
show errors

