Return-Path: <cygwin-patches-return-7731-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25032 invoked by alias); 18 Oct 2012 16:22:12 -0000
Received: (qmail 24783 invoked by uid 22791); 18 Oct 2012 16:21:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 18 Oct 2012 16:21:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BACC42C00D6; Thu, 18 Oct 2012 18:21:44 +0200 (CEST)
Date: Thu, 18 Oct 2012 16:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121018162144.GT25877@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com> <20121017164440.GA12989@ednor.casa.cgf.cx> <20121017170514.GD10578@calimero.vinschen.de> <20121017193258.GA15271@ednor.casa.cgf.cx> <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <CAEwic4Z3J4E5N97XJiv=okWow4HDNuz_rqfm9qzEBCby1CufOQ@mail.gmail.com> <CAEwic4ZH91sdRbgZ=RL4Nbp-2jdNXe5vMFA4K9UyUo3DzdcBMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEwic4ZH91sdRbgZ=RL4Nbp-2jdNXe5vMFA4K9UyUo3DzdcBMg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00008.txt.bz2

On Oct 18 17:57, Kai Tietz wrote:
> Hi Corinna,
> 
> 2012/10/18 Corinna Vinschen:
> > Hi Yaakov,
> >
> > On Oct 18 02:33, Yaakov (Cygwin/X) wrote:
> >> On Wed, 2012-10-17 at 15:32 -0400, Christopher Faylor wrote:
> >>> But, anyway, nevermind.  This shouldn't be a requirement for getting
> >>> these changes checked in.  I'm more concerned with just nuking the
> >>> now-unneeded mingw script.
> >>
> >> Draft patch attached, based partially on Kai's.  Yes, it needs a
> >> ChangeLog entry, but it also needs more testing first.
> >>
> >> On Cygwin, you need either mingw-gcc-g++ and mingw-zlib, or
> >> mingw64-i686-gcc-g++ with Ports' mingw64-i686-zlib, available here:
> >
> > Any problem to move mingw64-i686-zlib into the distro?
> 
> Hmm, wouldn't assume so.  I can give JonY a ping for that.  I assume
> he would provide such a package.  Shall I ask him?

Actually I thought we just take the one Yaakov already provides
on cygwinports:

> >> ftp://ftp.cygwinports.org/pub/cygwinports/release-2/CrossDevel/mingw64-i686-zlib/

> >> On Fedora, you need my cygwin-gcc-c++ plus mingw32-gcc-c++ and
> >> mingw32-zlib-static.  Unfortunately F17's mingw32-headers isn't
> >> (aren't?) new enough, so two files in winsup/utils wouldn't compile
> >
> > Indeed, unfortunately.  The Fedora maintainer cut the latest version
> > right before I started to apply my changes to mingw64.
> >
> > Kai, do you have a chance to bump the Fedora maintainer?  An update
> > to the latest state would help our cause a lot.
> 
> I am about to give the Fedora-maintainer a ping about this.

Thanks!

> >> until I manually upgraded to
> >> mingw32-headers-2.0.999-0.13.trunk.20121016.fc19.noarch.rpm from
> >> rawhide.  F16 (which uses the mingw.org toolchain) should also be okay.
> >>
> >> Apply the patch, rm -r winsup/mingw/ winsup/w32api/ winsup/utils/mingw,
> >> run autoconf in winsup/utils, then configure and build.  Tested so far
> >> with CVS HEAD on Cygwin and Fedora 17 (with the aforementioned issue)
> >> with our new w32api and the i686-w64-mingw32 toolchain; I have NOT yet
> >> tested the resulting cygwin1.dll.
> >
> > Just FYI, there's a branch in sourceware called cygwin-64bit-branch.
> > It contains all of Cygwin but omits the winsup/mingw and winsup/utils
> > dir already.
> >
> > The idea of the branch is to collect all changes required to make Cygwin
> > 64 bit work, while keeping the trunk intact for normal releases for the
> > time being.  Since we would like to keep Cygwin working on 32 bit,
> > cygwin-64bit-branch is supposed to make sure that Cygwin still builds on
> > 32 bit as well.
> >
> > I had a brief look into the patch but didn't test it yet.  It looks good,
> > but it misses out on one important thing:  In contrast to Kai's patch, it
> > does not test for the target CPU, so these patches don't allow to build
> > with --target=x86_64-pc-cygwin.
> 
>  Hmm, where do I check --target option?  I use host-triplet for
>  detecting cpu's architecture name. See in utils/configure.in file.

Oh, I missed that.  You should test the target CPU, not the host CPU.
The winsup/cygwin/configure.in tests (and always did) the target CPU,
too.  Cygwin is a target lib and the utils are supposed to run on
thei target.

At least I think so.  The difference between host and target is a bit
academic in case of building the Cygwin DLL.  But I think we should
keep up with the scheme.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
