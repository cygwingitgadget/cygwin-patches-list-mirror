Return-Path: <cygwin-patches-return-7211-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9986 invoked by alias); 28 Mar 2011 14:56:08 -0000
Received: (qmail 8357 invoked by uid 22791); 28 Mar 2011 14:55:49 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 28 Mar 2011 14:55:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 347B72C0168; Mon, 28 Mar 2011 16:55:40 +0200 (CEST)
Date: Mon, 28 Mar 2011 14:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Export strchrnul (pending newlib patch)
Message-ID: <20110328145540.GA15349@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301283496.5408.8.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301283496.5408.8.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00066.txt.bz2

On Mar 27 22:38, Yaakov (Cygwin/X) wrote:
> Here's the Cygwin patch to export strchrnul(3) once accepted in newlib.
> 
> 
> Yaakov
> 

> 2011-03-27  Yaakov Selkowitz
> 
> 	* cygwin.din (strchrnul): Export.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
> 	* posix.sgml (std-gnu): Add strchrnul.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
