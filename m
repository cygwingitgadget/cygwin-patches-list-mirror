Return-Path: <cygwin-patches-return-6906-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15539 invoked by alias); 14 Jan 2010 11:47:24 -0000
Received: (qmail 15520 invoked by uid 22791); 14 Jan 2010 11:47:23 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 11:47:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D4AE46D417D; Thu, 14 Jan 2010 12:47:00 +0100 (CET)
Date: Thu, 14 Jan 2010 11:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100114114700.GC3428@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B4E96D3.90300@byu.net>
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
X-SW-Source: 2010-q1/txt/msg00022.txt.bz2

On Jan 13 21:00, Eric Blake wrote:
>   And while it looks
> like mq_open should not care about O_CLOEXEC, there may be some cleanup
> needed there.

It just occured to me that this an important hint.  Message queue
descriptors are always closed-on-exec.  Apparently I forgot to set the
close-on-exec flag on the underlying file descriptor.  That's a good
time to do that via the O_CLOEXEC flag.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
