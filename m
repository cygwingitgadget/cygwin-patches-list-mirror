Return-Path: <cygwin-patches-return-7393-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9110 invoked by alias); 23 May 2011 20:55:07 -0000
Received: (qmail 9100 invoked by uid 22791); 23 May 2011 20:55:06 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm1-vm1.bullet.mail.ne1.yahoo.com (HELO nm1-vm1.bullet.mail.ne1.yahoo.com) (98.138.91.36)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 23 May 2011 20:54:53 +0000
Received: from [98.138.90.49] by nm1.bullet.mail.ne1.yahoo.com with NNFMP; 23 May 2011 20:54:51 -0000
Received: from [98.138.226.131] by tm2.bullet.mail.ne1.yahoo.com with NNFMP; 23 May 2011 20:54:51 -0000
Received: from [127.0.0.1] by smtp218.mail.ne1.yahoo.com with NNFMP; 23 May 2011 20:54:51 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp218.mail.ne1.yahoo.com with SMTP; 23 May 2011 13:54:50 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id D945642804C	for <cygwin-patches@cygwin.com>; Mon, 23 May 2011 16:54:49 -0400 (EDT)
Date: Mon, 23 May 2011 20:55:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: __xpg_strerror_r should not clobber strerror buffer
Message-ID: <20110523205449.GB7573@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DD8664D.2000407@redhat.com> <20110522013514.GA16516@ednor.casa.cgf.cx> <4DDAC777.5030205@redhat.com> <4DDAC8FC.5000508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DDAC8FC.5000508@redhat.com>
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
X-SW-Source: 2011-q2/txt/msg00159.txt.bz2

On Mon, May 23, 2011 at 02:52:12PM -0600, Eric Blake wrote:
>On 05/23/2011 02:45 PM, Eric Blake wrote:
>> On 05/21/2011 07:35 PM, Christopher Faylor wrote:
>>> On Sat, May 21, 2011 at 07:26:37PM -0600, Eric Blake wrote:
>>>> POSIX says that no other function in the standard should clobber the
>>>> strerror buffer.  Our strerror_r is a GNU extension, so it can get away
>>>> with clobbering the buffer (but if we wanted to fix it, we would have to
>>>> separate _my_tls.locals.strerror_buf into two different buffers).
>
>Shoot.  This introduced an off-by-one buffer overrun.  I'm pushing this
>followup.  Meanwhile, do we want a second buffer, so that the GNU
>strerror_r won't clobber the strerror buffer?
>
>+++ b/winsup/cygwin/ChangeLog
>@@ -2,6 +2,7 @@
>
> 	* errno.cc (strerror): Print unknown errno as int.
> 	(__xpg_strerror_r): Likewise, and don't clobber strerror buffer.
>+	* cygtls.h (strerror_buf): Resize to allow '-'.

Please don't send ChangeLog diffs.

The patch is approved.  I don't know if I care whether strerror_r
clobbers strerror.

Thanks.

cgf
