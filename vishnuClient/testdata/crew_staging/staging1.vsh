<?xml version='1.0'?>
<PROBLEM name="staging1_m2_c4_lt10" description="There are two missions, each with the same four legs.\\nThe first leg is from Hunter to Ramstein, the second from Ramstein\\nto Dha Haran, the third from Dha Haran to Ramstein, and the fourth\\nfrom Ramstein to Hunter.\\nUnloading occurs at Dha Haran.\\nThe second mission starts 12 hours after the first.\\n\\nThere are four crews.  They all start at Hunter.\\n\\nAfter each leg of each mission, the crew requires 14 hours of rest.\\nTo deadhead a crew from one location to another to another requires\\na time that is 67% greater than the travel time.\\nThe aircraft service requires 1 hour between legs if no unloading\\noccurs, and 3 hours if unloading occurs.\\n(All this logic is modifiable from the browser.)\\n\\nThe optimization trades off between keeping the mission on\\nschedule and reducing deadheading.\\nIn this particular run, the time late for missions is weighted 10\\ntimes more heavily than the time spent deadheading.\\nThe result is that, with the limited number of crews, the\\nmissions are as close to being on time as possible, and there are\\ntwo deadhead legs." >
<DATAFORMAT>
<OBJECTFORMAT name="Leg" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="mission" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="end_location" datatype="Location" is_subobject="false" is_globalptr="true" is_list="false" is_key="false" />
<FIELDFORMAT name="preceeding_leg" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="earliest_time" datatype="datetime" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="start_location" datatype="Location" is_subobject="false" is_globalptr="true" is_list="false" is_key="false" />
<FIELDFORMAT name="unload_at_end" datatype="boolean" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="final_leg" datatype="boolean" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="Crew" is_task="false" is_resource="true" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="true" />
<FIELDFORMAT name="init_location" datatype="Location" is_subobject="false" is_globalptr="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="Location" is_task="false" is_resource="false" >
<FIELDFORMAT name="geoloc" datatype="string" is_subobject="false" is_globalptr="false" is_list="false" is_key="false" />
<FIELDFORMAT name="latlong" datatype="latlong" is_subobject="true" is_globalptr="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" setupdisplay="color" wrapupdisplay="color" multitasking="none" >
<OPTCRITERION>
<OPERATOR operation="+" >
<OPERATOR operation="sumover" >
<LITERAL value="resources" type="variable" datatype="list:resource" />
<LITERAL value="r" type="constant" datatype="string" />
<OPERATOR operation="preptime" >
<LITERAL value="r" type="variable" datatype="resource" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="*" >
<LITERAL value="10.0" type="constant" datatype="number" />
<OPERATOR operation="sumover" >
<LITERAL value="tasks" type="variable" datatype="list:task" />
<LITERAL value="t" type="constant" datatype="string" />
<OPERATOR operation="if" >
<OPERATOR operation="get" >
<LITERAL value="t" type="variable" datatype="task" />
<LITERAL value="final_leg" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
<OPERATOR operation="-" >
<OPERATOR operation="taskendtime" >
<LITERAL value="t" type="variable" datatype="task" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="t" type="variable" datatype="task" />
<LITERAL value="earliest_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPTCRITERION>
<DELTACRITERION>
<OPERATOR operation="+" >
<OPERATOR operation="-" >
<OPERATOR operation="taskstarttime" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
<OPERATOR operation="tasksetuptime" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="*" >
<LITERAL value="10.0" type="constant" datatype="number" />
<OPERATOR operation="-" >
<OPERATOR operation="taskendtime" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="earliest_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</DELTACRITERION>
<TASKDURATION>
<OPERATOR operation="/" >
<OPERATOR operation="dist" >
<OPERATOR operation="get" >
<OPERATOR operation="globget" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="start_location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="Location" />
</OPERATOR>
<LITERAL value="latlong" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="latlong" />
</OPERATOR>
<OPERATOR operation="get" >
<OPERATOR operation="globget" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="end_location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="Location" />
</OPERATOR>
<LITERAL value="latlong" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="latlong" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="/" >
<LITERAL value="500.0" type="constant" datatype="number" />
<LITERAL value="3600.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</TASKDURATION>
<SETUPDURATION>
<OPERATOR operation="/" >
<OPERATOR operation="dist" >
<OPERATOR operation="if" >
<OPERATOR operation="hasvalue" >
<LITERAL value="previous" type="variable" datatype="task" />
</OPERATOR>
<OPERATOR operation="get" >
<OPERATOR operation="globget" >
<LITERAL value="previous" type="variable" datatype="task" />
<LITERAL value="end_location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="Location" />
</OPERATOR>
<LITERAL value="latlong" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="latlong" />
</OPERATOR>
<OPERATOR operation="get" >
<OPERATOR operation="globget" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="init_location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="Location" />
</OPERATOR>
<LITERAL value="latlong" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="latlong" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="get" >
<OPERATOR operation="globget" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="start_location" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="Location" />
</OPERATOR>
<LITERAL value="latlong" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="latlong" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="/" >
<LITERAL value="300.0" type="constant" datatype="number" />
<LITERAL value="3600.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</SETUPDURATION>
<WRAPUPDURATION>
<OPERATOR operation="*" >
<LITERAL value="14.0" type="constant" datatype="number" />
<LITERAL value="3600.0" type="constant" datatype="number" />
</OPERATOR>
</WRAPUPDURATION>
<PREREQUISITES>
<OPERATOR operation="if" >
<OPERATOR operation="!=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="preceeding_leg" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="" type="constant" datatype="string" />
</OPERATOR>
<OPERATOR operation="list" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="preceeding_leg" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</PREREQUISITES>
<TASKUNAVAIL>
<OPERATOR operation="append" >
<OPERATOR operation="list" >
<OPERATOR operation="interval" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="earliest_time" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
<OPERATOR operation="mapover" >
<LITERAL value="prerequisites" type="variable" datatype="list:task" />
<LITERAL value="t" type="constant" datatype="string" />
<OPERATOR operation="interval" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="+" >
<OPERATOR operation="taskendtime" >
<LITERAL value="t" type="variable" datatype="task" />
</OPERATOR>
<OPERATOR operation="if" >
<OPERATOR operation="get" >
<LITERAL value="t" type="variable" datatype="task" />
<LITERAL value="unload_at_end" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="boolean" />
</OPERATOR>
<OPERATOR operation="*" >
<LITERAL value="3.0" type="constant" datatype="number" />
<LITERAL value="3600.0" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="3600.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
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
<COLORTEST color="red" obj_type="task" title="M001" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="mission" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="M001" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="green" obj_type="task" title="M002" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="mission" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="M002" type="constant" datatype="string" />
</OPERATOR>
</COLORTEST>
<COLORTEST color="beige" obj_type="setup" title="Deadhead" >
<LITERAL value="true" type="constant" datatype="boolean" />
</COLORTEST>
<COLORTEST color="lightblue" obj_type="wrapup" title="Crew Rest" >
<LITERAL value="true" type="constant" datatype="boolean" />
</COLORTEST>
</COLORTESTS>
</SPECS>
<GAPARMS pop_size="50" parent_scalar="0.85000" max_evals="500" max_time="200" max_duplicates="500" max_top_dog_age="500" report_interval="10" initializer="org.cougaar.lib.vishnu.server.OrderedInitializer" decoder="org.cougaar.lib.vishnu.server.OrderedDecoder" >
<GAOPERATORS>
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedMutation" prob="0.5" parms="1.0" />
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedCrossover" prob="0.5" />
</GAOPERATORS>
</GAPARMS>
<DATA>
<CLEARDATABASE />
<WINDOW starttime="2001-09-01 00:00:00" />
<NEWOBJECTS>
<OBJECT type="Leg" >
<FIELD name="id" value="M001 L1" />
<FIELD name="mission" value="M001" />
<FIELD name="end_location" value="Ramstein" />
<FIELD name="preceeding_leg" value="" />
<FIELD name="earliest_time" value="2001-09-04 00:00:00" />
<FIELD name="start_location" value="Hunter" />
<FIELD name="unload_at_end" value="false" />
<FIELD name="final_leg" value="false" />
</OBJECT>
<OBJECT type="Leg" >
<FIELD name="id" value="M001 L2" />
<FIELD name="mission" value="M001" />
<FIELD name="end_location" value="Dha Haran" />
<FIELD name="preceeding_leg" value="M001 L1" />
<FIELD name="earliest_time" value="2001-09-04 06:00:00" />
<FIELD name="start_location" value="Ramstein" />
<FIELD name="unload_at_end" value="true" />
<FIELD name="final_leg" value="false" />
</OBJECT>
<OBJECT type="Leg" >
<FIELD name="id" value="M001 L3" />
<FIELD name="mission" value="M001" />
<FIELD name="end_location" value="Ramstein" />
<FIELD name="preceeding_leg" value="M001 L2" />
<FIELD name="earliest_time" value="2001-09-04 12:00:00" />
<FIELD name="start_location" value="Dha Haran" />
<FIELD name="unload_at_end" value="false" />
<FIELD name="final_leg" value="false" />
</OBJECT>
<OBJECT type="Leg" >
<FIELD name="id" value="M001 L4" />
<FIELD name="mission" value="M001" />
<FIELD name="end_location" value="Hunter" />
<FIELD name="preceeding_leg" value="M001 L3" />
<FIELD name="earliest_time" value="2001-09-04 18:00:00" />
<FIELD name="start_location" value="Ramstein" />
<FIELD name="unload_at_end" value="false" />
<FIELD name="final_leg" value="true" />
</OBJECT>
<OBJECT type="Leg" >
<FIELD name="id" value="M002 L1" />
<FIELD name="mission" value="M002" />
<FIELD name="end_location" value="Ramstein" />
<FIELD name="preceeding_leg" value="" />
<FIELD name="earliest_time" value="2001-09-04 12:00:00" />
<FIELD name="start_location" value="Hunter" />
<FIELD name="unload_at_end" value="false" />
<FIELD name="final_leg" value="false" />
</OBJECT>
<OBJECT type="Leg" >
<FIELD name="id" value="M002 L2" />
<FIELD name="mission" value="M002" />
<FIELD name="end_location" value="Dha Haran" />
<FIELD name="preceeding_leg" value="M002 L1" />
<FIELD name="earliest_time" value="2001-09-04 18:00:00" />
<FIELD name="start_location" value="Ramstein" />
<FIELD name="unload_at_end" value="true" />
<FIELD name="final_leg" value="false" />
</OBJECT>
<OBJECT type="Leg" >
<FIELD name="id" value="M002 L3" />
<FIELD name="mission" value="M002" />
<FIELD name="end_location" value="Ramstein" />
<FIELD name="preceeding_leg" value="M002 L2" />
<FIELD name="earliest_time" value="2001-09-05 00:00:00" />
<FIELD name="start_location" value="Dha Haran" />
<FIELD name="unload_at_end" value="false" />
<FIELD name="final_leg" value="false" />
</OBJECT>
<OBJECT type="Leg" >
<FIELD name="id" value="M002 L4" />
<FIELD name="mission" value="M002" />
<FIELD name="end_location" value="Hunter" />
<FIELD name="preceeding_leg" value="M002 L3" />
<FIELD name="earliest_time" value="2001-09-05 06:00:00" />
<FIELD name="start_location" value="Ramstein" />
<FIELD name="unload_at_end" value="false" />
<FIELD name="final_leg" value="true" />
</OBJECT>
<OBJECT type="Crew" >
<FIELD name="id" value="Crew 1" />
<FIELD name="init_location" value="Hunter" />
</OBJECT>
<OBJECT type="Crew" >
<FIELD name="id" value="Crew 2" />
<FIELD name="init_location" value="Hunter" />
</OBJECT>
<OBJECT type="Crew" >
<FIELD name="id" value="Crew 3" />
<FIELD name="init_location" value="Hunter" />
</OBJECT>
<OBJECT type="Crew" >
<FIELD name="id" value="Crew 4" />
<FIELD name="init_location" value="Hunter" />
</OBJECT>
<GLOBAL name="Hunter" >
<OBJECT type="Location" >
<FIELD name="geoloc" value="HUNT" />
<FIELD name="latlong" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="30" />
<FIELD name="longitude" value="-50" />
</OBJECT>
</FIELD>
</OBJECT>
</GLOBAL>
<GLOBAL name="Dha Haran" >
<OBJECT type="Location" >
<FIELD name="geoloc" value="DHAH" />
<FIELD name="latlong" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="5" />
<FIELD name="longitude" value="55" />
</OBJECT>
</FIELD>
</OBJECT>
</GLOBAL>
<GLOBAL name="Ramstein" >
<OBJECT type="Location" >
<FIELD name="geoloc" value="RAMS" />
<FIELD name="latlong" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="35" />
<FIELD name="longitude" value="10" />
</OBJECT>
</FIELD>
</OBJECT>
</GLOBAL>
</NEWOBJECTS>
</DATA>
</PROBLEM>
