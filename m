Return-Path: <cygwin-patches-return-5050-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3316 invoked by alias); 12 Oct 2004 22:20:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3305 invoked from network); 12 Oct 2004 22:20:08 -0000
Date: Tue, 12 Oct 2004 22:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041012222032.GB847@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041006145805.GB29289@trixie.casa.cgf.cx> <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag> <20041007021558.GL2722@trixie.casa.cgf.cx> <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag> <20041008001755.GK17593@trixie.casa.cgf.cx> <n2m-g.ck9k3i.3vvefmv.1@buzzy-box.bavag> <20041009231813.GD11984@trixie.casa.cgf.cx> <n2m-g.ckaqe1.3vva6e9.1@buzzy-box.bavag> <20041010171323.GD14377@trixie.casa.cgf.cx> <n2m-g.ckhq8e.3vvvbef.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ckhq8e.3vvvbef.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00051.txt.bz2

On Wed, Oct 13, 2004 at 12:11:05AM +0200, Bas van Gompel wrote:
>Op Sun, 10 Oct 2004 13:13:23 -0400 schreef Christopher Faylor
>in <20041010171323.GD14377@trixie.casa.cgf.cx>:
>:  On Sun, Oct 10, 2004 at 08:36:38AM +0200, Bas van Gompel wrote:
>: > Op Sat, 9 Oct 2004 19:18:13 -0400 schreef Christopher Faylor
>: > So cygcheck will have the same problem...
>:
>:   Right, but cygcheck can rely on the fact that cygwin1.dll is around, at
>:  least, if necessary.
>
>The dll is/should be around after setup ran (in install-mode), as well.

Right.  But it may not be loadable.  I don't know if you can still use
LoadLibrary on dlls which lack the correct permissions or not.

>:  I guess a goal could be to come up with a generic
>:  library which did sanity checking and corrections on cygwin permissions.
>
>Which would than have to be linked statically, or suffer from it's
>own permission-problems...

Right.

>: > How about doing it from a (postinstall-)script?
>:
>:   A post-install script doesn't help if someone copied all of their stuff
>:  to a CD-ROM and then to a new system.
>
>I didn't think that was a supported procedure. (IOW: YOWTWYWT)

If we are just going to worry about people doing things perfectly with
setup.exe then we hardly need cygcheck at all.  cygcheck reports on
things that you can get from other utilities.  In fact, cygcheck doesn't
really need to be a mingw program if we can rely on the fact that
everything is ok on the system.

>A post-install script does have the advantage of being run from within
>cygwin.

You seem to be arguing for a post-install script when I've already said
that it would be a good idea to have a post-install script.

cgf
