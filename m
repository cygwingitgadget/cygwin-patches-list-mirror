Return-Path: <cygwin-patches-return-7462-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23721 invoked by alias); 31 Jul 2011 18:51:42 -0000
Received: (qmail 23469 invoked by uid 22791); 31 Jul 2011 18:51:41 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm20-vm0.bullet.mail.bf1.yahoo.com (HELO nm20-vm0.bullet.mail.bf1.yahoo.com) (98.139.213.165)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 31 Jul 2011 18:51:26 +0000
Received: from [98.139.212.146] by nm20.bullet.mail.bf1.yahoo.com with NNFMP; 31 Jul 2011 18:51:25 -0000
Received: from [98.139.213.10] by tm3.bullet.mail.bf1.yahoo.com with NNFMP; 31 Jul 2011 18:51:25 -0000
Received: from [127.0.0.1] by smtp110.mail.bf1.yahoo.com with NNFMP; 31 Jul 2011 18:51:25 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@173.76.51.125 with login)        by smtp110.mail.bf1.yahoo.com with SMTP; 31 Jul 2011 11:51:25 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 08A5913C002	for <cygwin-patches@cygwin.com>; Sun, 31 Jul 2011 14:51:25 -0400 (EDT)
Date: Sun, 31 Jul 2011 18:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] workaround for sigproc_init
Message-ID: <20110731185111.GA22138@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E329C56.8090605@gmail.com> <20110730210453.GB31551@ednor.casa.cgf.cx> <20110731082623.GA23964@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110731082623.GA23964@calimero.vinschen.de>
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
X-SW-Source: 2011-q3/txt/msg00038.txt.bz2

On Sun, Jul 31, 2011 at 10:26:23AM +0200, Corinna Vinschen wrote:
>On Jul 30 17:04, Christopher Faylor wrote:
>> On Fri, Jul 29, 2011 at 08:41:10PM +0900, jojelino wrote:
>> >As sigproc_init is called during dll initialization, wait_sig thread is 
>> >not created as soon as possible.(this is known in msdn createthread 
>> >reference. http://msdn.microsoft.com/en-us/library/ms682453(v=vs.85).aspx)
>> >And then wait_sig starts to wake up as sig_dispatch_pending enters 
>> >waitforsingleobject. then main thread stops for few ms. and it shows 
>> >poor performance.
>> 
>> Incidentally, the intent of the now-defunct wincap
>> wincap.has_buggy_thread_startup was to avoid creating wait_sig during
>> thread startup, moving it to dll_crt0_1() which is the code that
>> eventually calls main().
>> 
>> (This was all rehashed back in August/September 2010)
>> 
>> Although I didn't fiddle with that myself, Corinna reported that having
>> the value set had no effect in her test cases so I don't think your
>> analysis here is 100% correct.
>
>Erm, I tested on 32 bit.  The slowdown occured on all platforms, not
>only 64 bit.  64 bit is still only half as fast in the date loop for
>reason or reasons unknown.

With my recent changes, I see about 10% difference between W7 64-bit
and XP 32-bit on the same machine.  W7 64-bit is slower.

cgf
