<if @forums:rowcount@ eq 0>
<i>No bboards</i>
</if>
<else>
<ul>
<multiple name="forums">
<li> <a href=@url@forum?forum_id=@forums.forum_id@>@forums.short_name@</a> &nbsp; - &nbsp; <a href=@url@forum-edit?forum_id=@forums.forum_id@>Administration</a>
</multiple>
</ul>
</else>
<p>
<a href=@url@forum-new>New Bboard</a>
