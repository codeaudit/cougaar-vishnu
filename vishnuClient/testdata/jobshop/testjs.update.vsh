<DATA>
  <NEWOBJECTS>
    <OBJECT type="job">
      <FIELD name="id" value="welding 3" />
      <FIELD name="duration_in_seconds" value="180" />
      <FIELD name="preceeding_tasks" list="t" >
      </FIELD>
      <FIELD name="quals_required">
        <OBJECT type="quals">
          <FIELD name="welding" value="true" />
          <FIELD name="cutting" value="false" />
          <FIELD name="painting" value="false" />
        </OBJECT>
      </FIELD>
    </OBJECT>
    <OBJECT type="machine" >
      <FIELD name="id" value="machine 3" />
      <FIELD name="quals" >
        <OBJECT type="quals" >
          <FIELD name="welding" value="true" />
          <FIELD name="cutting" value="true" />
          <FIELD name="painting" value="false" />
        </OBJECT>
      </FIELD>
      <FIELD name="location" >
        <OBJECT type="xy_coord" >
          <FIELD name="x" value="20.0" />
          <FIELD name="y" value="-10.0" />
        </OBJECT>
      </FIELD>
      <FIELD name="maintenance" >
        <LIST>
        </LIST>
      </FIELD>
    </OBJECT>
  </NEWOBJECTS>
  <CHANGEDOBJECTS>
    <OBJECT type="job">
      <FIELD name="id" value="welding 1" />
      <FIELD name="duration_in_seconds" value="1200" />
      <FIELD name="preceeding_tasks" >
        <LIST>
          <VALUE value="welding 2" />
          <VALUE value="cutting 1" />
          <VALUE value="welding 3" />
        </LIST>
      </FIELD>
      <FIELD name="quals_required">
        <OBJECT type="quals">
          <FIELD name="welding" value="true" />
          <FIELD name="cutting" value="true" />
          <FIELD name="painting" value="false" />
        </OBJECT>
      </FIELD>
    </OBJECT>
    <OBJECT type="machine" >
      <FIELD name="id" value="machine 1" />
      <FIELD name="quals" >
        <OBJECT type="quals" >
          <FIELD name="welding" value="false" />
          <FIELD name="cutting" value="false" />
          <FIELD name="painting" value="true" />
        </OBJECT>
      </FIELD>
      <FIELD name="location" >
        <OBJECT type="xy_coord" >
          <FIELD name="x" value="10.0" />
          <FIELD name="y" value="20.0" />
        </OBJECT>
      </FIELD>
      <FIELD name="maintenance" >
        <LIST>
          <VALUE>
            <OBJECT type="interval" >
              <FIELD name="start" value="2000-05-15 09:05:00" />
              <FIELD name="end" value="2000-05-15 09:10:00" />
              <FIELD name="label1" value="unplanned" />
              <FIELD name="label2" value="Jam" />
            </OBJECT>
          </VALUE>
          <VALUE>
            <OBJECT type="interval" >
              <FIELD name="start" value="2000-05-15 09:50:00" />
              <FIELD name="end" value="2000-05-15 10:00:00" />
              <FIELD name="label1" value="planned" />
              <FIELD name="label2" value="Repair" />
            </OBJECT>
          </VALUE>
        </LIST>
      </FIELD>
    </OBJECT>
  </CHANGEDOBJECTS>
  <DELETEDOBJECTS>
    <OBJECT type="job">
      <FIELD name="id" value="painting 1" />
    </OBJECT>
    <OBJECT type="machine">
      <FIELD name="id" value="machine 2" />
    </OBJECT>
  </DELETEDOBJECTS>
</DATA>
