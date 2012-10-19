Return-Path: <cygwin-patches-return-7736-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24737 invoked by alias); 19 Oct 2012 18:47:00 -0000
Received: (qmail 24639 invoked by uid 22791); 19 Oct 2012 18:46:45 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 19 Oct 2012 18:46:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 488B12C00D6; Fri, 19 Oct 2012 20:46:36 +0200 (CEST)
Date: Fri, 19 Oct 2012 18:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121019184636.GZ25877@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com> <20121017164440.GA12989@ednor.casa.cgf.cx> <20121017170514.GD10578@calimero.vinschen.de> <20121017193258.GA15271@ednor.casa.cgf.cx> <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1350664438.3492.114.camel@YAAKOV04>
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
X-SW-Source: 2012-q4/txt/msg00013.txt.bz2

On Oct 19 11:33, Yaakov (Cygwin/X) wrote:
> On Fri, 2012-10-19 at 11:21 +0200, Corinna Vinschen wrote:
> > On Oct 18 12:20, Yaakov (Cygwin/X) wrote:
> > > None; should I also move the other setup.exe prerequisites for
> > > i686-w64-mingw32?  Would you also like x86_64 versions of any of those?
> > 
> > If it's not asked too much, sure on both accounts!
> 
> Done.

Thanks!

> > The theory is that cygwin will continue to co-exist with mingw and
> > w32api for a while, but cygwin does not build or use mingw and w32api.
> > However, winsup/configure.in adds mingw and w32api subdirs to SUBDIRS
> > based on the mere existence of the dirs.
> > If we want to make Cygwin independent of mingw/w32api and vice versa,
> > I'd suggest the following patch to winsup/configure.in instead:
> >  
> > This builds cygwin, cygserver, lsaauth, utils and doc dirs
> > if the target is Cygwin, mingw and w32api otherwise.  
> 
> I'll incorporate that into my next draft.
> 
> > Just as a note for the future, we don't have to fix that immediately:
> > 
> > Given that the lsaauth modules don't call any Cygwin function but rather
> > only use a few Cygwin datastructure, and given that we now require a
> > mingw compiler to build the native utils anyway, I'm wondering if we
> > shouldn't simply require the x86 and x86_64 targeting mingw compilers to
> > build the lsaauth modules as well.
> > 
> > If we do that, we could already build the 32 and the 64 bit versions
> > of the lsaauth module today, right from the Makefile.  That sounds 
> > like a much better solution than the make-64bit-version-with-mingw-w64.sh
> > script and keeping the 64 bit DLL as a binary blob in the repo, doesn't
> > it?
> 
> Agreed, I'll add that too.

That's nice, but... I'm not yet sure how *exactly* this should look like.
I don't know if you can just include the required cygwin headers without
trouble, for instance.  Also, the 32 and the 64 bit version of the
cyglsa DLL belong together into a single 32 bit release.  This requires
to have both mingw compilers installed to create a 32 bit Cygwin
release.   Should configure fail if one of them can't be found?  Or
should it just warn?  Such a warning is easily missed.  I think we
should discuss this first.

At one point we will also have to decide if the 64 bit cyglsa should be
built with 64 bit Cygwin...

> > A very minor nit:  Personally I feel better if variables are braced in
> > such a scenario. From my POV it's also easier readable:
> > 
> >   AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++ ${target_cpu}-pc-mingw32-g++)
> 
> Fine.
> 
> > Other than that, I think it's good to go in after the 1.7.17 release.
> > I'll try to do the release at some point between now and Monday.
> 
> I'll include those changes and post a new patch then.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
