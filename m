Return-Path: <cygwin-patches-return-6539-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22975 invoked by alias); 4 Jun 2009 03:15:59 -0000
Received: (qmail 22965 invoked by uid 22791); 4 Jun 2009 03:15:59 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f226.google.com (HELO mail-bw0-f226.google.com) (209.85.218.226)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Jun 2009 03:15:50 +0000
Received: by bwz26 with SMTP id 26so448061bwz.2         for <cygwin-patches@cygwin.com>; Wed, 03 Jun 2009 20:15:47 -0700 (PDT)
Received: by 10.103.24.11 with SMTP id b11mr984059muj.90.1244085347400;         Wed, 03 Jun 2009 20:15:47 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 14sm2182701muo.3.2009.06.03.20.15.46         (version=SSLv3 cipher=RC4-MD5);         Wed, 03 Jun 2009 20:15:46 -0700 (PDT)
Message-ID: <4A273F2B.80004@gmail.com>
Date: Thu, 04 Jun 2009 03:15:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 3
References: <4A270656.8090704@gmail.com> <4A270BA4.3080602@gmail.com> <20090604014145.GB15999@ednor.casa.cgf.cx> <4A273967.6090703@gmail.com> <20090604030825.GA27249@ednor.casa.cgf.cx>
In-Reply-To: <20090604030825.GA27249@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00081.txt.bz2

Christopher Faylor wrote:
> On Thu, Jun 04, 2009 at 04:03:03AM +0100, Dave Korn wrote:
>> but it's a horrible bit of code.  Declaring the memory location as input only,
>> then clobbering all of memory and potentially confusing the optimisers with
>> type aliasing casts?  It makes me very uneasy.
> 
> Ok.  I'm convinced.  Please check in whatever you think is best.
> 
> cgf

  I will wait and see what advice the gcc list has to offer on the topic
first.  It may yet cast a new light on things.  (Or it may just confirm my
suspicions that even in trusted and well-tested library code, there has been a
fair deal of ad-hoc-ery and copypastaing of inline asms that people didn't
really grok.)  I'll also see if I can dig up any recent PRs or fixes that
might have a bearing on why we get better code from HEAD than 4.3.

    cheers,
      DaveK
