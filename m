Return-Path: <cygwin-patches-return-5065-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13945 invoked by alias); 18 Oct 2004 01:32:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13933 invoked from network); 18 Oct 2004 01:32:10 -0000
Message-ID: <n2m-g.ckvd9l.3vvapnt.1@buzzy-box.bavag>
From: "Buzz" <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: pretty_id misbehaving.
References: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag> <20041014173621.GG22814@trixie.casa.cgf.cx> <n2m-g.ckol7v.3vshjpb.1@buzzy-box.bavag> <20041015135904.GD29569@trixie.casa.cgf.cx> <n2m-g.ckprr1.3vvf2a7.1@buzzy-box.bavag> <20041017233423.GA8780@trixie.casa.cgf.cx>
In-Reply-To: <20041017233423.GA8780@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0
To: cygwin-patches@cygwin.com
Date: Mon, 18 Oct 2004 01:32:00 -0000
X-SW-Source: 2004-q4/txt/msg00066.txt.bz2

Op Sun, 17 Oct 2004 19:34:23 -0400 schreef Christopher Faylor
in <20041017233423.GA8780@trixie.casa.cgf.cx>:
:  On Sat, Oct 16, 2004 at 02:14:33AM +0200, Bas van Gompel wrote:
: > Op Fri, 15 Oct 2004 09:59:04 -0400 schreef Christopher Faylor
: > jj:  or to negate
: > :  sz repeatedly inside of a loop.
: >
: > My plan was to not negate sz at all, use the printf format-flag ``-''.
:
:   Yes.  I get it.  This is a difference of opinion.

Oh well, it works.

: > Also, space needs to be allocated for the trailing `\0` on uid and
: > gid, and notice there isn't a space at the end of the printf format.
:
:   I keep making this stupid mistake.  I have, again, checked in a variation
:  of your fix.  I think I got it right this time.

Well, almost. :)


ChangeLog-entry:

2004-10-18  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* Cygcheck.cc (pretty_id): Count ')' in ui_len and gui_len.


--- src/winsup/utils-3/cygcheck.cc	17 Oct 2004 23:31:23 -0000	1.51
+++ src/winsup/utils-3/cygcheck.cc	18 Oct 2004 01:20:27 -0000
@@ -814,8 +814,8 @@ pretty_id (const char *s, char *cygwin, 
     }
 
   char **ng = groups - 1;
-  size_t len_uid = strlen ("UID: ") + strlen (uid);
-  size_t len_gid = strlen ("GID: ") + strlen (gid);
+  size_t len_uid = strlen ("UID: )") + strlen (uid);
+  size_t len_gid = strlen ("GID: )") + strlen (gid);
   *++ng = groups[0] = (char *) alloca (len_uid + 1);
   *++ng = groups[1] = (char *) alloca (len_gid + 1);
   sprintf (groups[0], "UID: %s)", uid);


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
