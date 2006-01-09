Return-Path: <cygwin-patches-return-5705-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17316 invoked by alias); 9 Jan 2006 12:37:21 -0000
Received: (qmail 17306 invoked by uid 22791); 9 Jan 2006 12:37:20 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 09 Jan 2006 12:37:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 48FF0544001; Mon,  9 Jan 2006 13:37:17 +0100 (CET)
Date: Mon, 09 Jan 2006 12:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: export getsubopt
Message-ID: <20060109123717.GA22745@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20060106T162823-127@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20060106T162823-127@post.gmane.org>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00014.txt.bz2

On Jan  6 15:29, Eric Blake wrote:
> Since POSIX requires getsubopt, and newlib provides it, here goes (and let's 
> hope this patch applies cleaner than my previous two):
> 
> 2006-01-06  Eric Blake  <ebb9@byu.net>
> 
> 	* cygwin.din: Export getsubopt.
> 	* include/cygwin/version.h: Bump API minor version.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
