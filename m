Return-Path: <cygwin-patches-return-7738-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3750 invoked by alias); 21 Oct 2012 16:38:42 -0000
Received: (qmail 3665 invoked by uid 22791); 21 Oct 2012 16:38:41 -0000
X-SWARE-Spam-Status: No, hits=-5.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f171.google.com (HELO mail-ie0-f171.google.com) (209.85.223.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 21 Oct 2012 16:38:36 +0000
Received: by mail-ie0-f171.google.com with SMTP id s9so2799364iec.2        for <cygwin-patches@cygwin.com>; Sun, 21 Oct 2012 09:38:35 -0700 (PDT)
Received: by 10.43.120.9 with SMTP id fw9mr5705479icc.46.1350837515650;        Sun, 21 Oct 2012 09:38:35 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id us4sm20606253igc.9.2012.10.21.09.38.34        (version=TLSv1/SSLv3 cipher=OTHER);        Sun, 21 Oct 2012 09:38:35 -0700 (PDT)
Message-ID: <1350837515.1244.31.camel@YAAKOV04>
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Sun, 21 Oct 2012 16:38:00 -0000
In-Reply-To: <20121021113320.GA2469@calimero.vinschen.de>
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>	 <20121017164440.GA12989@ednor.casa.cgf.cx>	 <20121017170514.GD10578@calimero.vinschen.de>	 <20121017193258.GA15271@ednor.casa.cgf.cx>	 <1350545597.3492.59.camel@YAAKOV04>	 <20121018083419.GC6221@calimero.vinschen.de>	 <1350580828.3492.73.camel@YAAKOV04>	 <20121019092135.GA22432@calimero.vinschen.de>	 <1350664438.3492.114.camel@YAAKOV04>	 <20121019184636.GZ25877@calimero.vinschen.de>	 <20121021113320.GA2469@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00015.txt.bz2

On Sun, 2012-10-21 at 13:33 +0200, Corinna Vinschen wrote:
> On second thought... considering that w32api is now Mingw64 based, and
> considering that building Cygwin with this Mingw64 built w32api works
> fine... what do you guys think about a "once and for all" approach?  Is
> it really necessary to keep supporting a build against the old w32api?
> What does that buy us apart from added complexity?  Doesn't that also
> mean we have to test our builds against both w32api versions as long as
> we support it?  I, for one, have no real interest to do so.

AFAICS the momentum has been moving towards mingw-w64 since Fedora
switched for F17; I'm seeing more and more packages which compile with
mingw-w64 but not with mingw.org's toolchain.  Now that we've moved to a
mingw-w64-based w32api, F16 (the last release to use mingw.org) will be
EOL soon enough (one month after F18), and mingw-w64 is absolutely
required for adding x64 support, I agree that this would be a good time
to just switch and be done with it.  (Does the same apply to setup.exe?)

That does raise a related, but off-topic here, question as to whether we
need to continue supporting both toolchains in the distro, or if we
should just drop mingw-* and possibly rename mingw64-{i686,x86_64} to
mingw32- and mingw64- as Fedora has done.  But I imagine that may be a
bit contentious for some, so let's discuss that elsewhere.


Yaakov

