Return-Path: <cygwin-patches-return-5058-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31058 invoked by alias); 14 Oct 2004 17:35:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31024 invoked from network); 14 Oct 2004 17:35:52 -0000
Date: Thu, 14 Oct 2004 17:35:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: pretty_id misbehaving.
Message-ID: <20041014173621.GG22814@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00059.txt.bz2

On Thu, Oct 14, 2004 at 05:31:16PM +0200, Bas van Gompel wrote:
>Hi,
>
>here is yet another (trivial, I hope) patch.
>
>It makes pretty_id behave as (I expect) it was supposed to.
>
>It involves: Incrementing ``i'' in only one place, skipping over
>``groups='' only once, counting ")" (twice), fixing 2 printf-formats and
>setting ``n'' to 1 if it is 0.
>
>
>ChangeLog-entry:
>
>2004-10-14  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* cygcheck.cc (pretty_id): Correct layout.

Thanks for the patch but I think it's possible to do this and make
things a little more robust wrt the column calculations.  See below.
This actually shrinks the number of lines slightly too.

I'm going to check this in.

cgf

Index: cygcheck.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/utils/cygcheck.cc,v
retrieving revision 1.48
diff -u -p -r1.48 cygcheck.cc
--- cygcheck.cc	10 Oct 2004 17:07:23 -0000	1.48
+++ cygcheck.cc	14 Oct 2004 17:33:54 -0000
@@ -20,6 +20,8 @@
 #include "cygwin/include/sys/cygwin.h"
 #include "cygwin/include/mntent.h"
 
+#define alloca __builtin_alloca
+
 int verbose = 0;
 int registry = 0;
 int sysinfo = 0;
@@ -791,7 +793,6 @@ pretty_id (const char *s, char *cygwin, 
   FILE *f = popen (id, "rt");
 
   char buf[16384];
-  static char empty[] = "";
   buf[0] = '\0';
   fgets (buf, sizeof (buf), f);
   pclose (f);
@@ -799,20 +800,33 @@ pretty_id (const char *s, char *cygwin, 
   if (uid)
     uid += strlen ("uid=");
   else
-    uid = empty;
+    {
+      fprintf (stderr, "garbled output from `id' command - no uid= found\n");
+      exit (1);
+    }
   char *gid = strtok (NULL, ")");
   if (gid)
     gid += strlen ("gid=") + 1;
   else
-    gid = empty;
-  char **ng;
-  size_t sz = 0;
-  for (ng = groups; (*ng = strtok (NULL, ",")); ng++)
+    {
+      fprintf (stderr, "garbled output from `id' command - no gid= found\n");
+      exit (1);
+    }
+
+  char **ng = groups - 1;
+  size_t len_uid = strlen (uid);
+  size_t len_gid = strlen (gid);
+  *++ng = groups[0] = (char *) alloca (len_uid += sizeof ("UID: )"));
+  *++ng = groups[1] = (char *) alloca (len_uid += sizeof ("GID: )"));
+  sprintf (groups[0], "UID: %s)", uid);
+  sprintf (groups[1], "GID: %s)", gid);
+  size_t sz = max (len_uid, len_gid);
+  while ((*++ng = strtok (NULL, ",")))
     {
       char *p = strchr (*ng, '\n');
       if (p)
 	*p = '\0';
-      if (ng == groups)
+      if (ng == groups + 2)
 	*ng += strlen (" groups=");
       size_t len = strlen (*ng);
       if (sz < len)
@@ -820,32 +834,17 @@ pretty_id (const char *s, char *cygwin, 
     }
 
   printf ("\nOutput from %s (%s)\n", id, s);
-  size_t szmaybe = strlen ("UID: ") + strlen (uid);
-  if (sz < szmaybe)
-    sz = szmaybe;
-  sz += 1;
   int n = 80 / (int) sz;
-  sz = -sz;
-  ng[0] += strlen ("groups=");
-  printf ("UID: %.*s) GID: %s)\n", sz + (sizeof ("UID: ") - 1), uid, gid);
-  int i = 0;
+  sz = -(sz + 1);
+  int i = n - 2;
   for (char **g = groups; g < ng; g++)
-    {
-      if (i < n)
-	i++;
-      else
-	{
-	  i = 0;
-	  puts ("");
-	}
-      if (++i <= n && g != (ng - 1))
-	printf ("%*s ", sz, *g);
-      else
-	{
-	  printf ("%s\n", *g);
-	  i = 0;
-	}
-    }
+    if ((g != ng - 1) && (++i < n))
+      printf ("%*s ", sz, *g);
+    else
+      {
+	puts (*g);
+	i = 0;
+      }
 }
 
 static void
