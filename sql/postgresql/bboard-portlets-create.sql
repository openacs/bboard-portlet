--
-- packages/bboard-portlet/sql/bboard-portlets-create.sql
--

-- Creates bboard datasources for portal portlets

-- Copyright (C) 2001 ArsDigita Corporation 
-- @author Phong Nguyen (phong@arsdigita.com)
-- @creation-date 2001-02-26

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License.  Full text of the license is available from the GNU Project:
-- http://www.fsf.org/copyleft/gpl.html

select portal_datasource__new(NULL, 'raw', 'application/x-ats', NULL, 'Summarize bboard applications',
                              'Summarizes the bboard topics for all instances of bboard mounted below the current node',
                              'f', '/packages/bboard-portlets/www/summarize', 'bboard', 'portal_datasource',
                              current_timestamp, NULL, NULL, NULL);
