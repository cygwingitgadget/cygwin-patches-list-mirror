Return-Path: <cygwin-patches-return-7163-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10257 invoked by alias); 5 Feb 2011 20:28:16 -0000
Received: (qmail 10246 invoked by uid 22791); 5 Feb 2011 20:28:16 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0	tests=AWL,BAYES_20,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm30.bullet.mail.sp2.yahoo.com (HELO nm30.bullet.mail.sp2.yahoo.com) (98.139.91.100)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sat, 05 Feb 2011 20:28:09 +0000
Received: from [98.139.91.61] by nm30.bullet.mail.sp2.yahoo.com with NNFMP; 05 Feb 2011 20:28:08 -0000
Received: from [98.136.185.46] by tm1.bullet.mail.sp2.yahoo.com with NNFMP; 05 Feb 2011 20:28:08 -0000
Received: from [127.0.0.1] by smtp107.mail.gq1.yahoo.com with NNFMP; 05 Feb 2011 20:28:08 -0000
Received: from cgf.cx (cgf@72.70.43.36 with login)        by smtp107.mail.gq1.yahoo.com with SMTP; 05 Feb 2011 12:28:07 -0800 PST
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id BF6B513C0CD	for <cygwin-patches@cygwin.com>; Sat,  5 Feb 2011 15:28:06 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id B7DBF15AFE2; Sat,  5 Feb 2011 15:28:06 -0500 (EST)
Date: Sat, 05 Feb 2011 20:28:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: provide __xpg_strerror_r
Message-ID: <20110205202806.GA11118@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D4DAD40.3060904@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D4DAD40.3060904@redhat.com>
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
X-SW-Source: 2011-q1/txt/msg00018.txt.bz2

On Sat, Feb 05, 2011 at 01:04:16PM -0700, Eric Blake wrote:
>Our strerror_r is lousy (it doesn't even match glibc's behavior); see my
>request to the newlib list.

We really should just implement strerror_r in errno.cc.  It doesn't make
sense to have two different implementations

cgf
