<?xml version='1.0'?>
<PROBLEM name="jobshop_testglobal" >
<DATAFORMAT>
<OBJECTFORMAT name="machine" is_task="false" is_resource="true" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
<FIELDFORMAT name="quals" datatype="quals" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="location" datatype="xy_coord" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="factloc" datatype="latlong" is_subobject="false" is_list="false" is_key="false" is_globalptr="true" />
<FIELDFORMAT name="maintenance" datatype="interval" is_subobject="true" is_list="true" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="job" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
<FIELDFORMAT name="duration_in_seconds" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="quals_required" datatype="quals" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="preceeding_tasks" datatype="string" is_subobject="false" is_list="true" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="quals" is_task="false" is_resource="false" >
<FIELDFORMAT name="welding" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="cutting" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="painting" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" >
<OPTCRITERION>
<OPERATOR operation="-" >
<OPERATOR operation="maxover" >
<LITERAL value="resources" type="variable" datatype="list:resource" />
<LITERAL value="resource" type="constant" datatype="string" />
<OPERATOR operation="complete" >
<LITERAL value="resource" type="variable" datatype="resource" />
</OPERATOR>
</OPERATOR>
<LITERAL value="start_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPTCRITERION>
<TASKDURATION>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="duration_in_seconds" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</TASKDURATION>
<SETUPDURATION>
<LITERAL value="60" type="constant" datatype="number" />
</SETUPDURATION>
<CAPABILITY>
<OPERATOR operation="and" >
<OPERATOR operation="or" >
<OPERATOR operation="not" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="quals_required.welding" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="quals.welding" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="or" >
<OPERATOR operation="not" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="quals_required.cutting" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="quals.cutting" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="or" >
<OPERATOR operation="not" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="quals_required.painting" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="quals.painting" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</CAPABILITY>
<PREREQUISITES>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="preceeding_tasks" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:string" />
</OPERATOR>
</PREREQUISITES>
<TASKUNAVAIL>
<OPERATOR operation="mapover" >
<LITERAL value="prerequisites" type="variable" datatype="list:task" />
<LITERAL value="preceeding_task" type="constant" datatype="string" />
<OPERATOR operation="interval" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="+" >
<OPERATOR operation="taskendtime" >
<LITERAL value="preceeding_task" type="variable" datatype="task" />
</OPERATOR>
<OPERATOR operation="dist" >
<OPERATOR operation="get" >
<OPERATOR operation="resourcefor" >
<LITERAL value="preceeding_task" type="variable" datatype="task" />
</OPERATOR>
<LITERAL value="location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="xy_coord" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="xy_coord" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</TASKUNAVAIL>
<RESOURCEUNAVAIL>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="maintenance" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:interval" />
</OPERATOR>
</RESOURCEUNAVAIL>
<TASKTEXT>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="id" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</TASKTEXT>
<ACTIVITYTEXT>
<OPERATOR operation="get" >
<LITERAL value="interval" type="variable" datatype="interval" />
<LITERAL value="label2" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</ACTIVITYTEXT>
<COLORTESTS>
<COLORTEST color="red" obj_type="task" title="Welding" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="quals_required.welding" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="green" obj_type="task" title="Cutting" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="quals_required.cutting" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="cornflowerblue" obj_type="task" title="Painting" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="quals_required.painting" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="violet" obj_type="activity" title="Planned Maint" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="interval" type="variable" datatype="interval" />
<LITERAL value="label1" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="planned" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="yellow" obj_type="activity" title="Unplanned Maint" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="interval" type="variable" datatype="interval" />
<LITERAL value="label1" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="unplanned" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
</COLORTESTS>
</SPECS>
<GAPARMS pop_size="3" parent_scalar="0.70" max_evals="20" max_time="60" max_duplicates="10" max_top_dog_age="15" initializer="com.bbn.sched.OrderedInitializer" decoder="com.bbn.sched.OrderedDecoder" >
<GAOPERATORS>
<GAOPERATOR name="com.bbn.sched.OrderedMutation" prob="0.50" parms="0.8" />
<GAOPERATOR name="com.bbn.sched.OrderedCrossover" prob="0.50" />
</GAOPERATORS>
</GAPARMS>
<DATA>
<CLEARDATABASE />
<WINDOW starttime="2000-05-15 09:00:00" />
<NEWOBJECTS>
<OBJECT type="job" >
<FIELD name="id" value="welding 1" />
<FIELD name="duration_in_seconds" value="300.00" />
<FIELD name="quals_required" >
<OBJECT type="quals" >
<FIELD name="welding" value="true" />
<FIELD name="cutting" value="false" />
<FIELD name="painting" value="false" />
</OBJECT>
</FIELD>
<FIELD name="preceeding_tasks" >
<LIST>
<VALUE value="cutting 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="job" >
<FIELD name="id" value="welding 2" />
<FIELD name="duration_in_seconds" value="240.00" />
<FIELD name="quals_required" >
<OBJECT type="quals" >
<FIELD name="welding" value="true" />
<FIELD name="cutting" value="false" />
<FIELD name="painting" value="false" />
</OBJECT>
</FIELD>
<FIELD name="preceeding_tasks" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="job" >
<FIELD name="id" value="cutting 1" />
<FIELD name="duration_in_seconds" value="840.00" />
<FIELD name="quals_required" >
<OBJECT type="quals" >
<FIELD name="welding" value="false" />
<FIELD name="cutting" value="true" />
<FIELD name="painting" value="false" />
</OBJECT>
</FIELD>
<FIELD name="preceeding_tasks" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="job" >
<FIELD name="id" value="painting 1" />
<FIELD name="duration_in_seconds" value="540.00" />
<FIELD name="quals_required" >
<OBJECT type="quals" >
<FIELD name="welding" value="false" />
<FIELD name="cutting" value="false" />
<FIELD name="painting" value="true" />
</OBJECT>
</FIELD>
<FIELD name="preceeding_tasks" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="job" >
<FIELD name="id" value="painting 2" />
<FIELD name="duration_in_seconds" value="360.00" />
<FIELD name="quals_required" >
<OBJECT type="quals" >
<FIELD name="welding" value="false" />
<FIELD name="cutting" value="false" />
<FIELD name="painting" value="true" />
</OBJECT>
</FIELD>
<FIELD name="preceeding_tasks" >
<LIST>
<VALUE value="welding 1" />
<VALUE value="welding 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 1" />
<FIELD name="factloc" value="factory_location" />
<FIELD name="quals" >
<OBJECT type="quals" >
<FIELD name="welding" value="true" />
<FIELD name="cutting" value="true" />
<FIELD name="painting" value="false" />
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
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 2" />
<FIELD name="factloc" value="factory_loc" />
<FIELD name="quals" >
<OBJECT type="quals" >
<FIELD name="welding" value="false" />
<FIELD name="cutting" value="false" />
<FIELD name="painting" value="true" />
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
<GLOBAL name="factory_location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.544" />
<FIELD name="longitude" value="-37.441" />
</OBJECT>
</GLOBAL>
<GLOBAL name="distances" >
<OBJECT type="matrix" >
<FIELD name="numrows" value="3" />
<FIELD name="numcols" value="4" />
<FIELD name="values" >
<LIST>
<VALUE value="1" />
<VALUE value="2" />
<VALUE value="3" />
<VALUE value="4" />
<VALUE value="2" />
<VALUE value="3" />
<VALUE value="4" />
<VALUE value="5" />
<VALUE value="3" />
<VALUE value="4" />
<VALUE value="5" />
<VALUE value="6" />
</LIST>
</FIELD>
</OBJECT>
</GLOBAL>
</NEWOBJECTS>
</DATA>
</PROBLEM>
