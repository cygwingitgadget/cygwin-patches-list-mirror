Return-Path: <cygwin-patches-return-5062-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8201 invoked by alias); 16 Oct 2004 00:14:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8185 invoked from network); 16 Oct 2004 00:14:38 -0000
Message-ID: <n2m-g.ckprr1.3vvf2a7.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: pretty_id misbehaving.
References: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag> <20041014173621.GG22814@trixie.casa.cgf.cx> <n2m-g.ckol7v.3vshjpb.1@buzzy-box.bavag> <20041015135904.GD29569@trixie.casa.cgf.cx>
In-Reply-To: <20041015135904.GD29569@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Sat, 16 Oct 2004 00:14:00 -0000
X-SW-Source: 2004-q4/txt/msg00063.txt.bz2

Op Fri, 15 Oct 2004 09:59:04 -0400 schreef Christopher Faylor
in <20041015135904.GD29569@trixie.casa.cgf.cx>:
:  On Fri, Oct 15, 2004 at 02:03:24PM +0200, Bas van Gompel wrote:
: > ChangeLog-entry:
: >
: > 2004-10-15  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
: >
: > 	* cygcheck.cc (pretty_id): Don't exit, return. Correct layout.
:
:   Thanks.  I've checked in a variation of this patch.

Here we go again.

:  I don't see any reason to guard against n being zero

Is there a limit on the length of user/group-names?

:  or to negate
:  sz repeatedly inside of a loop.

My plan was to not negate sz at all, use the printf format-flag ``-''.
``man 3 printf'':
| Negative field widths are not supported; if you attempt to specify
| a negative field width, it is interpreted as a minus (`-') flag
| followed by a positive field width.

Also, space needs to be allocated for the trailing `\0` on uid and
gid, and notice there isn't a space at the end of the printf format.

HTH, HAND.


ChangeLog-entry:

2004-10-16  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (pretty_id): Allocate space for trailing '\0' on uid and
	guid. Don't negate sz. Fix printf-format.


--- src/winsup/utils/cygcheck.cc	15 Oct 2004 13:57:56 -0000	1.50
+++ src/winsup/utils/cygcheck.cc	15 Oct 2004 21:29:29 -0000
@@ -816,8 +816,8 @@ pretty_id (const char *s, char *cygwin, 
   char **ng = groups - 1;
   size_t len_uid = strlen (uid);
   size_t len_gid = strlen (gid);
-  *++ng = groups[0] = (char *) alloca (len_uid += sizeof ("UID: )") - 1);
-  *++ng = groups[1] = (char *) alloca (len_gid += sizeof ("GID: )") - 1);
+  *++ng = groups[0] = (char *) alloca ((len_uid += sizeof ("UID: )") - 1) + 1);
+  *++ng = groups[1] = (char *) alloca ((len_gid += sizeof ("GID: )") - 1) + 1);
   sprintf (groups[0], "UID: %s)", uid);
   sprintf (groups[1], "GID: %s)", gid);
   size_t sz = max (len_uid, len_gid);
@@ -837,10 +837,9 @@ pretty_id (const char *s, char *cygwin, 
   printf ("\nOutput from %s (%s)\n", id, s);
   int n = 80 / (int) ++sz;
   int i = n ? n - 2 : 0;
-  sz = -sz;
   for (char **g = groups; g <= ng; g++)
     if ((g != ng) && (++i < n))
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
