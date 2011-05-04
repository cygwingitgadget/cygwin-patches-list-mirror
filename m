Return-Path: <cygwin-patches-return-7298-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26269 invoked by alias); 4 May 2011 15:09:59 -0000
Received: (qmail 26254 invoked by uid 22791); 4 May 2011 15:09:57 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm14-vm0.bullet.mail.bf1.yahoo.com (HELO nm14-vm0.bullet.mail.bf1.yahoo.com) (98.139.213.164)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 04 May 2011 15:09:42 +0000
Received: from [98.139.212.146] by nm14.bullet.mail.bf1.yahoo.com with NNFMP; 04 May 2011 15:09:41 -0000
Received: from [98.139.213.2] by tm3.bullet.mail.bf1.yahoo.com with NNFMP; 04 May 2011 15:09:41 -0000
Received: from [127.0.0.1] by smtp102.mail.bf1.yahoo.com with NNFMP; 04 May 2011 15:09:41 -0000
Received: from cgf.cx (cgf@108.49.31.43 with login)        by smtp102.mail.bf1.yahoo.com with SMTP; 04 May 2011 08:09:41 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 990B54A800A	for <cygwin-patches@cygwin.com>; Wed,  4 May 2011 11:09:40 -0400 (EDT)
Date: Wed, 04 May 2011 15:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: initialize local variable wait_return
Message-ID: <20110504150940.GC19601@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BANLkTikUJ+opazYOga0URTKj6-6Nw_D+pw@mail.gmail.com> <BANLkTinhei4VRcfFLeFAJfqwOD08W1Df+w@mail.gmail.com> <20110504060321.GC30194@ednor.casa.cgf.cx> <1304504251.820.1.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304504251.820.1.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00064.txt.bz2

On Wed, May 04, 2011 at 05:17:31AM -0500, Yaakov (Cygwin/X) wrote:
>On Wed, 2011-05-04 at 02:03 -0400, Christopher Faylor wrote:
>> On Wed, May 04, 2011 at 11:11:52AM +0800, Chiheng Xu wrote:
>> >2011-05-04  Chiheng Xu  <chiheng.xu@gmail.com>
>> >
>> >       * fhandler.cc (fhandler_base_overlapped::wait_overlapped): initialize
>> >local variable wait_return , otherwise, gcc-4.3.4 will not compile it.
>> 
>> Sorry but this is the wrong solution to this problem.  I rewrote the
>> code recently to carefully set error conditions at each decision point.
>> Globally setting it at the beginning is a step backwards and it actually
>> masks the real problem.
>
>FWIW, I regularly build CVS with gcc-4.5, and there is currently no
>compilation problem.

I actually fixed this problem last night by marking a few functions as
__attribute__ ((noreturn)).  That eliminated the need to spuriously set
a variable to zero to quiet gcc.

cgf
