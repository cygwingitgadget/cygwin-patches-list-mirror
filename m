Return-Path: <cygwin-patches-return-1745-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16488 invoked by alias); 18 Jan 2002 22:01:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16473 invoked from network); 18 Jan 2002 22:01:22 -0000
Message-Id: <4.3.2.7.2.20020118224857.00aa3720@mail.oreka.com>
X-Sender: christian.lestrade@pop.free.fr
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 18 Jan 2002 14:01:00 -0000
To: cygwin-patches@cygwin.com
From: Christian LESTRADE <christian.lestrade@free.fr>
Subject: Terminal input processing fix
Cc: bub@io.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-SW-Source: 2002-q1/txt/msg00102.txt.bz2

Hello,

I would like to submit the following bugfix for theses bugs which appear
mainly when using rxvt:

* Unable to effectively disable c_cc[] input chars processing (like ^C) using
   $ stty intr '^-'
   When I type CTRL-SPACE, I enter a NULL char which is interpreted like ^C

* In raw mode (stty -icanon), the VDISCARD key (^O) should not be recognized,
   but should be passed to the application

This fix does not prevent rxvt to hang when typing ^O in cooked mode, but only
in raw mode, instead of always.


Christian LESTRADE
mailto:christian.lestrade@free.fr

---------- winsup/cygwin/ChangeLog ----------

2002-01-18  Christian Lestrade  <christian.lestrade@free.fr>

         * fhandler_termios.cc (CC_EQUAL): New macro
         (line_edit): Recognize disabled c_cc[] chars
         Ignore VDISCARD when not in ICANON mode

---------- winsup/cygwin/fhandler_termios.cc.patch ----------
--- fhandler_termios.cc.orig    Sun Aug 26 03:41:58 2001
+++ fhandler_termios.cc Tue Jan 15 11:49:04 2002
@@ -22,6 +22,18 @@
  #include "pinfo.h"
  #include "tty.h"

+/* Don't match caracters undefined with _POSIX_VDISABLE */
+#ifndef _POSIX_VDISABLE
+#define _POSIX_VDISABLE '\0'
+#endif
+
+/* Match char a with c_cc member b */
+/* Take care: types of a (char) and b (unsigned char)
+   don't have the same scope, so don't directly compare 'a'
+   with _POSIX_VDISABLE */
+#define CC_EQUAL(a, b) \
+  (((tc->ti.c_cc[b] != _POSIX_VDISABLE) && (a == tc->ti.c_cc[b])))
+
  /* Common functions shared by tty/console */

  void
@@ -207,11 +219,11 @@
        if (tc->ti.c_lflag & ISIG)
         {
           int sig;
-         if (c ==  tc->ti.c_cc[VINTR])
+         if (CC_EQUAL(c, VINTR))
             sig = SIGINT;
-         else if (c == tc->ti.c_cc[VQUIT])
+         else if (CC_EQUAL(c, VQUIT))
             sig = SIGQUIT;
-         else if (c == tc->ti.c_cc[VSUSP])
+         else if (CC_EQUAL(c, VSUSP))
             sig = SIGTSTP;
           else
             goto not_a_sig;
@@ -226,7 +238,7 @@
      not_a_sig:
        if (tc->ti.c_iflag & IXON)
         {
-         if (c == tc->ti.c_cc[VSTOP])
+         if (CC_EQUAL(c, VSTOP))
             {
               if (!tc->output_stopped)
                 {
@@ -235,7 +247,7 @@
                 }
               continue;
             }
-         else if (c == tc->ti.c_cc[VSTART])
+         else if (CC_EQUAL(c, VSTART))
             {
      restart_output:
               tc->output_stopped = 0;
@@ -245,20 +257,20 @@
           else if ((tc->ti.c_iflag & IXANY) && tc->output_stopped)
             goto restart_output;
         }
-      if (tc->ti.c_lflag & IEXTEN && c == tc->ti.c_cc[VDISCARD])
+      if (iscanon && tc->ti.c_lflag & IEXTEN && CC_EQUAL(c, VDISCARD))
         {
           tc->ti.c_lflag ^= FLUSHO;
           continue;
         }
        if (!iscanon)
         /* nothing */;
-      else if (c == tc->ti.c_cc[VERASE])
+      else if (CC_EQUAL(c, VERASE))
         {
           if (eat_readahead (1))
             echo_erase ();
           continue;
         }
-      else if (c == tc->ti.c_cc[VWERASE])
+      else if (CC_EQUAL(c, VWERASE))
         {
           int ch;
           do
@@ -269,7 +281,7 @@
           while ((ch = peek_readahead (1)) >= 0 && !isspace (ch));
           continue;
         }
-      else if (c == tc->ti.c_cc[VKILL])
+      else if (CC_EQUAL(c, VKILL))
         {
           int nchars = eat_readahead (-1);
           if (tc->ti.c_lflag & ECHO)
@@ -277,7 +289,7 @@
               echo_erase (1);
           continue;
         }
-      else if (c == tc->ti.c_cc[VREPRINT])
+      else if (CC_EQUAL(c, VREPRINT))
         {
           if (tc->ti.c_lflag & ECHO)
             {
@@ -286,14 +298,14 @@
             }
           continue;
         }
-      else if (c == tc->ti.c_cc[VEOF])
+      else if (CC_EQUAL(c, VEOF))
         {
           termios_printf ("EOF");
           input_done = 1;
           continue;
         }
-      else if (c == tc->ti.c_cc[VEOL] ||
-              c == tc->ti.c_cc[VEOL2] ||
+      else if (CC_EQUAL(c, VEOL) ||
+              CC_EQUAL(c, VEOL2) ||
                c == '\n')
         {
           set_input_done (1);
