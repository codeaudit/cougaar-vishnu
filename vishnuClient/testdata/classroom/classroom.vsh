<?xml version='1.0'?>
<PROBLEM name="classroom" >
<DATAFORMAT>
<OBJECTFORMAT name="classroom" is_task="false" is_resource="true" >
<FIELDFORMAT name="room_number" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="max_people" datatype="number" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="features" datatype="string" is_subobject="false" is_globalptr="false" is_list="true" is_key="false" />
<FIELDFORMAT name="building" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="class" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="num_people" datatype="number" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="required_features" datatype="string" is_subobject="false" is_globalptr="false" is_list="true" is_key="false" />
<FIELDFORMAT name="name" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="start_time" datatype="datetime" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="end_time" datatype="datetime" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="building_preference" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" multitasking="none" >
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
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<OPERATOR operation="resourcefor" >
<LITERAL value="t" type="variable" datatype="task" />
</OPERATOR>
<LITERAL value="building" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="t" type="variable" datatype="task" />
<LITERAL value="building_preference" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</OPERATOR>
<LITERAL value="0.0" type="constant" datatype="number" />
<LITERAL value="1.0" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="1000.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPTCRITERION>
<DELTACRITERION>
<OPERATOR operation="if" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="building" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="building_preference" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</OPERATOR>
<LITERAL value="0.0" type="constant" datatype="number" />
<LITERAL value="1.0" type="constant" datatype="number" />
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
<OPERATOR operation="and" >
<OPERATOR operation="&gt;=" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="max_people" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="num_people" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="andover" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="required_features" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:string" />
</OPERATOR>
<LITERAL value="f" type="constant" datatype="string" />
<OPERATOR operation="hasvalue" >
<OPERATOR operation="position" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="features" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:string" />
</OPERATOR>
<LITERAL value="f" type="variable" datatype="string" />
</OPERATOR>
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
<TASKTEXT>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="id" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</TASKTEXT>
<COLORTESTS>
<COLORTEST color="red" obj_type="task" title="preferred building" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="building_preference" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<OPERATOR operation="get" >
<OPERATOR operation="resourcefor" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
<LITERAL value="building" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</OPERATOR>
</COLORTEST>
<COLORTEST color="green" obj_type="task" title="not preferred building" >
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
<FIELD name="id" value="CSI101" />
<FIELD name="num_people" value="14" />
<FIELD name="required_features" >
<LIST>
<VALUE value="stage" />
</LIST>
</FIELD>
<FIELD name="name" value="Crime Scene Investigation" />
<FIELD name="start_time" value="2001-09-01 09:00:00" />
<FIELD name="end_time" value="2001-09-01 11:00:00" />
<FIELD name="building_preference" value="B" />
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="EC101" />
<FIELD name="num_people" value="15" />
<FIELD name="required_features" >
<LIST>
<VALUE value="video" />
</LIST>
</FIELD>
<FIELD name="name" value="Evidence Collection" />
<FIELD name="start_time" value="2001-09-01 09:30:00" />
<FIELD name="end_time" value="2001-09-01 12:00:00" />
<FIELD name="building_preference" value="B" />
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="HC1a" />
<FIELD name="num_people" value="70" />
<FIELD name="required_features" >
<LIST>
</LIST>
</FIELD>
<FIELD name="name" value="Beginning Handcuffing" />
<FIELD name="start_time" value="2001-09-01 09:00:00" />
<FIELD name="end_time" value="2001-09-01 11:30:00" />
<FIELD name="building_preference" value="A" />
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="MM1a" />
<FIELD name="num_people" value="30" />
<FIELD name="required_features" >
<LIST>
<VALUE value="video" />
<VALUE value="stage" />
</LIST>
</FIELD>
<FIELD name="name" value="Beginning Marksman" />
<FIELD name="start_time" value="2001-09-01 09:00:00" />
<FIELD name="end_time" value="2001-09-01 10:30:00" />
<FIELD name="building_preference" value="A" />
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="OR1" />
<FIELD name="num_people" value="18" />
<FIELD name="required_features" >
<LIST>
</LIST>
</FIELD>
<FIELD name="name" value="Orientation" />
<FIELD name="start_time" value="2001-09-01 14:00:00" />
<FIELD name="end_time" value="2001-09-01 17:00:00" />
<FIELD name="building_preference" value="A" />
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="OR2" />
<FIELD name="num_people" value="19" />
<FIELD name="required_features" >
<LIST>
</LIST>
</FIELD>
<FIELD name="name" value="Orientation 2" />
<FIELD name="start_time" value="2001-09-01 14:00:00" />
<FIELD name="end_time" value="2001-09-01 17:00:00" />
<FIELD name="building_preference" value="A" />
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="OR3" />
<FIELD name="num_people" value="18" />
<FIELD name="required_features" >
<LIST>
</LIST>
</FIELD>
<FIELD name="name" value="Orientation 3" />
<FIELD name="start_time" value="2001-09-01 14:00:00" />
<FIELD name="end_time" value="2001-09-01 17:00:00" />
<FIELD name="building_preference" value="B" />
</OBJECT>
<OBJECT type="class" >
<FIELD name="id" value="OR4" />
<FIELD name="num_people" value="19" />
<FIELD name="required_features" >
<LIST>
</LIST>
</FIELD>
<FIELD name="name" value="Orientation 4" />
<FIELD name="start_time" value="2001-09-01 14:00:00" />
<FIELD name="end_time" value="2001-09-01 17:00:00" />
<FIELD name="building_preference" value="B" />
</OBJECT>
<OBJECT type="classroom" >
<FIELD name="room_number" value="A111" />
<FIELD name="max_people" value="20" />
<FIELD name="features" >
<LIST>
<VALUE value="video" />
</LIST>
</FIELD>
<FIELD name="building" value="A" />
</OBJECT>
<OBJECT type="classroom" >
<FIELD name="room_number" value="A222" />
<FIELD name="max_people" value="40" />
<FIELD name="features" >
<LIST>
<VALUE value="stage" />
</LIST>
</FIELD>
<FIELD name="building" value="A" />
</OBJECT>
<OBJECT type="classroom" >
<FIELD name="room_number" value="B111" />
<FIELD name="max_people" value="40" />
<FIELD name="features" >
<LIST>
<VALUE value="video" />
<VALUE value="stage" />
</LIST>
</FIELD>
<FIELD name="building" value="B" />
</OBJECT>
<OBJECT type="classroom" >
<FIELD name="room_number" value="B333" />
<FIELD name="max_people" value="80" />
<FIELD name="features" >
<LIST>
</LIST>
</FIELD>
<FIELD name="building" value="B" />
</OBJECT>
</NEWOBJECTS>
</DATA>
</PROBLEM>
