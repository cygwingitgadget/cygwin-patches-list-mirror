Return-Path: <cygwin-patches-return-7461-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15750 invoked by alias); 31 Jul 2011 17:31:06 -0000
Received: (qmail 15738 invoked by uid 22791); 31 Jul 2011 17:31:05 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm1-vm3.bullet.mail.ne1.yahoo.com (HELO nm1-vm3.bullet.mail.ne1.yahoo.com) (98.138.91.131)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 31 Jul 2011 17:30:43 +0000
Received: from [98.138.90.49] by nm1.bullet.mail.ne1.yahoo.com with NNFMP; 31 Jul 2011 17:30:41 -0000
Received: from [98.138.84.40] by tm2.bullet.mail.ne1.yahoo.com with NNFMP; 31 Jul 2011 17:30:41 -0000
Received: from [127.0.0.1] by smtp108.mail.ne1.yahoo.com with NNFMP; 31 Jul 2011 17:30:41 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@173.76.51.125 with login)        by smtp108.mail.ne1.yahoo.com with SMTP; 31 Jul 2011 10:30:41 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id A808813C003	for <cygwin-patches@cygwin.com>; Sun, 31 Jul 2011 13:30:40 -0400 (EDT)
Date: Sun, 31 Jul 2011 17:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] you can use this patch to profile cygwin
Message-ID: <20110731173027.GA5795@ednor.casa.cgf.cx>
Reply-To: cygwin-developers@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E329C56.8090605@gmail.com> <20110730210453.GB31551@ednor.casa.cgf.cx> <20110731082623.GA23964@calimero.vinschen.de> <4E351D88.7000806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E351D88.7000806@gmail.com>
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
X-SW-Source: 2011-q3/txt/msg00037.txt.bz2

On Sun, Jul 31, 2011 at 06:16:56PM +0900, jojelino wrote:
>On 2011-07-31 PM 5:26, Corinna Vinschen wrote:
>> Erm, I tested on 32 bit.  The slowdown occured on all platforms, not
>> only 64 bit.  64 bit is still only half as fast in the date loop for
>> reason or reasons unknown.
>>
>>
>> Corinna
>>
>  I used this code to profile every source compiled with -pg 
>-finstrument-functions.
>It had no documentation. because it existed solely for the purpose to 
>breakdown  the cause of slow start.

And, as usual, the formatting is completely off so it couldn't be
incorporated into the source code as is regardless.

Given that this isn't a submitted patch, it probably makes sense to
continue any discussion in cygwin-developers.

cgf
