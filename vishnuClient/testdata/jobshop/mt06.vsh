<?xml version='1.0'?>
<PROBLEM name="jobshop_mt06" >
<DATAFORMAT>
<OBJECTFORMAT name="machine" is_task="false" is_resource="true" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
</OBJECTFORMAT>
<OBJECTFORMAT name="step" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
<FIELDFORMAT name="job" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="step" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="duration_in_seconds" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="assigned_machine" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="preceeding_steps" datatype="string" is_subobject="false" is_list="true" is_key="false" />
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
<CAPABILITY>
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="assigned_machine" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="id" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</OPERATOR>
</CAPABILITY>
<PREREQUISITES>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="preceeding_steps" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:string" />
</OPERATOR>
</PREREQUISITES>
<TASKUNAVAIL>
<OPERATOR operation="mapover" >
<LITERAL value="prerequisites" type="variable" datatype="list:task" />
<LITERAL value="preceeding_task" type="constant" datatype="string" />
<OPERATOR operation="interval" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="taskendtime" >
<LITERAL value="preceeding_task" type="variable" datatype="task" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</TASKUNAVAIL>
<TASKTEXT>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="step" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</TASKTEXT>
<COLORTESTS>
<COLORTEST color="red" obj_type="task" title="Job 1" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="1" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="green" obj_type="task" title="Job 2" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="2" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="blue" obj_type="task" title="Job 3" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="3" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="yellow" obj_type="task" title="Job 4" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="4" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="cyan" obj_type="task" title="Job 5" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="5" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="magenta" obj_type="task" title="Job 6" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="6" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
</COLORTESTS>
</SPECS>
<GAPARMS pop_size="1000" parent_scalar="0.99" max_evals="5000" max_time="300" max_duplicates="5000" max_top_dog_age="5000" report_interval="20" initializer="org.cougaar.lib.vishnu.server.OrderedInitializer" decoder="org.cougaar.lib.vishnu.server.OrderedDecoder" >
<GAOPERATORS>
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedMutation" prob="0.50" parms="0.8" />
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedCrossover" prob="0.50" />
</GAOPERATORS>
</GAPARMS>
<DATA>
<CLEARDATABASE />
<WINDOW starttime="2000-01-01 00:00:00" />
<NEWOBJECTS>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 1" />
<FIELD name="job" value="1" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="1.00" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 2" />
<FIELD name="job" value="1" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="3.00" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 3" />
<FIELD name="job" value="1" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="6.00" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 4" />
<FIELD name="job" value="1" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="7.00" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 5" />
<FIELD name="job" value="1" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="3.00" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 6" />
<FIELD name="job" value="1" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="6.00" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 1" />
<FIELD name="job" value="2" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="8.00" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 2" />
<FIELD name="job" value="2" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="5.00" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 3" />
<FIELD name="job" value="2" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="10.00" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 4" />
<FIELD name="job" value="2" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="10.00" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 5" />
<FIELD name="job" value="2" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="10.00" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 6" />
<FIELD name="job" value="2" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="4.00" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 1" />
<FIELD name="job" value="3" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="5.00" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 2" />
<FIELD name="job" value="3" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="4.00" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 3" />
<FIELD name="job" value="3" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="8.00" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 4" />
<FIELD name="job" value="3" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="9.00" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 5" />
<FIELD name="job" value="3" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="1.00" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 6" />
<FIELD name="job" value="3" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="7.00" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 1" />
<FIELD name="job" value="4" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="5.00" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 2" />
<FIELD name="job" value="4" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="5.00" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 3" />
<FIELD name="job" value="4" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="5.00" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 4" />
<FIELD name="job" value="4" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="3.00" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 5" />
<FIELD name="job" value="4" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="8.00" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 6" />
<FIELD name="job" value="4" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="9.00" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 1" />
<FIELD name="job" value="5" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="9.00" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 2" />
<FIELD name="job" value="5" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="3.00" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 3" />
<FIELD name="job" value="5" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="5.00" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 4" />
<FIELD name="job" value="5" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="4.00" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 5" />
<FIELD name="job" value="5" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="3.00" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 6" />
<FIELD name="job" value="5" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="1.00" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 1" />
<FIELD name="job" value="6" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="3.00" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 2" />
<FIELD name="job" value="6" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="3.00" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 3" />
<FIELD name="job" value="6" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="9.00" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 4" />
<FIELD name="job" value="6" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="10.00" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 5" />
<FIELD name="job" value="6" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="4.00" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 6" />
<FIELD name="job" value="6" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="1.00" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 1" />
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 2" />
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 3" />
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 4" />
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 5" />
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 6" />
</OBJECT>
</NEWOBJECTS>
</DATA>
</PROBLEM>
