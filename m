Return-Path: <cygwin-patches-return-7174-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6105 invoked by alias); 10 Feb 2011 06:04:42 -0000
Received: (qmail 6089 invoked by uid 22791); 10 Feb 2011 06:04:40 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm23-vm0.bullet.mail.ne1.yahoo.com (HELO nm23-vm0.bullet.mail.ne1.yahoo.com) (98.138.91.57)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 10 Feb 2011 06:04:34 +0000
Received: from [98.138.90.57] by nm23.bullet.mail.ne1.yahoo.com with NNFMP; 10 Feb 2011 06:04:32 -0000
Received: from [98.138.84.43] by tm10.bullet.mail.ne1.yahoo.com with NNFMP; 10 Feb 2011 06:04:32 -0000
Received: from [127.0.0.1] by smtp111.mail.ne1.yahoo.com with NNFMP; 10 Feb 2011 06:04:32 -0000
Received: from cgf.cx (cgf@72.70.43.36 with login)        by smtp111.mail.ne1.yahoo.com with SMTP; 09 Feb 2011 22:04:32 -0800 PST
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 717EA13C0CA	for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 01:04:31 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 69D192B352; Thu, 10 Feb 2011 01:04:31 -0500 (EST)
Date: Thu, 10 Feb 2011 06:04:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_yield
Message-ID: <20110210060431.GA11820@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1297316998.752.10.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1297316998.752.10.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00029.txt.bz2

On Wed, Feb 09, 2011 at 11:49:58PM -0600, Yaakov (Cygwin/X) wrote:
>pthread_yield(3) was part of the POSIX.1c drafts but never made it into
>the final standard.  Nevertheless, it is provided by Linux[1],
>FreeBSD[2], OpenBSD[3], AIX[4], and possibly other *NIXes.  
>
>"On Linux, this function is implemented as a call to sched_yield(2)."
>Patch attached.

Please check in.

Thanks.

cgf
