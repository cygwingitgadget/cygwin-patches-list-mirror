Return-Path: <cygwin-patches-return-6475-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19401 invoked by alias); 4 Apr 2009 07:03:57 -0000
Received: (qmail 19088 invoked by uid 22791); 4 Apr 2009 07:03:56 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f173.google.com (HELO mail-ew0-f173.google.com) (209.85.219.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 07:03:51 +0000
Received: by ewy21 with SMTP id 21so1264709ewy.2         for <cygwin-patches@cygwin.com>; Sat, 04 Apr 2009 00:03:48 -0700 (PDT)
Received: by 10.210.86.10 with SMTP id j10mr1153496ebb.41.1238828628058;         Sat, 04 Apr 2009 00:03:48 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 23sm3810783eya.16.2009.04.04.00.03.47         (version=SSLv3 cipher=RC4-MD5);         Sat, 04 Apr 2009 00:03:47 -0700 (PDT)
Message-ID: <49D708BE.1080603@gmail.com>
Date: Sat, 04 Apr 2009 07:03:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx>
In-Reply-To: <20090404062459.GB22452@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00017.txt.bz2

Christopher Faylor wrote:

> Why would changing uint32_t from 'unsigned long' to 'unsigned int' break
> anything?  

  Well, it mangles differently and will resolve overloads and instantiate
templates differently won't it?

> It looks to me like that is a disaster waiting to happen if
> we ever provide a 64-bit port

  Not necessarily.  Win64 is an LLP64 platform.  Won't that make it OK?  All
the 32-bit integer types remain 32-bits, the 64-bit long long remains 64-bits,
only pointers change in size.  (Along with the related [u]intptr_t, ptrdiff_t
etc.)

> Isn't a long 32 bits?  What would be the ABI breakage in changing that
> one typedef rather than lots of #defines?  It seems like fixing the
> typedefs in stdint.h is the right thing to do before Cygwin 1.7 rolls
> out.

  Agreed, but I'm not sure if they are wrong yet.  Just different, with a
legacy of applications that expect them to be the way they currently are.

    cheers,
      DaveK
