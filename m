From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: a bug in restoring the console.
Date: Mon, 03 Sep 2001 12:41:00 -0000
Message-id: <s1szo8c6p0y.fsf@jaist.ac.jp>
X-SW-Source: 2001-q3/msg00092.html

I succeeded to enjoy the feature saving/restoring the console
with less and the latest termcap, but found a bug on NT4/Win2k.

Less can't restore the previous screen properly when it starts
on the down-scrollable console window. It can scroll the console
buffer. When it terminates, the sequence restoring the cursor
included in `te' scrolls back and breaks the restored screen.

It is triggered by the wrong implementation of the feature
saving/restoring the cursor position. It shouldn't save the
position of the console buffer, but the cursor position.

The following patch corrects the implementation and can solve my 
problem.

2001-09-04  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* fhandler_console.cc (fhandler_console::char_command): Save the cursor
	position relative to the top of the window.
	* fhandler_cc (fhandler_console::write): Ditto.

Index: fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.57
diff -u -p -r1.57 fhandler_console.cc
--- fhandler_console.cc	2001/08/07 05:15:59	1.57
+++ fhandler_console.cc	2001/09/03 19:38:00
@@ -1306,9 +1306,10 @@ fhandler_console::char_command (char c)
       break;
     case 's':   /* Save cursor position */
       cursor_get (&savex, &savey);
+      savey -= info.winTop;
       break;
     case 'u':   /* Restore cursor position */
-      cursor_set (FALSE, savex, savey);
+      cursor_set (TRUE, savex, savey);
       break;
     case 'I':	/* TAB */
       cursor_get (&x, &y);
@@ -1543,12 +1544,13 @@ fhandler_console::write (const void *vsr
 	    }
 	  else if (*src == '8')		/* Restore cursor position */
 	    {
-	      cursor_set (FALSE, savex, savey);
+	      cursor_set (TRUE, savex, savey);
 	      state_ = normal;
 	    }
 	  else if (*src == '7')		/* Save cursor position */
 	    {
 	      cursor_get (&savex, &savey);
+	      savey -= info.winTop;
 	      state_ = normal;
 	    }
 	  else if (*src == 'R')

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  Center for Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
