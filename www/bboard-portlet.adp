
<ul>
<%
foreach forum $forums {
        set forum_name [lindex $forum 0]
        set forum_url [lindex $forum 1]
        set forum_forums [lindex $forum 2]

        # Skip forum groups with no forums
        if {[llength $forum_forums] == 0} {
                continue
        }

        foreach one_forum $forum_forums {
                template::adp_puts "<li> $forum_name: <a href=${forum_url}forum?forum_id=[lindex $one_forum 0]>[lindex $one_forum 1]</a>\n"
        }

}
%>
</ul>
