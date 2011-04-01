Return-Path: <cygwin-patches-return-7238-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5162 invoked by alias); 1 Apr 2011 15:34:22 -0000
Received: (qmail 5048 invoked by uid 22791); 1 Apr 2011 15:34:21 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm14-vm0.bullet.mail.ne1.yahoo.com (HELO nm14-vm0.bullet.mail.ne1.yahoo.com) (98.138.91.52)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 01 Apr 2011 15:34:15 +0000
Received: from [98.138.90.50] by nm14.bullet.mail.ne1.yahoo.com with NNFMP; 01 Apr 2011 15:34:14 -0000
Received: from [98.138.84.44] by tm3.bullet.mail.ne1.yahoo.com with NNFMP; 01 Apr 2011 15:34:14 -0000
Received: from [127.0.0.1] by smtp112.mail.ne1.yahoo.com with NNFMP; 01 Apr 2011 15:34:14 -0000
Received: from cgf.cx (cgf@72.70.43.165 with login)        by smtp112.mail.ne1.yahoo.com with SMTP; 01 Apr 2011 08:34:14 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 7EB7B428013	for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2011 11:34:13 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 6E7BE2B35F; Fri,  1 Apr 2011 11:34:13 -0400 (EDT)
Date: Fri, 01 Apr 2011 15:34:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] implement /proc/sysvipc/*
Message-ID: <20110401153413.GB6604@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301650256.3108.4.camel@YAAKOV04> <20110401100556.GB24008@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110401100556.GB24008@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00004.txt.bz2

On Fri, Apr 01, 2011 at 12:05:56PM +0200, Corinna Vinschen wrote:
>Chris, do you think there's anything speaking against rearranging this
>so that the FH_FS and FH_NETDRIVE definitions are separate from the
>stuff under /proc?  Or, hang on, we should change all PROC values,
>along these lines:
>
>  FH_FS      = FHDEV (0, 247),  /* filesystem based device */
>  FH_NETDRIVE= FHDEV (0, 246),
>  FH_DEV     = FHDEV (0, 245),
>
>  FH_PROC    = FHDEV (0, 244),
>  FH_REGISTRY= FHDEV (0, 243),
>  FH_PROCESS = FHDEV (0, 242),
>  FH_PROCNET = FHDEV (0, 241),
>  FH_PROCESSFD = FHDEV (0, 240),
>  FH_PROCSYS = FHDEV (0, 239),
>  FH_PROCSYSVIPC = FHDEV (0, 238),
>
>  FH_PROC_MIN_MINOR = FHDEV (0, 200),	/* Arbitrary value */
>
>Then we can simplify the isproc_dev definition like this:
>
>#define isproc_dev(devn) \
>	(devn >= FH_PROC_MIN_MINOR && devn <= FH_PROC)
>
>Does that sound ok?

Yes.  I was, for a while, trying to keep the device numbers the same as
Linux but I don't think that even applies in this case.

cgf
