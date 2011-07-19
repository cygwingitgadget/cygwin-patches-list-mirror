Return-Path: <cygwin-patches-return-7434-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23340 invoked by alias); 19 Jul 2011 15:31:37 -0000
Received: (qmail 23329 invoked by uid 22791); 19 Jul 2011 15:31:36 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_05,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm23-vm0.bullet.mail.bf1.yahoo.com (HELO nm23-vm0.bullet.mail.bf1.yahoo.com) (98.139.212.191)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 19 Jul 2011 15:31:22 +0000
Received: from [98.139.212.151] by nm23.bullet.mail.bf1.yahoo.com with NNFMP; 19 Jul 2011 15:31:21 -0000
Received: from [98.139.213.1] by tm8.bullet.mail.bf1.yahoo.com with NNFMP; 19 Jul 2011 15:31:21 -0000
Received: from [127.0.0.1] by smtp101.mail.bf1.yahoo.com with NNFMP; 19 Jul 2011 15:31:21 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@108.20.226.5 with login)        by smtp101.mail.bf1.yahoo.com with SMTP; 19 Jul 2011 08:31:21 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 72CB113C002	for <cygwin-patches@cygwin.com>; Tue, 19 Jul 2011 11:31:20 -0400 (EDT)
Date: Tue, 19 Jul 2011 15:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add getconf(1)
Message-ID: <20110719153110.GB944@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311042021.7348.26.camel@YAAKOV04> <20110719074343.GA15263@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110719074343.GA15263@calimero.vinschen.de>
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
X-SW-Source: 2011-q3/txt/msg00010.txt.bz2

On Tue, Jul 19, 2011 at 09:43:43AM +0200, Corinna Vinschen wrote:
>On Jul 18 21:20, Yaakov (Cygwin/X) wrote:
>> This patch adds getconf(1) as required by POSIX:
>
>This looks good.  I'm just wondering... on one hand the code seems to
>have nothing Cygwin-specifc and could be packed as an external package
>like any other POSIX tool, on the other hand I can see how it belongs to
>the Cygwin utils given that getconf on Linux is part of glibc.  I'm
>inclined to stick it into utils for the latter reason.  Chris?  What's
>your stance?

I went through the same thought process and came to the same conclusion.
I think it belongs in winsup/utils.

cgf
