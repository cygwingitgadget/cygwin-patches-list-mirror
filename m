Return-Path: <cygwin-patches-return-7826-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2666 invoked by alias); 21 Feb 2013 11:27:43 -0000
Received: (qmail 2612 invoked by uid 22791); 21 Feb 2013 11:27:29 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 21 Feb 2013 11:27:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0FCEA52030D; Thu, 21 Feb 2013 12:27:14 +0100 (CET)
Date: Thu, 21 Feb 2013 11:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] lsaauth: skip 32bit DLL on 64bit target, part 2
Message-ID: <20130221112714.GB24054@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130220231548.700127f9@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130220231548.700127f9@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00037.txt.bz2

On Feb 20 23:15, Yaakov wrote:
> The attached patch is a follow-up to my previous lsaauth patch. FWIW,
> it worked as intended only because the toplevel Makefile provided
> target_alias; this fixes make in the subdir.
> 
> 
> Yaakov

> 2013-02-21  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* Makefile.in (target_alias): Define for previous commit.
> 	* configure.in: Skip check for i686-w64-mingw32-g++ on x86_64.

Please apply.


Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
