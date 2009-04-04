Return-Path: <cygwin-patches-return-6474-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28389 invoked by alias); 4 Apr 2009 06:27:35 -0000
Received: (qmail 28379 invoked by uid 22791); 4 Apr 2009 06:27:35 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 06:27:31 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 267A113C022 	for <cygwin-patches@cygwin.com>; Sat,  4 Apr 2009 02:27:21 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 03E8F8F618; Sat,  4 Apr 2009 02:27:21 -0400 (EDT)
Date: Sat, 04 Apr 2009 06:27:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090404062720.GC22452@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090404062459.GB22452@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00016.txt.bz2

On Sat, Apr 04, 2009 at 02:24:59AM -0400, Christopher Faylor wrote:
>On Sat, Apr 04, 2009 at 05:11:09AM +0100, Dave Korn wrote:
>>Christopher Faylor wrote:
>>
>>>>  The attached patch fixes all these by adjusting only the suffix letters.  OK
>>>> for head?
>>>>
>>>> winsup/cygwin/ChangeLog
>>>>
>>>> 	* include/stdint.h (UINT32_MAX, INT_LEAST32_MIN, INT_LEAST32_MAX,
>>>> 	INT_FAST16_MIN, INT_FAST32_MIN, INT_FAST16_MAX, INT_FAST32_MAX,
>>>> 	INTPTR_MIN, INTPTR_MAX, SIZE_MAX):  Fix integer constant suffixes.
>>> 
>>>Many of the changes introduce divergence from Linux.  Why is that?
>>
>>Because our stdint.h types are divergent from Linux, and changing them
>>instead could cause yet another ABI break.
>
>Why would changing uint32_t from 'unsigned long' to 'unsigned int' break
>anything?  It looks to me like that is a disaster waiting to happen if
>we ever provide a 64-bit port.

The disaster I'm referring to, in case it isn't clear, is keeping the
current typedef.

cgf
