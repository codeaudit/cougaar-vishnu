<?xml version='1.0'?>
<PROBLEM name="jobshop_mt10" description="This is the classic Muth-Thompson 10x10 job-shop scheduling problem. \\nThere are six machines and six jobs. \\nEach job has six different steps, with each step being a separate \\ntask and each step capable of being performed by only one machine. \\nFor each job, there is exactly one step matched with each machine. \\nThe steps for each job must be performed in a specific order. \\nEach step requires a specified amount of time. \\nThe optimization criterion is the makespan, i.e. the \\ntime at which the last step/task completes.\\nThe genetic algorithm parameters are set so that the search\\nis slow, but the solution is good (although still suboptimal)." >
<DATAFORMAT>
<OBJECTFORMAT name="machine" is_task="false" is_resource="true" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
</OBJECTFORMAT>
<OBJECTFORMAT name="step" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="job" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="step" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="duration_in_seconds" datatype="number" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="assigned_machine" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="preceeding_steps" datatype="string" is_subobject="false" is_globalptr="false" is_list="true" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" multitasking="none" >
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
<COLORTEST color="orange" obj_type="task" title="Job 7" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="7" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="chocolate" obj_type="task" title="Job 8" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="8" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="lightblue" obj_type="task" title="Job 9" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="9" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="pink" obj_type="task" title="Job 10" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="job" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="10" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
</COLORTESTS>
</SPECS>
<GAPARMS pop_size="50009" parent_scalar="0.99980" max_evals="1000000" max_time="1500000" max_duplicates="9900000" max_top_dog_age="9900000" report_interval="100" initializer="org.cougaar.lib.vishnu.server.OrderedInitializer" decoder="org.cougaar.lib.vishnu.server.OrderedDecoder" >
<GAOPERATORS>
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedMutation" prob="0.5" parms="1.0" />
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedCrossover" prob="0.5" />
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
<FIELD name="duration_in_seconds" value="29" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 10" />
<FIELD name="job" value="1" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="21" />
<FIELD name="assigned_machine" value="machine 10" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 2" />
<FIELD name="job" value="1" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="78" />
<FIELD name="assigned_machine" value="machine 2" />
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
<FIELD name="duration_in_seconds" value="9" />
<FIELD name="assigned_machine" value="machine 3" />
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
<FIELD name="duration_in_seconds" value="36" />
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
<FIELD name="duration_in_seconds" value="49" />
<FIELD name="assigned_machine" value="machine 5" />
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
<FIELD name="duration_in_seconds" value="11" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 7" />
<FIELD name="job" value="1" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="62" />
<FIELD name="assigned_machine" value="machine 7" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 8" />
<FIELD name="job" value="1" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="56" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 1 step 9" />
<FIELD name="job" value="1" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="44" />
<FIELD name="assigned_machine" value="machine 9" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 1 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 1" />
<FIELD name="job" value="10" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="85" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 10" />
<FIELD name="job" value="10" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="45" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 10 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 2" />
<FIELD name="job" value="10" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="13" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 10 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 3" />
<FIELD name="job" value="10" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="61" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 10 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 4" />
<FIELD name="job" value="10" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="7" />
<FIELD name="assigned_machine" value="machine 7" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 10 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 5" />
<FIELD name="job" value="10" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="64" />
<FIELD name="assigned_machine" value="machine 9" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 10 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 6" />
<FIELD name="job" value="10" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="76" />
<FIELD name="assigned_machine" value="machine 10" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 10 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 7" />
<FIELD name="job" value="10" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="47" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 10 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 8" />
<FIELD name="job" value="10" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="52" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 10 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 10 step 9" />
<FIELD name="job" value="10" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="90" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 10 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 1" />
<FIELD name="job" value="2" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="43" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 10" />
<FIELD name="job" value="2" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="30" />
<FIELD name="assigned_machine" value="machine 9" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 2" />
<FIELD name="job" value="2" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="90" />
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
<FIELD name="duration_in_seconds" value="75" />
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
<FIELD name="duration_in_seconds" value="11" />
<FIELD name="assigned_machine" value="machine 10" />
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
<FIELD name="duration_in_seconds" value="69" />
<FIELD name="assigned_machine" value="machine 4" />
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
<FIELD name="duration_in_seconds" value="28" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 7" />
<FIELD name="job" value="2" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="46" />
<FIELD name="assigned_machine" value="machine 7" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 8" />
<FIELD name="job" value="2" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="46" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 2 step 9" />
<FIELD name="job" value="2" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="72" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 2 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 1" />
<FIELD name="job" value="3" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="91" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 10" />
<FIELD name="job" value="3" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="33" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 2" />
<FIELD name="job" value="3" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="85" />
<FIELD name="assigned_machine" value="machine 1" />
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
<FIELD name="duration_in_seconds" value="39" />
<FIELD name="assigned_machine" value="machine 4" />
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
<FIELD name="duration_in_seconds" value="74" />
<FIELD name="assigned_machine" value="machine 3" />
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
<FIELD name="duration_in_seconds" value="90" />
<FIELD name="assigned_machine" value="machine 9" />
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
<FIELD name="duration_in_seconds" value="10" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 7" />
<FIELD name="job" value="3" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="12" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 8" />
<FIELD name="job" value="3" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="89" />
<FIELD name="assigned_machine" value="machine 7" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 3 step 9" />
<FIELD name="job" value="3" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="45" />
<FIELD name="assigned_machine" value="machine 10" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 3 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 1" />
<FIELD name="job" value="4" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="81" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 10" />
<FIELD name="job" value="4" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="43" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 2" />
<FIELD name="job" value="4" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="95" />
<FIELD name="assigned_machine" value="machine 3" />
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
<FIELD name="duration_in_seconds" value="71" />
<FIELD name="assigned_machine" value="machine 1" />
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
<FIELD name="duration_in_seconds" value="99" />
<FIELD name="assigned_machine" value="machine 5" />
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
<FIELD name="duration_in_seconds" value="9" />
<FIELD name="assigned_machine" value="machine 7" />
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
<FIELD name="duration_in_seconds" value="52" />
<FIELD name="assigned_machine" value="machine 9" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 7" />
<FIELD name="job" value="4" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="85" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 8" />
<FIELD name="job" value="4" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="98" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 4 step 9" />
<FIELD name="job" value="4" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="22" />
<FIELD name="assigned_machine" value="machine 10" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 4 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 1" />
<FIELD name="job" value="5" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="14" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 10" />
<FIELD name="job" value="5" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="53" />
<FIELD name="assigned_machine" value="machine 7" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 2" />
<FIELD name="job" value="5" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="6" />
<FIELD name="assigned_machine" value="machine 1" />
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
<FIELD name="duration_in_seconds" value="22" />
<FIELD name="assigned_machine" value="machine 2" />
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
<FIELD name="duration_in_seconds" value="61" />
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
<FIELD name="duration_in_seconds" value="26" />
<FIELD name="assigned_machine" value="machine 4" />
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
<FIELD name="duration_in_seconds" value="69" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 7" />
<FIELD name="job" value="5" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="21" />
<FIELD name="assigned_machine" value="machine 9" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 8" />
<FIELD name="job" value="5" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="49" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 5 step 9" />
<FIELD name="job" value="5" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="72" />
<FIELD name="assigned_machine" value="machine 10" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 5 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 1" />
<FIELD name="job" value="6" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="84" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 10" />
<FIELD name="job" value="6" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="25" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 2" />
<FIELD name="job" value="6" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="2" />
<FIELD name="assigned_machine" value="machine 2" />
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
<FIELD name="duration_in_seconds" value="52" />
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
<FIELD name="duration_in_seconds" value="95" />
<FIELD name="assigned_machine" value="machine 4" />
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
<FIELD name="duration_in_seconds" value="48" />
<FIELD name="assigned_machine" value="machine 9" />
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
<FIELD name="duration_in_seconds" value="72" />
<FIELD name="assigned_machine" value="machine 10" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 7" />
<FIELD name="job" value="6" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="47" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 8" />
<FIELD name="job" value="6" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="65" />
<FIELD name="assigned_machine" value="machine 7" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 6 step 9" />
<FIELD name="job" value="6" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="6" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 6 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 1" />
<FIELD name="job" value="7" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="46" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 10" />
<FIELD name="job" value="7" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="55" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 7 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 2" />
<FIELD name="job" value="7" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="37" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 7 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 3" />
<FIELD name="job" value="7" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="61" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 7 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 4" />
<FIELD name="job" value="7" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="13" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 7 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 5" />
<FIELD name="job" value="7" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="32" />
<FIELD name="assigned_machine" value="machine 7" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 7 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 6" />
<FIELD name="job" value="7" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="21" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 7 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 7" />
<FIELD name="job" value="7" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="32" />
<FIELD name="assigned_machine" value="machine 10" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 7 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 8" />
<FIELD name="job" value="7" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="89" />
<FIELD name="assigned_machine" value="machine 9" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 7 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 7 step 9" />
<FIELD name="job" value="7" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="30" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 7 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 1" />
<FIELD name="job" value="8" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="31" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 10" />
<FIELD name="job" value="8" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="79" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 8 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 2" />
<FIELD name="job" value="8" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="86" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 8 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 3" />
<FIELD name="job" value="8" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="46" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 8 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 4" />
<FIELD name="job" value="8" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="74" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 8 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 5" />
<FIELD name="job" value="8" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="32" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 8 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 6" />
<FIELD name="job" value="8" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="88" />
<FIELD name="assigned_machine" value="machine 7" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 8 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 7" />
<FIELD name="job" value="8" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="19" />
<FIELD name="assigned_machine" value="machine 9" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 8 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 8" />
<FIELD name="job" value="8" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="48" />
<FIELD name="assigned_machine" value="machine 10" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 8 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 8 step 9" />
<FIELD name="job" value="8" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="36" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 8 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 1" />
<FIELD name="job" value="9" />
<FIELD name="step" value="1" />
<FIELD name="duration_in_seconds" value="76" />
<FIELD name="assigned_machine" value="machine 1" />
<FIELD name="preceeding_steps" >
<LIST>
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 10" />
<FIELD name="job" value="9" />
<FIELD name="step" value="10" />
<FIELD name="duration_in_seconds" value="74" />
<FIELD name="assigned_machine" value="machine 9" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 9 step 9" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 2" />
<FIELD name="job" value="9" />
<FIELD name="step" value="2" />
<FIELD name="duration_in_seconds" value="69" />
<FIELD name="assigned_machine" value="machine 2" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 9 step 1" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 3" />
<FIELD name="job" value="9" />
<FIELD name="step" value="3" />
<FIELD name="duration_in_seconds" value="76" />
<FIELD name="assigned_machine" value="machine 4" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 9 step 2" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 4" />
<FIELD name="job" value="9" />
<FIELD name="step" value="4" />
<FIELD name="duration_in_seconds" value="51" />
<FIELD name="assigned_machine" value="machine 6" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 9 step 3" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 5" />
<FIELD name="job" value="9" />
<FIELD name="step" value="5" />
<FIELD name="duration_in_seconds" value="85" />
<FIELD name="assigned_machine" value="machine 3" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 9 step 4" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 6" />
<FIELD name="job" value="9" />
<FIELD name="step" value="6" />
<FIELD name="duration_in_seconds" value="11" />
<FIELD name="assigned_machine" value="machine 10" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 9 step 5" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 7" />
<FIELD name="job" value="9" />
<FIELD name="step" value="7" />
<FIELD name="duration_in_seconds" value="40" />
<FIELD name="assigned_machine" value="machine 7" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 9 step 6" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 8" />
<FIELD name="job" value="9" />
<FIELD name="step" value="8" />
<FIELD name="duration_in_seconds" value="89" />
<FIELD name="assigned_machine" value="machine 8" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 9 step 7" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="step" >
<FIELD name="id" value="job 9 step 9" />
<FIELD name="job" value="9" />
<FIELD name="step" value="9" />
<FIELD name="duration_in_seconds" value="26" />
<FIELD name="assigned_machine" value="machine 5" />
<FIELD name="preceeding_steps" >
<LIST>
<VALUE value="job 9 step 8" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 1" />
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 10" />
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
<OBJECT type="machine" >
<FIELD name="id" value="machine 7" />
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 8" />
</OBJECT>
<OBJECT type="machine" >
<FIELD name="id" value="machine 9" />
</OBJECT>
</NEWOBJECTS>
</DATA>
</PROBLEM>
