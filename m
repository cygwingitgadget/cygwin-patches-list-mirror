Return-Path: <cygwin-patches-return-7388-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19405 invoked by alias); 23 May 2011 01:36:43 -0000
Received: (qmail 19227 invoked by uid 22791); 23 May 2011 01:36:42 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm13-vm4.bullet.mail.ne1.yahoo.com (HELO nm13-vm4.bullet.mail.ne1.yahoo.com) (98.138.91.173)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 23 May 2011 01:36:28 +0000
Received: from [98.138.90.52] by nm13.bullet.mail.ne1.yahoo.com with NNFMP; 23 May 2011 01:36:27 -0000
Received: from [98.138.226.125] by tm5.bullet.mail.ne1.yahoo.com with NNFMP; 23 May 2011 01:36:26 -0000
Received: from [127.0.0.1] by smtp204.mail.ne1.yahoo.com with NNFMP; 23 May 2011 01:36:24 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp204.mail.ne1.yahoo.com with SMTP; 22 May 2011 18:36:24 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 07B3842804C	for <cygwin-patches@cygwin.com>; Sun, 22 May 2011 21:36:20 -0400 (EDT)
Date: Mon, 23 May 2011 01:36:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (1/5)
Message-ID: <20110523013619.GA5954@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD5FB.9050508@cs.utoronto.ca> <20110522014135.GA18936@ednor.casa.cgf.cx> <4DD909E8.1050407@cs.utoronto.ca> <20110522202918.GC25762@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110522202918.GC25762@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q2/txt/msg00154.txt.bz2

On Sun, May 22, 2011 at 04:29:18PM -0400, Christopher Faylor wrote:
>...I'd prefer that the testing be done in frok:parent when the
>child_copy happens for static and dynamic dlls, maybe by adding a dll
>function which first checks that the data/bss can be copied to the same
>location as the parent.

Actually, no, I think there's a better way to do that.  I'll check something
in in the next couple of days.

I think the rest of your patches have merit too so I'll be checking those
in as well.  Thanks for all of your work.

cgf
