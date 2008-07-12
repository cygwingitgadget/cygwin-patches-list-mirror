Return-Path: <cygwin-patches-return-6338-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11824 invoked by alias); 12 Jul 2008 15:35:02 -0000
Received: (qmail 11804 invoked by uid 22791); 12 Jul 2008 15:35:01 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sat, 12 Jul 2008 15:34:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 31B4C6D4354; Sat, 12 Jul 2008 17:35:19 +0200 (CEST)
Date: Sat, 12 Jul 2008 15:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: use volatile when replacing Interlocked*
Message-ID: <20080712153519.GA13069@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4878A2C3.6060908@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4878A2C3.6060908@byu.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00001.txt.bz2

On Jul 12 06:25, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Based on a recent patch to the win32 headers
> (http://cygwin.com/ml/cygwin-cvs/2008-q2/msg00157.html), the Interlocked*
> functions in winbase.h are now properly prototyped to take volatile
> arguments.  This patch makes cygwin match.
>
> 2008-07-12  Eric Blake  <ebb9@byu.net>
>
> 	Fix usage of recently fixed Interlocked* functions.
> 	* winbase.h (ilockincr, ilockdecr, ilockexch, ilockcmpexch): Add
> 	volatile qualifier, to match Interlocked* functions.

You missed to attach the patch, apparantly :)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
