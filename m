Return-Path: <cygwin-patches-return-6565-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6525 invoked by alias); 7 Jul 2009 21:43:55 -0000
Received: (qmail 6513 invoked by uid 22791); 7 Jul 2009 21:43:55 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Jul 2009 21:43:43 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id BC05B3B0008 	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2009 17:43:31 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id B6B682B380; Tue,  7 Jul 2009 17:43:31 -0400 (EDT)
Date: Tue, 07 Jul 2009 21:43:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
Message-ID: <20090707214331.GA10497@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com>  <4A53BC5D.7010401@gmail.com>  <20090707213202.GA10393@ednor.casa.cgf.cx>  <4A53C441.5090708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A53C441.5090708@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00019.txt.bz2

On Tue, Jul 07, 2009 at 10:55:13PM +0100, Dave Korn wrote:
>Christopher Faylor wrote:
>> On Tue, Jul 07, 2009 at 10:21:33PM +0100, Dave Korn wrote:
>
>>> winsup/cygwin/ChangeLog:
>>>
>>> 	* winbase.h (ilockexch):  Avoid making 'ret' volatile.
>>> 	(ilockcmpexch):  Likewise.
>>>
>>>  Ok?
>> 
>> Yes.  Thanks.
>
>  Applied, and I even caught the changelog formatting in time!

I think I may have to turn in my Anal Whitespace Enforcer badge.

cgf
