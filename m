Return-Path: <cygwin-patches-return-6953-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21368 invoked by alias); 11 Feb 2010 10:06:02 -0000
Received: (qmail 21357 invoked by uid 22791); 11 Feb 2010 10:06:01 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 11 Feb 2010 10:05:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3688D6D42ED; Thu, 11 Feb 2010 11:05:47 +0100 (CET)
Date: Thu, 11 Feb 2010 10:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] internal_setlocale tweak
Message-ID: <20100211100547.GK28659@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <416096c61002101317x6ee2698epaa4ba260af39dcba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416096c61002101317x6ee2698epaa4ba260af39dcba@mail.gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00069.txt.bz2

On Feb 10 21:17, Andy Koppe wrote:
> winsup/cygwin/ChangeLog:
> 	* nlsfuncs.cc (internal_setlocale, initial_setlocale):
> 	Move check whether charset has changed to internal_setlocale,
> 	to avoid unnecessary work when invoked via CW_INT_SETLOCALE.
> 
> Sufficiently trivial, I hope.

Yes.  Thanks, applied.  It would still be cool if you could give
yourself a kick and sign the copyright assignment.


Thanks again,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
