<?xml version='1.0'?>
<PROBLEM name="DeckPacker_alp_107" >
<DATAFORMAT>
<OBJECTFORMAT name="DeckPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="is_prepositioned" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="level" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_containers" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_footprint_area" datatype="Area" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_passengers" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_volume" datatype="Volume" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="refrigeration" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="ship_id" datatype="string" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="Deck" is_task="false" is_resource="true" >
<FIELDFORMAT name="roleSchedule" datatype="RoleScheduleImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="UID" datatype="string" is_subobject="false" is_list="false" is_key="true" />
<FIELDFORMAT name="typeIdentificationPG" datatype="TypeIdentificationPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="class" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="itemIdentificationPG" datatype="ItemIdentificationPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="DeckPG" datatype="DeckPGImpl" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="CostRate" is_task="false" is_resource="false" >
<FIELDFORMAT name="dollarsPerSecond" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="WaterSelfPropulsionPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="cruise_speed" datatype="Speed" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="full_payload_range" datatype="Distance" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_speed" datatype="Speed" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="AboveScoringFunction" is_task="false" is_resource="false" >
<FIELDFORMAT name="best" datatype="AspectScorePoint" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="Transport" is_task="true" is_resource="false" >
<FIELDFORMAT name="claimed" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="destination" datatype="ClusterIdentifier" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="directObject" datatype="SelfPropelledGroundWeapon" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="ID" datatype="string" is_subobject="false" is_list="false" is_key="true" />
<FIELDFORMAT name="parentTask" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="persistable" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="plan" datatype="PlanImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="preferences" datatype="PreferenceImpl" is_subobject="true" is_list="true" is_key="false" />
<FIELDFORMAT name="prepositionalPhrases" datatype="PrepositionalPhraseImpl" is_subobject="true" is_list="true" is_key="false" />
<FIELDFORMAT name="priority" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="source" datatype="ClusterIdentifier" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="verb" datatype="string" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="WeaponPGImpl" is_task="false" is_resource="false" >
</OBJECTFORMAT>
<OBJECTFORMAT name="AssetConsumptionRatePGImpl" is_task="false" is_resource="false" >
</OBJECTFORMAT>
<OBJECTFORMAT name="GroundVehiclePGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="crew_requirements" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="vehicle_type" datatype="string" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="GroundSelfPropulsionPGImpl" is_task="false" is_resource="false" >
</OBJECTFORMAT>
<OBJECTFORMAT name="ContainPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="is_prepositioned" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_containers" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_footprint_area" datatype="Area" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_passengers" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_volume" datatype="Volume" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="refrigeration" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="MaintenancePGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="ASL_size" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="REL_size" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="TowPGImpl" is_task="false" is_resource="false" >
</OBJECTFORMAT>
<OBJECTFORMAT name="WaterVehiclePGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="beam" datatype="Distance" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="crew_requirements" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="length" datatype="Distance" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="maximum_draft" datatype="Distance" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="Mass" is_task="false" is_resource="false" >
<FIELDFORMAT name="shortTons" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="ScheduleImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="empty" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="endDate" datatype="datetime" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="scheduleElements" datatype="ScheduleElementImpl" is_subobject="true" is_list="true" is_key="false" />
<FIELDFORMAT name="scheduleType" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="startDate" datatype="datetime" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="PlanImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="planName" datatype="string" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="ScheduleElementImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="endDate" datatype="datetime" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="endTime" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="startDate" datatype="datetime" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="startTime" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="ItemIdentificationPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="item_identification" datatype="string" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="CostPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="break_out_cost" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="per_diem_cost" datatype="CostRate" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="CargoShip" is_task="false" is_resource="false" >
<FIELDFORMAT name="roleSchedule" datatype="RoleScheduleImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="UID" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="MovabilityPG" datatype="MovabilityPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="PhysicalPG" datatype="PhysicalPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="MaintenancePG" datatype="MaintenancePGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="typeIdentificationPG" datatype="TypeIdentificationPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="MEIPG" datatype="MEIPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="class" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="itemIdentificationPG" datatype="ItemIdentificationPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="WaterVehiclePG" datatype="WaterVehiclePGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="ShipConfigurationPG" datatype="ShipConfigurationPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="ContainPG" datatype="ContainPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="AssetConsumptionRatePG" datatype="AssetConsumptionRatePGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="WaterSelfPropulsionPG" datatype="WaterSelfPropulsionPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="TowPG" datatype="TowPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="CostPGImpl" datatype="CostPGImpl" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="TypeIdentificationPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="nomenclature" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="type_identification" datatype="string" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="AspectValue" is_task="false" is_resource="false" >
<FIELDFORMAT name="aspectType" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="value" datatype="datetime" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="SelfPropelledGroundWeapon" is_task="false" is_resource="false" >
<FIELDFORMAT name="WeaponPG" datatype="WeaponPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="roleSchedule" datatype="RoleScheduleImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="UID" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="MovabilityPG" datatype="MovabilityPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="PhysicalPG" datatype="PhysicalPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="MaintenancePG" datatype="MaintenancePGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="typeIdentificationPG" datatype="TypeIdentificationPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="MEIPG" datatype="MEIPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="class" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="itemIdentificationPG" datatype="ItemIdentificationPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="GroundVehiclePG" datatype="GroundVehiclePGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="GroundSelfPropulsionPG" datatype="GroundSelfPropulsionPGImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="AssetConsumptionRatePG" datatype="AssetConsumptionRatePGImpl" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="AspectScorePoint" is_task="false" is_resource="false" >
<FIELDFORMAT name="aspectType" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="aspectValue" datatype="AspectValue" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="score" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="value" datatype="datetime" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="UTILEndDateScoringFunction" is_task="false" is_resource="false" >
<FIELDFORMAT name="best" datatype="AspectScorePoint" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="bestDate" datatype="datetime" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="earlyDate" datatype="datetime" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="lateDate" datatype="datetime" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="ClusterIdentifier" is_task="false" is_resource="false" >
<FIELDFORMAT name="address" datatype="string" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="GeolocLocationImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="geolocCode" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="latitude" datatype="latlong" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="name" datatype="string" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="PhysicalPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="footprint_area" datatype="Area" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="height" datatype="Distance" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="length" datatype="Distance" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="mass" datatype="Mass" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="volume" datatype="Volume" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="width" datatype="Distance" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="Volume" is_task="false" is_resource="false" >
<FIELDFORMAT name="gallons" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="PreferenceImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="aspectType" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="weight" datatype="number" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="scoringFunction_0" datatype="AboveScoringFunction" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="scoringFunction_1" datatype="UTILEndDateScoringFunction" is_subobject="true" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="Distance" is_task="false" is_resource="false" >
<FIELDFORMAT name="meters" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="MEIPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="operational" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="ShipConfigurationPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="number_of_decks" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="RoleScheduleImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="availableSchedule" datatype="ScheduleImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="empty" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="Speed" is_task="false" is_resource="false" >
<FIELDFORMAT name="milesPerHour" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="PrepositionalPhraseImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="preposition" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="indirectObject_0" datatype="CargoShip" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="indirectObject_1" datatype="GeolocLocationImpl" is_subobject="true" is_list="false" is_key="false" />
<FIELDFORMAT name="indirectObject_2" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="Area" is_task="false" is_resource="false" >
<FIELDFORMAT name="squareFeet" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="MovabilityPGImpl" is_task="false" is_resource="false" >
<FIELDFORMAT name="cargo_category_code" datatype="string" is_subobject="false" is_list="false" is_key="false" />
<FIELDFORMAT name="moveable" datatype="boolean" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
<OBJECTFORMAT name="namelist" is_task="false" is_resource="false" >
<FIELDFORMAT name="namelist" datatype="string" is_subobject="false" is_list="true" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" multitasking="grouped" >
<OPTCRITERION>
<OPERATOR operation="/" >
<OPERATOR operation="sumover" >
<LITERAL value="tasks" type="variable" datatype="list:task" />
<LITERAL value="cargo" type="constant" datatype="string" />
<OPERATOR operation="if" >
<OPERATOR operation="hasvalue" >
<OPERATOR operation="resourcefor" >
<LITERAL value="cargo" type="variable" datatype="task" />
</OPERATOR>
</OPERATOR>
<LITERAL value="0.0" type="constant" datatype="number" />
<LITERAL value="10.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="sumover" >
<LITERAL value="resources" type="variable" datatype="list:resource" />
<LITERAL value="deck" type="constant" datatype="string" />
<OPERATOR operation="busytime" >
<LITERAL value="deck" type="variable" datatype="resource" />
<LITERAL value="start_time" type="variable" datatype="datetime" />
<LITERAL value="end_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPTCRITERION>
<DELTACRITERION>
<OPERATOR operation="/" >
<OPERATOR operation="if" >
<OPERATOR operation="hasvalue" >
<OPERATOR operation="resourcefor" >
<LITERAL value="task" type="variable" datatype="task" />
</OPERATOR>
</OPERATOR>
<LITERAL value="0.0" type="constant" datatype="number" />
<LITERAL value="10.0" type="constant" datatype="number" />
</OPERATOR>
<OPERATOR operation="busytime" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="start_time" type="variable" datatype="datetime" />
<LITERAL value="end_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</DELTACRITERION>
<BESTTIME>
<OPERATOR operation="get" >
<OPERATOR operation="find" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="preferences" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:PreferenceImpl" />
</OPERATOR>
<LITERAL value="preference" type="constant" datatype="string" />
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="preference" type="variable" datatype="PreferenceImpl" />
<LITERAL value="aspectType" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="1.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
<LITERAL value="scoringFunction_1.bestDate" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</BESTTIME>
<TASKDURATION>
<OPERATOR operation="/" >
<OPERATOR operation="get" >
<OPERATOR operation="find" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="prepositionalPhrases" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:PrepositionalPhraseImpl" />
</OPERATOR>
<LITERAL value="prep" type="constant" datatype="string" />
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="prep" type="variable" datatype="PrepositionalPhraseImpl" />
<LITERAL value="preposition" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="VISHNU_DATA" type="constant" datatype="string" />
</OPERATOR>
</OPERATOR>
<LITERAL value="indirectObject_2" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="1000.0" type="constant" datatype="number" />
</OPERATOR>
</TASKDURATION>
<CAPABILITY>
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<OPERATOR operation="entry" >
<OPERATOR operation="mapover" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="prepositionalPhrases" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:PrepositionalPhraseImpl" />
</OPERATOR>
<LITERAL value="prep" type="constant" datatype="string" />
<OPERATOR operation="if" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="prep" type="variable" datatype="PrepositionalPhraseImpl" />
<LITERAL value="preposition" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="With" type="constant" datatype="string" />
</OPERATOR>
<LITERAL value="prep" type="variable" datatype="PrepositionalPhraseImpl" />
</OPERATOR>
</OPERATOR>
<LITERAL value="1.0" type="constant" datatype="number" />
</OPERATOR>
<LITERAL value="indirectObject_0.typeIdentificationPG.type_identification" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="DeckPG.ship_id" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</OPERATOR>
</CAPABILITY>
<TASKUNAVAIL>
<OPERATOR operation="mapover" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="preferences" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="list:PreferenceImpl" />
</OPERATOR>
<LITERAL value="preference" type="constant" datatype="string" />
<OPERATOR operation="if" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="preference" type="variable" datatype="PreferenceImpl" />
<LITERAL value="aspectType" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="0.0" type="constant" datatype="number" />
</OPERATOR>
<OPERATOR operation="interval" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="get" >
<LITERAL value="preference" type="variable" datatype="PreferenceImpl" />
<LITERAL value="scoringFunction_0.best.value" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="if" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="preference" type="variable" datatype="PreferenceImpl" />
<LITERAL value="aspectType" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<LITERAL value="1.0" type="constant" datatype="number" />
</OPERATOR>
<OPERATOR operation="interval" >
<OPERATOR operation="get" >
<LITERAL value="preference" type="variable" datatype="PreferenceImpl" />
<LITERAL value="scoringFunction_1.bestDate" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<LITERAL value="end_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</OPERATOR>
</OPERATOR>
</TASKUNAVAIL>
<RESOURCEUNAVAIL>
<OPERATOR operation="list" >
<OPERATOR operation="interval" >
<LITERAL value="start_time" type="variable" datatype="datetime" />
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="roleSchedule.availableSchedule.startDate" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="interval" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="roleSchedule.availableSchedule.endDate" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="datetime" />
</OPERATOR>
<LITERAL value="end_time" type="variable" datatype="datetime" />
</OPERATOR>
</OPERATOR>
</RESOURCEUNAVAIL>
<CAPACITYCONTRIB>
<OPERATOR operation="list" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="directObject.PhysicalPG.footprint_area.squareFeet" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="if" >
<OPERATOR operation="hasvalue" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="directObject.GroundVehiclePG.vehicle_type" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</OPERATOR>
<LITERAL value="0.0" type="constant" datatype="number" />
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="directObject.PhysicalPG.volume.gallons" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
<OPERATOR operation="if" >
<OPERATOR operation="=" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="directObject.class" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
<LITERAL value="org.cougaar.domain.glm.ldm.assets.Container" type="constant" datatype="string" />
</OPERATOR>
<LITERAL value="1.0" type="constant" datatype="number" />
<LITERAL value="0.0" type="constant" datatype="number" />
</OPERATOR>
</OPERATOR>
</CAPACITYCONTRIB>
<CAPACITYTHRESH>
<OPERATOR operation="list" >
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="DeckPG.maximum_footprint_area.squareFeet" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="DeckPG.maximum_volume.gallons" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="resource" type="variable" datatype="resource" />
<LITERAL value="DeckPG.maximum_containers" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
</CAPACITYTHRESH>
<GROUPABLE>
<LITERAL value="true" type="constant" datatype="boolean" />
</GROUPABLE>
<COLORTESTS>
</COLORTESTS>
</SPECS>
<GAPARMS pop_size="1000" parent_scalar="0.99000" max_evals="10000" max_time="120" max_duplicates="3000" max_top_dog_age="3000" initializer="org.cougaar.lib.vishnu.server.OrderedInitializer" decoder="org.cougaar.lib.vishnu.server.OrderedDecoder" >
<GAOPERATORS>
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedMutation" prob="0.50" parms="0.8" />
<GAOPERATOR name="org.cougaar.lib.vishnu.server.OrderedCrossover" prob="0.50" />
</GAOPERATORS>
</GAPARMS>
<DATA>
<CLEARDATABASE />
<WINDOW starttime="2000-01-01 00:00:00" endtime="2002-01-01 00:00:00" />
<NEWOBJECTS>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657578" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-010" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655419" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657577" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-009" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655418" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657576" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-008" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655417" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657575" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-007" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655416" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657574" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-006" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655415" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657573" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-005" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655414" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657572" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-004" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655413" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657571" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-003" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655412" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657570" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-002" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655411" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657569" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-001" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655410" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657588" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-020" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655429" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657587" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-019" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655428" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657586" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-018" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655427" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657585" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-017" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655426" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657584" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-016" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655425" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657583" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-015" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655424" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657582" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-014" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655423" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657581" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-013" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655422" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657580" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-012" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655421" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Transport" >
<FIELD name="claimed" value="false" />
<FIELD name="destination" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="directObject" >
<OBJECT type="SelfPropelledGroundWeapon" >
<FIELD name="WeaponPG" >
<OBJECT type="WeaponPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="TOPSClient/973524657579" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="A0D" />
<FIELD name="moveable" value="true" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="387.00" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="5.51" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="9.83" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="61.89" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="52356.15" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="3.66" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="M1A1" />
<FIELD name="type_identification" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.SelfPropelledGroundWeapon" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="tank-011" />
</OBJECT>
</FIELD>
<FIELD name="GroundVehiclePG" >
<OBJECT type="GroundVehiclePGImpl" >
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="vehicle_type" value="TANK" />
</OBJECT>
</FIELD>
<FIELD name="GroundSelfPropulsionPG" >
<OBJECT type="GroundSelfPropulsionPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ID" value="GlobalSea/973524655420" />
<FIELD name="parentTask" value="GlobalSea/973524655408" />
<FIELD name="persistable" value="true" />
<FIELD name="plan" >
<OBJECT type="PlanImpl" >
<FIELD name="planName" value="Reality" />
</OBJECT>
</FIELD>
<FIELD name="preferences" >
<LIST>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-05-18 15:17:40" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="" />
<FIELD name="earlyDate" value="" />
<FIELD name="lateDate" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PreferenceImpl" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="weight" value="1.00" />
<FIELD name="scoringFunction_0" >
<OBJECT type="AboveScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
<FIELD name="score" value="" />
<FIELD name="value" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="scoringFunction_1" >
<OBJECT type="UTILEndDateScoringFunction" >
<FIELD name="best" >
<OBJECT type="AspectScorePoint" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="aspectValue" >
<OBJECT type="AspectValue" >
<FIELD name="aspectType" value="1.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="score" value="0.00" />
<FIELD name="value" value="2000-06-04 12:00:00" />
</OBJECT>
</FIELD>
<FIELD name="bestDate" value="2000-06-04 12:00:00" />
<FIELD name="earlyDate" value="2000-06-03 16:00:00" />
<FIELD name="lateDate" value="2000-06-04 16:00:00" />
</OBJECT>
</FIELD>
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="prepositionalPhrases" >
<LIST>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="From" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="HKUZ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="31.85" />
<FIELD name="longitude" value="-81.60" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="To" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="ABFL" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="26.43" />
<FIELD name="longitude" value="50.10" />
</OBJECT>
</FIELD>
<FIELD name="name" value="AD DAMMAM, SA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="POE" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="UZXJ" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="32.08" />
<FIELD name="longitude" value="-81.12" />
</OBJECT>
</FIELD>
<FIELD name="name" value="Savannah Port (Garden City Term) GA" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="With" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="false" />
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="scheduleElements" >
<LIST>
<VALUE>
<OBJECT type="ScheduleElementImpl" >
<FIELD name="endDate" value="2002-12-31 00:00:00" />
<FIELD name="endTime" value="1041292787712.00" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
<FIELD name="startTime" value="915148767232.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="Other" />
<FIELD name="startDate" value="1999-01-01 00:00:00" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655339" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="false" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="0.00" />
<FIELD name="REL_size" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo" />
<FIELD name="type_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="false" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.CargoShip" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="32.16" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="0.00" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="288.34" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="11.13" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="4.00" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="208685.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="31.07" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="22594400.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="37.98" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="10000.00" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="1848960000.00" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="0.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="PORT_DUR" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="216000.00" />
</OBJECT>
</VALUE>
<VALUE>
<OBJECT type="PrepositionalPhraseImpl" >
<FIELD name="preposition" value="VISHNU_DATA" />
<FIELD name="indirectObject_0" >
<OBJECT type="CargoShip" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="" />
<FIELD name="MovabilityPG" >
<OBJECT type="MovabilityPGImpl" >
<FIELD name="cargo_category_code" value="" />
<FIELD name="moveable" value="" />
</OBJECT>
</FIELD>
<FIELD name="PhysicalPG" >
<OBJECT type="PhysicalPGImpl" >
<FIELD name="footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="height" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="mass" >
<OBJECT type="Mass" >
<FIELD name="shortTons" value="" />
</OBJECT>
</FIELD>
<FIELD name="volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="width" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="MaintenancePG" >
<OBJECT type="MaintenancePGImpl" >
<FIELD name="ASL_size" value="" />
<FIELD name="REL_size" value="" />
</OBJECT>
</FIELD>
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="" />
<FIELD name="type_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="MEIPG" >
<OBJECT type="MEIPGImpl" >
<FIELD name="operational" value="" />
</OBJECT>
</FIELD>
<FIELD name="class" value="" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="" />
</OBJECT>
</FIELD>
<FIELD name="WaterVehiclePG" >
<OBJECT type="WaterVehiclePGImpl" >
<FIELD name="beam" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="crew_requirements" value="" />
<FIELD name="length" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_draft" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="ShipConfigurationPG" >
<OBJECT type="ShipConfigurationPGImpl" >
<FIELD name="number_of_decks" value="" />
</OBJECT>
</FIELD>
<FIELD name="ContainPG" >
<OBJECT type="ContainPGImpl" >
<FIELD name="is_prepositioned" value="" />
<FIELD name="maximum_containers" value="" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="" />
</OBJECT>
</FIELD>
<FIELD name="AssetConsumptionRatePG" >
<OBJECT type="AssetConsumptionRatePGImpl" >
</OBJECT>
</FIELD>
<FIELD name="WaterSelfPropulsionPG" >
<OBJECT type="WaterSelfPropulsionPGImpl" >
<FIELD name="cruise_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
<FIELD name="full_payload_range" >
<OBJECT type="Distance" >
<FIELD name="meters" value="" />
</OBJECT>
</FIELD>
<FIELD name="maximum_speed" >
<OBJECT type="Speed" >
<FIELD name="milesPerHour" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="TowPG" >
<OBJECT type="TowPGImpl" >
</OBJECT>
</FIELD>
<FIELD name="CostPGImpl" >
<OBJECT type="CostPGImpl" >
<FIELD name="break_out_cost" value="" />
<FIELD name="per_diem_cost" >
<OBJECT type="CostRate" >
<FIELD name="dollarsPerSecond" value="" />
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
</OBJECT>
</FIELD>
<FIELD name="indirectObject_1" >
<OBJECT type="GeolocLocationImpl" >
<FIELD name="geolocCode" value="" />
<FIELD name="latitude" >
<OBJECT type="latlong" >
<FIELD name="latitude" value="" />
<FIELD name="longitude" value="" />
</OBJECT>
</FIELD>
<FIELD name="name" value="" />
</OBJECT>
</FIELD>
<FIELD name="indirectObject_2" value="1456940032.00" />
</OBJECT>
</VALUE>
</LIST>
</FIELD>
<FIELD name="priority" value="0.00" />
<FIELD name="source" >
<OBJECT type="ClusterIdentifier" >
<FIELD name="address" value="GlobalSea" />
</OBJECT>
</FIELD>
<FIELD name="verb" value="Transport" />
</OBJECT>
<OBJECT type="Deck" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655432" />
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo-Deck1" />
<FIELD name="type_identification" value="Antares-Deck1-4" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.Deck" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares-Deck1" />
</OBJECT>
</FIELD>
<FIELD name="DeckPG" >
<OBJECT type="DeckPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="level" value="1.00" />
<FIELD name="maximum_containers" value="228.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2183114.75" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
<FIELD name="ship_id" value="Antares" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="Deck" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655433" />
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo-Deck2" />
<FIELD name="type_identification" value="Antares-Deck2-4" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.Deck" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares-Deck2" />
</OBJECT>
</FIELD>
<FIELD name="DeckPG" >
<OBJECT type="DeckPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="level" value="2.00" />
<FIELD name="maximum_containers" value="0.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="2352331.50" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
<FIELD name="ship_id" value="Antares" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="Deck" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655434" />
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo-Deck3" />
<FIELD name="type_identification" value="Antares-Deck3-4" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.Deck" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares-Deck3" />
</OBJECT>
</FIELD>
<FIELD name="DeckPG" >
<OBJECT type="DeckPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="level" value="3.00" />
<FIELD name="maximum_containers" value="0.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="120000.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
<FIELD name="ship_id" value="Antares" />
</OBJECT>
</FIELD>
</OBJECT>
<OBJECT type="Deck" >
<FIELD name="roleSchedule" >
<OBJECT type="RoleScheduleImpl" >
<FIELD name="availableSchedule" >
<OBJECT type="ScheduleImpl" >
<FIELD name="empty" value="" />
<FIELD name="endDate" value="" />
<FIELD name="scheduleElements" >
<LIST>
</LIST>
</FIELD>
<FIELD name="scheduleType" value="" />
<FIELD name="startDate" value="" />
</OBJECT>
</FIELD>
<FIELD name="empty" value="true" />
</OBJECT>
</FIELD>
<FIELD name="UID" value="GlobalSea/973524655435" />
<FIELD name="typeIdentificationPG" >
<OBJECT type="TypeIdentificationPGImpl" >
<FIELD name="nomenclature" value="FSS|RORO|Combo-Deck4" />
<FIELD name="type_identification" value="Antares-Deck4-4" />
</OBJECT>
</FIELD>
<FIELD name="class" value="class org.cougaar.domain.glm.ldm.asset.Deck" />
<FIELD name="itemIdentificationPG" >
<OBJECT type="ItemIdentificationPGImpl" >
<FIELD name="item_identification" value="Antares-Deck4" />
</OBJECT>
</FIELD>
<FIELD name="DeckPG" >
<OBJECT type="DeckPGImpl" >
<FIELD name="is_prepositioned" value="false" />
<FIELD name="level" value="4.00" />
<FIELD name="maximum_containers" value="0.00" />
<FIELD name="maximum_footprint_area" >
<OBJECT type="Area" >
<FIELD name="squareFeet" value="120000.00" />
</OBJECT>
</FIELD>
<FIELD name="maximum_passengers" value="0.00" />
<FIELD name="maximum_volume" >
<OBJECT type="Volume" >
<FIELD name="gallons" value="0.00" />
</OBJECT>
</FIELD>
<FIELD name="refrigeration" value="false" />
<FIELD name="ship_id" value="Antares" />
</OBJECT>
</FIELD>
</OBJECT>
<GLOBAL name="shippenalty" >
<OBJECT type="matrix" >
<FIELD name="numrows" value="9.00" />
<FIELD name="numcols" value="4.00" />
<FIELD name="values" >
<LIST>
<VALUE value="1" />
<VALUE value="10000" />
<VALUE value="10000" />
<VALUE value="10000" />
<VALUE value="10000" />
<VALUE value="1.4" />
<VALUE value="1.4" />
<VALUE value="1.4" />
<VALUE value="10000" />
<VALUE value="1" />
<VALUE value="1" />
<VALUE value="1" />
<VALUE value="10000" />
<VALUE value="2" />
<VALUE value="2" />
<VALUE value="2" />
<VALUE value="10000" />
<VALUE value="2.8" />
<VALUE value="10000" />
<VALUE value="10000" />
<VALUE value="10000" />
<VALUE value="8" />
<VALUE value="8" />
<VALUE value="8" />
<VALUE value="10000" />
<VALUE value="16" />
<VALUE value="11" />
<VALUE value="11" />
<VALUE value="10000" />
<VALUE value="16" />
<VALUE value="10000" />
<VALUE value="10000" />
<VALUE value="10000" />
<VALUE value="128" />
<VALUE value="128" />
<VALUE value="128" />
</LIST>
</FIELD>
</OBJECT>
</GLOBAL>
<GLOBAL name="namelist" >
<OBJECT type="namelist" >
<FIELD name="namelist" >
<LIST>
<VALUE value="Ammo" />
<VALUE value="FSS|RORO|Combo" />
<VALUE value="LMSR|RORO|Combo" />
<VALUE value="MPS|RORO|Combo" />
<VALUE value="RORO" />
<VALUE value="BreakBulk|Container" />
<VALUE value="BreakBulk" />
<VALUE value="Container" />
<VALUE value="LASH" />
</LIST>
</FIELD>
</OBJECT>
</GLOBAL>
</NEWOBJECTS>
</DATA>
</PROBLEM>
