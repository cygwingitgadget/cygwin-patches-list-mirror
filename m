Return-Path: <cygwin-patches-return-7168-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27393 invoked by alias); 7 Feb 2011 15:26:35 -0000
Received: (qmail 27383 invoked by uid 22791); 7 Feb 2011 15:26:34 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm11-vm0.bullet.mail.bf1.yahoo.com (HELO nm11-vm0.bullet.mail.bf1.yahoo.com) (98.139.213.136)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 07 Feb 2011 15:26:30 +0000
Received: from [98.139.212.151] by nm11.bullet.mail.bf1.yahoo.com with NNFMP; 07 Feb 2011 15:26:28 -0000
Received: from [98.139.213.14] by tm8.bullet.mail.bf1.yahoo.com with NNFMP; 07 Feb 2011 15:26:28 -0000
Received: from [127.0.0.1] by smtp114.mail.bf1.yahoo.com with NNFMP; 07 Feb 2011 15:26:28 -0000
Received: from cgf.cx (cgf@72.70.43.36 with login)        by smtp114.mail.bf1.yahoo.com with SMTP; 07 Feb 2011 07:26:27 -0800 PST
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 5127813C022	for <cygwin-patches@cygwin.com>; Mon,  7 Feb 2011 10:26:27 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 0B9A82B352; Mon,  7 Feb 2011 10:26:26 -0500 (EST)
Date: Mon, 07 Feb 2011 15:26:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Crosscompiling configure fix
Message-ID: <20110207152625.GD6611@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7630E3AFCCB3F84AB86B9B1EBF730D536ACF9B01@SERVER.foleyremote.com> <20110207115857.GC24247@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110207115857.GC24247@calimero.vinschen.de>
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
X-SW-Source: 2011-q1/txt/msg00023.txt.bz2

On Mon, Feb 07, 2011 at 12:58:57PM +0100, Corinna Vinschen wrote:
>On Feb  5 21:34, Peter Foley wrote:
>> I've submitted a fix for a problem I came across while trying to build a Linux-hosted Cygwin cross compiler. While bootstrapping Cygwin the autoconf scripts in winsup/cygwin and winsup/cygserver fail because the bootstrap compiler is missing some of the files needed to link a Cygwin executable. Because the source for some of the needed files is in the winsup directory, this creates a curricular dependency. The attached patch lets autoconf complete successfully by not running the tests that require linking if Cygwin is being crosscompiled.
>> 
>> Thanks,
>> 
>> Peter Foley
>> 
>> winsup/cygserver/ChangeLog:
>> 
>> 2011-02-5 Peter Foley <...>
>> 
>> 	* configure.in: Skip tests that require linking if cross compiling.
>> 	* configure: Regenerate.
>> 
>> winsup/cygwin/ChangeLog:
>> 
>> 2011-02-5 Peter Foley <...>
>> 
>> 	* configure.in: Skip tests that require linking if cross compiling.
>> 	* configure: Regenerate.
>
>Thanks for the patch.  Btw., you don't have to provide the generated
>files, the configure.in files are sufficient.
>
>I'm just wondering why we need this stuff at all.  I mean, is there
>really any good reason to do the AC_ALLOCA test, and why do we have
>this AC_TRY_COMPILE test for __builtin_memset?  Both results are not
>used anywhere, they are just written to config.h and then forgotten.
>
>So I take it, we could just drop this stuff.
>
>Chris?  What do you say?

I agree.  Nuke 'em.

cgf
