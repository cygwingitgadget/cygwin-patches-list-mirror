Return-Path: <cygwin-patches-return-6779-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5484 invoked by alias); 18 Oct 2009 08:48:39 -0000
Received: (qmail 5474 invoked by uid 22791); 18 Oct 2009 08:48:38 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 08:48:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 43F3C6D5598; Sun, 18 Oct 2009 10:48:24 +0200 (CEST)
Date: Sun, 18 Oct 2009 08:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
Message-ID: <20091018084824.GA25560@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm> <4AD8DE16.3030506@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD8DE16.3030506@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00110.txt.bz2

On Oct 16 16:56, Charles Wilson wrote:
> Charles Wilson wrote:
> >> Why are you setting DESTDIR?  My understanding is that for DESTDIR to work
> >> reliably, you need to use $(DESTDIR), but not set it.  Then make will
> >> default it to empty, which can be changed by either 'make DESTDIR=...' or
> >> 'env DESTDIR=... make -e'.
> > 
> > Oh, ok.  I'll take those bits out -- I'm just always used to explicitly
> > setting it (empty).  I see that, if they support DESTDIR at all, both
> > automake-generated and custom Makefile.in's in src/ seem to follow your
> > rule.
> 
> Better?  Who can approve this?

The Mingw developers should approve mingw stuff, usually.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
