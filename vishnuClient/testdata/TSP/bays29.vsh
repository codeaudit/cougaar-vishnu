<?xml version='1.0'?>
<PROBLEM name="tsp_bays29" >
<DATAFORMAT>
<OBJECTFORMAT name="salesman" is_task="false" is_resource="true" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
</OBJECTFORMAT>
<OBJECTFORMAT name="city" is_task="true" is_resource="false" >
<FIELDFORMAT name="id" datatype="string" is_subobject="false" is_list="false" is_key="true" />
<FIELDFORMAT name="index" datatype="number" is_subobject="false" is_list="false" is_key="false" />
</OBJECTFORMAT>
</DATAFORMAT>
<SPECS direction="minimize" setupdisplay="line" >
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
<LITERAL value="0" type="constant" datatype="number" />
</TASKDURATION>
<SETUPDURATION>
<OPERATOR operation="matentry" >
<LITERAL value="distances" type="variable" datatype="matrix" />
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="index" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
<OPERATOR operation="get" >
<LITERAL value="previous" type="variable" datatype="task" />
<LITERAL value="index" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="number" />
</OPERATOR>
</OPERATOR>
</SETUPDURATION>
<PREREQUISITES>
<OPERATOR operation="if" >
  <OPERATOR operation="!=" >
    <OPERATOR operation="get" >
      <LITERAL value="task" type="variable" datatype="task" />
      <LITERAL value="id" type="constant" datatype="string" />
      <LITERAL value="" type="variable" datatype="string" />
    </OPERATOR>
    <LITERAL value="Start" type="constant" datatype="string" />
  </OPERATOR>
  <OPERATOR operation="if" >
    <OPERATOR operation="=" >
      <OPERATOR operation="get" >
        <LITERAL value="task" type="variable" datatype="task" />
        <LITERAL value="id" type="constant" datatype="string" />
        <LITERAL value="" type="variable" datatype="string" />
      </OPERATOR>
      <LITERAL value="City 1" type="constant" datatype="string" />
    </OPERATOR>
    <OPERATOR operation="mapover" >
      <LITERAL value="tasks" type="variable" datatype="list:task" />
      <LITERAL value="task2" type="constant" datatype="string" />
      <OPERATOR operation="if" >
        <OPERATOR operation="!=" >
          <OPERATOR operation="get" >
            <LITERAL value="task2" type="variable" datatype="task" />
            <LITERAL value="id" type="constant" datatype="string" />
            <LITERAL value="" type="variable" datatype="string" />
          </OPERATOR>
          <LITERAL value="City 1" type="constant" datatype="string" />
        </OPERATOR>
        <OPERATOR operation="get" >
          <LITERAL value="task2" type="variable" datatype="task" />
          <LITERAL value="id" type="constant" datatype="string" />
          <LITERAL value="" type="variable" datatype="string" />
        </OPERATOR>
      </OPERATOR>
    </OPERATOR>
    <OPERATOR operation="list" >
      <LITERAL value="Start" type="constant" datatype="string" />
    </OPERATOR>
  </OPERATOR>
</OPERATOR>
</PREREQUISITES>
<TASKTEXT>
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="index" type="constant" datatype="string" />
<LITERAL value="" type="variable" datatype="string" />
</OPERATOR>
</TASKTEXT>
<COLORTESTS>
<COLORTEST color="red" obj_type="task" title="1 mod 5" >
<OPERATOR operation="=" >
<OPERATOR operation="mod" >
<OPERATOR operation="get" >
<LITERAL value="task" type="variable" datatype="task" />
<LITERAL value="index" type="constant" datatype="string" />
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
<LITERAL value="index" type="constant" datatype="string" />
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
<LITERAL value="index" type="constant" datatype="string" />
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
<LITERAL value="index" type="constant" datatype="string" />
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
<LITERAL value="index" type="constant" datatype="string" />
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
<OBJECT type="salesman" >
<FIELD name="id" value="Willie Loman" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="Start" />
<FIELD name="index" value="1" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 1" />
<FIELD name="index" value="1" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 2" />
<FIELD name="index" value="2" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 3" />
<FIELD name="index" value="3" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 4" />
<FIELD name="index" value="4" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 5" />
<FIELD name="index" value="5" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 6" />
<FIELD name="index" value="6" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 7" />
<FIELD name="index" value="7" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 8" />
<FIELD name="index" value="8" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 9" />
<FIELD name="index" value="9" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 10" />
<FIELD name="index" value="10" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 11" />
<FIELD name="index" value="11" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 12" />
<FIELD name="index" value="12" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 13" />
<FIELD name="index" value="13" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 14" />
<FIELD name="index" value="14" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 15" />
<FIELD name="index" value="15" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 16" />
<FIELD name="index" value="16" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 17" />
<FIELD name="index" value="17" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 18" />
<FIELD name="index" value="18" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 19" />
<FIELD name="index" value="19" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 20" />
<FIELD name="index" value="20" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 21" />
<FIELD name="index" value="21" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 22" />
<FIELD name="index" value="22" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 23" />
<FIELD name="index" value="23" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 24" />
<FIELD name="index" value="24" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 25" />
<FIELD name="index" value="25" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 26" />
<FIELD name="index" value="26" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 27" />
<FIELD name="index" value="27" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 28" />
<FIELD name="index" value="28" />
</OBJECT>
<OBJECT type="city" >
<FIELD name="id" value="City 29" />
<FIELD name="index" value="29" />
</OBJECT>
<GLOBAL name="distances" >
<OBJECT type="matrix" >
<FIELD name="numrows" value="29" />
<FIELD name="numcols" value="29" />
<FIELD name="values" >
<LIST>
<VALUE value="0" />
<VALUE value="107" />
<VALUE value="241" />
<VALUE value="190" />
<VALUE value="124" />
<VALUE value="80" />
<VALUE value="316" />
<VALUE value="76" />
<VALUE value="152" />
<VALUE value="157" />
<VALUE value="283" />
<VALUE value="133" />
<VALUE value="113" />
<VALUE value="297" />
<VALUE value="228" />
<VALUE value="129" />
<VALUE value="348" />
<VALUE value="276" />
<VALUE value="188" />
<VALUE value="150" />
<VALUE value="65" />
<VALUE value="341" />
<VALUE value="184" />
<VALUE value="67" />
<VALUE value="221" />
<VALUE value="169" />
<VALUE value="108" />
<VALUE value="45" />
<VALUE value="167" />
<VALUE value="107" />
<VALUE value="0" />
<VALUE value="148" />
<VALUE value="137" />
<VALUE value="88" />
<VALUE value="127" />
<VALUE value="336" />
<VALUE value="183" />
<VALUE value="134" />
<VALUE value="95" />
<VALUE value="254" />
<VALUE value="180" />
<VALUE value="101" />
<VALUE value="234" />
<VALUE value="175" />
<VALUE value="176" />
<VALUE value="265" />
<VALUE value="199" />
<VALUE value="182" />
<VALUE value="67" />
<VALUE value="42" />
<VALUE value="278" />
<VALUE value="271" />
<VALUE value="146" />
<VALUE value="251" />
<VALUE value="105" />
<VALUE value="191" />
<VALUE value="139" />
<VALUE value="79" />
<VALUE value="241" />
<VALUE value="148" />
<VALUE value="0" />
<VALUE value="374" />
<VALUE value="171" />
<VALUE value="259" />
<VALUE value="509" />
<VALUE value="317" />
<VALUE value="217" />
<VALUE value="232" />
<VALUE value="491" />
<VALUE value="312" />
<VALUE value="280" />
<VALUE value="391" />
<VALUE value="412" />
<VALUE value="349" />
<VALUE value="422" />
<VALUE value="356" />
<VALUE value="355" />
<VALUE value="204" />
<VALUE value="182" />
<VALUE value="435" />
<VALUE value="417" />
<VALUE value="292" />
<VALUE value="424" />
<VALUE value="116" />
<VALUE value="337" />
<VALUE value="273" />
<VALUE value="77" />
<VALUE value="190" />
<VALUE value="137" />
<VALUE value="374" />
<VALUE value="0" />
<VALUE value="202" />
<VALUE value="234" />
<VALUE value="222" />
<VALUE value="192" />
<VALUE value="248" />
<VALUE value="42" />
<VALUE value="117" />
<VALUE value="287" />
<VALUE value="79" />
<VALUE value="107" />
<VALUE value="38" />
<VALUE value="121" />
<VALUE value="152" />
<VALUE value="86" />
<VALUE value="68" />
<VALUE value="70" />
<VALUE value="137" />
<VALUE value="151" />
<VALUE value="239" />
<VALUE value="135" />
<VALUE value="137" />
<VALUE value="242" />
<VALUE value="165" />
<VALUE value="228" />
<VALUE value="205" />
<VALUE value="124" />
<VALUE value="88" />
<VALUE value="171" />
<VALUE value="202" />
<VALUE value="0" />
<VALUE value="61" />
<VALUE value="392" />
<VALUE value="202" />
<VALUE value="46" />
<VALUE value="160" />
<VALUE value="319" />
<VALUE value="112" />
<VALUE value="163" />
<VALUE value="322" />
<VALUE value="240" />
<VALUE value="232" />
<VALUE value="314" />
<VALUE value="287" />
<VALUE value="238" />
<VALUE value="155" />
<VALUE value="65" />
<VALUE value="366" />
<VALUE value="300" />
<VALUE value="175" />
<VALUE value="307" />
<VALUE value="57" />
<VALUE value="220" />
<VALUE value="121" />
<VALUE value="97" />
<VALUE value="80" />
<VALUE value="127" />
<VALUE value="259" />
<VALUE value="234" />
<VALUE value="61" />
<VALUE value="0" />
<VALUE value="386" />
<VALUE value="141" />
<VALUE value="72" />
<VALUE value="167" />
<VALUE value="351" />
<VALUE value="55" />
<VALUE value="157" />
<VALUE value="331" />
<VALUE value="272" />
<VALUE value="226" />
<VALUE value="362" />
<VALUE value="296" />
<VALUE value="232" />
<VALUE value="164" />
<VALUE value="85" />
<VALUE value="375" />
<VALUE value="249" />
<VALUE value="147" />
<VALUE value="301" />
<VALUE value="118" />
<VALUE value="188" />
<VALUE value="60" />
<VALUE value="185" />
<VALUE value="316" />
<VALUE value="336" />
<VALUE value="509" />
<VALUE value="222" />
<VALUE value="392" />
<VALUE value="386" />
<VALUE value="0" />
<VALUE value="233" />
<VALUE value="438" />
<VALUE value="254" />
<VALUE value="202" />
<VALUE value="439" />
<VALUE value="235" />
<VALUE value="254" />
<VALUE value="210" />
<VALUE value="187" />
<VALUE value="313" />
<VALUE value="266" />
<VALUE value="154" />
<VALUE value="282" />
<VALUE value="321" />
<VALUE value="298" />
<VALUE value="168" />
<VALUE value="249" />
<VALUE value="95" />
<VALUE value="437" />
<VALUE value="190" />
<VALUE value="314" />
<VALUE value="435" />
<VALUE value="76" />
<VALUE value="183" />
<VALUE value="317" />
<VALUE value="192" />
<VALUE value="202" />
<VALUE value="141" />
<VALUE value="233" />
<VALUE value="0" />
<VALUE value="213" />
<VALUE value="188" />
<VALUE value="272" />
<VALUE value="193" />
<VALUE value="131" />
<VALUE value="302" />
<VALUE value="233" />
<VALUE value="98" />
<VALUE value="344" />
<VALUE value="289" />
<VALUE value="177" />
<VALUE value="216" />
<VALUE value="141" />
<VALUE value="346" />
<VALUE value="108" />
<VALUE value="57" />
<VALUE value="190" />
<VALUE value="245" />
<VALUE value="43" />
<VALUE value="81" />
<VALUE value="243" />
<VALUE value="152" />
<VALUE value="134" />
<VALUE value="217" />
<VALUE value="248" />
<VALUE value="46" />
<VALUE value="72" />
<VALUE value="438" />
<VALUE value="213" />
<VALUE value="0" />
<VALUE value="206" />
<VALUE value="365" />
<VALUE value="89" />
<VALUE value="209" />
<VALUE value="368" />
<VALUE value="286" />
<VALUE value="278" />
<VALUE value="360" />
<VALUE value="333" />
<VALUE value="284" />
<VALUE value="201" />
<VALUE value="111" />
<VALUE value="412" />
<VALUE value="321" />
<VALUE value="221" />
<VALUE value="353" />
<VALUE value="72" />
<VALUE value="266" />
<VALUE value="132" />
<VALUE value="111" />
<VALUE value="157" />
<VALUE value="95" />
<VALUE value="232" />
<VALUE value="42" />
<VALUE value="160" />
<VALUE value="167" />
<VALUE value="254" />
<VALUE value="188" />
<VALUE value="206" />
<VALUE value="0" />
<VALUE value="159" />
<VALUE value="220" />
<VALUE value="57" />
<VALUE value="149" />
<VALUE value="80" />
<VALUE value="132" />
<VALUE value="193" />
<VALUE value="127" />
<VALUE value="100" />
<VALUE value="28" />
<VALUE value="95" />
<VALUE value="193" />
<VALUE value="241" />
<VALUE value="131" />
<VALUE value="169" />
<VALUE value="200" />
<VALUE value="161" />
<VALUE value="189" />
<VALUE value="163" />
<VALUE value="283" />
<VALUE value="254" />
<VALUE value="491" />
<VALUE value="117" />
<VALUE value="319" />
<VALUE value="351" />
<VALUE value="202" />
<VALUE value="272" />
<VALUE value="365" />
<VALUE value="159" />
<VALUE value="0" />
<VALUE value="404" />
<VALUE value="176" />
<VALUE value="106" />
<VALUE value="79" />
<VALUE value="161" />
<VALUE value="165" />
<VALUE value="141" />
<VALUE value="95" />
<VALUE value="187" />
<VALUE value="254" />
<VALUE value="103" />
<VALUE value="279" />
<VALUE value="215" />
<VALUE value="117" />
<VALUE value="359" />
<VALUE value="216" />
<VALUE value="308" />
<VALUE value="322" />
<VALUE value="133" />
<VALUE value="180" />
<VALUE value="312" />
<VALUE value="287" />
<VALUE value="112" />
<VALUE value="55" />
<VALUE value="439" />
<VALUE value="193" />
<VALUE value="89" />
<VALUE value="220" />
<VALUE value="404" />
<VALUE value="0" />
<VALUE value="210" />
<VALUE value="384" />
<VALUE value="325" />
<VALUE value="279" />
<VALUE value="415" />
<VALUE value="349" />
<VALUE value="285" />
<VALUE value="217" />
<VALUE value="138" />
<VALUE value="428" />
<VALUE value="310" />
<VALUE value="200" />
<VALUE value="354" />
<VALUE value="169" />
<VALUE value="241" />
<VALUE value="112" />
<VALUE value="238" />
<VALUE value="113" />
<VALUE value="101" />
<VALUE value="280" />
<VALUE value="79" />
<VALUE value="163" />
<VALUE value="157" />
<VALUE value="235" />
<VALUE value="131" />
<VALUE value="209" />
<VALUE value="57" />
<VALUE value="176" />
<VALUE value="210" />
<VALUE value="0" />
<VALUE value="186" />
<VALUE value="117" />
<VALUE value="75" />
<VALUE value="231" />
<VALUE value="165" />
<VALUE value="81" />
<VALUE value="85" />
<VALUE value="92" />
<VALUE value="230" />
<VALUE value="184" />
<VALUE value="74" />
<VALUE value="150" />
<VALUE value="208" />
<VALUE value="104" />
<VALUE value="158" />
<VALUE value="206" />
<VALUE value="297" />
<VALUE value="234" />
<VALUE value="391" />
<VALUE value="107" />
<VALUE value="322" />
<VALUE value="331" />
<VALUE value="254" />
<VALUE value="302" />
<VALUE value="368" />
<VALUE value="149" />
<VALUE value="106" />
<VALUE value="384" />
<VALUE value="186" />
<VALUE value="0" />
<VALUE value="69" />
<VALUE value="191" />
<VALUE value="59" />
<VALUE value="35" />
<VALUE value="125" />
<VALUE value="167" />
<VALUE value="255" />
<VALUE value="44" />
<VALUE value="309" />
<VALUE value="245" />
<VALUE value="169" />
<VALUE value="327" />
<VALUE value="246" />
<VALUE value="335" />
<VALUE value="288" />
<VALUE value="228" />
<VALUE value="175" />
<VALUE value="412" />
<VALUE value="38" />
<VALUE value="240" />
<VALUE value="272" />
<VALUE value="210" />
<VALUE value="233" />
<VALUE value="286" />
<VALUE value="80" />
<VALUE value="79" />
<VALUE value="325" />
<VALUE value="117" />
<VALUE value="69" />
<VALUE value="0" />
<VALUE value="122" />
<VALUE value="122" />
<VALUE value="56" />
<VALUE value="56" />
<VALUE value="108" />
<VALUE value="175" />
<VALUE value="113" />
<VALUE value="240" />
<VALUE value="176" />
<VALUE value="125" />
<VALUE value="280" />
<VALUE value="177" />
<VALUE value="266" />
<VALUE value="243" />
<VALUE value="129" />
<VALUE value="176" />
<VALUE value="349" />
<VALUE value="121" />
<VALUE value="232" />
<VALUE value="226" />
<VALUE value="187" />
<VALUE value="98" />
<VALUE value="278" />
<VALUE value="132" />
<VALUE value="161" />
<VALUE value="279" />
<VALUE value="75" />
<VALUE value="191" />
<VALUE value="122" />
<VALUE value="0" />
<VALUE value="244" />
<VALUE value="178" />
<VALUE value="66" />
<VALUE value="160" />
<VALUE value="161" />
<VALUE value="235" />
<VALUE value="118" />
<VALUE value="62" />
<VALUE value="92" />
<VALUE value="277" />
<VALUE value="55" />
<VALUE value="155" />
<VALUE value="275" />
<VALUE value="348" />
<VALUE value="265" />
<VALUE value="422" />
<VALUE value="152" />
<VALUE value="314" />
<VALUE value="362" />
<VALUE value="313" />
<VALUE value="344" />
<VALUE value="360" />
<VALUE value="193" />
<VALUE value="165" />
<VALUE value="415" />
<VALUE value="231" />
<VALUE value="59" />
<VALUE value="122" />
<VALUE value="244" />
<VALUE value="0" />
<VALUE value="66" />
<VALUE value="178" />
<VALUE value="198" />
<VALUE value="286" />
<VALUE value="77" />
<VALUE value="362" />
<VALUE value="287" />
<VALUE value="228" />
<VALUE value="358" />
<VALUE value="299" />
<VALUE value="380" />
<VALUE value="319" />
<VALUE value="276" />
<VALUE value="199" />
<VALUE value="356" />
<VALUE value="86" />
<VALUE value="287" />
<VALUE value="296" />
<VALUE value="266" />
<VALUE value="289" />
<VALUE value="333" />
<VALUE value="127" />
<VALUE value="141" />
<VALUE value="349" />
<VALUE value="165" />
<VALUE value="35" />
<VALUE value="56" />
<VALUE value="178" />
<VALUE value="66" />
<VALUE value="0" />
<VALUE value="112" />
<VALUE value="132" />
<VALUE value="220" />
<VALUE value="79" />
<VALUE value="296" />
<VALUE value="232" />
<VALUE value="181" />
<VALUE value="292" />
<VALUE value="233" />
<VALUE value="314" />
<VALUE value="253" />
<VALUE value="188" />
<VALUE value="182" />
<VALUE value="355" />
<VALUE value="68" />
<VALUE value="238" />
<VALUE value="232" />
<VALUE value="154" />
<VALUE value="177" />
<VALUE value="284" />
<VALUE value="100" />
<VALUE value="95" />
<VALUE value="285" />
<VALUE value="81" />
<VALUE value="125" />
<VALUE value="56" />
<VALUE value="66" />
<VALUE value="178" />
<VALUE value="112" />
<VALUE value="0" />
<VALUE value="128" />
<VALUE value="167" />
<VALUE value="169" />
<VALUE value="179" />
<VALUE value="120" />
<VALUE value="69" />
<VALUE value="283" />
<VALUE value="121" />
<VALUE value="213" />
<VALUE value="281" />
<VALUE value="150" />
<VALUE value="67" />
<VALUE value="204" />
<VALUE value="70" />
<VALUE value="155" />
<VALUE value="164" />
<VALUE value="282" />
<VALUE value="216" />
<VALUE value="201" />
<VALUE value="28" />
<VALUE value="187" />
<VALUE value="217" />
<VALUE value="85" />
<VALUE value="167" />
<VALUE value="108" />
<VALUE value="160" />
<VALUE value="198" />
<VALUE value="132" />
<VALUE value="128" />
<VALUE value="0" />
<VALUE value="88" />
<VALUE value="211" />
<VALUE value="269" />
<VALUE value="159" />
<VALUE value="197" />
<VALUE value="172" />
<VALUE value="189" />
<VALUE value="182" />
<VALUE value="135" />
<VALUE value="65" />
<VALUE value="42" />
<VALUE value="182" />
<VALUE value="137" />
<VALUE value="65" />
<VALUE value="85" />
<VALUE value="321" />
<VALUE value="141" />
<VALUE value="111" />
<VALUE value="95" />
<VALUE value="254" />
<VALUE value="138" />
<VALUE value="92" />
<VALUE value="255" />
<VALUE value="175" />
<VALUE value="161" />
<VALUE value="286" />
<VALUE value="220" />
<VALUE value="167" />
<VALUE value="88" />
<VALUE value="0" />
<VALUE value="299" />
<VALUE value="229" />
<VALUE value="104" />
<VALUE value="236" />
<VALUE value="110" />
<VALUE value="149" />
<VALUE value="97" />
<VALUE value="108" />
<VALUE value="341" />
<VALUE value="278" />
<VALUE value="435" />
<VALUE value="151" />
<VALUE value="366" />
<VALUE value="375" />
<VALUE value="298" />
<VALUE value="346" />
<VALUE value="412" />
<VALUE value="193" />
<VALUE value="103" />
<VALUE value="428" />
<VALUE value="230" />
<VALUE value="44" />
<VALUE value="113" />
<VALUE value="235" />
<VALUE value="77" />
<VALUE value="79" />
<VALUE value="169" />
<VALUE value="211" />
<VALUE value="299" />
<VALUE value="0" />
<VALUE value="353" />
<VALUE value="289" />
<VALUE value="213" />
<VALUE value="371" />
<VALUE value="290" />
<VALUE value="379" />
<VALUE value="332" />
<VALUE value="184" />
<VALUE value="271" />
<VALUE value="417" />
<VALUE value="239" />
<VALUE value="300" />
<VALUE value="249" />
<VALUE value="168" />
<VALUE value="108" />
<VALUE value="321" />
<VALUE value="241" />
<VALUE value="279" />
<VALUE value="310" />
<VALUE value="184" />
<VALUE value="309" />
<VALUE value="240" />
<VALUE value="118" />
<VALUE value="362" />
<VALUE value="296" />
<VALUE value="179" />
<VALUE value="269" />
<VALUE value="229" />
<VALUE value="353" />
<VALUE value="0" />
<VALUE value="121" />
<VALUE value="162" />
<VALUE value="345" />
<VALUE value="80" />
<VALUE value="189" />
<VALUE value="342" />
<VALUE value="67" />
<VALUE value="146" />
<VALUE value="292" />
<VALUE value="135" />
<VALUE value="175" />
<VALUE value="147" />
<VALUE value="249" />
<VALUE value="57" />
<VALUE value="221" />
<VALUE value="131" />
<VALUE value="215" />
<VALUE value="200" />
<VALUE value="74" />
<VALUE value="245" />
<VALUE value="176" />
<VALUE value="62" />
<VALUE value="287" />
<VALUE value="232" />
<VALUE value="120" />
<VALUE value="159" />
<VALUE value="104" />
<VALUE value="289" />
<VALUE value="121" />
<VALUE value="0" />
<VALUE value="154" />
<VALUE value="220" />
<VALUE value="41" />
<VALUE value="93" />
<VALUE value="218" />
<VALUE value="221" />
<VALUE value="251" />
<VALUE value="424" />
<VALUE value="137" />
<VALUE value="307" />
<VALUE value="301" />
<VALUE value="95" />
<VALUE value="190" />
<VALUE value="353" />
<VALUE value="169" />
<VALUE value="117" />
<VALUE value="354" />
<VALUE value="150" />
<VALUE value="169" />
<VALUE value="125" />
<VALUE value="92" />
<VALUE value="228" />
<VALUE value="181" />
<VALUE value="69" />
<VALUE value="197" />
<VALUE value="236" />
<VALUE value="213" />
<VALUE value="162" />
<VALUE value="154" />
<VALUE value="0" />
<VALUE value="352" />
<VALUE value="147" />
<VALUE value="247" />
<VALUE value="350" />
<VALUE value="169" />
<VALUE value="105" />
<VALUE value="116" />
<VALUE value="242" />
<VALUE value="57" />
<VALUE value="118" />
<VALUE value="437" />
<VALUE value="245" />
<VALUE value="72" />
<VALUE value="200" />
<VALUE value="359" />
<VALUE value="169" />
<VALUE value="208" />
<VALUE value="327" />
<VALUE value="280" />
<VALUE value="277" />
<VALUE value="358" />
<VALUE value="292" />
<VALUE value="283" />
<VALUE value="172" />
<VALUE value="110" />
<VALUE value="371" />
<VALUE value="345" />
<VALUE value="220" />
<VALUE value="352" />
<VALUE value="0" />
<VALUE value="265" />
<VALUE value="178" />
<VALUE value="39" />
<VALUE value="108" />
<VALUE value="191" />
<VALUE value="337" />
<VALUE value="165" />
<VALUE value="220" />
<VALUE value="188" />
<VALUE value="190" />
<VALUE value="43" />
<VALUE value="266" />
<VALUE value="161" />
<VALUE value="216" />
<VALUE value="241" />
<VALUE value="104" />
<VALUE value="246" />
<VALUE value="177" />
<VALUE value="55" />
<VALUE value="299" />
<VALUE value="233" />
<VALUE value="121" />
<VALUE value="189" />
<VALUE value="149" />
<VALUE value="290" />
<VALUE value="80" />
<VALUE value="41" />
<VALUE value="147" />
<VALUE value="265" />
<VALUE value="0" />
<VALUE value="124" />
<VALUE value="263" />
<VALUE value="45" />
<VALUE value="139" />
<VALUE value="273" />
<VALUE value="228" />
<VALUE value="121" />
<VALUE value="60" />
<VALUE value="314" />
<VALUE value="81" />
<VALUE value="132" />
<VALUE value="189" />
<VALUE value="308" />
<VALUE value="112" />
<VALUE value="158" />
<VALUE value="335" />
<VALUE value="266" />
<VALUE value="155" />
<VALUE value="380" />
<VALUE value="314" />
<VALUE value="213" />
<VALUE value="182" />
<VALUE value="97" />
<VALUE value="379" />
<VALUE value="189" />
<VALUE value="93" />
<VALUE value="247" />
<VALUE value="178" />
<VALUE value="124" />
<VALUE value="0" />
<VALUE value="199" />
<VALUE value="167" />
<VALUE value="79" />
<VALUE value="77" />
<VALUE value="205" />
<VALUE value="97" />
<VALUE value="185" />
<VALUE value="435" />
<VALUE value="243" />
<VALUE value="111" />
<VALUE value="163" />
<VALUE value="322" />
<VALUE value="238" />
<VALUE value="206" />
<VALUE value="288" />
<VALUE value="243" />
<VALUE value="275" />
<VALUE value="319" />
<VALUE value="253" />
<VALUE value="281" />
<VALUE value="135" />
<VALUE value="108" />
<VALUE value="332" />
<VALUE value="342" />
<VALUE value="218" />
<VALUE value="350" />
<VALUE value="39" />
<VALUE value="263" />
<VALUE value="199" />
<VALUE value="0" />
</LIST>
</FIELD>
</OBJECT>
</GLOBAL>
</NEWOBJECTS>
</DATA>
</PROBLEM>
