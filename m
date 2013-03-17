Return-Path: <cygwin-patches-return-7856-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12749 invoked by alias); 17 Mar 2013 23:49:19 -0000
Received: (qmail 12730 invoked by uid 22791); 17 Mar 2013 23:49:17 -0000
X-SWARE-Spam-Status: No, hits=-5.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f169.google.com (HELO mail-ie0-f169.google.com) (209.85.223.169)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 17 Mar 2013 23:49:12 +0000
Received: by mail-ie0-f169.google.com with SMTP id 13so6462345iea.0        for <cygwin-patches@cygwin.com>; Sun, 17 Mar 2013 16:49:11 -0700 (PDT)
X-Received: by 10.50.33.139 with SMTP id r11mr5123612igi.63.1363564151784;        Sun, 17 Mar 2013 16:49:11 -0700 (PDT)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id xd4sm8626873igb.3.2013.03.17.16.49.10        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Sun, 17 Mar 2013 16:49:11 -0700 (PDT)
Date: Sun, 17 Mar 2013 23:49:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130317184909.1b7a838a@YAAKOV04>
In-Reply-To: <20130317041825.42371500@YAAKOV04>
References: <20130304131539.GE2481@calimero.vinschen.de>	<20130304144022.GI2481@calimero.vinschen.de>	<20130305000934.66f77aba@YAAKOV04>	<20130305084950.GB16361@calimero.vinschen.de>	<20130305031430.5ff522eb@YAAKOV04>	<20130305093009.GD16361@calimero.vinschen.de>	<20130305093850.GE16361@calimero.vinschen.de>	<20130315051819.2ce99a0b@YAAKOV04>	<20130315102655.GD1360@calimero.vinschen.de>	<20130315165640.14bdcb71@YAAKOV04>	<20130316104515.GA30245@calimero.vinschen.de>	<20130317041825.42371500@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00067.txt.bz2

On Sun, 17 Mar 2013 04:18:25 -0500, Yaakov (Cygwin/X) wrote:
> I also discovered two more gcc macros which were missing updates for
> x86_64-cygwin.  I have added those patches, and incorporated your x86_64
> patches into mine, into a 4.8 branch of my gcc port:
> 
> http://cygwin-ports.git.sourceforge.net/git/gitweb.cgi?p=cygwin-ports/gcc;a=shortlog;h=refs/heads/4.8
> 
> I am building native and 32-to-64 compilers with this patchset now.

libgcj needs some work, and gnat will have to wait until I can get a
native gnat 4.8, but the current tip of this branch builds successfully
for C/C++/Fortran/ObjC/ObjC++.


Yaakov
