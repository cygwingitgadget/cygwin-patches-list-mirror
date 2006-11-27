Return-Path: <cygwin-patches-return-6004-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14526 invoked by alias); 27 Nov 2006 15:35:28 -0000
Received: (qmail 14508 invoked by uid 22791); 27 Nov 2006 15:35:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 27 Nov 2006 15:35:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 9E9E8544001; Mon, 27 Nov 2006 16:35:19 +0100 (CET)
Date: Mon, 27 Nov 2006 15:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC][patch] cygwin/singal.h is not compatible with -std=c89 or -std=c99
Message-ID: <20061127153519.GF8385@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4568655E.6030403@sh.cvut.cz> <20061127083341.GB8385@calimero.vinschen.de> <20061127151759.GA30938@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127151759.GA30938@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00022.txt.bz2

On Nov 27 10:17, Christopher Faylor wrote:
> How about the alternative "Don't do that" approach?  I think there are
> other parts of the header files which won't work with -std=c89.  I've
> always been coding with the understanding that this is a GNU C environment.

Well, BSD and Linux are using the more portable approach.  Why should
Cygwin stand back?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
