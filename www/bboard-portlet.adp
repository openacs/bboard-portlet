<if @shaded_p@ ne "t">

  <if @no_forums_p@ eq "f">

    <if @one_instance_p@ eq 0>
      <ul>
    </if>
   
    @data@
  
    <if @one_instance_p@ eq 0>
      </ul>
    </if>

  </if>
  <else>
    <small>No Forums</small>
  </else>

</if>
<else>
  &nbsp;
</else>
