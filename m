Return-Path: <cygwin-patches-return-7662-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19087 invoked by alias); 10 May 2012 08:37:42 -0000
Received: (qmail 16236 invoked by uid 22791); 10 May 2012 08:37:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 10 May 2012 08:37:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BB2C62C18ED; Thu, 10 May 2012 10:36:59 +0200 (CEST)
Date: Thu, 10 May 2012 08:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Export memrchr
Message-ID: <20120510083659.GA13090@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1336551515.8880.4.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1336551515.8880.4.camel@YAAKOV04>
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
X-SW-Source: 2012-q2/txt/msg00031.txt.bz2

On May  9 03:18, Yaakov (Cygwin/X) wrote:
> Here are the patches for exporting memrchr, once my patches to newlib
> are accepted.
> 
> 
> Yaakov
> 

> 2012-05-09  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* cygwin.din (memrchr): Export.
> 	* posix.sgml (std-gnu): Add memrchr.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

> 2012-05-09  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* new-features.sgml (ov-new1.7.15): Document memrchr.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
