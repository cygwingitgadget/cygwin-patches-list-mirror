Return-Path: <cygwin-patches-return-5038-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 842 invoked by alias); 9 Oct 2004 22:41:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 829 invoked from network); 9 Oct 2004 22:41:23 -0000
Message-ID: <n2m-g.ck9k3i.3vvefmv.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: warn about empty path-components
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006145805.GB29289@trixie.casa.cgf.cx> <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag> <20041007021558.GL2722@trixie.casa.cgf.cx> <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag> <20041008001755.GK17593@trixie.casa.cgf.cx>
In-Reply-To: <20041008001755.GK17593@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Sat, 09 Oct 2004 22:41:00 -0000
X-SW-Source: 2004-q4/txt/msg00039.txt.bz2

Op Thu, 7 Oct 2004 20:17:55 -0400 schreef Christopher Faylor
in <20041008001755.GK17593@trixie.casa.cgf.cx>:
:  On Fri, Oct 08, 2004 at 01:42:05AM +0200, Bas van Gompel wrote:
: > : > :  Why are we bothering with this?
: > : >
: > : > If I may attempt to answer this one... Many people may not know of
: > : > this usage, yet may have their windows path ending on a ';'.
: > :
: > :   I'm sure the same thing is true on UNIX and yet it has survived for
: > :  years without a unicheck program informing people of this fact.
: >
: > There are no windows paths in UNIX, and there is no unicheck program
: > for any purpose. Does this mean cygcheck should be removed?
:
:   We're talking about paths, not "Windows paths".

We're talking about how paths are displayed by cygcheck.
It displays them using window's conventions.

[...]

:  Of course, if someone can use cygcheck to diagnose their own problems
:  then, that's great.  I don't see any reason to alarm someone with a
:  warning about a minor issue like an empty path component when it
:  is not an uncommon idiom, though.

I see what you mean. I got the idea for the patch when reviewing a
cygcheck.out which I first thought had 2 empty lines after the path.
Further examination revealed the first of these held a TAB.

I thought that was unclear. One might miss the fact there was an empty
component.

: > What are you planning to do? Will you revert this patch, reject the
: > next patch and leave things as they are, or consider it when it's
: > submitted?
:
:   I'm leaning to reverting the patch unless you can point me to a
:  preponderance of email messages in the cygwin list which illustrate
:  that this has been a common problem crying out for a warning.  Maybe
:  I just missed something.

You know there is no such thing. Would you anyhow consider the
following patch, which just displays "." instead of the warning?

:  If you are interested in adding real improvements to cygcheck, I'd
:  suggest something to ensure that the permissions on system directories
:  and files are sane, and maybe even a method to correct problems in that
:  area.  That seems to be one of the biggest complaints in the mailing
:  list.

I'll see what I can do. I however doubt if this can be accomplished
with a trivial patch. (I do have some more trivia in store...)

(Would not corrections be misplaced in cygcheck?
Is ensuring correct permissions not something better handled in setup?)


ChangeLog-entry:

2004-10-10  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (dump_sysinfo): Don't warn about empty path-
	components, just display ``.''.


--- src/winsup/utils/cygcheck.cc	6 Oct 2004 09:46:40 -0000	1.45
+++ src/winsup/utils/cygcheck.cc	9 Oct 2004 07:39:01 -0000
@@ -958,9 +958,9 @@ dump_sysinfo ()
     {
       for (e = s; *e && *e != sep; e++);
       if (e-s)
-        printf ("\t%.*s\n", e - s, s);
+	printf ("\t%.*s\n", e - s, s);
       else
-        puts ("\tWarning: Empty path-component");
+	puts ("\t.");
       count_path_items++;
       if (!*e)
 	break;


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
