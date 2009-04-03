Return-Path: <cygwin-patches-return-6465-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 600 invoked by alias); 3 Apr 2009 09:07:57 -0000
Received: (qmail 588 invoked by uid 22791); 3 Apr 2009 09:07:56 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f173.google.com (HELO mail-ew0-f173.google.com) (209.85.219.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Apr 2009 09:07:51 +0000
Received: by ewy21 with SMTP id 21so907935ewy.2         for <cygwin-patches@cygwin.com>; Fri, 03 Apr 2009 02:07:48 -0700 (PDT)
Received: by 10.216.52.196 with SMTP id e46mr329499wec.124.1238749668525;         Fri, 03 Apr 2009 02:07:48 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id m5sm4426495gve.22.2009.04.03.02.07.47         (version=SSLv3 cipher=RC4-MD5);         Fri, 03 Apr 2009 02:07:47 -0700 (PDT)
Message-ID: <49D5D44C.3070105@gmail.com>
Date: Fri, 03 Apr 2009 09:07:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <asm/byteorder.h> missing prototypes warning
References: <49D57E45.4000409@users.sourceforge.net> <20090403082635.GB27898@calimero.vinschen.de>
In-Reply-To: <20090403082635.GB27898@calimero.vinschen.de>
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
X-SW-Source: 2009-q2/txt/msg00007.txt.bz2

Corinna Vinschen wrote:

> Wouldn't it be better to move newlib's _ELIDABLE_INLINE definition to
> some nicely matchin header like _ansi.h and then use it wherever it
> fits?

  I think you're right.  Can one of you two please take care of it?  I've got
a bit of a load on right now what with gcc back in stage1.

    cheers,
      DaveK
