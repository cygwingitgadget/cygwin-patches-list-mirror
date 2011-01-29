Return-Path: <cygwin-patches-return-7157-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6129 invoked by alias); 29 Jan 2011 06:41:54 -0000
Received: (qmail 6119 invoked by uid 22791); 29 Jan 2011 06:41:52 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0	tests=AWL,BAYES_00,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm11-vm0.bullet.mail.bf1.yahoo.com (HELO nm11-vm0.bullet.mail.bf1.yahoo.com) (98.139.213.136)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sat, 29 Jan 2011 06:41:48 +0000
Received: from [98.139.212.144] by nm11.bullet.mail.bf1.yahoo.com with NNFMP; 29 Jan 2011 06:41:46 -0000
Received: from [98.139.213.14] by tm1.bullet.mail.bf1.yahoo.com with NNFMP; 29 Jan 2011 06:41:46 -0000
Received: from [127.0.0.1] by smtp114.mail.bf1.yahoo.com with NNFMP; 29 Jan 2011 06:41:46 -0000
Received: from cgf.cx (cgf@72.70.43.36 with login)        by smtp114.mail.bf1.yahoo.com with SMTP; 28 Jan 2011 22:41:45 -0800 PST
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 669AD13C0C9	for <cygwin-patches@cygwin.com>; Sat, 29 Jan 2011 01:41:45 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 16CE232D48C; Sat, 29 Jan 2011 01:41:44 -0500 (EST)
Date: Sat, 29 Jan 2011 06:41:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Crosscompiling cygserver fix
Message-ID: <20110129064144.GC18901@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <001301cbbf3e$4cfda540$e6f8efc0$@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001301cbbf3e$4cfda540$e6f8efc0$@verizon.net>
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
X-SW-Source: 2011-q1/txt/msg00012.txt.bz2

On Fri, Jan 28, 2011 at 05:54:20PM -0500, John Foley Junk Mail wrote:
>I've submitted a fix for a problem I came across while trying to build a
>Linux-hosted Cygwin cross compiler. Some of the code in winsup/cygwin relies
>on winsup/cygserver/libcygserver.a, which is currently only compiled on
>Cygwin systems. However, linking cygwin0.dll failed with a host of undefined
>reference errors because LIBSERVER was undefined since I was compiling on a
>Linux system. The attached patch causes libcygserver.a to be compiled
>regardless of the current host.
>
>winsup/ChangeLog:
>
>2011-01-28 Peter Foley <jpfoley2@verizon.net>
>
>	* configure.in: Configure winsup/cygserver regardless of cross_host.
>	* configure: Regenerate.
>
>winsup/cygwin/ChangeLog:
>
>2011-01-28 Peter Foley <jpfoley2@verizon.net>
>
>	* configure.in: Define LIBSERVER regardless of cross_host.
>	* configure: Regenerate.

Applied.  Thanks for the patch.

cgf
