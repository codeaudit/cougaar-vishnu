<?xml version='1.0'?>
<PROBLEM name="jobshop_testjs" >
<DATAFORMAT>
<OBJECTFORMAT name="machine" is_task="false" is_resource="true" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
<FIELDFORMAT name="quals" datatype="quals" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="location" datatype="xy_coord" is_subobject="true" is_list="false" is_key="false" />
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
<GAPARMS pop_size="3" parent_scalar="0.70" max_evals="20" max_time="60" max_duplicates="10" max_top_dog_age="15" initializer="org.cougaar.lib.vishnu.server.OrderedInitializer" decoder="org.cougaar.lib.vishnu.server.OrderedDecoder" >
<GAOPERATORS>
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedMutation" prob="0.50" parms="0.8" />
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedCrossover" prob="0.50" />
</GAOPERATORS>
</GAPARMS>
<DATA>
<CLEARDATABASE />
<WINDOW starttime="2000-05-15 09:00:00" />
</DATA>
</PROBLEM>
