Return-Path: <cygwin-patches-return-3295-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21931 invoked by alias); 10 Dec 2002 06:12:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21921 invoked from network); 10 Dec 2002 06:12:31 -0000
Date: Mon, 09 Dec 2002 22:12:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] termios accept_input
Message-ID: <20021210002215.A15522@fnord.io.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-SW-Source: 2002-q4/txt/msg00246.txt.bz2


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 422

Hi,
Sorry for the delay in submitting this patch.  This moves the
accept_input() call into the character processing loop where
it can fail and be recovered from.  It should have no behavioral
effect.

Thanks,
-steve

ChangeLog
2002-12-09  Steve Osborn  <bub@io.com>

	* fhandler_termios.cc (fhandler_termios::line_edit): Call
	accept_input() in character processing loop.  Set return 
	value independently of input_done.


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tty3.patch"
Content-length: 1262

Index: cygwin/fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.34
diff -u -p -r1.34 fhandler_termios.cc
--- cygwin/fhandler_termios.cc	5 Dec 2002 16:24:52 -0000	1.34
+++ cygwin/fhandler_termios.cc	10 Dec 2002 05:43:43 -0000
@@ -308,7 +308,8 @@ fhandler_termios::line_edit (const char 
       else if (CCEQ (tc->ti.c_cc[VEOF], c))
 	{
 	  termios_printf ("EOF");
-	  input_done = 1;
+	  (void) accept_input();
+	  ret = line_edit_input_done;
 	  continue;
 	}
       else if (CCEQ (tc->ti.c_cc[VEOL], c) ||
@@ -323,20 +324,21 @@ fhandler_termios::line_edit (const char 
 	c = cyg_tolower (c);
 
       put_readahead (c);
+      if (!iscanon || always_accept || input_done)
+	{
+	  (void) accept_input();
+	  ret = line_edit_input_done;
+	  input_done = 0;
+	}
       if (tc->ti.c_lflag & ECHO)
 	doecho (&c, 1);
     }
 
-  if (!iscanon || always_accept)
-    set_input_done (ralen > 0);
+  if ((!iscanon || always_accept) && ralen > 0)
+    ret = line_edit_input_done;
 
   if (sawsig)
     ret = line_edit_signalled;
-  else if (input_done)
-    {
-      ret = line_edit_input_done;
-      (void) accept_input ();
-    }
 
   return ret;
 }

--NzB8fVQJ5HfG6fxh--
