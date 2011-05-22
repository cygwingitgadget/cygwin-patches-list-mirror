Return-Path: <cygwin-patches-return-7382-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21463 invoked by alias); 22 May 2011 01:35:33 -0000
Received: (qmail 21338 invoked by uid 22791); 22 May 2011 01:35:32 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm20-vm1.bullet.mail.ne1.yahoo.com (HELO nm20-vm1.bullet.mail.ne1.yahoo.com) (98.138.91.21)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 22 May 2011 01:35:17 +0000
Received: from [98.138.90.51] by nm20.bullet.mail.ne1.yahoo.com with NNFMP; 22 May 2011 01:35:16 -0000
Received: from [98.138.84.46] by tm4.bullet.mail.ne1.yahoo.com with NNFMP; 22 May 2011 01:35:16 -0000
Received: from [127.0.0.1] by smtp114.mail.ne1.yahoo.com with NNFMP; 22 May 2011 01:35:16 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp114.mail.ne1.yahoo.com with SMTP; 21 May 2011 18:35:15 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 37DFA42804C	for <cygwin-patches@cygwin.com>; Sat, 21 May 2011 21:35:15 -0400 (EDT)
Date: Sun, 22 May 2011 01:35:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: __xpg_strerror_r should not clobber strerror buffer
Message-ID: <20110522013514.GA16516@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DD8664D.2000407@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DD8664D.2000407@redhat.com>
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
X-SW-Source: 2011-q2/txt/msg00148.txt.bz2

On Sat, May 21, 2011 at 07:26:37PM -0600, Eric Blake wrote:
>POSIX says that no other function in the standard should clobber the
>strerror buffer.  Our strerror_r is a GNU extension, so it can get away
>with clobbering the buffer (but if we wanted to fix it, we would have to
>separate _my_tls.locals.strerror_buf into two different buffers).
>perror() is still broken, but that needs to be fixed in newlib.  But
>__xpg_strerror_r, which is our POSIX strerror_r variant, has to be fixed
>in cygwin.
>
>Meanwhile, glibc just patched strerror this week to print negative
>errnum as a negative 32-bit int, rather than as a positive unsigned
>long; cygwin should do likewise.
>
>2011-05-21  Eric Blake  <eblake@redhat.com>
>
>	* errno.cc (strerror): Print unknown errno as int.
>	(__xpg_strerror_r): Likewise, and don't clobber strerror buffer.

Looks good.  Please check in.

Thanks.

cgf
