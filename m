Return-Path: <cygwin-patches-return-5059-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25252 invoked by alias); 15 Oct 2004 12:03:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25184 invoked from network); 15 Oct 2004 12:03:29 -0000
Message-ID: <n2m-g.ckol7v.3vshjpb.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: pretty_id misbehaving.
References: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag> <20041014173621.GG22814@trixie.casa.cgf.cx>
In-Reply-To: <20041014173621.GG22814@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Fri, 15 Oct 2004 12:03:00 -0000
X-SW-Source: 2004-q4/txt/msg00060.txt.bz2

Op Thu, 14 Oct 2004 13:36:21 -0400 schreef Christopher Faylor
in <20041014173621.GG22814@trixie.casa.cgf.cx>:
:  On Thu, Oct 14, 2004 at 05:31:16PM +0200, Bas van Gompel wrote:

[...]

: > 	* cygcheck.cc (pretty_id): Correct layout.
:
:   Thanks for the patch but I think it's possible to do this and make
:  things a little more robust wrt the column calculations.  See below.
:  This actually shrinks the number of lines slightly too.
:
:  I'm going to check this in.

Here are some corrections/changes to your patch:

*) Don't exit, return. (Allow other checks to run.)
*) Update len_gid, not len_uid.
*) Correct calculation of sz. (sizeof(x) == strlen(x) + 1)
*) Don't negate sz, update printf-format
*) Correct low values of n and i.
*) Change order in which final n and sz are set.


ChangeLog-entry:

2004-10-15  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (pretty_id): Don't exit, return. Correct layout.


--- src/winsup/utils-3/cygcheck.cc	14 Oct 2004 17:35:46 -0000	1.49
+++ src/winsup/utils-3/cygcheck.cc	15 Oct 2004 10:56:44 -0000
@@ -802,7 +802,7 @@ pretty_id (const char *s, char *cygwin, 
   else
     {
       fprintf (stderr, "garbled output from `id' command - no uid= found\n");
-      exit (1);
+      return;
     }
   char *gid = strtok (NULL, ")");
   if (gid)
@@ -810,17 +810,17 @@ pretty_id (const char *s, char *cygwin, 
   else
     {
       fprintf (stderr, "garbled output from `id' command - no gid= found\n");
-      exit (1);
+      return;
     }
 
   char **ng = groups - 1;
   size_t len_uid = strlen (uid);
   size_t len_gid = strlen (gid);
   *++ng = groups[0] = (char *) alloca (len_uid += sizeof ("UID: )"));
-  *++ng = groups[1] = (char *) alloca (len_uid += sizeof ("GID: )"));
+  *++ng = groups[1] = (char *) alloca (len_gid += sizeof ("GID: )"));
   sprintf (groups[0], "UID: %s)", uid);
   sprintf (groups[1], "GID: %s)", gid);
-  size_t sz = max (len_uid, len_gid);
+  size_t sz = max (len_uid, len_gid) - 1;
   while ((*++ng = strtok (NULL, ",")))
     {
       char *p = strchr (*ng, '\n');
@@ -834,12 +834,14 @@ pretty_id (const char *s, char *cygwin, 
     }
 
   printf ("\nOutput from %s (%s)\n", id, s);
+  sz++;
   int n = 80 / (int) sz;
-  sz = -(sz + 1);
-  int i = n - 2;
+  if (!n)
+    n = 1;
+  int i = (n > 1) ? n - 2 : 0;
   for (char **g = groups; g < ng; g++)
     if ((g != ng - 1) && (++i < n))
-      printf ("%*s ", sz, *g);
+      printf ("%-*s", sz, *g);
     else
       {
 	puts (*g);


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
