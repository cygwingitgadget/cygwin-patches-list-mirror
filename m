Return-Path: <cygwin-patches-return-7506-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7234 invoked by alias); 8 Sep 2011 19:10:11 -0000
Received: (qmail 7223 invoked by uid 22791); 8 Sep 2011 19:10:09 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm29.bullet.mail.bf1.yahoo.com (HELO nm29.bullet.mail.bf1.yahoo.com) (98.139.212.188)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 08 Sep 2011 19:09:54 +0000
Received: from [98.139.212.148] by nm29.bullet.mail.bf1.yahoo.com with NNFMP; 08 Sep 2011 19:09:53 -0000
Received: from [98.139.212.213] by tm5.bullet.mail.bf1.yahoo.com with NNFMP; 08 Sep 2011 19:09:53 -0000
Received: from [127.0.0.1] by omp1022.mail.bf1.yahoo.com with NNFMP; 08 Sep 2011 19:09:53 -0000
Received: (qmail 65630 invoked from network); 8 Sep 2011 19:09:53 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@72.70.43.200 with login)        by smtp203.mail.bf1.yahoo.com with SMTP; 08 Sep 2011 12:09:53 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id B2CD413C00B	for <cygwin-patches@cygwin.com>; Thu,  8 Sep 2011 15:09:52 -0400 (EDT)
Date: Thu, 08 Sep 2011 19:10:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix strace -T
Message-ID: <20110908190952.GB30425@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E690B69.6020306@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E690B69.6020306@dronecode.org.uk>
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
X-SW-Source: 2011-q3/txt/msg00082.txt.bz2

On Thu, Sep 08, 2011 at 07:37:29PM +0100, Jon TURNEY wrote:
>
>strace -T to toggle stracing of a process doesn't seem to work at the moment. 
>Attached is a patch to make it work again.
>
>2011-09-08  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
>	* include/sys/strace.h (strace): Add toggle() method
>	* strace.cc (toggle): Implement toggle() method
>	* sigproc.cc (wait_sig): Use strace.toggle() in __SIGSTRACE

IIRC, the intent was for hello() to toggle (in which case I guess it
should be hellogoodbye).  Why do you even need this functionality?
I'd just as soon remove it.

cgf
