From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: control characters echoed incorrectly.
Date: Wed, 09 May 2001 10:54:00 -0000
Message-id: <s1spudixvai.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00209.html

The terminal device echoes control characters even when the echo 
flag is off.

2001-05-10  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* fhandler_termios.cc (fhandler_termios::line_edit): Check the echo
	flag before echoing control characters.

Index: fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.18
diff -u -p -r1.18 fhandler_termios.cc
--- fhandler_termios.cc	2001/04/28 23:48:28	1.18
+++ fhandler_termios.cc	2001/05/09 17:39:30
@@ -246,7 +246,7 @@ fhandler_termios::line_edit (const char 
 	/* nothing */;
       else if (c == tc->ti.c_cc[VERASE])
 	{
-	  if (eat_readahead (1))
+	  if (eat_readahead (1) && (tc->ti.c_lflag & ECHO))
 	    doecho ("\b \b", 3);
 	  continue;
 	}
@@ -256,7 +256,7 @@ fhandler_termios::line_edit (const char 
 	  do
 	    if (!eat_readahead (1))
 	      break;
-	    else
+	    else if (tc->ti.c_lflag & ECHO)
 	      doecho ("\b \b", 3);
 	  while ((ch = peek_readahead (1)) >= 0 && !isspace (ch));
 	  continue;
@@ -264,14 +264,18 @@ fhandler_termios::line_edit (const char 
       else if (c == tc->ti.c_cc[VKILL])
 	{
 	  int nchars = eat_readahead (-1);
-	  while (nchars--)
-	    doecho ("\b \b", 3);
+	  if (tc->ti.c_lflag & ECHO)
+	    while (nchars--)
+	      doecho ("\b \b", 3);
 	  continue;
 	}
       else if (c == tc->ti.c_cc[VREPRINT])
 	{
-	  doecho ("\n\r", 2);
-	  doecho (rabuf, ralen);
+	  if (tc->ti.c_lflag & ECHO)
+	    {
+	      doecho ("\n\r", 2);
+	      doecho (rabuf, ralen);
+	    }
 	  continue;
 	}
       else if (c == tc->ti.c_cc[VEOF])

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
