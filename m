Return-Path: <cygwin-patches-return-1983-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15221 invoked by alias); 12 Mar 2002 02:09:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15193 invoked from network); 12 Mar 2002 02:09:41 -0000
Message-ID: <20020312020938.84935.qmail@web20004.mail.yahoo.com>
Date: Tue, 12 Mar 2002 05:54:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: long-option patch for kill.cc
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-618069424-1015898978=:82780"
X-SW-Source: 2002-q1/txt/msg00340.txt.bz2

--0-618069424-1015898978=:82780
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 172

Um. And here's the patch.


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
--0-618069424-1015898978=:82780
Content-Type: text/plain; name="kill.cc-patch"
Content-Description: kill.cc-patch
Content-Disposition: inline; filename="kill.cc-patch"
Content-length: 1639

--- kill.cc-orig	Mon Mar 11 19:48:34 2002
+++ kill.cc	Mon Mar 11 19:55:19 2002
@@ -1,6 +1,6 @@
 /* kill.cc
 
-   Copyright 1996, 1997, 1998, 1999, 2000, 2001 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -61,26 +61,50 @@ main (int argc, char **argv)
   int force = 0;
   int gotsig = 0;
   int ret = 0;
+  int opt = 0;
+  char *longopt;
 
   if (argc == 1)
     usage ();
 
   while (*++argv && **argv == '-')
-    if (strcmp (*argv + 1, "f") == 0)
-      force = 1;
-    else if (gotsig)
-      break;
-    else if (strcmp(*argv + 1, "0") != 0)
-      {
-	sig = getsig (*argv + 1);
-	gotsig = 1;
-      }
-    else
-      {
-	argv++;
-	sig = 0;
-	goto sig0;
-      }
+    {
+      opt = *(*argv + 1);
+      if (!gotsig)
+        switch (opt)
+          {
+          case 'f':
+            force = 1;
+            break;
+
+          case '0':
+            argv++;
+            sig = 0;
+            goto sig0;
+            return ret;
+
+          /* Handle long options */
+          case '-':
+            longopt = *argv + 2;
+            if (strcmp (longopt, "force") == 0)
+              force = 1;
+            else
+              {
+                fprintf (stderr, "kill: unknown long option: --%s\n\n",
+                         longopt);
+                usage ();
+              }
+            *argv += strlen (longopt);
+            break;
+          /* End of long options */
+
+          default:
+            sig = getsig (*argv + 1);
+            gotsig = 1;
+          }
+      else
+        break;
+    }
 
   if (sig <= 0 || sig > NSIG)
     {

--0-618069424-1015898978=:82780--
