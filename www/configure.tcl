# /packages/portal-creator/www/datasources/bboard/configure.tcl

ad_page_contract {
    Config page for the DS

    @author Arjun Sanyal (arjun@openforce.net)
    @creation-date Sept 2001
    @cvs-id $Id$
} {
    element_id:integer,notnull
} -properties {}

# Show a list of all the available forums
db_0or1row forum_info forum_info_select {
    select short_name, moderated_p, bboard_id
    from bboard_forums
}

ad_return_template
