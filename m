Return-Path: <cygwin-patches-return-7286-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12508 invoked by alias); 2 May 2011 16:09:17 -0000
Received: (qmail 12410 invoked by uid 22791); 2 May 2011 16:08:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 02 May 2011 16:08:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BF10A2C0578; Mon,  2 May 2011 18:08:35 +0200 (CEST)
Date: Mon, 02 May 2011 16:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define _SC_SPIN_LOCKS
Message-ID: <20110502160835.GA22745@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1304352457.6972.16.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1304352457.6972.16.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00052.txt.bz2

On May  2 11:07, Yaakov (Cygwin/X) wrote:
> Corresponding patch to newlib just committed; this is the patch for
> winsup/cygwin/sysconf.cc.
> 
> 
> Yaakov
> 

> 2011-05-02  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* sysconf.cc (sca): Set _SC_SPIN_LOCKS to _POSIX_SPIN_LOCKS.

Thanks.  Go ahead.


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
