

<%
set ul_output_p 0
        
foreach forum $forums {
        set forum_name [lindex $forum 0]
        set forum_url [lindex $forum 1]
        set forum_forums [lindex $forum 2]

        # Skip forum groups with no forums
        if {[llength $forum_forums] == 0} {
                continue
        }

        foreach one_forum $forum_forums {
                if {!$ul_output_p} {
                        template::adp_puts "<ul>"
                        set ul_output_p 1
                }
                template::adp_puts "<li>"
                
                if {$display_group_name_p == "t"} {
                        template::adp_puts " $forum_name:"
                }

                template::adp_puts " <a href=${forum_url}forum?forum_id=[lindex $one_forum 0]>[lindex $one_forum 1]</a>\n"
        }

}

if {$ul_output_p} {
        template::adp_puts "</ul>"
} else {
        template::adp_puts "<small>No Discussion Forums</small>"
}
%>
