--
-- packages/bboard-portlet/sql/bboard-portlets-create.sql
--

-- Creates bboard datasources for portal portlets

-- Copyright (C) 2001 OpenForce, Inc.
-- @author Arjun Sanyal (arjun@openforce.net)
-- @creation-date 2001-30-09

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

declare
  ds_id portal_datasources.datasource_id%TYPE;
begin
  ds_id := portal_datasource.new(
    data_type        => 'raw',
    mime_type        => 'application/x-ats',
    name             => 'Summarize bboard applications',
    description      => 'Summarizes the bboard topics for all instances of bboard mounted below the current node',
    content_varchar  => '/packages/bboard-portlet/www/summarize',
    configurable_p   => 'f'
  );
end;
/
show errors
