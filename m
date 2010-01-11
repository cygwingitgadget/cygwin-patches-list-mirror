Return-Path: <cygwin-patches-return-6899-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11666 invoked by alias); 11 Jan 2010 15:11:50 -0000
Received: (qmail 11643 invoked by uid 22791); 11 Jan 2010 15:11:48 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 11 Jan 2010 15:11:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 084C96D417D; Mon, 11 Jan 2010 16:11:32 +0100 (CET)
Date: Mon, 11 Jan 2010 15:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix misc aliasing warnings.
Message-ID: <20100111151132.GA25888@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B486906.4000600@gmail.com>  <20100109133348.GO23992@calimero.vinschen.de>  <4B48DD4E.1080701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B48DD4E.1080701@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00015.txt.bz2

On Jan  9 19:47, Dave Korn wrote:
> Corinna Vinschen wrote:
> > Shouldn't defining szBuffer as a union pointer avoid the need to memcpy?
> > Like this:
> 
>   Well yeh, but it's a far bigger change, which was why I didn't.  Don't mind
> giving it a test though.

I've checked in a new version of this.  That shouldn't give any warning
with 4.5, hopefully.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
