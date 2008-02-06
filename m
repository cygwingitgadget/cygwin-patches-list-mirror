Return-Path: <cygwin-patches-return-6245-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12451 invoked by alias); 6 Feb 2008 22:32:35 -0000
Received: (qmail 12437 invoked by uid 22791); 6 Feb 2008 22:32:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 06 Feb 2008 22:32:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id BE85F6D430E; Wed,  6 Feb 2008 23:32:14 +0100 (CET)
Date: Wed, 06 Feb 2008 22:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] fix strfuncs-related breakage of cygserver
Message-ID: <20080206223214.GY5866@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47A6888D.5CF73D29@dessent.net> <20080204121016.GA18100@calimero.vinschen.de> <20080206221039.GA25956@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080206221039.GA25956@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00019.txt.bz2

On Feb  6 23:10, Corinna Vinschen wrote:
> Hi Brian,
> 
> On Feb  4 13:10, Corinna Vinschen wrote:
> > On Feb  3 19:37, Brian Dessent wrote:
> > > Attached are two patches, one for cygwin/ and one in cygserver/.
> > 
> > Thanks, applied.
> 
> On second thought it occured to me that there's no good reason that
> cygserver shouldn't use standard C functions instead of the internal
> __small_printf stuff, given that it is linked against Cygwin anyway.
> 
> So what I did was to remove every trace of dependency to Cygwin sources,
> except for the version information.
> 
> I'd be grateful if you could have a sanitizing look.  Maybe I missed
> something.

Of course I forgot something.
I forgot to replace special small_printf format specifiers with standard
printf specifiers.  I hope that's fixed now.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
