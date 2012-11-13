Return-Path: <cygwin-patches-return-7780-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11652 invoked by alias); 13 Nov 2012 21:07:46 -0000
Received: (qmail 11636 invoked by uid 22791); 13 Nov 2012 21:07:45 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Nov 2012 21:07:41 +0000
Received: from pool-98-110-183-145.bstnma.fios.verizon.net ([98.110.183.145] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TYNhs-000GFB-Ty	for cygwin-patches@cygwin.com; Tue, 13 Nov 2012 21:07:40 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id DE6BB13C0C7	for <cygwin-patches@cygwin.com>; Tue, 13 Nov 2012 16:07:39 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+CeyRsBN3Yq1v0InnKyBy5
Date: Tue, 13 Nov 2012 21:07:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121113210739.GA22535@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx> <20121112215023.GA1436@calimero.vinschen.de> <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx> <20121113093301.GA23491@calimero.vinschen.de> <20121113173900.GA13846@ednor.casa.cgf.cx> <20121113183414.GA12388@ednor.casa.cgf.cx> <20121113184732.GB27964@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121113184732.GB27964@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00057.txt.bz2

On Tue, Nov 13, 2012 at 07:47:32PM +0100, Corinna Vinschen wrote:
>On Nov 13 13:34, Christopher Faylor wrote:
>> On Tue, Nov 13, 2012 at 12:39:00PM -0500, Christopher Faylor wrote:
>> >Maybe I can use -isystem with ccwraper.  I'd previously gotten things
>> >working without the wrapper, using idirafter so that's what I stuck
>> >with.  However, the wrapper may now allow just always including the
>> >windows headers last.
>> 
>> Yep.  Adding the windows headers directories dead last as -isystem means
>> that none of my header file changes are needed, *except* for the #define
>> _WIN32.  I wonder why you don't need those.  My (i.e., Yaakov's) cross
>> compiler doesn't define _WIN32.
>> 
>> % /cygwin/bin/i686-cygwin-gcc --version
>> i686-cygwin-gcc (GCC) 4.5.3 20110428 (Fedora Cygwin 4.5.3-4)
>> Copyright (C) 2010 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> 
>> % /cygwin/bin/i686-cygwin-gcc -dD -E -xc /dev/null | grep WIN
>> #define __WINT_TYPE__ unsigned int
>> #define __WINT_MAX__ 4294967295U
>> #define __WINT_MIN__ 0U
>> #define __SIZEOF_WINT_T__ 4
>> #define __CYGWIN32__ 1
>> #define __CYGWIN__ 1
>> 
>> So, except for that, mystery solved.
>> 
>> My new, smaller diff is attached.  Unless you have objections, I'll be
>> checking this in.
>
>I have no objections against the patch in general, but I'd rather like to
>test it first.  I'd like to try to figure out what the _WIN32 problem is
>first, and I'd like to give it a try in the 64 bit scenario.

Ok, I'm thoroughly confused.  I made another few unrelated changes to the
wrapper script and now I don't need the _WIN32 setting either.

cgf
