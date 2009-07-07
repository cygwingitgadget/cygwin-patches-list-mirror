Return-Path: <cygwin-patches-return-6563-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29139 invoked by alias); 7 Jul 2009 21:32:18 -0000
Received: (qmail 29128 invoked by uid 22791); 7 Jul 2009 21:32:17 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Jul 2009 21:32:12 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 3CEBD3B0008 	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2009 17:32:02 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 383262B380; Tue,  7 Jul 2009 17:32:02 -0400 (EDT)
Date: Tue, 07 Jul 2009 21:32:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
Message-ID: <20090707213202.GA10393@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com>  <4A53BC5D.7010401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A53BC5D.7010401@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00017.txt.bz2

On Tue, Jul 07, 2009 at 10:21:33PM +0100, Dave Korn wrote:
>Brian Ford wrote:
>> I'm trying to build Cygwin 1.7 from CVS to debug an ImageMagick problem on
>> server 2008 that causes an access violation in cygwin1.dll.  Doe anyone
>> know the work around for this issue?
>> 
>> g++ (GCC) 3.4.4 (cygming special, gdc 0.12, using dmd 0.125)
>> 
>> winsup/cygwin/winbase.h: In
>> member function `int pthread_mutex::_trylock(pthread*)':
>> winsup/cygwin/winbase.h:59:
>> warning: volatile register variables don't work as you might wish
>> winsup/cygwin/winbase.h:63:
>> error: can't find a register in class `AREG' while reloading `asm'
>
>  The attached patch fixes the warning about volatile register variables, by
>explicitly specifying the type, instead of using typeof() the input parameter
>(which inherits the volatility), and which I also saw using gcc HEAD the other
>day.
>
>  It doesn't do anything about the reload failure, which is a bug in GCC-3,
>since the usage is a standard usage supported by the documentation.  It's
>possible that it may disappear as a side-effect, in which case all the better.
> (I experimented briefly with removing the register asm from the source and
>building it with gcc-4.3.2, and the results were disappointing; we actually
>got worse register allocation, resulting in some functions having larger stack
>frames and more registers saved/restored, so I guess the RA can still benefit
>from the extra hint.)
>
>  Tested by building thread.o and shared.o with CFLAGS="-g -O2 --save-temps"
>before and after and comparing the generated .s file; no differences except in
>debug info, where (naturally) a bunch of bits changed in the flag words
>encoding the datatypes of variables.
>
>winsup/cygwin/ChangeLog:
>
>	* winbase.h (ilockexch):  Avoid making 'ret' volatile.
>	(ilockcmpexch):  Likewise.
>
>  Ok?

Yes.  Thanks.

cgf
