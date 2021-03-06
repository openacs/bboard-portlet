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

array set config $cf	

set shaded_p $config(shaded_p)
set list_of_package_ids $config(package_id)
set one_instance_p [ad_decode [llength $list_of_package_ids] 1 1 0]

db_multirow forums select_forums "
    select bboard_forums.bboard_id as package_id,
           (select apm_packages.instance_name
            from apm_packages
            where apm_packages.package_id = apm_package.parent_id(bboard_forums.bboard_id)) as parent_name,
           (select site_node.url(site_nodes.node_id)
            from site_nodes
            where site_nodes.object_id = bboard_forums.bboard_id) as url,
           bboard_forums.forum_id,
           bboard_forums.short_name
    from bboard_forums
    where bboard_forums.bboard_id in ([join $list_of_package_ids ,])
    order by parent_name,
             bboard_forums.short_name
"
