<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="select_bboard">      
      <querytext>
      
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

      </querytext>
</fullquery>

 
</queryset>
