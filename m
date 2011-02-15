Return-Path: <cygwin-patches-return-7199-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8480 invoked by alias); 15 Feb 2011 16:10:04 -0000
Received: (qmail 8009 invoked by uid 22791); 15 Feb 2011 16:09:50 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 15 Feb 2011 16:09:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0412C2CAB63; Tue, 15 Feb 2011 17:09:44 +0100 (CET)
Date: Tue, 15 Feb 2011 16:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: FW: [PATCH] Crosscompiling configure fix
Message-ID: <20110215160943.GE29654@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7630E3AFCCB3F84AB86B9B1EBF730D536AD09289@SERVER.foleyremote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7630E3AFCCB3F84AB86B9B1EBF730D536AD09289@SERVER.foleyremote.com>
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
X-SW-Source: 2011-q1/txt/msg00054.txt.bz2

On Feb 11 21:37, Peter Foley wrote:
> I've submitted a fix for a problem I came across while trying to build a Linux-hosted Cygwin cross compiler. Autoconf fails in the cygwin and cygserver directories because the bootstrap compiler cannot link. This patch works around this by defining GCC_NO_EXECUTABLES, which causes autoconf to skip tests that involve linking.
> 
> Note: I submitted a previous patch that included this change, however only part of that patch was applied (the removal of AC_ALLOCA) so I am resubmitting the GCC_NO_EXECUTABLES part of the patch.

Why is that necessary?  There are no tests left which try to build
executables.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
