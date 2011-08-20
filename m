Return-Path: <cygwin-patches-return-7489-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9004 invoked by alias); 20 Aug 2011 01:07:07 -0000
Received: (qmail 8992 invoked by uid 22791); 20 Aug 2011 01:07:06 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm21.bullet.mail.bf1.yahoo.com (HELO nm21.bullet.mail.bf1.yahoo.com) (98.139.212.180)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sat, 20 Aug 2011 01:06:52 +0000
Received: from [98.139.214.32] by nm21.bullet.mail.bf1.yahoo.com with NNFMP; 20 Aug 2011 01:06:51 -0000
Received: from [98.139.212.219] by tm15.bullet.mail.bf1.yahoo.com with NNFMP; 20 Aug 2011 01:06:51 -0000
Received: from [127.0.0.1] by omp1028.mail.bf1.yahoo.com with NNFMP; 20 Aug 2011 01:06:51 -0000
Received: (qmail 26334 invoked from network); 20 Aug 2011 01:06:51 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@108.49.32.9 with login)        by smtp203.mail.bf1.yahoo.com with SMTP; 19 Aug 2011 18:06:51 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 838D91D00BF	for <cygwin-patches@cygwin.com>; Fri, 19 Aug 2011 21:06:50 -0400 (EDT)
Date: Sat, 20 Aug 2011 01:07:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <paths.h> additions
Message-ID: <20110820005447.GA32668@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1313784780.2220.14.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1313784780.2220.14.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00065.txt.bz2

On Fri, Aug 19, 2011 at 03:12:58PM -0500, Yaakov (Cygwin/X) wrote:
>This patch adds _PATH_MAILDIR and _PATH_SHELLS to <paths.h>, as found on
>Linux and *BSD.  This will save me a patch to kdeadmin.
>
>
>Yaakov
>

>2011-08-19  Yaakov Selkowitz  <yselkowitz@...>
>
>	* include/paths.h (_PATH_MAILDIR): Define.
>	(_PATH_SHELLS): Define.

Looks good.  Thanks.

Please check in.

cgf
