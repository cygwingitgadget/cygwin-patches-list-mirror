Return-Path: <cygwin-patches-return-7845-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16441 invoked by alias); 5 Mar 2013 06:19:02 -0000
Received: (qmail 16426 invoked by uid 22791); 5 Mar 2013 06:19:01 -0000
X-SWARE-Spam-Status: No, hits=-5.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_BG,TW_GC
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f177.google.com (HELO mail-ie0-f177.google.com) (209.85.223.177)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 05 Mar 2013 06:18:55 +0000
Received: by mail-ie0-f177.google.com with SMTP id 16so7094288iea.8        for <cygwin-patches@cygwin.com>; Mon, 04 Mar 2013 22:18:55 -0800 (PST)
X-Received: by 10.42.30.132 with SMTP id v4mr25941271icc.34.1362464334984;        Mon, 04 Mar 2013 22:18:54 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ew5sm15628239igc.2.2013.03.04.22.18.53        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Mon, 04 Mar 2013 22:18:54 -0800 (PST)
Date: Tue, 05 Mar 2013 06:19:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130305000934.66f77aba@YAAKOV04>
In-Reply-To: <20130304144022.GI2481@calimero.vinschen.de>
References: <20130304021224.381b9ec4@YAAKOV04>	<20130304105134.GF5468@calimero.vinschen.de>	<20130304053936.49484e71@YAAKOV04>	<20130304131539.GE2481@calimero.vinschen.de>	<20130304144022.GI2481@calimero.vinschen.de>
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
X-SW-Source: 2013-q1/txt/msg00056.txt.bz2

On Mon, 4 Mar 2013 15:40:22 +0100, Corinna Vinschen wrote:
> On Mar  4 14:15, Corinna Vinschen wrote:
> > Thanks, but here's a question:  If the libgcj ABI version really changes
> > with every GCC major.minor release, wouldn't it then make sense to
> > change the libgcj DLL versioning scheme so it uses the GCC major.minor
> > number rather than an arbitrary version number?
> > 
> > In other words, why not cyggcj-4.8.dll?  This would allow easy
> > automation of Cygwin's LIBGCJ_SONAME, and everybody would know what
> > GCC version it's based on.
> 
> Here's my version of the LIBGCJ_SONAME setting:
> 
> #ifndef BUILDING_GCC_MAJOR
> #include "bversion.h"
> #endif
> #define ___cyg_mkstr(x) #x
> #define __cyg_mkstr(x)  ___cyg_mkstr(x)
> #define LIBGCJ_SONAME "cyggcj-" __cyg_mkstr (BUILDING_GCC_MAJOR) "." \
> 				__cyg_mkstr (BUILDING_GCC_MINOR) ".dll"

I don't know if the version changes are a matter of policy or just how
it has happened, but in any case that's not the current versioning
scheme, nor is it how libtool libraries are usually versioned (and no,
libgnat is not built with libtool).  As long as this continues, the
following would work instead if you want to automate it:

#define LIBGCJ_SONAME "cyggcj-" __cyg_mkstr (BUILDING_GCC_MINOR+6) ".dll"

Also, you missed the #undef CXX_WRAP_SPEC_LIST before #define
CXX_WRAP_SPEC_LIST in cygwin-w64.h; this avoids a bunch of warnings
building GCC.


Yaakov
