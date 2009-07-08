Return-Path: <cygwin-patches-return-6568-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1436 invoked by alias); 8 Jul 2009 16:24:28 -0000
Received: (qmail 1423 invoked by uid 22791); 8 Jul 2009 16:24:27 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f213.google.com (HELO mail-ew0-f213.google.com) (209.85.219.213)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 08 Jul 2009 16:24:17 +0000
Received: by ewy9 with SMTP id 9so6335334ewy.2         for <cygwin-patches@cygwin.com>; Wed, 08 Jul 2009 09:24:14 -0700 (PDT)
Received: by 10.211.180.19 with SMTP id h19mr9000916ebp.22.1247070254154;         Wed, 08 Jul 2009 09:24:14 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 10sm352669eyz.41.2009.07.08.09.24.11         (version=SSLv3 cipher=RC4-MD5);         Wed, 08 Jul 2009 09:24:11 -0700 (PDT)
Message-ID: <4A54CB28.1090703@gmail.com>
Date: Wed, 08 Jul 2009 16:24:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com> <4A53BC5D.7010401@gmail.com> <4A53E449.4020504@gmail.com> <20090708090638.GY12258@calimero.vinschen.de>
In-Reply-To: <20090708090638.GY12258@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00022.txt.bz2

Corinna Vinschen wrote:
> On Jul  8 01:11, Dave Korn wrote:

> But seriously, I'm still using gcc 4.3.2 20080827 (alpha-testing) 1
> for building Cygwin.  Is that sufficient for now or should I upgrade?

  That's 4.3.2-1, no?  I've been using nothing but 4.3.2-2 for a while now.
The problems are known, and none of them affect the Cygwin DLL:

- redirected gfortran IO when using libgfortran DLL
- shared lib java completely borked
- libstdc++ dll operators new/delete not replaceable.

  I'll have 4.3.3-1 out shortly.  Java will revert to static linking only, for
the moment, but I know what the problem is and how to fix it.  Libstdc++ is
taken care of.  The fortran IO problem I have debugged and solved, but it
needs to be fixed in the cygwin DLL - it's an order-of-termination problem,
that I'll post about on the -dev list shortly.  It should be the best one yet
and as near as dammit what I'd call production-ready.

  Hopefully I'll also be able to get most of my patches upstream in time for
4.5.0; libstdc++ will be the first priority there.

    cheers,
      DaveK
