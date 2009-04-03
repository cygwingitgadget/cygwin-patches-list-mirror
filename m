Return-Path: <cygwin-patches-return-6462-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18618 invoked by alias); 3 Apr 2009 08:05:46 -0000
Received: (qmail 18608 invoked by uid 22791); 3 Apr 2009 08:05:46 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f173.google.com (HELO mail-ew0-f173.google.com) (209.85.219.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Apr 2009 08:05:41 +0000
Received: by ewy21 with SMTP id 21so885176ewy.2         for <cygwin-patches@cygwin.com>; Fri, 03 Apr 2009 01:05:38 -0700 (PDT)
Received: by 10.216.11.138 with SMTP id 10mr320160wex.51.1238745938400;         Fri, 03 Apr 2009 01:05:38 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id x6sm4358489gvf.0.2009.04.03.01.05.37         (version=SSLv3 cipher=RC4-MD5);         Fri, 03 Apr 2009 01:05:37 -0700 (PDT)
Message-ID: <49D5C5BA.1040308@gmail.com>
Date: Fri, 03 Apr 2009 08:05:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <asm/byteorder.h> missing prototypes warning
References: <49D57E45.4000409@users.sourceforge.net> <49D5B44F.7030509@gmail.com>
In-Reply-To: <49D5B44F.7030509@gmail.com>
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
X-SW-Source: 2009-q2/txt/msg00004.txt.bz2

Dave Korn wrote:

>   Maybe we can call it __extern__ (so it looks like a c99-compatible extension
> keyword and doesn't cause problems for non-GCC compilers)

  ENOCOFFEE.  That's not a c99 extension, it's a gcc extension.  Dur me!

    cheers,
      DaveK
