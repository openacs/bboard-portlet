# /packages/portal-creator/www/datasources/bboard/summarize.tcl

ad_page_contract {
    Summarizes all bboard applications mounted directly below this node

    @author Arjun Sanyal (arjun@openforce.net)
    @creation-date Sept 2001
    @cvs-id $Id$
} {
    forum_id:integer,notnull
    {last_n_days:integer,optional,""}
} -properties {}

#set node_id [ad_conn node_id]
#
## get all of the bboard packages mounted under this node
#db_multirow bboard select_bboard {
#    select b.forum_id,
#	    b.short_name,
#	    site_node.url(sn.node_id) as url,
#	    acs_object.name(sn.object_id) as bboard_name
#      from bboard_forums b, 
#	    site_nodes sn, 
#	    apm_packages apm
#     where sn.object_id = b.bboard_id(+)
#	and sn.parent_id = :node_id
#	and sn.object_id = apm.package_id
#	and apm.package_key = 'bboard'
#     order by lower(bboard_name)
#}
#
#set subsite_url [site_node_closest_ancestor_package_url -package_key acs-subsite]
#

db_0or1row forum_info forum_info_select {
    select short_name, moderated_p, bboard_id
    from bboard_forums
    where forum_id = :forum_id
}

db_multirow messages messages_select {
    select message_id, title, num_replies,
    first_names||' '||last_name as full_name,
    to_char(last_reply_date,'MM/DD/YY hh12:Mi am') as last_updated
    from bboard_messages_all b, persons
    where forum_id = :forum_id
    and sent_date > decode(:last_n_days, 0, '1976-01-01', sysdate - :last_n_days)
    and person_id = sender
    and reply_to is null
    order by sent_date desc
}
    
ad_return_template
