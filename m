Return-Path: <cygwin-patches-return-7289-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10398 invoked by alias); 3 May 2011 21:01:36 -0000
Received: (qmail 10383 invoked by uid 22791); 3 May 2011 21:01:35 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm3.bullet.mail.bf1.yahoo.com (HELO nm3.bullet.mail.bf1.yahoo.com) (98.139.212.162)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 03 May 2011 21:01:21 +0000
Received: from [98.139.212.148] by nm3.bullet.mail.bf1.yahoo.com with NNFMP; 03 May 2011 21:01:20 -0000
Received: from [98.139.213.7] by tm5.bullet.mail.bf1.yahoo.com with NNFMP; 03 May 2011 21:01:20 -0000
Received: from [127.0.0.1] by smtp107.mail.bf1.yahoo.com with NNFMP; 03 May 2011 21:01:20 -0000
Received: from cgf.cx (cgf@108.49.31.43 with login)        by smtp107.mail.bf1.yahoo.com with SMTP; 03 May 2011 14:01:20 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 0208E4A800A	for <cygwin-patches@cygwin.com>; Tue,  3 May 2011 17:01:20 -0400 (EDT)
Date: Tue, 03 May 2011 21:01:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_attr_getstack{,addr}, pthread_getattr_np
Message-ID: <20110503210119.GA1673@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1304350389.6972.11.camel@YAAKOV04> <20110502201124.GA13011@ednor.casa.cgf.cx> <20110503075635.GA1451@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110503075635.GA1451@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00055.txt.bz2

On Tue, May 03, 2011 at 09:56:35AM +0200, Corinna Vinschen wrote:
>On May  2 16:11, Christopher Faylor wrote:
>> On Mon, May 02, 2011 at 10:33:09AM -0500, Yaakov (Cygwin/X) wrote:
>> >This implements pthread_attr_getstack(), pthread_attr_getstackaddr, and
>> >pthread_getattr_np(), which I need for webkitgtk.
>> >
>> >In essence, I added a stackaddr member to pthread_attr, which is
>> >accessed (slightly differently) by pthread_attr_getstack{,attr},
>> >behaving just as on Linux.  The bulk of the work is to support
>> >pthread_getattr_np, which provides the real attributes of the given
>> >thread, including the real stack address and size.
>> >
>> >The pthread_attr_setstack{,addr} setters are not implemented, as I have
>> >yet to find a way to set the thread stack address on Windows.  For that
>> >reason I'm not defining _POSIX_THREAD_ATTR_STACKADDR, as the feature is
>> >not yet (fully) implemented.
>> 
>> Cygwin already plays with the stack address.  It has to for situations
>> when you call fork() from a thread.
>
>Isn't that what GetThreadContext/SetThreadContext is for?

If you're just setting ebp/esp yes but you also have to mess around with
the locations where Windows stores stack frame information.

cgf
