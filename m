Return-Path: <cygwin-patches-return-6548-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30601 invoked by alias); 3 Jul 2009 13:02:07 -0000
Received: (qmail 30557 invoked by uid 22791); 3 Jul 2009 13:02:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Jul 2009 13:01:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id C02206D5598; Fri,  3 Jul 2009 15:01:34 +0200 (CEST)
Date: Fri, 03 Jul 2009 13:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mkstemps
Message-ID: <20090703130134.GB12258@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A46A3AB.2060604@byu.net> <20090628103249.GX30864@calimero.vinschen.de> <4A4DFA3E.2010909@byu.net> <4A4DFAE4.3090008@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A4DFAE4.3090008@byu.net>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00002.txt.bz2

On Jul  3 06:34, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Eric Blake on 7/3/2009 6:31 AM:
> > With that vote of confidence, here's the patch (the changes to mktemp.cc,
> > modulo a changed variable name, mirror newlib):
> > 
> > 2009-07-03  Eric Blake  <ebb9@byu.net>
> > 
> > 	Add fpurge, mkstemps.
> > 	* cygwin.din (fpurge, mkstemps): New exports.
> > 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
> > 	* mktemp.cc (_gettemp): Add parameter.
> > 	(mkstemps): New function.
> > 	(mkstemp, mkdtemp, mktemp): Adjust clients.
> 
> Updated to avoid a compiler warning.

Patch applied.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
