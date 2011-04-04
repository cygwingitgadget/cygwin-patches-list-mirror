Return-Path: <cygwin-patches-return-7259-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8565 invoked by alias); 4 Apr 2011 10:58:36 -0000
Received: (qmail 8528 invoked by uid 22791); 4 Apr 2011 10:58:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 04 Apr 2011 10:58:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C4CA02C0313; Mon,  4 Apr 2011 12:58:18 +0200 (CEST)
Date: Mon, 04 Apr 2011 10:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add information to /proc/version
Message-ID: <20110404105818.GO3669@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301875126.3104.30.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301875126.3104.30.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00025.txt.bz2

On Apr  3 18:58, Yaakov (Cygwin/X) wrote:
> On Linux, /proc/version also displays the username of the kernel
> compiler and the version of gcc used to compile[1].  This patch does the
> same for Cygwin:
> [...]
> 	* new-features.sgml (ov-new1.7.10): Document additional information
> 	in /proc/version.

Funny.  Please apply.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
