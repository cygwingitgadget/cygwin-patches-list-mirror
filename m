Return-Path: <cygwin-patches-return-6472-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27095 invoked by alias); 4 Apr 2009 04:01:00 -0000
Received: (qmail 27077 invoked by uid 22791); 4 Apr 2009 04:00:59 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f173.google.com (HELO mail-ew0-f173.google.com) (209.85.219.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 04:00:54 +0000
Received: by ewy21 with SMTP id 21so1241962ewy.2         for <cygwin-patches@cygwin.com>; Fri, 03 Apr 2009 21:00:51 -0700 (PDT)
Received: by 10.210.116.16 with SMTP id o16mr1460270ebc.13.1238817651802;         Fri, 03 Apr 2009 21:00:51 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 10sm3835344eyz.49.2009.04.03.21.00.51         (version=SSLv3 cipher=RC4-MD5);         Fri, 03 Apr 2009 21:00:51 -0700 (PDT)
Message-ID: <49D6DDDD.4030504@gmail.com>
Date: Sat, 04 Apr 2009 04:01:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx>
In-Reply-To: <20090404033545.GA3386@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00014.txt.bz2

Christopher Faylor wrote:

>>  The attached patch fixes all these by adjusting only the suffix letters.  OK
>> for head?
>>
>> winsup/cygwin/ChangeLog
>>
>> 	* include/stdint.h (UINT32_MAX, INT_LEAST32_MIN, INT_LEAST32_MAX,
>> 	INT_FAST16_MIN, INT_FAST32_MIN, INT_FAST16_MAX, INT_FAST32_MAX,
>> 	INTPTR_MIN, INTPTR_MAX, SIZE_MAX):  Fix integer constant suffixes.
> 
> Many of the changes introduce divergence from Linux.  Why is that?

  Because our stdint.h types are divergent from Linux, and changing them
instead could cause yet another ABI break.

    cheers,
      DaveK
