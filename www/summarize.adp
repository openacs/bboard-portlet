<ul>

<if @bboard:rowcount@ eq 0>
  <li>There are no bboard applications mounted here. You can <a href=@subsite_url@admin/site-map/auto-mount?package_key=bboard&node_id=@node_id@>mount one if you like</a>
</if>

<else>
  <multiple name="bboard">
    <li><a href=@bboard.url@>@bboard.bboard_name@</a>
    <ul>
      <group column="bboard_name">
      <if @bboard.short_name@ not nil>
        <li><a href="@bboard.url@forum?forum_id=@bboard.forum_id@">@bboard.short_name@</a>
      </if>
      </group>
      <li><a href="@bboard.url@forum-new">Create a new topic</a>
    </ul>
  </multiple>
</else>

</ul>
