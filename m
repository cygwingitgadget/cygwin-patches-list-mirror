Return-Path: <cygwin-patches-return-7852-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28485 invoked by alias); 15 Mar 2013 10:27:38 -0000
Received: (qmail 28193 invoked by uid 22791); 15 Mar 2013 10:27:04 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 15 Mar 2013 10:26:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A5BB35203B8; Fri, 15 Mar 2013 11:26:55 +0100 (CET)
Date: Fri, 15 Mar 2013 10:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130315102655.GD1360@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130304105134.GF5468@calimero.vinschen.de> <20130304053936.49484e71@YAAKOV04> <20130304131539.GE2481@calimero.vinschen.de> <20130304144022.GI2481@calimero.vinschen.de> <20130305000934.66f77aba@YAAKOV04> <20130305084950.GB16361@calimero.vinschen.de> <20130305031430.5ff522eb@YAAKOV04> <20130305093009.GD16361@calimero.vinschen.de> <20130305093850.GE16361@calimero.vinschen.de> <20130315051819.2ce99a0b@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130315051819.2ce99a0b@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00063.txt.bz2

On Mar 15 05:18, Yaakov wrote:
> On Tue, 5 Mar 2013 10:38:50 +0100, Corinna Vinschen wrote:
> > What about
> > 
> > #if BUILDING_GCC_MAJOR == 4
> > #define LIBGCJ_SONAME "cyggcj-" __cyg_mkstr (BUILDING_GCC_MINOR+6) ".dll"
> > #else
> > #error LIBGCJ_SONAME versioning scheme needs attention
> > #endif
> > 
> > for now?
> 
> Nope; this failed in boostrap stage 1 due to failed #include
> <bversion.h>.
> 
> BTW, could you post your current gcc patch?

It's the one from

ftp://ftp.cygwin.com/pub/cygwin/64bit/x86_64-pc-cygwin-gcc-20130305.patch

I didn't change anything in the toolchain since then.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
