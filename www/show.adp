<ul>

<if @forum_info:rowcount@ eq 0>
  <li>Bad forum_id sent to this datasource, sorry</a>
</if>
<else>
  <if @messages:rowcount@ eq 0>
  <i>There are no messages available.</i><p>
  </if>
  <else>
  <table>
  <multiple name=messages>
   <tr>
    <td><a href="<%=[bboard_message_url @messages.message_id@ @forum_id@]%>">@messages.title@</a></td>
     <td>@messages.full_name@</td> 
     <td><%= [expr @messages.num_replies@-1] %></td>
     <if @sent_date_p@ not nil and @sent_date_p@ ne 0>
     <td>@messages.sent_date@</td>
     </if>	
   </tr>
  </multiple>
  </table>
  </else>
</else>

