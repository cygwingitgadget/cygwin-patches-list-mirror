Return-Path: <cygwin-patches-return-5259-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1235 invoked by alias); 20 Dec 2004 15:53:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1134 invoked from network); 20 Dec 2004 15:53:38 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 20 Dec 2004 15:53:38 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I912TB-0000MF-3I
	for cygwin-patches@cygwin.com; Mon, 20 Dec 2004 10:53:35 -0500
Message-ID: <41C6F57E.2D058229@phumblet.no-ip.org>
Date: Mon, 20 Dec 2004 15:53:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <3.0.5.32.20041219215720.0082da20@incoming.verizon.net> <20041220102329.GL9277@cygbert.vinschen.de> <20041220151716.GA1175@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00260.txt.bz2


Christopher Faylor wrote:
> 
> On Mon, Dec 20, 2004 at 11:23:29AM +0100, Corinna Vinschen wrote:
> >On Dec 19 21:57, Pierre A. Humblet wrote:
> >> At 09:44 PM 12/18/2004 -0500, Christopher Faylor wrote:
> >> >
> >> >For now, I'm disallowing all use of '.\' and ' \' in a path.  It seems
> >> >more consistent to disallow everything than to allow some stuff.  I
> >> >didn't change the symlink code to disallow "ln -s foo bar..."  If someone
> >> >actually complains about this, maybe I will.
> >> >
> >> >So, "ls /bin........." works, "ls /bin./pwd.exe" doesn't work and "ls
> >> >/cygwin/c/cygwin/bin./pwd.exe" doesn't work either.  Nor does
> >> >"ls c:\cygwin\bin.\pwd.exe".  I don't know if we'll hear complaints about
> >> >this one or not.
> >
> >I guess we will.  The trailing dots are not removed from the POSIX path
> >in case of chdir, but the chdir itself succeeds.  That leads to an
> >unexpected result:
> >
> >$ cd /bin...
> >$ pwd
> >/bin...                <- This was printed as /bin before
> >$ ls sh.exe
> >ls: sh.exe: No such file or directory
> >
> >In terms of consistancy it should be impossible to chdir already,
> >shouldn't it?
> 
> If we're allowing trailing dots then I guess we should strip them from the
> posix path as well as the windows path.

chdir should be the only case where this matters.
We can either disallow it, or strip the tail.
I prefer the latter.

Stripping from the Posix path can't be done during normalize_
because it would apply to all paths (not only disk).

It's easy to fix posix_cwd at the end of cwdstuff::set, 
only in the case where "doit" is true.
We should also strip win32_cwd there because it will be used
to build an absolute path in normalize_win32_path.

> >> Do you intent to remove the dot checking code in normalize_xxx_path?
> >> It now seems to be useless and even counterproductive.
> >
> >AFAICS, this code could go.
> 
> We're talking about this code, right?

Right.

Pierre
