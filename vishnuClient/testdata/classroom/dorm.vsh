<?xml version='1.0'?>
<PROBLEM name="dormitory" >
<DATAFORMAT>
<OBJECTFORMAT name="room" is_task="false" is_resource="true" >
<FIELDFORMAT name="number" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="gender" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="max_people" datatype="number" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="smoking" datatype="boolean" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="handicap_access" datatype="boolean" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="resident" is_task="true" is_resource="false" >
<FIELDFORMAT name="name" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="gender" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="smoker" datatype="boolean" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="handicapped" datatype="boolean" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="arrival" datatype="datetime" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="departure" datatype="datetime" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" multitasking="ungrouped" >
<OPTCRITERION>
<OPERATOR operation="sumover" >
<LITERAL value="tasks" type="variable" datatype="list:task" />
<LITERAL value="t" type="constant" datatype="string" />
<OPERATOR operation="if" >
<OPERATOR operation="hasvalue" >
<OPERATOR operation="resourcefor" >
<LITERAL value="t" type="variable" datatype="task" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="if" >
<OPERATOR operation="!=" >
<OPERATOR operation="get" >
<LITERAL value="t" type="variable" datatype="task" />
<LITERAL value="smoker" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
<OPERATOR operation="get" >
<OPERATOR operation="resourcefor" >
<LITERAL value="t" type="variable" datatype="task" />
</OPERATOR>
<LITERAL value="smoking" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</OPERATOR>
<LITERAL value="10.0" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="1000.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPTCRITERION>
<DELTACRITERION>
<OPERATOR operation="if" >
<OPERATOR operation="!=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="smoker" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="smoking" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</OPERATOR>
<LITERAL value="10.0" type="constant" datatype="number" />
</OPERATOR>
</DELTACRITERION>
<TASKDURATION>
<OPERATOR operation="-" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="departure" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="arrival" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</TASKDURATION>
<CAPABILITY>
<OPERATOR operation="and" >
<OPERATOR operation="or" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="handicap_access" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
<OPERATOR operation="not" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="handicapped" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="gender" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="gender" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
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
<LITERAL value="arrival" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="interval" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="departure" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<LITERAL value="end_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</TASKUNAVAIL>
<CAPACITYCONTRIB>
<LITERAL value="1.0" type="constant" datatype="number" />
</CAPACITYCONTRIB>
<CAPACITYTHRESH>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="max_people" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</CAPACITYTHRESH>
<COLORTESTS>
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
<OBJECT type="resident" >
<FIELD name="name" value="Abigail" />
<FIELD name="gender" value="female" />
<FIELD name="smoker" value="false" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-01 12:00:00" />
<FIELD name="departure" value="2001-09-05 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Ben" />
<FIELD name="gender" value="male" />
<FIELD name="smoker" value="false" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-01 12:00:00" />
<FIELD name="departure" value="2001-09-07 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Christine" />
<FIELD name="gender" value="female" />
<FIELD name="smoker" value="false" />
<FIELD name="handicapped" value="true" />
<FIELD name="arrival" value="2001-09-03 12:00:00" />
<FIELD name="departure" value="2001-09-07 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="David" />
<FIELD name="gender" value="male" />
<FIELD name="smoker" value="true" />
<FIELD name="handicapped" value="true" />
<FIELD name="arrival" value="2001-09-03 12:00:00" />
<FIELD name="departure" value="2001-09-06 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Ellen" />
<FIELD name="gender" value="female" />
<FIELD name="smoker" value="true" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-01 12:00:00" />
<FIELD name="departure" value="2001-09-07 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Frank" />
<FIELD name="gender" value="male" />
<FIELD name="smoker" value="true" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-04 12:00:00" />
<FIELD name="departure" value="2001-09-06 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Gwen" />
<FIELD name="gender" value="female" />
<FIELD name="smoker" value="false" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-01 12:00:00" />
<FIELD name="departure" value="2001-09-03 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Harry" />
<FIELD name="gender" value="male" />
<FIELD name="smoker" value="false" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-01 12:00:00" />
<FIELD name="departure" value="2001-09-07 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Irene" />
<FIELD name="gender" value="female" />
<FIELD name="smoker" value="false" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-01 12:00:00" />
<FIELD name="departure" value="2001-09-07 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Jerry" />
<FIELD name="gender" value="male" />
<FIELD name="smoker" value="false" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-05 12:00:00" />
<FIELD name="departure" value="2001-09-07 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Karen" />
<FIELD name="gender" value="female" />
<FIELD name="smoker" value="true" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-01 12:00:00" />
<FIELD name="departure" value="2001-09-05 12:00:00" />
</OBJECT>
<OBJECT type="resident" >
<FIELD name="name" value="Lorenzo" />
<FIELD name="gender" value="male" />
<FIELD name="smoker" value="true" />
<FIELD name="handicapped" value="false" />
<FIELD name="arrival" value="2001-09-01 12:00:00" />
<FIELD name="departure" value="2001-09-04 12:00:00" />
</OBJECT>
<OBJECT type="room" >
<FIELD name="number" value="A111" />
<FIELD name="gender" value="male" />
<FIELD name="max_people" value="2" />
<FIELD name="smoking" value="true" />
<FIELD name="handicap_access" value="true" />
</OBJECT>
<OBJECT type="room" >
<FIELD name="number" value="A222" />
<FIELD name="gender" value="male" />
<FIELD name="max_people" value="3" />
<FIELD name="smoking" value="false" />
<FIELD name="handicap_access" value="false" />
</OBJECT>
<OBJECT type="room" >
<FIELD name="number" value="B111" />
<FIELD name="gender" value="female" />
<FIELD name="max_people" value="2" />
<FIELD name="smoking" value="false" />
<FIELD name="handicap_access" value="true" />
</OBJECT>
<OBJECT type="room" >
<FIELD name="number" value="B222" />
<FIELD name="gender" value="female" />
<FIELD name="max_people" value="3" />
<FIELD name="smoking" value="true" />
<FIELD name="handicap_access" value="false" />
</OBJECT>
</NEWOBJECTS>
</DATA>
</PROBLEM>
