Return-Path: <cygwin-patches-return-7798-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31899 invoked by alias); 15 Feb 2013 10:23:21 -0000
Received: (qmail 31876 invoked by uid 22791); 15 Feb 2013 10:23:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 15 Feb 2013 10:23:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 551B5520354; Fri, 15 Feb 2013 11:23:01 +0100 (CET)
Date: Fri, 15 Feb 2013 10:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] lsaauth: skip 32bit DLL on 64bit target
Message-ID: <20130215102301.GA27934@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130214200956.35632ae0@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130214200956.35632ae0@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00009.txt.bz2

On Feb 14 20:09, Yaakov wrote:

> 2013-02-14  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* Makefile.in: Do not build or install 32bit DLL for 64bit target.

Please apply.


Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
