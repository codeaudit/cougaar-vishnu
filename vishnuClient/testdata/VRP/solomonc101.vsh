<?xml version='1.0'?>
<PROBLEM name="vrptw_solomonc101" >
<DATAFORMAT>
<OBJECTFORMAT name="vehicle" is_task="false" is_resource="true" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
</OBJECTFORMAT>
<OBJECTFORMAT name="customer" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
<FIELDFORMAT name="load" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="ready_time" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="due_date" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="location" datatype="xy_coord" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="extradata" is_task="false" is_resource="false" >
<FIELDFORMAT name="capacity" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="service_time" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="depot_location" datatype="xy_coord" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" setupdisplay="line" >
<OPTCRITERION>
<OPERATOR operation="+" >
<OPERATOR operation="sumover" >
<LITERAL value="resources" type="variable" datatype="list:resource" />
<LITERAL value="resource" type="constant" datatype="string" />
<OPERATOR operation="preptime" >
<LITERAL value="resource" type="variable" datatype="resource" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="sumover" >
<LITERAL value="tasks" type="variable" datatype="list:task" />
<LITERAL value="task" type="constant" datatype="string" />
<OPERATOR operation="if" >
<OPERATOR operation="hasvalue" >
<OPERATOR operation="resourcefor" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
</OPERATOR>
<LITERAL value="0" type="constant" datatype="number" />
<LITERAL value="1000" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPTCRITERION>
<DELTACRITERION>
<OPERATOR operation="-" >
<OPERATOR operation="preptime" >
<LITERAL value="resource" type="variable" datatype="resource" />
</OPERATOR>
<OPERATOR operation="previousdelta" >
<LITERAL value="resource" type="variable" datatype="resource" />
</OPERATOR>
</OPERATOR>
</DELTACRITERION>
<TASKDURATION>
<OPERATOR operation="get" >
<LITERAL value="extradata" type="variable" datatype="extradata" />
<LITERAL value="service_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
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
<TASKUNAVAIL>
<OPERATOR operation="list" >
<OPERATOR operation="interval" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="+" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="ready_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
<OPERATOR operation="interval" >
<OPERATOR operation="+" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="+" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="due_date" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="extradata" type="variable" datatype="extradata" />
<LITERAL value="service_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
<LITERAL value="end_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</TASKUNAVAIL>
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
<COLORTEST color="red" obj_type="task" title="1-10" >
<OPERATOR operation="&lt;=" >
<OPERATOR operation="/" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="10" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="1" type="constant" datatype="number" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="green" obj_type="task" title="11-20" >
<OPERATOR operation="&lt;=" >
<OPERATOR operation="/" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="10" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="2" type="constant" datatype="number" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="cornflowerblue" obj_type="task" title="21-30" >
<OPERATOR operation="&lt;=" >
<OPERATOR operation="/" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="10" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="3" type="constant" datatype="number" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="violet" obj_type="task" title="31-40" >
<OPERATOR operation="&lt;=" >
<OPERATOR operation="/" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="load" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="10" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="4" type="constant" datatype="number" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="yellow" obj_type="task" title="41+" >
<LITERAL value="true" type="constant" datatype="boolean" />
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
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 9" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 10" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 11" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 12" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 13" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 14" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 15" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 16" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 17" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 18" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 19" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 20" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 21" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 22" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 23" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 24" />
</OBJECT>
<OBJECT type="vehicle" >
<FIELD name="id" value="Vehicle 25" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 1" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="45" />
<FIELD name="y" value="68" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="912" />
<FIELD name="due_date" value="967" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 2" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="45" />
<FIELD name="y" value="70" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="825" />
<FIELD name="due_date" value="870" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 3" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="42" />
<FIELD name="y" value="66" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="65" />
<FIELD name="due_date" value="146" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 4" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="42" />
<FIELD name="y" value="68" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="727" />
<FIELD name="due_date" value="782" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 5" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="42" />
<FIELD name="y" value="65" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="15" />
<FIELD name="due_date" value="67" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 6" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="40" />
<FIELD name="y" value="69" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="621" />
<FIELD name="due_date" value="702" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 7" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="40" />
<FIELD name="y" value="66" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="170" />
<FIELD name="due_date" value="225" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 8" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="38" />
<FIELD name="y" value="68" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="255" />
<FIELD name="due_date" value="324" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 9" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="38" />
<FIELD name="y" value="70" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="534" />
<FIELD name="due_date" value="605" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 10" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="35" />
<FIELD name="y" value="66" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="357" />
<FIELD name="due_date" value="410" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 11" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="35" />
<FIELD name="y" value="69" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="448" />
<FIELD name="due_date" value="505" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 12" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="25" />
<FIELD name="y" value="85" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="652" />
<FIELD name="due_date" value="721" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 13" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="22" />
<FIELD name="y" value="75" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="30" />
<FIELD name="due_date" value="92" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 14" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="22" />
<FIELD name="y" value="85" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="567" />
<FIELD name="due_date" value="620" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 15" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="20" />
<FIELD name="y" value="80" />
</OBJECT>
</FIELD>
<FIELD name="load" value="40" />
<FIELD name="ready_time" value="384" />
<FIELD name="due_date" value="429" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 16" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="20" />
<FIELD name="y" value="85" />
</OBJECT>
</FIELD>
<FIELD name="load" value="40" />
<FIELD name="ready_time" value="475" />
<FIELD name="due_date" value="528" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 17" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="18" />
<FIELD name="y" value="75" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="99" />
<FIELD name="due_date" value="148" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 18" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="15" />
<FIELD name="y" value="75" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="179" />
<FIELD name="due_date" value="254" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 19" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="15" />
<FIELD name="y" value="80" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="278" />
<FIELD name="due_date" value="345" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 20" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="30" />
<FIELD name="y" value="50" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="10" />
<FIELD name="due_date" value="73" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 21" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="30" />
<FIELD name="y" value="52" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="914" />
<FIELD name="due_date" value="965" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 22" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="28" />
<FIELD name="y" value="52" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="812" />
<FIELD name="due_date" value="883" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 23" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="28" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="732" />
<FIELD name="due_date" value="777" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 24" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="25" />
<FIELD name="y" value="50" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="65" />
<FIELD name="due_date" value="144" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 25" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="25" />
<FIELD name="y" value="52" />
</OBJECT>
</FIELD>
<FIELD name="load" value="40" />
<FIELD name="ready_time" value="169" />
<FIELD name="due_date" value="224" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 26" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="25" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="622" />
<FIELD name="due_date" value="701" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 27" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="23" />
<FIELD name="y" value="52" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="261" />
<FIELD name="due_date" value="316" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 28" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="23" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="546" />
<FIELD name="due_date" value="593" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 29" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="20" />
<FIELD name="y" value="50" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="358" />
<FIELD name="due_date" value="405" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 30" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="20" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="449" />
<FIELD name="due_date" value="504" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 31" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="10" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="200" />
<FIELD name="due_date" value="237" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 32" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="10" />
<FIELD name="y" value="40" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="31" />
<FIELD name="due_date" value="100" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 33" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="8" />
<FIELD name="y" value="40" />
</OBJECT>
</FIELD>
<FIELD name="load" value="40" />
<FIELD name="ready_time" value="87" />
<FIELD name="due_date" value="158" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 34" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="8" />
<FIELD name="y" value="45" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="751" />
<FIELD name="due_date" value="816" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 35" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="5" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="283" />
<FIELD name="due_date" value="344" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 36" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="5" />
<FIELD name="y" value="45" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="665" />
<FIELD name="due_date" value="716" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 37" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="2" />
<FIELD name="y" value="40" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="383" />
<FIELD name="due_date" value="434" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 38" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="0" />
<FIELD name="y" value="40" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="479" />
<FIELD name="due_date" value="522" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 39" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="0" />
<FIELD name="y" value="45" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="567" />
<FIELD name="due_date" value="624" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 40" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="35" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="264" />
<FIELD name="due_date" value="321" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 41" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="35" />
<FIELD name="y" value="32" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="166" />
<FIELD name="due_date" value="235" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 42" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="33" />
<FIELD name="y" value="32" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="68" />
<FIELD name="due_date" value="149" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 43" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="33" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="16" />
<FIELD name="due_date" value="80" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 44" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="32" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="359" />
<FIELD name="due_date" value="412" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 45" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="30" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="541" />
<FIELD name="due_date" value="600" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 46" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="30" />
<FIELD name="y" value="32" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="448" />
<FIELD name="due_date" value="509" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 47" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="30" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="1054" />
<FIELD name="due_date" value="1127" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 48" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="28" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="632" />
<FIELD name="due_date" value="693" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 49" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="28" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="1001" />
<FIELD name="due_date" value="1066" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 50" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="26" />
<FIELD name="y" value="32" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="815" />
<FIELD name="due_date" value="880" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 51" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="25" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="725" />
<FIELD name="due_date" value="786" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 52" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="25" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="912" />
<FIELD name="due_date" value="969" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 53" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="44" />
<FIELD name="y" value="5" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="286" />
<FIELD name="due_date" value="347" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 54" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="42" />
<FIELD name="y" value="10" />
</OBJECT>
</FIELD>
<FIELD name="load" value="40" />
<FIELD name="ready_time" value="186" />
<FIELD name="due_date" value="257" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 55" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="42" />
<FIELD name="y" value="15" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="95" />
<FIELD name="due_date" value="158" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 56" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="40" />
<FIELD name="y" value="5" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="385" />
<FIELD name="due_date" value="436" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 57" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="40" />
<FIELD name="y" value="15" />
</OBJECT>
</FIELD>
<FIELD name="load" value="40" />
<FIELD name="ready_time" value="35" />
<FIELD name="due_date" value="87" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 58" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="38" />
<FIELD name="y" value="5" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="471" />
<FIELD name="due_date" value="534" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 59" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="38" />
<FIELD name="y" value="15" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="651" />
<FIELD name="due_date" value="740" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 60" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="35" />
<FIELD name="y" value="5" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="562" />
<FIELD name="due_date" value="629" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 61" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="50" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="531" />
<FIELD name="due_date" value="610" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 62" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="50" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="262" />
<FIELD name="due_date" value="317" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 63" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="50" />
<FIELD name="y" value="40" />
</OBJECT>
</FIELD>
<FIELD name="load" value="50" />
<FIELD name="ready_time" value="171" />
<FIELD name="due_date" value="218" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 64" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="48" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="632" />
<FIELD name="due_date" value="693" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 65" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="48" />
<FIELD name="y" value="40" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="76" />
<FIELD name="due_date" value="129" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 66" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="47" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="826" />
<FIELD name="due_date" value="875" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 67" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="47" />
<FIELD name="y" value="40" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="12" />
<FIELD name="due_date" value="77" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 68" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="45" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="734" />
<FIELD name="due_date" value="777" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 69" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="45" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="916" />
<FIELD name="due_date" value="969" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 70" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="95" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="387" />
<FIELD name="due_date" value="456" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 71" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="95" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="293" />
<FIELD name="due_date" value="360" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 72" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="53" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="450" />
<FIELD name="due_date" value="505" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 73" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="92" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="478" />
<FIELD name="due_date" value="551" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 74" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="53" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="50" />
<FIELD name="ready_time" value="353" />
<FIELD name="due_date" value="412" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 75" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="45" />
<FIELD name="y" value="65" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="997" />
<FIELD name="due_date" value="1068" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 76" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="90" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="203" />
<FIELD name="due_date" value="260" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 77" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="88" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="574" />
<FIELD name="due_date" value="643" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 78" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="88" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="109" />
<FIELD name="due_date" value="170" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 79" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="87" />
<FIELD name="y" value="30" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="668" />
<FIELD name="due_date" value="731" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 80" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="85" />
<FIELD name="y" value="25" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="769" />
<FIELD name="due_date" value="820" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 81" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="85" />
<FIELD name="y" value="35" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="47" />
<FIELD name="due_date" value="124" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 82" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="75" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="369" />
<FIELD name="due_date" value="420" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 83" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="72" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="265" />
<FIELD name="due_date" value="338" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 84" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="70" />
<FIELD name="y" value="58" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="458" />
<FIELD name="due_date" value="523" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 85" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="68" />
<FIELD name="y" value="60" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="555" />
<FIELD name="due_date" value="612" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 86" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="66" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="173" />
<FIELD name="due_date" value="238" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 87" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="65" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="85" />
<FIELD name="due_date" value="144" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 88" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="65" />
<FIELD name="y" value="60" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="645" />
<FIELD name="due_date" value="708" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 89" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="63" />
<FIELD name="y" value="58" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="737" />
<FIELD name="due_date" value="802" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 90" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="60" />
<FIELD name="y" value="55" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="20" />
<FIELD name="due_date" value="84" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 91" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="60" />
<FIELD name="y" value="60" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="836" />
<FIELD name="due_date" value="889" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 92" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="67" />
<FIELD name="y" value="85" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="368" />
<FIELD name="due_date" value="441" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 93" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="65" />
<FIELD name="y" value="85" />
</OBJECT>
</FIELD>
<FIELD name="load" value="40" />
<FIELD name="ready_time" value="475" />
<FIELD name="due_date" value="518" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 94" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="65" />
<FIELD name="y" value="82" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="285" />
<FIELD name="due_date" value="336" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 95" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="62" />
<FIELD name="y" value="80" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="196" />
<FIELD name="due_date" value="239" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 96" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="60" />
<FIELD name="y" value="80" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="95" />
<FIELD name="due_date" value="156" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 97" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="60" />
<FIELD name="y" value="85" />
</OBJECT>
</FIELD>
<FIELD name="load" value="30" />
<FIELD name="ready_time" value="561" />
<FIELD name="due_date" value="622" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 98" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="58" />
<FIELD name="y" value="75" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="30" />
<FIELD name="due_date" value="84" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 99" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="55" />
<FIELD name="y" value="80" />
</OBJECT>
</FIELD>
<FIELD name="load" value="10" />
<FIELD name="ready_time" value="743" />
<FIELD name="due_date" value="820" />
</OBJECT>
<OBJECT type="customer" >
<FIELD name="id" value="Customer 100" />
<FIELD name="location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="55" />
<FIELD name="y" value="85" />
</OBJECT>
</FIELD>
<FIELD name="load" value="20" />
<FIELD name="ready_time" value="647" />
<FIELD name="due_date" value="726" />
</OBJECT>
<GLOBAL name="extradata" >
<OBJECT type="extradata" >
<FIELD name="capacity" value="200" />
<FIELD name="service_time" value="90" />
<FIELD name="depot_location" >
<OBJECT type="xy_coord" >
<FIELD name="x" value="40" />
<FIELD name="y" value="50" />
</OBJECT>
</FIELD>
</OBJECT>
</GLOBAL>
</NEWOBJECTS>
</DATA>
</PROBLEM>
