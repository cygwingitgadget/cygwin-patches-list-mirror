Return-Path: <cygwin-patches-return-5255-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32323 invoked by alias); 20 Dec 2004 10:23:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32041 invoked from network); 20 Dec 2004 10:23:30 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.119.94)
  by sourceware.org with SMTP; 20 Dec 2004 10:23:30 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id AD0785808F; Mon, 20 Dec 2004 11:23:29 +0100 (CET)
Date: Mon, 20 Dec 2004 10:23:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041220102329.GL9277@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <3.0.5.32.20041219215720.0082da20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041219215720.0082da20@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00256.txt.bz2

On Dec 19 21:57, Pierre A. Humblet wrote:
> At 09:44 PM 12/18/2004 -0500, Christopher Faylor wrote:
> >
> >For now, I'm disallowing all use of '.\' and ' \' in a path.  It seems
> >more consistent to disallow everything than to allow some stuff.  I
> >didn't change the symlink code to disallow "ln -s foo bar..."  If someone
> >actually complains about this, maybe I will.
> >
> >So, "ls /bin........." works, "ls /bin./pwd.exe" doesn't work and "ls
> >/cygwin/c/cygwin/bin./pwd.exe" doesn't work either.  Nor does
> >"ls c:\cygwin\bin.\pwd.exe".  I don't know if we'll hear complaints about
> >this one or not.

I guess we will.  The trailing dots are not removed from the POSIX path
in case of chdir, but the chdir itself succeeds.  That leads to an
unexpected result:

$ cd /bin...
$ pwd
/bin...		<- This was printed as /bin before
$ ls sh.exe
ls: sh.exe: No such file or directory

In terms of consistancy it should be impossible to chdir already,
shouldn't it?

> Do you intent to remove the dot checking code in normalize_xxx_path?
> It now seems to be useless and even counterproductive.

AFAICS, this code could go.

> >>Also, for my info, what is the unc\ in
> >>       !strncasematch (this->path + 4, "unc\\", 4)))
> >>around line 868? I have never seen that documented.
> >[...]
> \\.\unc\computer\share indicates a remote share. So apparently the intention
> was to add a final \ in that case, but not on \\.\c: (according to the
> comment) nor on \\.\c:\somedir   (why not??), and never with PC_FULL.
> Is there ever any reason to add a \ to a Windows path?
>  
> Now, I checked (on XP Home) that "dir \\.\c:" does NOT work, while "dir \\.\c:\"
> does work, which seems to contradict the intention in the comment.

This is really old stuff.  The original intend was not to append the
backslash because otherwise Cygwin failed to open raw devices and tapes
using the \\.\X: or \\.\tapeN syntax.  This has long gone now and there
should be really no reason anymore to special case that.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
