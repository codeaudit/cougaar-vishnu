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
//
//  The variable $horizbar should be set if the navigation bar
//  should be across the top rather than down the left side

function putseparator ($width=120) {
  global $horizbar;
  echo $horizbar ? "</TD><TD width=$width align=center>" :
       "<br>\n</td></tr>\n<TR><TD></TD></TR>\n<TR><TD>" .
       "</TD></TR>\n<tr><td align=center>\n";
}

?>
<HTML>
<HEAD> 
<TITLE><? getTitle (); ?></TITLE> 
</HEAD>

<BODY bgcolor="white">
<DIV align=center>
<? if ($horizbar) { ?>
<table cellpadding=4 border=-1 bgcolor="<? echo getcolor(); ?>">
<tr> <td align=center width=70>
<img width=45 height=45 src="logo3.gif">
<? putseparator(70); ?>
<? } else { ?>
<table border=0 width=100%>
<tr>
<td align=center valign=top width=150 bgcolor="<? echo getcolor(); ?>">
<br>
<table><tr><td align=center width=150>
<img width=120 height=120 src="logo2.gif">
</td></tr></table>
<table border=0 cellspacing=5 width=150>
<TR><TD></TD></TR>
<tr><td align=center>
<? } ?>
<a href="vishnu.php">Home</a>
<? if ($problem) { ?>
<? putseparator(); ?>
<a href="problem.php?problem=<? echo $problem ?>">
  <? echo $problem ?> main page</a>
<? putseparator(); ?>
<a href="viewspecs.php?problem=<? echo $problem ?>">
  <? echo $problem ?> specs</a>
<? } ?>
<? putseparator(); ?>
<a href="fulldoc.php">Full Vishnu Documentation</a>
<? putseparator(); ?>
<a href="faq.php">Frequently Asked Questions</a>
</td></tr>
</table>
<? if (! $horizbar) { ?>
</td>
<td valign=top width=20>
<table border=0 width=20>
<tr><td width=20>&nbsp;</td></tr>
</table>
</td>
<td width=100% align=center valign=top>
<? } ?>
<H1><? getHeader (); ?></H1>

<H2><? getSubheader(); ?></H2>
<? mainContent (); ?>
<? if (! $horizbar) { ?>
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
<? } ?>
</DIV>

</BODY>
</HTML>

<? function getcolor() { return "#E0D0B0"; } ?>
