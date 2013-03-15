Return-Path: <cygwin-patches-return-7851-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23435 invoked by alias); 15 Mar 2013 10:18:27 -0000
Received: (qmail 23417 invoked by uid 22791); 15 Mar 2013 10:18:25 -0000
X-SWARE-Spam-Status: No, hits=-5.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f181.google.com (HELO mail-ia0-f181.google.com) (209.85.210.181)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Mar 2013 10:18:19 +0000
Received: by mail-ia0-f181.google.com with SMTP id o25so781476iad.12        for <cygwin-patches@cygwin.com>; Fri, 15 Mar 2013 03:18:18 -0700 (PDT)
X-Received: by 10.50.140.5 with SMTP id rc5mr831823igb.78.1363342698645;        Fri, 15 Mar 2013 03:18:18 -0700 (PDT)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id s8sm1142068igs.0.2013.03.15.03.18.17        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Fri, 15 Mar 2013 03:18:18 -0700 (PDT)
Date: Fri, 15 Mar 2013 10:18:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130315051819.2ce99a0b@YAAKOV04>
In-Reply-To: <20130305093850.GE16361@calimero.vinschen.de>
References: <20130304021224.381b9ec4@YAAKOV04>	<20130304105134.GF5468@calimero.vinschen.de>	<20130304053936.49484e71@YAAKOV04>	<20130304131539.GE2481@calimero.vinschen.de>	<20130304144022.GI2481@calimero.vinschen.de>	<20130305000934.66f77aba@YAAKOV04>	<20130305084950.GB16361@calimero.vinschen.de>	<20130305031430.5ff522eb@YAAKOV04>	<20130305093009.GD16361@calimero.vinschen.de>	<20130305093850.GE16361@calimero.vinschen.de>
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
X-SW-Source: 2013-q1/txt/msg00062.txt.bz2

On Tue, 5 Mar 2013 10:38:50 +0100, Corinna Vinschen wrote:
> What about
> 
> #if BUILDING_GCC_MAJOR == 4
> #define LIBGCJ_SONAME "cyggcj-" __cyg_mkstr (BUILDING_GCC_MINOR+6) ".dll"
> #else
> #error LIBGCJ_SONAME versioning scheme needs attention
> #endif
> 
> for now?

Nope; this failed in boostrap stage 1 due to failed #include
<bversion.h>.

BTW, could you post your current gcc patch?


Yaakov
