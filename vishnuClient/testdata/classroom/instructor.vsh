<?xml version='1.0'?>
<PROBLEM name="instructor" >
<DATAFORMAT>
<OBJECTFORMAT name="instructor" is_task="false" is_resource="true" >
<FIELDFORMAT name="name" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="qualifications" datatype="string" is_subobject="false" is_globalptr="false" is_list="true" is_key="false" />
<FIELDFORMAT name="busy_times" datatype="interval" is_subobject="true" is_globalptr="false" is_list="true" is_key="false" />
<FIELDFORMAT name="telephone_number" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="class" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="name" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="start_time" datatype="datetime" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="end_time" datatype="datetime" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="required_quals" datatype="string" is_subobject="false" is_globalptr="false" is_list="true" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" multitasking="none" >
<OPTCRITERION>
<OPERATOR operation="+" >
<OPERATOR operation="sumover" >
<LITERAL value="resources" type="variable" datatype="list:resource" />
<LITERAL value="r" type="constant" datatype="string" />
<OPERATOR operation="*" >
<OPERATOR operation="length" >
<OPERATOR operation="tasksfor" >
<LITERAL value="r" type="variable" datatype="resource" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="length" >
<OPERATOR operation="tasksfor" >
<LITERAL value="r" type="variable" datatype="resource" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
<OPERATOR operation="sumover" >
<LITERAL value="tasks" type="variable" datatype="list:task" />
<LITERAL value="t" type="constant" datatype="string" />
<OPERATOR operation="if" >
<OPERATOR operation="hasvalue" >
<OPERATOR operation="resourcefor" >
<LITERAL value="t" type="variable" datatype="task" />
</OPERATOR>
</OPERATOR>
<LITERAL value="0.0" type="constant" datatype="number" />
<LITERAL value="1000.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPTCRITERION>
<DELTACRITERION>
<OPERATOR operation="length" >
<OPERATOR operation="tasksfor" >
<LITERAL value="resource" type="variable" datatype="resource" />
</OPERATOR>
</OPERATOR>
</DELTACRITERION>
<TASKDURATION>
<OPERATOR operation="-" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="end_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="start_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</TASKDURATION>
<CAPABILITY>
<OPERATOR operation="andover" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="required_quals" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:string" />
</OPERATOR>
<LITERAL value="q" type="constant" datatype="string" />
<OPERATOR operation="hasvalue" >
<OPERATOR operation="position" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="qualifications" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:string" />
</OPERATOR>
<LITERAL value="q" type="variable" datatype="string" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</CAPABILITY>
<TASKUNAVAIL>
<OPERATOR operation="list" >
<OPERATOR operation="interval" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="start_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="interval" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="end_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<LITERAL value="end_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</TASKUNAVAIL>
<RESOURCEUNAVAIL>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="busy_times" type="constant" datatype="string" />
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
<LITERAL value="label1" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</ACTIVITYTEXT>
<COLORTESTS>
<COLORTEST color="red" obj_type="task" title="Handcuffing" >
<OPERATOR operation="hasvalue" >
<OPERATOR operation="position" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="required_quals" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:string" />
</OPERATOR>
<LITERAL value="handcuff" type="constant" datatype="string" />
</OPERATOR>
</OPERATOR>
</COLORTEST>
<COLORTEST color="cyan" obj_type="task" title="Marksman" >
<OPERATOR operation="hasvalue" >
<OPERATOR operation="position" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="required_quals" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:string" />
</OPERATOR>
<LITERAL value="marksman" type="constant" datatype="string" />
</OPERATOR>
</OPERATOR>
</COLORTEST>
<COLORTEST color="yellow" obj_type="activity" title="Unavailable" >
<LITERAL value="true" type="constant" datatype="boolean" />
</COLORTEST>
</COLORTESTS>
</SPECS>
<GAPARMS pop_size="20" parent_scalar="0.70000" max_evals="4000" max_time="20" max_duplicates="300" max_top_dog_age="100" initializer="org.cougaar.lib.vishnu.server.OrderedInitializer" decoder="org.cougaar.lib.vishnu.server.OrderedDecoder" >
<GAOPERATORS>
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedMutation" prob="0.5" parms="1.0" />
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedCrossover" prob="0.5" />
</GAOPERATORS>
</GAPARMS>
<DATA>
<CLEARDATABASE />
<WINDOW starttime="2001-09-01 00:00:00" />
<NEWOBJECTS>
<OBJECT type="class" >
<FIELD name="id" value="HC1a" />
<FIELD name="name" value="Beginning Handcuffing" />
<FIELD name="start_time" value="2001-09-01 09:00:00" />
<FIELD name="end_time" value="2001-09-01 10:30:00" />
<FIELD name="required_quals" >
<LIST>
<VALUE value="handcuff" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="HC1b" />
<FIELD name="name" value="Beginning Handcuffing" />
<FIELD name="start_time" value="2001-09-01 10:30:00" />
<FIELD name="end_time" value="2001-09-01 12:00:00" />
<FIELD name="required_quals" >
<LIST>
<VALUE value="handcuff" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="HC2a" />
<FIELD name="name" value="Advanced Handcuffing" />
<FIELD name="start_time" value="2001-09-01 13:30:00" />
<FIELD name="end_time" value="2001-09-01 15:00:00" />
<FIELD name="required_quals" >
<LIST>
<VALUE value="handcuff" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="HC2b" />
<FIELD name="name" value="Advanced Handcuffing" />
<FIELD name="start_time" value="2001-09-01 15:00:00" />
<FIELD name="end_time" value="2001-09-01 16:30:00" />
<FIELD name="required_quals" >
<LIST>
<VALUE value="handcuff" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="MM1a" />
<FIELD name="name" value="Beginning Marksman" />
<FIELD name="start_time" value="2001-09-01 09:00:00" />
<FIELD name="end_time" value="2001-09-01 10:30:00" />
<FIELD name="required_quals" >
<LIST>
<VALUE value="marksman" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="MM1b" />
<FIELD name="name" value="Beginning Marksman" />
<FIELD name="start_time" value="2001-09-01 10:30:00" />
<FIELD name="end_time" value="2001-09-01 12:00:00" />
<FIELD name="required_quals" >
<LIST>
<VALUE value="marksman" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="MM2a" />
<FIELD name="name" value="Advanced Marksman" />
<FIELD name="start_time" value="2001-09-01 13:30:00" />
<FIELD name="end_time" value="2001-09-01 15:00:00" />
<FIELD name="required_quals" >
<LIST>
<VALUE value="marksman" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="MM2b" />
<FIELD name="name" value="Advanced Marksman" />
<FIELD name="start_time" value="2001-09-01 15:00:00" />
<FIELD name="end_time" value="2001-09-01 16:30:00" />
<FIELD name="required_quals" >
<LIST>
<VALUE value="marksman" />
</LIST>
</FIELD>
</OBJECT>
<OBJECT type="instructor" >
<FIELD name="name" value="Brown, Jack" />
<FIELD name="qualifications" >
<LIST>
<VALUE value="handcuff" />
<VALUE value="marksman" />
</LIST>
</FIELD>
<FIELD name="busy_times" >
<LIST>
</LIST>
</FIELD>
<FIELD name="telephone_number" value="567-2345" />
</OBJECT>
<OBJECT type="instructor" >
<FIELD name="name" value="Johnson, John" />
<FIELD name="qualifications" >
<LIST>
<VALUE value="handcuff" />
</LIST>
</FIELD>
<FIELD name="busy_times" >
<LIST>
</LIST>
</FIELD>
<FIELD name="telephone_number" value="123-4567" />
</OBJECT>
<OBJECT type="instructor" >
<FIELD name="name" value="Smith, Sally" />
<FIELD name="qualifications" >
<LIST>
<VALUE value="marksman" />
</LIST>
</FIELD>
<FIELD name="busy_times" >
<LIST>
</LIST>
</FIELD>
<FIELD name="telephone_number" value="765-4321" />
</OBJECT>
</NEWOBJECTS>
</DATA>
</PROBLEM>
