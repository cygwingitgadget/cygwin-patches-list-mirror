Return-Path: <cygwin-patches-return-7304-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24231 invoked by alias); 5 May 2011 06:47:12 -0000
Received: (qmail 24095 invoked by uid 22791); 5 May 2011 06:46:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 05 May 2011 06:46:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0E5E42C0578; Thu,  5 May 2011 08:46:19 +0200 (CEST)
Date: Thu, 05 May 2011 06:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] False positive from access("/proc/registry/...", F_OK)
Message-ID: <20110505064618.GA17806@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DC1B292.70201@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DC1B292.70201@t-online.de>
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
X-SW-Source: 2011-q2/txt/msg00070.txt.bz2

On May  4 22:09, Christian Franke wrote:
> 	* fhandler_registry.cc (fhandler_registry::exists): Fix regression
> 	in EACCES handling.
> 	(fhandler_registry::open): Fix "%val" case.

Applied with the EACCESS typo noted by Eric fixed.


Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
