<?
	echo "<HTML><HEAD><TITLE>calendar test</TITLE>\n";
	echo "<SCRIPT LANGUAGE=\"JavaScript\" SRC=\"calendar.js\"></SCRIPT>\n";

/*
	function CreateCalendarLink($linkTo)
	{
		echo "<A HREF=\"javascript:doNothing()\" ";
		echo "onClick=\"setDateField(" . $linkTo . "); ";
		echo "top.newWin = window.open('calendar.html','cal','dependent=yes,width=210,height=230,screenX=200,screenY=300,titlebar=yes')\">";
		echo "<IMG SRC=\"calendar.gif\" BORDER=0></A>";
	}
*/

	echo "</HEAD>\n";
	echo "<BODY>\n";
	echo "<CENTER><FORM NAME=myForm METHOD=POST ACTION=calendar.php>\n";
	echo "<TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=myDateField>\n";
//	CreateCalendarLink("document.searchForm.begindate");
?>

        <A HREF="javascript:doNothing()" onClick="setDateField(document.myForm.myDateField);top.newWin = window.open('calendar.html','cal','dependent=yes,width=210,height=230,screenX=200,screenY=300,titlebar=yes')">
        <IMG SRC="calendar.gif" BORDER=0></A><font size=1>Popup Calendar</font>
<?

	echo "<INPUT TYPE=SUBMIT VALUE=Execute>\n";
	echo "</FORM></CENTER>\n";	
	echo "</BODY>\n";
	echo "</HTML>\n";
?>
