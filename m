Return-Path: <cygwin-patches-return-7850-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2267 invoked by alias); 5 Mar 2013 09:48:31 -0000
Received: (qmail 2256 invoked by uid 22791); 5 Mar 2013 09:48:31 -0000
X-SWARE-Spam-Status: No, hits=-5.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_GC
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f174.google.com (HELO mail-ia0-f174.google.com) (209.85.210.174)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 05 Mar 2013 09:48:25 +0000
Received: by mail-ia0-f174.google.com with SMTP id u20so5774289iag.19        for <cygwin-patches@cygwin.com>; Tue, 05 Mar 2013 01:48:24 -0800 (PST)
X-Received: by 10.42.128.70 with SMTP id l6mr16511195ics.54.1362476904583;        Tue, 05 Mar 2013 01:48:24 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id s8sm16550824igs.0.2013.03.05.01.48.23        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Tue, 05 Mar 2013 01:48:23 -0800 (PST)
Date: Tue, 05 Mar 2013 09:48:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130305034820.6c75beec@YAAKOV04>
In-Reply-To: <20130305093009.GD16361@calimero.vinschen.de>
References: <20130304021224.381b9ec4@YAAKOV04>	<20130304105134.GF5468@calimero.vinschen.de>	<20130304053936.49484e71@YAAKOV04>	<20130304131539.GE2481@calimero.vinschen.de>	<20130304144022.GI2481@calimero.vinschen.de>	<20130305000934.66f77aba@YAAKOV04>	<20130305084950.GB16361@calimero.vinschen.de>	<20130305031430.5ff522eb@YAAKOV04>	<20130305093009.GD16361@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-SW-Source: 2013-q1/txt/msg00061.txt.bz2

On Tue, 5 Mar 2013 10:30:09 +0100, Corinna Vinschen wrote:
> On Mar  5 03:14, Yaakov wrote:
> > No, we don't control the DLL name; libjava/Makefile.am and
> > libjava/libtool-version determine the soname of libgcj based on
> > standard libtool naming and versioning practices.  Since GCC 3.2
> > (libgcj.so.3), there has been a consistent +1 version bump for each
> > major.minor release, hence the x+6 for the 4.x series
> > (for 4.8: cyggcj-14.dll, libgcj.so.14, etc.).
> > 
> > The define in cygwin*.h or mingw32.h is used in
> > libgcc/config/i386/cygming-crtbegin.c:__gcc_register_frame(), so it's
> > the define that needs to match the build system, not the other way
> > around.
> 
> Sigh, ok.  I'll use your definition.  What do we do when gcc 5.0
> is getting close?

We can deal with it then, but at least we won't have to worry about
this for a while (as otherwise this seems to always be forgotten by
upstream).


Yaakov
