<if @forum_info:rowcount@ eq 0>
  <li>No bboard forums found. Ask your sysadmin to set some up.</a>
</if>
<else>
  Choose a forum to show in this portal element:
  <table>
  <multiple name=forum_info>
   <tr>
    <td><a href="<a href=configure-2?@forum_info.bboard_id@">@forum_info.name@</a></td>
   </tr>
  </multiple>
  </table>
</else>


