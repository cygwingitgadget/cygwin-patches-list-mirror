Return-Path: <cygwin-patches-return-6505-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25154 invoked by alias); 11 Apr 2009 19:17:33 -0000
Received: (qmail 25143 invoked by uid 22791); 11 Apr 2009 19:17:32 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Apr 2009 19:17:27 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 3C05413C022 	for <cygwin-patches@cygwin.com>; Sat, 11 Apr 2009 15:17:17 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 36B392B35E; Sat, 11 Apr 2009 15:17:17 -0400 (EDT)
Date: Sat, 11 Apr 2009 19:17:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090411191717.GA10686@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm> <20090407131534.GY852@calimero.vinschen.de> <49E013DC.4030509@gmail.com> <20090411080736.GA25426@calimero.vinschen.de> <20090411180023.GA3324@ednor.casa.cgf.cx> <49E0DED2.5020601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49E0DED2.5020601@gmail.com>
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
X-SW-Source: 2009-q2/txt/msg00047.txt.bz2

On Sat, Apr 11, 2009 at 07:17:54PM +0100, Dave Korn wrote:
>Christopher Faylor wrote:
>> On Sat, Apr 11, 2009 at 10:07:36AM +0200, Corinna Vinschen wrote:
>>> On Apr 11 04:51, Dave Korn wrote:
>>>> Corinna Vinschen wrote:
>>>>
>>>>> Good point, I guess.  So, if we all agree on that, I'd suggest to
>>>>> change Dave's patch to the one below.
>>>>   Two hunks went astray in the adjustment, the fixes for INTPTR_Mxx and
>>>> SIZE_MAX still apply because we didn't change their types.
>>>>
>>>>   Also, Joseph just introduced a new testcase in GCC SVN, and it shows up a
>>>> problem with our definition of WINT_MAX.
>>> What problem exactly?  UINT_MAX not defined?
>>>
>>>> 	* include/stdint.h (INTPTR_MIN, INTPTR_MAX):  Add 'L' suffix.
>>>> 	(WINT_MAX):  Add 'U' suffix.
>>> Applied.
>> 
>> These are now different than linux.  Didn't we want to make them the same?
>
>  If linux doesn't have them matching the types they define, the linux headers
>are going to need patching upstream as well.  We have
>
>typedef long intptr_t;
>
>therefore the constants must be long as well.  What does Linux have?

 From:
http://sourceware.org/cgi-bin/cvsweb.cgi/~checkout~/libc/sysdeps/generic/stdint.h?rev=1.11&cvsroot=glibc

/* Types for `void *' pointers.  */
#if __WORDSIZE == 64
# ifndef __intptr_t_defined
typedef long int		intptr_t;
#  define __intptr_t_defined
# endif
typedef unsigned long int	uintptr_t;
#else
# ifndef __intptr_t_defined
typedef int			intptr_t;
#  define __intptr_t_defined
# endif
typedef unsigned int		uintptr_t;
#endif

So the answer is "int".

cgf
