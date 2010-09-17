Return-Path: <cygwin-patches-return-7109-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12211 invoked by alias); 17 Sep 2010 07:04:07 -0000
Received: (qmail 12154 invoked by uid 22791); 17 Sep 2010 07:03:55 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 17 Sep 2010 07:03:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0E3896D4194; Fri, 17 Sep 2010 09:03:49 +0200 (CEST)
Date: Fri, 17 Sep 2010 07:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [Fwd: Fw: res_send() doesn't work with osquery enabled]
Message-ID: <20100917070349.GG15121@calimero.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20100826175510.GN6726@calimero.vinschen.de>
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
X-SW-Source: 2010-q3/txt/msg00069.txt.bz2

----- Forwarded message from "Pierre A. Humblet" -----

> Date: Thu, 16 Sep 2010 12:43:33 -0400
> From: "Pierre A. Humblet" 
> Subject: Fw: res_send() doesn't work with osquery enabled
> To: Corinna Vinschen <corinna@vinschen.de>
> 
> Corinna,
> 
> this has not made it to the list so far, not sure why.
> 
> I am leaving on a trip and don't have time to investigate,
> so sending it straight to you.
> 
> Pierre
> ****************************************************
> ----- Original Message ----- 
> From: "Pierre A. Humblet"
> To: cygwin-patches
> Sent: Thursday, September 16, 2010 9:52
> Subject: Re: res_send() doesn't work with osquery enabled
> 
> 
> | ----- Original Message ----- 
> | From: "Corinna Vinschen"
> | To: cygwin-patches
> | Sent: Friday, September 10, 2010 5:22
> | 
> | 
> || Pierre?  Ping?
> || 
> | 
> | Corinna,
> | 
> | Sorry, an earlier answer was rejected due to inappropriate subject.
> | 
> | After thinking about it, I don't like mixing calls to the Windows resolver 
> | for res_query and contacting DNS servers directly with res_send,
> | as proposed. So I have a patch where res_send also uses the Windows
> | resolver. 
> | 
> | Unfortunately although I can build cygwin1.dll fine, it's broken,
> | something to do with a NULL stdout (this is from /bin/date)
> |   1 thread 2588.0x4c0  fputc (ch=10, file=0x0)
> |     at ../../../../../src/newlib/libc/stdio/fputc.c:101
> | 
> | Not sure what to do, I already did make clean for cygwin.
> | 
> | Also minires used to come with a README explaining the effect of
> | an optional /etc/resolv.conf  (e.g. to bypass the Windows resolver).
> | That information is not present currently [ and nobody asks for it :) ]
> | I wonder if we should add it and where to place it. One option is the 
> | User's Guide. Another option is a custom resolv.conf man page. 
> | What do you think?
> | 
> | Pierre

----- End forwarded message -----
