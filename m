Return-Path: <cygwin-patches-return-5241-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5819 invoked by alias); 17 Dec 2004 23:01:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5771 invoked from network); 17 Dec 2004 23:01:09 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 17 Dec 2004 23:01:09 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I8W2LT-0000DY-NQ
	for cygwin-patches@cygwin.com; Fri, 17 Dec 2004 18:01:05 -0500
Message-ID: <41C36530.89F5A621@phumblet.no-ip.org>
Date: Fri, 17 Dec 2004 23:01:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org> <20041217175649.GA1237@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00242.txt.bz2

Christopher Faylor wrote:

> While I detest the trailing dot crap, I don't want cygwin to be inconsistent.
> I don't want ls /bin./ls.exe to fail but ls /cygdrive/c/bin./ls.exe to work.

Assuming a normal install, the first one is c:\cygwin\bin.\ls.exe,
which would NOT fail, while the second is c:\bin.\ls.exe, which would
fail as expected (not due to dots).

You probably mean /usr/bin./ls.exe (fail) vs. /cygdrive/c/cygwin/bin./ls.exe
(no fail, although NtCreateFile fails and Cygwin backs off to alternate code).
Cygwin has always behaved that way (still does), without generating
complaints about inconsistencies. 

We can't fix Windows, but I don't see why we should add processing 
to disallow behavior that it allows, or mimic its crazy behavior
when we don't have to.

> I'm not sure that it makes sense for ln -s foo "bar." to actually create a file
> with a trailing dot on a non-managed mount either.  That seems to expose an
> implementation detail of the way links are handled and it seems inconsistent
> to me.

Perhaps, but nobody has complained about it over the years!
Look at it positively: Cygwin can implement symbolic link names in a Posix
way, without tail dot/space limitations. Ditto with /proc/registry.
Actually if one is porting some code that has a hardcoded filename ending
with a dot, it's nice to have a simple way (symbolic link to valid Windows
name) of making it work.

> If we are "fixing" this (I firmly believe that the code in path_conv is never
> really going to be right) then I don't want to add inconsistencies.

I agree that path_conv is never going to be "right". I would 
not reduce functionality nor open new holes merely to reduce 
inconsistencies due to Windows.

Would it be better to eliminate the inconsistency by allowing 
ls /usr/bin./ls.exe (and how many dots? spaces?) or by disallowing 
ls /cygdrive/c/cygwin/bin./ls.exe (and ls c:/cygwin/bin./ls.exe) ? 
I can argue either way, with a preference for disallowing
(to avoid accidental aliasing, although it breaks precedent,
and because on NT, "touch /cygdrive/c/cygwin/bin./ls.exe" fails
naturally).
Overall I would leave the inconsistency as it is, and blame it
on Windows and on Cygwin tradition.

There are repeated complaints about /usr/bin/somefile not having the
same binary/text mode as /cygdrive/c/cygwin/bin/somefile or 
c:\cygwin\bin\somefile. We rightly dismiss them, although that can
be seen as an inconsistency, and it's purely a Cygwin issue. 

Pierre
