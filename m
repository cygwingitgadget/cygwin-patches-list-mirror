Return-Path: <cygwin-patches-return-6131-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8150 invoked by alias); 9 Aug 2007 17:19:25 -0000
Received: (qmail 7779 invoked by uid 22791); 9 Aug 2007 17:19:23 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-70-61-242.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.70.61.242)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 09 Aug 2007 17:19:13 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 5659C2B358; Thu,  9 Aug 2007 13:19:11 -0400 (EDT)
Date: Thu, 09 Aug 2007 17:19:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handler not executed
Message-ID: <20070809171911.GA9596@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <76087731258D2545B1016BB958F00ADA123A4B@STEELPO.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76087731258D2545B1016BB958F00ADA123A4B@STEELPO.steeleye.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00006.txt.bz2

On Thu, Aug 09, 2007 at 01:09:48PM -0400, Ernie Coskrey wrote:
>There's a very small window of vulnerability in _sigbe, which can lead
>to signal handlers not being executed.  In _sigbe, the _cygtls lock is
>released before incyg is decremented.  If setup_handler acquires the
>lock just after _sigbe releases it, but before incyg is decremented,
>setup_handler will mistakenly believe that the thread is in Cygwin code,
>and will set up the interrupt using the tls stack.
> 
>_sigbe should decrement incyg before releasing the lock.

I'll apply this but are you saying that this actually fixes your problem
or that you think it fixes your problem?

Thanks for the patch.

cgf
