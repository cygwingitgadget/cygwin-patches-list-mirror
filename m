Return-Path: <cygwin-patches-return-7421-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23869 invoked by alias); 6 Jun 2011 15:51:44 -0000
Received: (qmail 23817 invoked by uid 22791); 6 Jun 2011 15:51:43 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm19-vm0.bullet.mail.bf1.yahoo.com (HELO nm19-vm0.bullet.mail.bf1.yahoo.com) (98.139.213.162)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 06 Jun 2011 15:51:27 +0000
Received: from [98.139.212.144] by nm19.bullet.mail.bf1.yahoo.com with NNFMP; 06 Jun 2011 15:51:27 -0000
Received: from [98.139.213.4] by tm1.bullet.mail.bf1.yahoo.com with NNFMP; 06 Jun 2011 15:51:26 -0000
Received: from [127.0.0.1] by smtp104.mail.bf1.yahoo.com with NNFMP; 06 Jun 2011 15:51:26 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp104.mail.bf1.yahoo.com with SMTP; 06 Jun 2011 08:51:26 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id C768242804C	for <cygwin-patches@cygwin.com>; Mon,  6 Jun 2011 11:51:25 -0400 (EDT)
Date: Mon, 06 Jun 2011 15:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: do some adjustment
Message-ID: <20110606155123.GA3956@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BANLkTimrHKK8YrrQ9sFGa5qgt1i6hAQMqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTimrHKK8YrrQ9sFGa5qgt1i6hAQMqA@mail.gmail.com>
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
X-SW-Source: 2011-q2/txt/msg00187.txt.bz2

On Mon, Jun 06, 2011 at 06:27:25PM +0800, Chiheng Xu wrote:
>	* dcrt0.cc (dll_crt0_1): remove call to fork_init().
>	* fork.cc (fork_init): remove.
>	* globals.cc (fork_init): add user_data global variable.
>	* perprocess.h (fork_init): change user_data from macro to variable
>declaration.
>	* pinfo.cc (fork_init): adjust.

Sorry.  This patch makes no sense.  It will not be applied.

cgf
