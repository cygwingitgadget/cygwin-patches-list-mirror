Return-Path: <cygwin-patches-return-5055-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23003 invoked by alias); 14 Oct 2004 15:31:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22990 invoked from network); 14 Oct 2004 15:31:29 -0000
Message-ID: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: pretty_id misbehaving.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Thu, 14 Oct 2004 15:31:00 -0000
X-SW-Source: 2004-q4/txt/msg00056.txt.bz2

Hi,

here is yet another (trivial, I hope) patch.

It makes pretty_id behave as (I expect) it was supposed to.

It involves: Incrementing ``i'' in only one place, skipping over
``groups='' only once, counting ")" (twice), fixing 2 printf-formats and
setting ``n'' to 1 if it is 0.


ChangeLog-entry:

2004-10-14  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (pretty_id): Correct layout.


--- src/winsup/utils/cygcheck.cc	10 Oct 2004 17:07:23 -0000	1.48
+++ src/winsup/utils/cygcheck.cc	14 Oct 2004 12:44:21 -0000
@@ -820,14 +820,16 @@ pretty_id (const char *s, char *cygwin, 
     }
 
   printf ("\nOutput from %s (%s)\n", id, s);
-  size_t szmaybe = strlen ("UID: ") + strlen (uid);
+  size_t szmaybe = strlen ("UID: )") + strlen (uid);
   if (sz < szmaybe)
     sz = szmaybe;
   sz += 1;
   int n = 80 / (int) sz;
+  if (!n)
+    n = 1;
   sz = -sz;
-  ng[0] += strlen ("groups=");
-  printf ("UID: %.*s) GID: %s)\n", sz + (sizeof ("UID: ") - 1), uid, gid);
+  printf ("UID: %s)%*sGID: %s)\n", uid, sz + strlen ("UID: )") + strlen (uid),
+      "", gid);
   int i = 0;
   for (char **g = groups; g < ng; g++)
     {
@@ -838,8 +840,8 @@ pretty_id (const char *s, char *cygwin, 
 	  i = 0;
 	  puts ("");
 	}
-      if (++i <= n && g != (ng - 1))
-	printf ("%*s ", sz, *g);
+      if (i < n && g != (ng - 1))
+	printf ("%*s", sz, *g);
       else
 	{
 	  printf ("%s\n", *g);


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
