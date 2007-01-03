Return-Path: <cygwin-patches-return-6024-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26933 invoked by alias); 3 Jan 2007 13:36:05 -0000
Received: (qmail 26923 invoked by uid 22791); 3 Jan 2007 13:36:05 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 03 Jan 2007 13:36:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 7CFEE6D42FE; Wed,  3 Jan 2007 14:35:57 +0100 (CET)
Date: Wed, 03 Jan 2007 13:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Increase st_blksize to 64k
Message-ID: <20070103133557.GC4106@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com> <20070102184551.GA18182@trixie.casa.cgf.cx> <Pine.CYG.4.58.0701021301510.2464@PC1163-8460-XP.flightsafety.com> <20070103121620.GB4106@calimero.vinschen.de> <459BADB3.7080705@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459BADB3.7080705@byu.net>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00005.txt.bz2

On Jan  3 06:20, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Corinna Vinschen on 1/3/2007 5:16 AM:
> > 
> > Setting st_blksize to 64K might be a good idea for disk I/O if the value
> > is actually used by applications.  Do you have a specific example or a
> > test result from a Cygwin application which shows the advantage of
> > setting st_blksize to this value?  I assume there was some actual case
> > which led you to make this change ;)
> 
> Did you read the original link?
> http://sourceware.org/ml/cygwin/2006-12/msg00911.html

Urgh, sorry, no.  I missed it even twice, once when scanning the Cygwin
list to see what happened since Christmas, and once in Brian's mail
starting this thread.

So it appears to make much sense to set the blocksize to 64K.  The
only question would be whether to use getpagesize() or a hard coded
value.  It seems to me that the 64K allocation granularity and using
64K as buffer size in disk I/O coincide so I tend to agree that it
makes sort of sense to use getpagesize at this point.  What do you
think, Chris?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
