<?xml version='1.0'?>
<PROBLEM name="cvrp_vrpnc1" >
<DATAFORMAT>
<OBJECTFORMAT name="vehicle" is_task="false" is_resource="true" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
</OBJECTFORMAT>
<OBJECTFORMAT name="customer" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
<FIELDFORMAT name="load" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="location" datatype="xy_coord" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="extradata" is_task="false" is_resource="false" >
<FIELDFORMAT name="capacity" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="drop_time" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="depot_location" datatype="xy_coord" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" setupdisplay="line" >
<OPTCRITERION>
<OPERATOR operation="sumover" >
<LITERAL value="resources" type="variable" datatype="list:resource" />
<LITERAL value="resource" type="constant" datatype="string" />
<OPERATOR operation="-" >
<OPERATOR operation="complete" >
<LITERAL value="resource" type="variable" datatype="resource" />
</OPERATOR>
<LITERAL value="start_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</OPTCRITERION>
<DELTACRITERION>
<OPERATOR operation="-" >
<OPERATOR operation="-" >
<OPERATOR operation="complete" >
<LITERAL value="resource" type="variable" datatype="resource" />
</OPERATOR>
<LITERAL value="start_time" type="variable" datatype="datetime" />
</OPERATOR>
<OPERATOR operation="previousdelta" >
<LITERAL value="resource" type="variable" datatype="resource" />
</OPERATOR>
</OPERATOR>
</DELTACRITERION>
<TASKDURATION>
<LITERAL value="0" type="constant" datatype="number" />
</TASKDURATION>
<SETUPDURATION>
<OPERATOR operation="dist" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="xy_coord" />
</OPERATOR>
<OPERATOR operation="if" >
<OPERATOR operation="hasvalue" >
<LITERAL value="previous" type="variable" datatype="task" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="previous" type="variable" datatype="task" />
<LITERAL value="location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="xy_coord" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="extradata" type="variable" datatype="extradata" />
<LITERAL value="depot_location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="xy_coord" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</SETUPDURATION>
<WRAPUPDURATION>
<OPERATOR operation="if" >
<OPERATOR operation="hasvalue" >
<LITERAL value="next" type="variable" datatype="task" />
</OPERATOR>
<LITERAL value="0" type="constant" datatype="number" />
<OPERATOR operation="dist" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="xy_coord" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="extradata" type="variable" datatype="extradata" />
<LITERAL value="depot_location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="xy_coord" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</WRAPUPDURATION>
<CAPACITYCONTRIB>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</CAPACITYCONTRIB>
<CAPACITYTHRESH>
<OPERATOR operation="get" >
<LITERAL value="extradata" type="variable" datatype="extradata" />
<LITERAL value="capacity" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</CAPACITYTHRESH>
<TASKTEXT>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</TASKTEXT>
<COLORTESTS>
<COLORTEST color="red" obj_type="task" title="1 mod 5" >
<OPERATOR operation="=" >
<OPERATOR operation="mod" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="5" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="1" type="constant" datatype="number" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="green" obj_type="task" title="2 mod 5" >
<OPERATOR operation="=" >
<OPERATOR operation="mod" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="5" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="2" type="constant" datatype="number" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="cornflowerblue" obj_type="task" title="3 mod 5" >
<OPERATOR operation="=" >
<OPERATOR operation="mod" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="5" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="3" type="constant" datatype="number" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="violet" obj_type="task" title="4 mod 5" >
<OPERATOR operation="=" >
<OPERATOR operation="mod" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="5" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="4" type="constant" datatype="number" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="yellow" obj_type="task" title="0 mod 5" >
<OPERATOR operation="=" >
<OPERATOR operation="mod" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="5" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="0" type="constant" datatype="number" />
</OPERATOR>
</COLORTEST>
</COLORTESTS>
</SPECS>
<GAPARMS pop_size="1000" parent_scalar="0.99" max_evals="10000" max_time="120" max_duplicates="3000" max_top_dog_age="3000" initializer="org.cougaar.lib.vishnu.server.OrderedInitializer" decoder="org.cougaar.lib.vishnu.server.OrderedDecoder" >
<GAOPERATORS>
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedMutation" prob="0.50" parms="0.8" />
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedCrossover" prob="0.50" />
</GAOPERATORS>
</GAPARMS>
<DATA>
<CLEARDATABASE />
<WINDOW starttime="2000-01-01 00:00:00" />
<NEWOBJECTS>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 1" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 2" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 3" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 4" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 5" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 6" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 7" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 8" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 1" />
<FIELD name="load" value="7" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="37" />
<FIELD name="y" value="52" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 2" />
<FIELD name="load" value="30" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="49" />
<FIELD name="y" value="49" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 3" />
<FIELD name="load" value="16" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="52" />
<FIELD name="y" value="64" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 4" />
<FIELD name="load" value="9" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="20" />
<FIELD name="y" value="26" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 5" />
<FIELD name="load" value="21" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="40" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 6" />
<FIELD name="load" value="15" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="21" />
<FIELD name="y" value="47" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 7" />
<FIELD name="load" value="19" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="17" />
<FIELD name="y" value="63" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 8" />
<FIELD name="load" value="23" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="31" />
<FIELD name="y" value="62" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 9" />
<FIELD name="load" value="11" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="52" />
<FIELD name="y" value="33" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 10" />
<FIELD name="load" value="5" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="51" />
<FIELD name="y" value="21" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 11" />
<FIELD name="load" value="19" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="42" />
<FIELD name="y" value="41" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 12" />
<FIELD name="load" value="29" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="31" />
<FIELD name="y" value="32" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 13" />
<FIELD name="load" value="23" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="5" />
<FIELD name="y" value="25" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 14" />
<FIELD name="load" value="21" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="12" />
<FIELD name="y" value="42" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 15" />
<FIELD name="load" value="10" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="36" />
<FIELD name="y" value="16" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 16" />
<FIELD name="load" value="15" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="52" />
<FIELD name="y" value="41" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 17" />
<FIELD name="load" value="3" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="27" />
<FIELD name="y" value="23" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 18" />
<FIELD name="load" value="41" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="17" />
<FIELD name="y" value="33" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 19" />
<FIELD name="load" value="9" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="13" />
<FIELD name="y" value="13" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 20" />
<FIELD name="load" value="28" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="57" />
<FIELD name="y" value="58" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 21" />
<FIELD name="load" value="8" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="62" />
<FIELD name="y" value="42" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 22" />
<FIELD name="load" value="8" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="42" />
<FIELD name="y" value="57" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 23" />
<FIELD name="load" value="16" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="16" />
<FIELD name="y" value="57" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 24" />
<FIELD name="load" value="10" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="8" />
<FIELD name="y" value="52" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 25" />
<FIELD name="load" value="28" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="7" />
<FIELD name="y" value="38" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 26" />
<FIELD name="load" value="7" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="27" />
<FIELD name="y" value="68" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 27" />
<FIELD name="load" value="15" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="30" />
<FIELD name="y" value="48" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 28" />
<FIELD name="load" value="14" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="43" />
<FIELD name="y" value="67" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 29" />
<FIELD name="load" value="6" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="58" />
<FIELD name="y" value="48" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 30" />
<FIELD name="load" value="19" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="58" />
<FIELD name="y" value="27" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 31" />
<FIELD name="load" value="11" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="37" />
<FIELD name="y" value="69" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 32" />
<FIELD name="load" value="12" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="38" />
<FIELD name="y" value="46" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 33" />
<FIELD name="load" value="23" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="46" />
<FIELD name="y" value="10" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 34" />
<FIELD name="load" value="26" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="61" />
<FIELD name="y" value="33" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 35" />
<FIELD name="load" value="17" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="62" />
<FIELD name="y" value="63" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 36" />
<FIELD name="load" value="6" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="63" />
<FIELD name="y" value="69" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 37" />
<FIELD name="load" value="9" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="32" />
<FIELD name="y" value="22" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 38" />
<FIELD name="load" value="15" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="45" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 39" />
<FIELD name="load" value="14" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="59" />
<FIELD name="y" value="15" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 40" />
<FIELD name="load" value="7" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="5" />
<FIELD name="y" value="6" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 41" />
<FIELD name="load" value="27" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="10" />
<FIELD name="y" value="17" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 42" />
<FIELD name="load" value="13" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="21" />
<FIELD name="y" value="10" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 43" />
<FIELD name="load" value="11" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="5" />
<FIELD name="y" value="64" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 44" />
<FIELD name="load" value="16" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="30" />
<FIELD name="y" value="15" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 45" />
<FIELD name="load" value="10" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="39" />
<FIELD name="y" value="10" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 46" />
<FIELD name="load" value="5" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="32" />
<FIELD name="y" value="39" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 47" />
<FIELD name="load" value="25" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="25" />
<FIELD name="y" value="32" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 48" />
<FIELD name="load" value="17" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="25" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 49" />
<FIELD name="load" value="18" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="48" />
<FIELD name="y" value="28" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 50" />
<FIELD name="load" value="10" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="56" />
<FIELD name="y" value="37" />
</OBJECT>
</FIELD>
</OBJECT>
<GLOBAL name="extradata" >
<OBJECT type="extradata" >
<FIELD name="capacity" value="160" />
<FIELD name="drop_time" value="0" />
<FIELD name="depot_location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="30" />
<FIELD name="y" value="40" />
</OBJECT>
</FIELD>
</OBJECT>
</GLOBAL>
</NEWOBJECTS>
</DATA>
</PROBLEM>
