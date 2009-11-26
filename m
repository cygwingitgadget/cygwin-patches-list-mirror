Return-Path: <cygwin-patches-return-6853-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3626 invoked by alias); 26 Nov 2009 11:21:04 -0000
Received: (qmail 3614 invoked by uid 22791); 26 Nov 2009 11:21:03 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Nov 2009 11:20:53 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6F4C66D4481; Thu, 26 Nov 2009 12:20:42 +0100 (CET)
Date: Thu, 26 Nov 2009 11:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] override-able installation_root
Message-ID: <20091126112042.GO29173@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B0D3920.3020907@shaddybaddah.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B0D3920.3020907@shaddybaddah.name>
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
X-SW-Source: 2009-q4/txt/msg00184.txt.bz2

On Nov 26 01:03, Shaddy Baddah wrote:
> Hi,
> 
> Please find attached a patch to allow for override-able
> installation_root. I actually wrote this patch for release 1.7.0-52
> motivated by the thread I started " [1.7] Alternative root
> directory. Sort of a regression."
> [http://cygwin.com/ml/cygwin/2009-07/msg00904.html]. I have forward
> ported it.

Sorry, but no.  We won't accept this patch.  We have deliberately chosen
to get away from the dependency to the Windows registry, and we really
don't want to add it back again.

Btw., for a non-trivial patch like this you need to file a copyright
assignment.  See http://cygwin.com/contrib.html, the "Before you get
started" section.

> To be honest, I don't totally understand why it was necessary, even
> though I am aware of the difference between const positioning.

That's worth a fix, afaics.  But it doesn't matter for now, so this
will have to wait until after the 1.7.1 release.

> Perhaps this needs a second look at? By the way, this problem
> pricked my curiosity leading me to ask about "regtool/registry
> interfacing and charset support"
> [http://cygwin.com/ml/cygwin/2009-07/msg00930.html].

That's on my TODO list and PTC.  It will have to wait until after 1.7.1
as well, though.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
