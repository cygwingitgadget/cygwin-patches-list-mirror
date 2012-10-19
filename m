Return-Path: <cygwin-patches-return-7735-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10917 invoked by alias); 19 Oct 2012 16:33:57 -0000
Received: (qmail 10904 invoked by uid 22791); 19 Oct 2012 16:33:55 -0000
X-SWARE-Spam-Status: No, hits=-5.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f171.google.com (HELO mail-ia0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 19 Oct 2012 16:33:52 +0000
Received: by mail-ia0-f171.google.com with SMTP id u21so460870ial.2        for <cygwin-patches@cygwin.com>; Fri, 19 Oct 2012 09:33:51 -0700 (PDT)
Received: by 10.50.51.225 with SMTP id n1mr2060208igo.7.1350664430990;        Fri, 19 Oct 2012 09:33:50 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id 7sm764233igh.0.2012.10.19.09.33.49        (version=TLSv1/SSLv3 cipher=OTHER);        Fri, 19 Oct 2012 09:33:50 -0700 (PDT)
Message-ID: <1350664438.3492.114.camel@YAAKOV04>
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Fri, 19 Oct 2012 16:33:00 -0000
In-Reply-To: <20121019092135.GA22432@calimero.vinschen.de>
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>	 <20121017164440.GA12989@ednor.casa.cgf.cx>	 <20121017170514.GD10578@calimero.vinschen.de>	 <20121017193258.GA15271@ednor.casa.cgf.cx>	 <1350545597.3492.59.camel@YAAKOV04>	 <20121018083419.GC6221@calimero.vinschen.de>	 <1350580828.3492.73.camel@YAAKOV04>	 <20121019092135.GA22432@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00012.txt.bz2

On Fri, 2012-10-19 at 11:21 +0200, Corinna Vinschen wrote:
> On Oct 18 12:20, Yaakov (Cygwin/X) wrote:
> > None; should I also move the other setup.exe prerequisites for
> > i686-w64-mingw32?  Would you also like x86_64 versions of any of those?
> 
> If it's not asked too much, sure on both accounts!

Done.

> The theory is that cygwin will continue to co-exist with mingw and
> w32api for a while, but cygwin does not build or use mingw and w32api.
> However, winsup/configure.in adds mingw and w32api subdirs to SUBDIRS
> based on the mere existence of the dirs.
> If we want to make Cygwin independent of mingw/w32api and vice versa,
> I'd suggest the following patch to winsup/configure.in instead:
>  
> This builds cygwin, cygserver, lsaauth, utils and doc dirs
> if the target is Cygwin, mingw and w32api otherwise.  

I'll incorporate that into my next draft.

> Just as a note for the future, we don't have to fix that immediately:
> 
> Given that the lsaauth modules don't call any Cygwin function but rather
> only use a few Cygwin datastructure, and given that we now require a
> mingw compiler to build the native utils anyway, I'm wondering if we
> shouldn't simply require the x86 and x86_64 targeting mingw compilers to
> build the lsaauth modules as well.
> 
> If we do that, we could already build the 32 and the 64 bit versions
> of the lsaauth module today, right from the Makefile.  That sounds 
> like a much better solution than the make-64bit-version-with-mingw-w64.sh
> script and keeping the 64 bit DLL as a binary blob in the repo, doesn't
> it?

Agreed, I'll add that too.

> A very minor nit:  Personally I feel better if variables are braced in
> such a scenario. From my POV it's also easier readable:
> 
>   AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++ ${target_cpu}-pc-mingw32-g++)

Fine.

> Other than that, I think it's good to go in after the 1.7.17 release.
> I'll try to do the release at some point between now and Monday.

I'll include those changes and post a new patch then.


Yaakov

