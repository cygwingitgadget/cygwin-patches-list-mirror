Return-Path: <cygwin-patches-return-5885-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18163 invoked by alias); 12 Jun 2006 14:01:25 -0000
Received: (qmail 18053 invoked by uid 22791); 12 Jun 2006 14:01:23 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 12 Jun 2006 14:00:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 5D16D544008; Mon, 12 Jun 2006 16:00:23 +0200 (CEST)
Date: Mon, 12 Jun 2006 14:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Addition to the testsuite & cygwin patch
Message-ID: <20060612140023.GD2129@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00ab01c673b5$969108c0$280010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ab01c673b5$969108c0$280010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00073.txt.bz2

On May  9 18:11, Pierre A. Humblet wrote:
> The main purpose of this patch is to contribute the attached file to
> testsuite/winsup.api. It checks that Cygwin can support a user
> supplied version of malloc.
> However the patch below is required to make it work and to
> support versions of malloc that don't call sbrk.
> 
> Pierre
> 
> 2006-05-09  Pierre Humblet  Pierre.Humblet@ieee.org
> 
>    * winsup.api/malloc.c: New file
> 
> 2006-05-09  Pierre Humblet  Pierre.Humblet@ieee.org
> 
> * heap.cc (heap_init): Only commit if allocsize is not zero.

I applied this change.  I just renamed malloc.c to user_malloc.c to
have a slightly more self-describing file name.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
