<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<META NAME="Generator" CONTENT="Microsoft Word 97">
<TITLE>Currently Defined Functions</TITLE>
</HEAD>
<BODY>

<B><U><FONT SIZE=4><P>Currently Defined Functions</P>
</B></U></FONT>
<?
echo "<a href=\"editspec.php?problem=" . $problem . 
	"&specname=" . urlencode($specname) . 
	"\"/>" . 
     "Return to editing " . $simplename . "</a>";
?>
<br>
<br>
<TABLE BORDER CELLSPACING=2 BORDERCOLOR="#000000" CELLPADDING=2 WIDTH=590>
<TR><TD WIDTH="17%" VALIGN="TOP" BGCOLOR="#000000">
<B><FONT COLOR="#ffffff"><P>Function</B></FONT></TD>
<TD WIDTH="32%" VALIGN="TOP" BGCOLOR="#000000">
<B><FONT COLOR="#ffffff"><P>Data Types</B></FONT></TD>
<TD WIDTH="51%" VALIGN="TOP" BGCOLOR="#000000">
<B><FONT COLOR="#ffffff"><P>Description</B></FONT></TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>if</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(boolean, <I>type, &lt;type&gt;</I>)</P>
<P>=&gt; <I>type </I></TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>If the first argument is true, returns the second argument; otherwise, the third argument (or null)</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>and</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(boolean, &lt;boolean&gt;<I>, …</I>)</P>
<P>=&gt; boolean</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Logical and of arguments</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>or</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(boolean, &lt;boolean&gt;<I>, …</I>)</P>
<P>=&gt; boolean</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Logical or of arguments</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>not</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(boolean) =&gt; boolean</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Logical not of argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>mod</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(number, number)</P>
<P>=&gt; number</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Remainder when dividing the first argument by the second argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>max</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(number, &lt;number&gt;<I>, …</I>)</P>
<P>=&gt; number  <B>or</P>
</B><P>(datetime, &lt;datetime&gt;<I>, …</I>)</P>
<P>=&gt; datetime</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Maximum value of arguments</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>min</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(number, &lt;number&gt;<I>, …</I>)</P>
<P>=&gt; number  <B>or</P>
</B><P>(datetime, &lt;datetime&gt;<I>, …</I>)</P>
<P>=&gt; datetime</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Minimum value of arguments</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>list</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(&lt;<I>type&gt;, </I>&lt;<I>type&gt;, …</I>)</P>
<P>=&gt; list</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Makes a list out of all the arguments</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>entry</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list, number) =&gt; <I>type</I></TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the i<SUP>th</SUP> element (starting from 1) of the list, where i is the second argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>matentry</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(matrix, number, number)</P>
<P>=&gt; <I>type</I></TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the i-j<SUP>th</SUP> element (starting from 1) of the matrix, where i and j are the second and third arguments</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>length</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list) =&gt; number</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the length of a list</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>mapover</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list, string, <I>type</I>)</P>
<P>=&gt; list</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Iterates over each element of the first argument, setting the variable given by the second argument to it, accumulating the value of the third argument into a new list</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>sumover</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list, string, number)</P>
<P>=&gt; number</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Iterates over each element of the first argument, setting the variable given by the second argument to it, summing the values of the third argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>maxover</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list, string, number)</P>
<P>=&gt; number</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Iterates over each element of the first argument, setting the variable given by the second argument to it, maximizing over the values of the third argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>minover</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list, string, number)</P>
<P>=&gt; number</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Iterates over each element of the first argument, setting the variable given by the second argument to it, minimizing over the values of the third argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>andover</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list, string, boolean)</P>
<P>=&gt; boolean</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Iterates over each element of the first argument, setting the variable given by the second argument to it, doing a logical and of the values of the third argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>orover</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list, string, boolean)</P>
<P>=&gt; boolean</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Iterates over each element of the first argument, setting the variable given by the second argument to it, doing a logical or of the values of the third argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>loop</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(number, string, <I>type</I>)</P>
<P>=&gt; list</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Iterates, setting the variable named by the second argument equal to all integers between 1 and the first argument inclusive, accumulating the third argument into a list</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>dist</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(latlong, latlong)</P>
<P>=&gt; number  <B>or</P>
</B><P>(xy_coord, xy_coord)</P>
<P>=&gt; number</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the distance (in nautical miles if using latlong's) between the two arguments</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>latlong</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(number, number)</P>
<P>=&gt; latlong</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Return a latlong object with latitude and longitude set to the first and second arguments respectively</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>xy_coord</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(number, number)</P>
<P>=&gt; xy_coord</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Return a xy_coord object with x and y set to the first and second arguments respectively</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>interval</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(datetime, datetime,</P>
<P> &lt;string&gt;, &lt;string&gt;)</P>
<P>=&gt; interval</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Return an interval object with start and end times set to the first and second arguments and label1 and label2 set to the third and fourth arguments</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>findtask</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list, string) =&gt; task</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Return the task in a list whose key is equal to the second argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>findresource</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(list, string) =&gt; resource</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Return the resource in a list whose key is equal to the second argument</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>taskstarttime</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(task) =&gt; datetime</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the assigned start time of a task, or null if not yet assigned</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>taskendtime</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(task) =&gt; datetime</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the assigned end time of a task, or null if not yet assigned</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>resourcefor</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(task) =&gt; resource</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the resource assigned to a task, or null if not yet assigned</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>complete</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(resource) =&gt; datetime</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the time when a resource has finished all its assignments</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>busytime</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(resource, &lt;datetime&gt;,</P>
<P> &lt;datetime&gt;)</P>
<P>=&gt; number</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the number of seconds that a resource has spent performing tasks in the time interval between the second and third arguments (or for all time)</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>preptime</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(resource) =&gt; number</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the number of seconds that a resource has spent doing setup and wrapup</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>hasvalue</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(<I>type</I>) =&gt; boolean</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns true if the argument is not null</TD>
</TR>
<TR><TD WIDTH="17%" VALIGN="TOP">
<P>previousdelta</TD>
<TD WIDTH="32%" VALIGN="TOP">
<P>(resource) =&gt; number</TD>
<TD WIDTH="51%" VALIGN="TOP">
<P>Returns the sum of all delta evaluations for all the tasks already assigned to a resource</TD>
</TR>
</TABLE>

<FONT SIZE=2><P>&nbsp;</P></FONT>

</BODY>
</HTML>
