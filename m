Return-Path: <cygwin-patches-return-7431-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18045 invoked by alias); 18 Jul 2011 22:59:05 -0000
Received: (qmail 18033 invoked by uid 22791); 18 Jul 2011 22:59:04 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm29.bullet.mail.sp2.yahoo.com (HELO nm29.bullet.mail.sp2.yahoo.com) (98.139.91.99)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 18 Jul 2011 22:58:24 +0000
Received: from [98.139.91.61] by nm29.bullet.mail.sp2.yahoo.com with NNFMP; 18 Jul 2011 22:58:24 -0000
Received: from [208.71.42.196] by tm1.bullet.mail.sp2.yahoo.com with NNFMP; 18 Jul 2011 22:58:24 -0000
Received: from [127.0.0.1] by smtp207.mail.gq1.yahoo.com with NNFMP; 18 Jul 2011 22:58:24 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@108.20.226.5 with login)        by smtp207.mail.gq1.yahoo.com with SMTP; 18 Jul 2011 15:58:23 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 85FE913C002	for <cygwin-patches@cygwin.com>; Mon, 18 Jul 2011 18:58:22 -0400 (EDT)
Date: Mon, 18 Jul 2011 22:59:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] update sysconf, confstr, limits
Message-ID: <20110718225812.GA24075@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311028013.7348.5.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311028013.7348.5.camel@YAAKOV04>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00007.txt.bz2

On Mon, Jul 18, 2011 at 05:26:51PM -0500, Yaakov (Cygwin/X) wrote:
>This patch adds return values for recent additions to sysconf() and
>confstr(), and adds a couple of missing <limits.h> defines required by
>POSIX.
>
>This patch, plus the one just posted to newlib@, are required for my
>next patch, a getconf(1) implementation.
>
>
>Yaakov
>Cygwin/X
>

>2011-07-18  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>
>
>	* sysconf.cc (sca): Return -1 for _SC_THREAD_ROBUST_PRIO_INHERIT,
>	_SC_THREAD_ROBUST_PRIO_PROTECT, and _SC_XOPEN_UUCP.
>	(SC_MAX): Redefine accordingly.
>	(csa): Return strings for _CS_POSIX_V7_THREADS_CFLAGS,
>	_CS_POSIX_V7_THREADS_LDFLAGS, and _CS_V7_ENV.
>	(CS_MAX): Redefine accordingly.
>	* include/limits.h (LONG_BIT): Define.
>	(WORD_BIT): Define.

Looks good.  Please check in.

Thanks.

cgf
