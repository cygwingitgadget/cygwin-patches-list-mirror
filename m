Return-Path: <cygwin-patches-return-5054-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13947 invoked by alias); 12 Oct 2004 22:36:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13936 invoked from network); 12 Oct 2004 22:36:52 -0000
Date: Tue, 12 Oct 2004 22:36:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
In-Reply-To: <20041012223227.GD847@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.61.0410121835490.27836@slinky.cs.nyu.edu>
References: <20041007021558.GL2722@trixie.casa.cgf.cx> <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag>
 <20041008001755.GK17593@trixie.casa.cgf.cx> <n2m-g.ck9k3i.3vvefmv.1@buzzy-box.bavag>
 <20041009231813.GD11984@trixie.casa.cgf.cx> <n2m-g.ckaqe1.3vva6e9.1@buzzy-box.bavag>
 <20041010171323.GD14377@trixie.casa.cgf.cx> <n2m-g.ckhq8e.3vvvbef.1@buzzy-box.bavag>
 <20041012222032.GB847@trixie.casa.cgf.cx> <Pine.GSO.4.61.0410121825550.27836@slinky.cs.nyu.edu>
 <20041012223227.GD847@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q4/txt/msg00055.txt.bz2

On Tue, 12 Oct 2004, Christopher Faylor wrote:

> On Tue, Oct 12, 2004 at 06:26:36PM -0400, Igor Pechtchanski wrote:
> >On Tue, 12 Oct 2004, Christopher Faylor wrote:
> >
> >> On Wed, Oct 13, 2004 at 12:11:05AM +0200, Bas van Gompel wrote:
> >> >Op Sun, 10 Oct 2004 13:13:23 -0400 schreef Christopher Faylor:
> >> >:  On Sun, Oct 10, 2004 at 08:36:38AM +0200, Bas van Gompel wrote:
> >> >: > Op Sat, 9 Oct 2004 19:18:13 -0400 schreef Christopher Faylor
> >> >: > So cygcheck will have the same problem...
> >> >:
> >> >:   Right, but cygcheck can rely on the fact that cygwin1.dll is around, at
> >> >:  least, if necessary.
> >> >
> >> >The dll is/should be around after setup ran (in install-mode), as well.
> >>
> >> Right.  But it may not be loadable.  I don't know if you can still use
> >> LoadLibrary on dlls which lack the correct permissions or not.
> >
> >FYI: you can't.  Just tested on WinXP Pro.  HTH,
>
> Wow, that was fast.  Thanks for the feedback.
>
> cgf

You're welcome.  It helps to have a pre-compiled "loader.exe" executable
that does a dlopen(argv[1]) and prints the return value. :-D
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Happiness lies in being privileged to work hard for long hours in doing
whatever you think is worth doing."  -- Dr. Jubal Harshaw
