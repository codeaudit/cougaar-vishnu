<?xml version='1.0'?>
<PROBLEM name="supply" >
<DATAFORMAT>
<OBJECTFORMAT name="supplier" is_task="false" is_resource="true" >
<FIELDFORMAT name="company" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="area" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="delivery_days" datatype="number" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="cost_per_lb" datatype="number" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="minimum_cost" datatype="number" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="out_of_area_factor" datatype="number" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="order" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="weight" datatype="number" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="due_date" datatype="datetime" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="city" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="location" datatype="latlong" is_subobject="true" is_globalptr="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" multitasking="ungrouped" >
<OPTCRITERION>
<OPERATOR operation="sumover" >
<LITERAL value="tasks" type="variable" datatype="list:task" />
<LITERAL value="task" type="constant" datatype="string" />
<OPERATOR operation="+" >
<OPERATOR operation="*" >
<OPERATOR operation="if" >
<OPERATOR operation="!=" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<OPERATOR operation="resourcefor" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
<LITERAL value="area" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="east" type="constant" datatype="string" />
</OPERATOR>
<OPERATOR operation="&lt;" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="location.longitude" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="-" >
<LITERAL value="0.0" type="constant" datatype="number" />
<LITERAL value="93.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
<LITERAL value="1.0" type="constant" datatype="number" />
<OPERATOR operation="get" >
<OPERATOR operation="resourcefor" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
<LITERAL value="out_of_area_factor" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="max" >
<OPERATOR operation="get" >
<OPERATOR operation="resourcefor" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
<LITERAL value="minimum_cost" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="*" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="weight" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="get" >
<OPERATOR operation="resourcefor" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
<LITERAL value="cost_per_lb" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
<OPERATOR operation="*" >
<LITERAL value="0.1" type="constant" datatype="number" />
<OPERATOR operation="-" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="due_date" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<OPERATOR operation="taskendtime" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPTCRITERION>
<DELTACRITERION>
<OPERATOR operation="+" >
<OPERATOR operation="*" >
<OPERATOR operation="if" >
<OPERATOR operation="!=" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="area" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="east" type="constant" datatype="string" />
</OPERATOR>
<OPERATOR operation="&lt;" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="location.longitude" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="-" >
<LITERAL value="0.0" type="constant" datatype="number" />
<LITERAL value="93.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
<LITERAL value="1.0" type="constant" datatype="number" />
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="out_of_area_factor" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="max" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="minimum_cost" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="*" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="weight" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="cost_per_lb" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
<OPERATOR operation="*" >
<LITERAL value="0.1" type="constant" datatype="number" />
<OPERATOR operation="-" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="due_date" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<OPERATOR operation="taskendtime" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</DELTACRITERION>
<BESTTIME>
<OPERATOR operation="-" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="due_date" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<OPERATOR operation="*" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="delivery_days" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="86400.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</BESTTIME>
<TASKDURATION>
<OPERATOR operation="*" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="delivery_days" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="86400.0" type="constant" datatype="number" />
</OPERATOR>
</TASKDURATION>
<TASKUNAVAIL>
<OPERATOR operation="list" >
<OPERATOR operation="interval" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="due_date" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<LITERAL value="end_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</TASKUNAVAIL>
<CAPACITYCONTRIB>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="weight" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</CAPACITYCONTRIB>
<CAPACITYTHRESH>
<LITERAL value="80.0" type="constant" datatype="number" />
</CAPACITYTHRESH>
<TASKTEXT>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="id" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</TASKTEXT>
<COLORTESTS>
</COLORTESTS>
</SPECS>
<GAPARMS pop_size="30" parent_scalar="0.80000" max_evals="300" max_time="60" max_duplicates="90" max_top_dog_age="120" initializer="org.cougaar.lib.vishnu.server.OrderedInitializer" decoder="org.cougaar.lib.vishnu.server.OrderedDecoder" >
<GAOPERATORS>
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedMutation" prob="0.50" parms="0.8" />
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedCrossover" prob="0.50" />
</GAOPERATORS>
</GAPARMS>
<DATA>
<CLEARDATABASE />
<WINDOW starttime="2000-11-01 00:00:00" />
<NEWOBJECTS>
<OBJECT type="order" >
<FIELD name="id" value="ID01" />
<FIELD name="weight" value="20.00" />
<FIELD name="due_date" value="2000-11-12 12:00:00" />
<FIELD name="city" value="Atlanta, GA" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="33.80" />
<FIELD name="longitude" value="-84.40" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="order" >
<FIELD name="id" value="ID02" />
<FIELD name="weight" value="20.00" />
<FIELD name="due_date" value="2000-11-03 12:00:00" />
<FIELD name="city" value="Atlanta, GA" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="33.80" />
<FIELD name="longitude" value="-84.40" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="order" >
<FIELD name="id" value="ID03" />
<FIELD name="weight" value="6.00" />
<FIELD name="due_date" value="2000-11-25 12:00:00" />
<FIELD name="city" value="Atlanta, GA" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="33.80" />
<FIELD name="longitude" value="-84.40" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="order" >
<FIELD name="id" value="ID04" />
<FIELD name="weight" value="25.00" />
<FIELD name="due_date" value="2000-11-19 12:00:00" />
<FIELD name="city" value="Atlanta, GA" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="33.80" />
<FIELD name="longitude" value="-84.40" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="order" >
<FIELD name="id" value="ID05" />
<FIELD name="weight" value="28.00" />
<FIELD name="due_date" value="2000-11-16 12:00:00" />
<FIELD name="city" value="Albany, NY" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="42.60" />
<FIELD name="longitude" value="-73.90" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="order" >
<FIELD name="id" value="ID06" />
<FIELD name="weight" value="28.00" />
<FIELD name="due_date" value="2000-11-02 12:00:00" />
<FIELD name="city" value="Albany, NY" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="42.60" />
<FIELD name="longitude" value="-73.90" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="order" >
<FIELD name="id" value="ID07" />
<FIELD name="weight" value="28.00" />
<FIELD name="due_date" value="2000-11-18 12:00:00" />
<FIELD name="city" value="Albany, NY" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="42.60" />
<FIELD name="longitude" value="-73.90" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="order" >
<FIELD name="id" value="ID08" />
<FIELD name="weight" value="34.00" />
<FIELD name="due_date" value="2000-11-17 12:00:00" />
<FIELD name="city" value="Albany, NY" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="42.60" />
<FIELD name="longitude" value="-73.90" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="order" >
<FIELD name="id" value="ID09" />
<FIELD name="weight" value="25.00" />
<FIELD name="due_date" value="2000-11-17 12:00:00" />
<FIELD name="city" value="Las Vegas, NV" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="36.10" />
<FIELD name="longitude" value="-115.10" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="order" >
<FIELD name="id" value="ID10" />
<FIELD name="weight" value="25.00" />
<FIELD name="due_date" value="2000-11-19 12:00:00" />
<FIELD name="city" value="Albuquerque, NM" />
<FIELD name="location" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="35.00" />
<FIELD name="longitude" value="-106.60" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="supplier" >
<FIELD name="company" value="Speedy East" />
<FIELD name="area" value="east" />
<FIELD name="delivery_days" value="1.00" />
<FIELD name="cost_per_lb" value="1.00" />
<FIELD name="minimum_cost" value="5.00" />
<FIELD name="out_of_area_factor" value="1.40" />
</OBJECT>
<OBJECT type="supplier" >
<FIELD name="company" value="Speedy West" />
<FIELD name="area" value="west" />
<FIELD name="delivery_days" value="1.00" />
<FIELD name="cost_per_lb" value="1.00" />
<FIELD name="minimum_cost" value="5.00" />
<FIELD name="out_of_area_factor" value="1.40" />
</OBJECT>
<OBJECT type="supplier" >
<FIELD name="company" value="Cheap East" />
<FIELD name="area" value="east" />
<FIELD name="delivery_days" value="4.00" />
<FIELD name="cost_per_lb" value="0.50" />
<FIELD name="minimum_cost" value="8.00" />
<FIELD name="out_of_area_factor" value="1.40" />
</OBJECT>
<OBJECT type="supplier" >
<FIELD name="company" value="Cheap West" />
<FIELD name="area" value="west" />
<FIELD name="delivery_days" value="4.00" />
<FIELD name="cost_per_lb" value="0.50" />
<FIELD name="minimum_cost" value="8.00" />
<FIELD name="out_of_area_factor" value="1.40" />
</OBJECT>
</NEWOBJECTS>
</DATA>
</PROBLEM>
