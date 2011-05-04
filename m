Return-Path: <cygwin-patches-return-7292-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26590 invoked by alias); 4 May 2011 06:03:40 -0000
Received: (qmail 26563 invoked by uid 22791); 4 May 2011 06:03:39 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm26-vm4.bullet.mail.ne1.yahoo.com (HELO nm26-vm4.bullet.mail.ne1.yahoo.com) (98.138.91.186)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 04 May 2011 06:03:24 +0000
Received: from [98.138.90.57] by nm26.bullet.mail.ne1.yahoo.com with NNFMP; 04 May 2011 06:03:23 -0000
Received: from [98.138.84.35] by tm10.bullet.mail.ne1.yahoo.com with NNFMP; 04 May 2011 06:03:23 -0000
Received: from [127.0.0.1] by smtp103.mail.ne1.yahoo.com with NNFMP; 04 May 2011 06:03:23 -0000
Received: from cgf.cx (cgf@108.49.31.43 with login)        by smtp103.mail.ne1.yahoo.com with SMTP; 03 May 2011 23:03:22 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id A8AFE4A800A	for <cygwin-patches@cygwin.com>; Wed,  4 May 2011 02:03:21 -0400 (EDT)
Date: Wed, 04 May 2011 06:03:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: initialize local variable wait_return
Message-ID: <20110504060321.GC30194@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BANLkTikUJ+opazYOga0URTKj6-6Nw_D+pw@mail.gmail.com> <BANLkTinhei4VRcfFLeFAJfqwOD08W1Df+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTinhei4VRcfFLeFAJfqwOD08W1Df+w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00058.txt.bz2

On Wed, May 04, 2011 at 11:11:52AM +0800, Chiheng Xu wrote:
>2011-05-04  Chiheng Xu  <chiheng.xu@gmail.com>
>
>       * fhandler.cc (fhandler_base_overlapped::wait_overlapped): initialize
>local variable wait_return , otherwise, gcc-4.3.4 will not compile it.

Sorry but this is the wrong solution to this problem.  I rewrote the
code recently to carefully set error conditions at each decision point.
Globally setting it at the beginning is a step backwards and it actually
masks the real problem.

cgf
