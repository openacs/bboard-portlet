--
--  Copyright (C) 2001, 2002 OpenForce, Inc.
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--

--
-- packages/bboard-portlets/sql/bboard-portlets-drop.sql
--

-- Drops bboard datasources for portal portlets

-- Copyright (C) 2001 Openforce, Inc. 
-- @author Arjun Sanyal (arjun@openforce.net)
-- @creation-date 2001-30-09

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

declare  
  ds_id portal_datasources.datasource_id%TYPE;
begin

  begin 
    select datasource_id into ds_id
      from portal_datasources
     where name = 'bboard-portlet';
   exception when no_data_found then
     ds_id := null;
  end;

  if ds_id is not null then
    portal_datasource.delete(ds_id);
  end if;

end;
/
show errors;



declare
	foo integer;
begin

	-- add all the hooks
	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'GetMyName'
	);

	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'GetPrettyName'
	);


	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'Link'
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
	       'Edit'
	);

	foo := acs_sc_impl.delete_alias (
	       'portal_datasource',
	       'bboard_portlet',
	       'RemoveSelfFromPage'
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


