Return-Path: <cygwin-patches-return-7240-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8408 invoked by alias); 1 Apr 2011 19:57:56 -0000
Received: (qmail 8393 invoked by uid 22791); 1 Apr 2011 19:57:55 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gy0-f171.google.com (HELO mail-gy0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 01 Apr 2011 19:57:49 +0000
Received: by gye5 with SMTP id 5so1897670gye.2        for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2011 12:57:48 -0700 (PDT)
Received: by 10.151.13.11 with SMTP id q11mr184172ybi.272.1301687868755;        Fri, 01 Apr 2011 12:57:48 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id x29sm1252520yhc.11.2011.04.01.12.57.46        (version=SSLv3 cipher=OTHER);        Fri, 01 Apr 2011 12:57:47 -0700 (PDT)
Subject: Re: [PATCH] implement /proc/sysvipc/*
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110401100556.GB24008@calimero.vinschen.de>
References: <1301650256.3108.4.camel@YAAKOV04>	 <20110401100556.GB24008@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Apr 2011 19:57:00 -0000
Message-ID: <1301687867.184.10.camel@YAAKOV04>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00006.txt.bz2

On Fri, 2011-04-01 at 12:05 +0200, Corinna Vinschen wrote:
> The definition of isproc_dev starts to get on my nerves.  We have to
> check for six distinct values now.  I think we should really change
> the definition.  Here's what we have in devices.h right now:
> 
>   FH_PROC    = FHDEV (0, 250),
>   FH_REGISTRY= FHDEV (0, 249),
>   FH_PROCESS = FHDEV (0, 248),
> 
>   FH_FS      = FHDEV (0, 247),  /* filesystem based device */
>     
>   FH_NETDRIVE= FHDEV (0, 246),
>   FH_DEV     = FHDEV (0, 245),
>   FH_PROCNET = FHDEV (0, 244),
>   FH_PROCESSFD = FHDEV (0, 243),
>   FH_PROCSYS = FHDEV (0, 242),
>   FH_PROCSYSVIPC = FHDEV (0, 241),
> 
> Chris, do you think there's anything speaking against rearranging this
> so that the FH_FS and FH_NETDRIVE definitions are separate from the
> stuff under /proc?  Or, hang on, we should change all PROC values,
> along these lines:
> 
>   FH_FS      = FHDEV (0, 247),  /* filesystem based device */
>   FH_NETDRIVE= FHDEV (0, 246),
>   FH_DEV     = FHDEV (0, 245),
> 
>   FH_PROC    = FHDEV (0, 244),
>   FH_REGISTRY= FHDEV (0, 243),
>   FH_PROCESS = FHDEV (0, 242),
>   FH_PROCNET = FHDEV (0, 241),
>   FH_PROCESSFD = FHDEV (0, 240),
>   FH_PROCSYS = FHDEV (0, 239),
>   FH_PROCSYSVIPC = FHDEV (0, 238),
> 
>   FH_PROC_MIN_MINOR = FHDEV (0, 200),	/* Arbitrary value */
> 
> Then we can simplify the isproc_dev definition like this:
> 
> #define isproc_dev(devn) \
> 	(devn >= FH_PROC_MIN_MINOR && devn <= FH_PROC)
> 
> Does that sound ok?

That would mean that the /proc directories range would be right in the
middle of the major-device-0 range, with non-/proc stuff before and
after.  For the sake of clarity, I would reorder it a bit further to
make FH_PROC and friends to one side of major-0 and everything else to
the other side:

  /* begin /proc directories */
  FH_PROC    = FHDEV (0, 255),
  FH_REGISTRY= FHDEV (0, 254),
  FH_PROCNET = FHDEV (0, 253),
  FH_PROCESSFD = FHDEV (0, 252),
  FH_PROCSYS = FHDEV (0, 251),
  FH_PROCSYSVIPC = FHDEV (0,250),

  FH_PROC_MIN_MINOR = FHDEV (0,200),
  /* end /proc directories */

  FH_PIPE    = FHDEV (0, 199),
  FH_PIPER   = FHDEV (0, 198),
  FH_PIPEW   = FHDEV (0, 197),
  FH_FIFO    = FHDEV (0, 196),
  FH_PROCESS = FHDEV (0, 195),
  FH_FS      = FHDEV (0, 194),	/* filesystem based device */
  FH_NETDRIVE= FHDEV (0, 193),
  FH_DEV     = FHDEV (0, 192),

As either way this should be a separate changeset IMHO, I have committed
my patch as is and will follow this up on Sunday.


Yaakov

