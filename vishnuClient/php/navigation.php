<?
//  files that require this file should define functions :
//  getTitle     -- title of the page
//  getHeader    -- the header that goes at the top of the page
//  getSubheader -- a sub header below the main header
//  mainContent  -- the main part of the page
//
//  Anything but getTitle can be empty.
//
//  The variable $norightbar should be set if there should be no
//  column with blank space on the right in order to center
?>
<HTML>
<HEAD> 
<TITLE><? getTitle (); ?></TITLE> 
</HEAD>

<BODY>
<DIV align=center>
<table border=0 width=100%>
<tr>
<td align=center valign=top width=150 bgcolor="<? echo getcolor(); ?>">
<br>
<table><tr><td align=center width=150>
<img width=120 height=120 src="logo2.gif">
</td></tr></table>
<table border=0 cellspacing=5 width=150>
<TR><TD></TD></TR>
<tr><td align=center> <a href="vishnu.php">Home</a> </td></tr>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
<? if ($problem) { ?>
<tr><td align=center>
<a href="problem.php?problem=<? echo $problem ?>">
  <? echo $problem ?> main page</a><br>
</td></tr>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
<tr><td align=center>
<a href="viewspecs.php?problem=<? echo $problem ?>">
  <? echo $problem ?> specs</a><br>
</td></tr>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
<? } ?>
<tr><td align=center>
<a href="vishnu_description.html">Full Vishnu Documentation</a>
</td></tr>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
<tr><td align=center>
<a href="faq.php">Frequently Asked Questions</a>
</td></tr>
</table>
</td>
<td valign=top width=20>
<table border=0 width=20>
<tr><td width=20>&nbsp;</td></tr>
</table>
</td>
<td width=100% align=center valign=top>
<H1><? getHeader (); ?></H1>

<H2><? getSubheader(); ?></H2>
<? mainContent (); ?>
</td>
<? if (! $norightbar) { ?>
<td valign=top width=170>
<table border=0 width=170>
<tr><td width=170>&nbsp;</td></tr>
</table>
</td>
<? } ?>
</tr>
</table>
</DIV>

</BODY>
</HTML>

<? function getcolor() { return "#E0D0B0"; } ?>
