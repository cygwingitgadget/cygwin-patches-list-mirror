Return-Path: <cygwin-patches-return-6854-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4033 invoked by alias); 26 Nov 2009 11:21:54 -0000
Received: (qmail 4019 invoked by uid 22791); 26 Nov 2009 11:21:54 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Nov 2009 11:21:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 90E2A6D4481; Thu, 26 Nov 2009 12:21:21 +0100 (CET)
Date: Thu, 26 Nov 2009 11:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch: sleep/nanosleep bug
Message-ID: <20091126112121.GP29173@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B045581.4040301@byu.net>  <20091118204709.GA3461@ednor.casa.cgf.cx>  <4B06A48C.5050904@byu.net>  <4B0D2CE5.4000000@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B0D2CE5.4000000@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00185.txt.bz2

On Nov 25 06:11, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Eric Blake on 11/20/2009 7:15 AM:
> >>> 	* signal.cc (nanosleep): Support 'infinite' sleep times.
> >>> 	(sleep): Avoid uninitialized memory.
> >> Sorry but, while I agree with the basic idea, this seems like
> >> unnecessary use of recursion.  It seems like you could accomplish the
> >> same thing by just putting the cancelable_wait in a for loop.  I think
> >> adding recursion here obfuscates the function unnecesarily.
> > 
> > How about the following, then?  Same changelog.
> 
> Ping.

Do you think we need it in 1.7.1?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
