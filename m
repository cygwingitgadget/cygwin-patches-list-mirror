Return-Path: <cygwin-patches-return-6492-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18579 invoked by alias); 7 Apr 2009 14:53:39 -0000
Received: (qmail 18474 invoked by uid 22791); 7 Apr 2009 14:53:38 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 14:53:34 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 1EDA413C022 	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2009 10:53:24 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 196E92C4022; Tue,  7 Apr 2009 10:53:24 -0400 (EDT)
Date: Tue, 07 Apr 2009 14:53:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090407145324.GB22338@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DB4D95.7000903@byu.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00034.txt.bz2

On Tue, Apr 07, 2009 at 06:56:53AM -0600, Eric Blake wrote:
>According to Christopher Faylor on 4/4/2009 12:24 AM:
>>> Because our stdint.h types are divergent from Linux, and changing them
>>> instead could cause yet another ABI break.
>> 
>>Why would changing uint32_t from 'unsigned long' to 'unsigned int'
>>break anything?  It looks to me like that is a disaster waiting to
>>happen if we ever provide a 64-bit port.
>
>If we ever provide a 64-bit port, then we are free to use #ifdef magic
>to select a different underlying type on 64-bit compiles than on 32-bit
>compiles.  In one sense, using a different type between the two builds
>will flush out coding bugs where the wrong type specifiers are used
>(for example, printf("%ld", (int32_t)val) should have been written
>printf("%"PRI32d, (int32_t)val).

Yes, of course, you could #ifdef these things.  If flushing out coding
bugs was a core requirement for Cygwin that would be an interesting
thing to do.  However our goal it really is quite the contrary.

We're suposed to make things easy to move between systems, warts and
all.  The goal is not to provide us with the opportunity to wag our
finger at hapless users in the Cygwin mailing who barely understand how
to run configure and make but nevertheless have a program that compiles
on linux and breaks on cygwin.  We're supposed to make things easier.

If people want to sanity check their code, they can buy a Plum Hall
or something.

cgf
