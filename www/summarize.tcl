# /packages/portal-creator/www/datasources/bboard/summarize.tcl

ad_page_contract {
    Summarizes all bboard applications mounted directly below this node

    @author Phong Nguyen (phong@arsdigita.com)
    @creation-date 2001-02-26
    @cvs-id $Id$
} {
} -properties {
    context_bar:onevalue
}

set node_id [ad_conn node_id]

# get all of the bboard packages mounted under this node
db_multirow bboard select_bboard {
    select b.forum_id,
           b.short_name,
           site_node.url(sn.node_id) as url,
           acs_object.name(sn.object_id) as bboard_name
      from bboard_forums b, 
           site_nodes sn, 
           apm_packages apm
     where sn.object_id = b.bboard_id(+)
       and sn.parent_id = :node_id
       and sn.object_id = apm.package_id
       and apm.package_key = 'bboard'
     order by lower(bboard_name)
}

set subsite_url [site_node_closest_ancestor_package_url -package_key acs-subsite]

ad_return_template
