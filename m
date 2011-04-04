Return-Path: <cygwin-patches-return-7253-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7540 invoked by alias); 4 Apr 2011 05:40:32 -0000
Received: (qmail 7239 invoked by uid 22791); 4 Apr 2011 05:40:30 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm5.bullet.mail.bf1.yahoo.com (HELO nm5.bullet.mail.bf1.yahoo.com) (98.139.212.164)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 04 Apr 2011 05:39:46 +0000
Received: from [98.139.212.149] by nm5.bullet.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 05:39:45 -0000
Received: from [98.139.213.6] by tm6.bullet.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 05:39:45 -0000
Received: from [127.0.0.1] by smtp106.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 05:39:45 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp106.mail.bf1.yahoo.com with SMTP; 03 Apr 2011 22:39:44 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 4FEB4428013	for <cygwin-patches@cygwin.com>; Mon,  4 Apr 2011 01:39:44 -0400 (EDT)
Date: Mon, 04 Apr 2011 05:40:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix make after clean
Message-ID: <20110404053944.GA31709@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301870258.3104.11.camel@YAAKOV04> <20110403230350.GA16226@ednor.casa.cgf.cx> <1301876562.3104.45.camel@YAAKOV04> <20110404050727.GA23230@ednor.casa.cgf.cx> <20110404053427.GA26407@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110404053427.GA26407@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q2/txt/msg00019.txt.bz2

On Mon, Apr 04, 2011 at 01:34:27AM -0400, Christopher Faylor wrote:
>On Mon, Apr 04, 2011 at 01:07:27AM -0400, Christopher Faylor wrote:
>>I *am* building on Linux, though, so maybe that's the difference.
>
>Nope.  It works fine on Windows too.

I wonder if maybe you somehow have a devices.cc in your build directory.

cgf
