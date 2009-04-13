Return-Path: <cygwin-patches-return-6513-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26828 invoked by alias); 13 Apr 2009 20:03:21 -0000
Received: (qmail 26233 invoked by uid 22791); 13 Apr 2009 20:03:15 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 13 Apr 2009 20:03:10 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 1AAA413C023 	for <cygwin-patches@cygwin.com>; Mon, 13 Apr 2009 16:03:01 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id E9BAA2B35E; Mon, 13 Apr 2009 16:03:00 -0400 (EDT)
Date: Mon, 13 Apr 2009 20:03:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090413200300.GB7669@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm> <20090407131534.GY852@calimero.vinschen.de> <49E013DC.4030509@gmail.com> <20090411080736.GA25426@calimero.vinschen.de> <20090411180023.GA3324@ednor.casa.cgf.cx> <49E0DED2.5020601@gmail.com> <20090411191717.GA10686@ednor.casa.cgf.cx> <49E0F413.6090008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49E0F413.6090008@gmail.com>
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
X-SW-Source: 2009-q2/txt/msg00055.txt.bz2

On Sat, Apr 11, 2009 at 08:48:35PM +0100, Dave Korn wrote:
>Christopher Faylor wrote:
>
>> 
>> So the answer is "int".
>
>
>  Oh, drat.  Yes, shoulda changed the type, not the constant.  Gah.  Like
>this, you mean?
>
>
>winsup/cygwin/ChangeLog
>
>	* include/stdint.h (intptr_t):  Remove long from type.
>	(uintptr_t):  Likewise.
>	(INTPTR_MIN):  Remove 'L' suffix.
>	(INTPTR_MAX, UINTPTR_MAX):  Likewise.
>
>
>    cheers,
>      DaveK

>Index: stdint.h
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/include/stdint.h,v
>retrieving revision 1.12
>diff -p -u -r1.12 stdint.h
>--- stdint.h	11 Apr 2009 08:07:30 -0000	1.12
>+++ stdint.h	11 Apr 2009 19:35:11 -0000
>@@ -57,9 +57,9 @@ typedef unsigned long long uint_fast64_t
> 
> #ifndef __intptr_t_defined
> #define __intptr_t_defined
>-typedef long intptr_t;
>+typedef int intptr_t;
> #endif
>-typedef unsigned long uintptr_t;
>+typedef unsigned int uintptr_t;
> 
> /* Greatest-width integer types */
> 
>@@ -119,9 +119,9 @@ typedef unsigned long long uintmax_t;
> 
> /* Limits of integer types capable of holding object pointers */
> 
>-#define INTPTR_MIN (-2147483647L - 1L)
>-#define INTPTR_MAX (2147483647L)
>-#define UINTPTR_MAX (4294967295UL)
>+#define INTPTR_MIN (-2147483647 - 1)
>+#define INTPTR_MAX (2147483647)
>+#define UINTPTR_MAX (4294967295U)
> 
> /* Limits of greatest-width integer types */

I thought I responded to this but I must have imagined it.

Yes, I think this is right.

cgf
