Return-Path: <cygwin-patches-return-7860-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15901 invoked by alias); 22 Mar 2013 07:24:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15790 invoked by uid 89); 22 Mar 2013 07:23:58 -0000
X-Spam-SWARE-Status: No, score=-3.0 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_GC autolearn=ham version=3.3.1
Received: from mail-ia0-f170.google.com (HELO mail-ia0-f170.google.com) (209.85.210.170)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Fri, 22 Mar 2013 07:23:55 +0000
Received: by mail-ia0-f170.google.com with SMTP id h8so3319819iaa.29        for <cygwin-patches@cygwin.com>; Fri, 22 Mar 2013 00:23:54 -0700 (PDT)
X-Received: by 10.50.11.229 with SMTP id t5mr4111474igb.65.1363937034504;        Fri, 22 Mar 2013 00:23:54 -0700 (PDT)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id g6sm7029327ign.4.2013.03.22.00.23.52        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Fri, 22 Mar 2013 00:23:53 -0700 (PDT)
Date: Fri, 22 Mar 2013 07:24:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130322022351.6b6cefe1@YAAKOV04>
In-Reply-To: <20130318100924.GA15206@calimero.vinschen.de>
References: <20130305084950.GB16361@calimero.vinschen.de>	<20130305031430.5ff522eb@YAAKOV04>	<20130305093009.GD16361@calimero.vinschen.de>	<20130305093850.GE16361@calimero.vinschen.de>	<20130315051819.2ce99a0b@YAAKOV04>	<20130315102655.GD1360@calimero.vinschen.de>	<20130315165640.14bdcb71@YAAKOV04>	<20130316104515.GA30245@calimero.vinschen.de>	<20130317041825.42371500@YAAKOV04>	<20130317184909.1b7a838a@YAAKOV04>	<20130318100924.GA15206@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q1/txt/msg00071.txt.bz2

On Mon, 18 Mar 2013 11:09:24 +0100, Corinna Vinschen wrote:
> On Mar 17 18:49, Yaakov wrote:
> > On Sun, 17 Mar 2013 04:18:25 -0500, Yaakov (Cygwin/X) wrote:
> > > I also discovered two more gcc macros which were missing updates for
> > > x86_64-cygwin.  I have added those patches, and incorporated your x86_64
> > > patches into mine, into a 4.8 branch of my gcc port:
> > > 
> > > http://cygwin-ports.git.sourceforge.net/git/gitweb.cgi?p=cygwin-ports/gcc;a=shortlog;h=refs/heads/4.8
> > > 
> > > I am building native and 32-to-64 compilers with this patchset now.
> > 
> > libgcj needs some work, and gnat will have to wait until I can get a
> > native gnat 4.8, but the current tip of this branch builds successfully
> > for C/C++/Fortran/ObjC/ObjC++.
> 
> Do you have a full diff relative to GCC HEAD?

I've been focusing on 4.8 right now, so what I have is in the
aforementioned branch (which I updated just yesterday).  Working on
upstream HEAD will have to wait a few weeks.


Yaakov
