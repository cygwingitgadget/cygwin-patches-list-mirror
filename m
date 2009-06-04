Return-Path: <cygwin-patches-return-6538-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21638 invoked by alias); 4 Jun 2009 03:08:42 -0000
Received: (qmail 21628 invoked by uid 22791); 4 Jun 2009 03:08:42 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Jun 2009 03:08:36 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 5B2CF13C0C3 	for <cygwin-patches@cygwin.com>; Wed,  3 Jun 2009 23:08:26 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 13082849C6; Wed,  3 Jun 2009 23:08:25 -0400 (EDT)
Date: Thu, 04 Jun 2009 03:08:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 3
Message-ID: <20090604030825.GA27249@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A270656.8090704@gmail.com> <4A270BA4.3080602@gmail.com> <20090604014145.GB15999@ednor.casa.cgf.cx> <4A273967.6090703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A273967.6090703@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00080.txt.bz2

On Thu, Jun 04, 2009 at 04:03:03AM +0100, Dave Korn wrote:
>but it's a horrible bit of code.  Declaring the memory location as input only,
>then clobbering all of memory and potentially confusing the optimisers with
>type aliasing casts?  It makes me very uneasy.

Ok.  I'm convinced.  Please check in whatever you think is best.

cgf
