Return-Path: <cygwin-patches-return-5248-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28163 invoked by alias); 18 Dec 2004 21:12:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28121 invoked from network); 18 Dec 2004 21:12:17 -0000
Received: from unknown (HELO slinky.cs.nyu.edu) (128.122.20.14)
  by sourceware.org with SMTP; 18 Dec 2004 21:12:17 -0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id iBILCHW3028493
	for <cygwin-patches@cygwin.com>; Sat, 18 Dec 2004 16:12:17 -0500 (EST)
Date: Sat, 18 Dec 2004 21:12:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
In-Reply-To: <20041218003615.GB3068@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.61.0412172132500.2298@slinky.cs.nyu.edu>
References: <20041216155339.GA16474@cygbert.vinschen.de>
 <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de>
 <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
 <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net>
 <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org>
 <20041217175649.GA1237@trixie.casa.cgf.cx> <41C36530.89F5A621@phumblet.no-ip.org>
 <20041218003615.GB3068@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q4/txt/msg00249.txt.bz2

On Fri, 17 Dec 2004, Christopher Faylor wrote:

> On Fri, Dec 17, 2004 at 06:01:04PM -0500, Pierre A. Humblet wrote:
> >Christopher Faylor wrote:
> >
> >> While I detest the trailing dot crap, I don't want cygwin to be
> >> inconsistent. I don't want ls /bin./ls.exe to fail but ls
> >> /cygdrive/c/bin./ls.exe to work.
> >
> >Assuming a normal install, the first one is c:\cygwin\bin.\ls.exe,
> >which would NOT fail, while the second is c:\bin.\ls.exe, which would
> >fail as expected (not due to dots).
>
> Ok.  Yes.  I had a typo.
>
> If /cygdrive/c/cygwin/bin./ls.exe works, then /bin./ls.exe should also
> work. Or, both should fail.  "consistent"

If I may chime in, I think there are at least three separate possibilities
for accessing each directory:

1) via a managed Cygwin mount;
2) via a regular Cygwin mount;
3) via a /cygdrive-prefixed path; and maybe
4) via a Win32 path.

There's a need for consistency in each of the above cases, but not between
cases.  Each may justifiably have different behavior.  We already default
to textmode for 4), and 2) and 3) may have different textmode/binmode
behavior.  It could be argued that as you go down this list, the POSIXness
decreases, so it's ok to distinguish trailing dots, e.g., in the first two
cases, and ignore them in the latter two.

Just my $0.02.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
