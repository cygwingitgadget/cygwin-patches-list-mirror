Return-Path: <cygwin-patches-return-5258-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28038 invoked by alias); 20 Dec 2004 15:45:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27969 invoked from network); 20 Dec 2004 15:45:21 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.119.94)
  by sourceware.org with SMTP; 20 Dec 2004 15:45:21 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id E363B5808F; Mon, 20 Dec 2004 16:45:20 +0100 (CET)
Date: Mon, 20 Dec 2004 15:45:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041220154520.GR9277@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <3.0.5.32.20041219215720.0082da20@incoming.verizon.net> <20041220102329.GL9277@cygbert.vinschen.de> <20041220151716.GA1175@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220151716.GA1175@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00259.txt.bz2

On Dec 20 10:17, Christopher Faylor wrote:
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
> >/bin...		<- This was printed as /bin before
> >$ ls sh.exe
> >ls: sh.exe: No such file or directory
> >
> >In terms of consistancy it should be impossible to chdir already,
> >shouldn't it?
> 
> If we're allowing trailing dots then I guess we should strip them from the
> posix path as well as the windows path.

What I'm trying to say is, if it's possible to chdir into a directory
with a non-existant name, then it comes as a surprise that stat()
fails for files inside that directory.  The inconsistancy I see is
that `ls /bin.../foo' does not work, but cd'ing into /bin... works.
After that, ls foo doesn't work either, but the successing chdir is
somewhat misleading.

> >AFAICS, this code could go.
> 
> We're talking about this code, right?
> 
>               else if (src[2] && !isslash (src[2]))
>                 {

Actually just about this part:

>                   if (src[2] == '.')
> 		    {
> 		  /* Is this a run of dots? That would be an invalid
> 		     filename.  A bunch of leading dots would be ok,
> 		     though. */
> 		    int n = strspn (src, ".");
> 		    if (!src[n] || isslash (src[n])) /* just dots... */
> 		      return ENOENT;
> 		    }

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
