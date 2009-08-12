Return-Path: <cygwin-patches-return-6596-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14169 invoked by alias); 12 Aug 2009 21:22:25 -0000
Received: (qmail 14134 invoked by uid 22791); 12 Aug 2009 21:22:25 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_32,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f217.google.com (HELO mail-ew0-f217.google.com) (209.85.219.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 12 Aug 2009 21:22:18 +0000
Received: by ewy17 with SMTP id 17so349377ewy.2         for <cygwin-patches@cygwin.com>; Wed, 12 Aug 2009 14:22:15 -0700 (PDT)
Received: by 10.210.63.18 with SMTP id l18mr733557eba.11.1250112134513;         Wed, 12 Aug 2009 14:22:14 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm3465132eyg.25.2009.08.12.14.22.13         (version=SSLv3 cipher=RC4-MD5);         Wed, 12 Aug 2009 14:22:13 -0700 (PDT)
Message-ID: <4A8335AE.5060100@gmail.com>
Date: Wed, 12 Aug 2009 21:22:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix dlopen vs cxx malloc bug.
References: <4A8334E6.8010808@gmail.com>
In-Reply-To: <4A8334E6.8010808@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00050.txt.bz2


  Oh, P.S.:-

Dave Korn wrote:

> winsup/cygwin/ChangeLog:
> 
> 	* cxx.cc (default_cygwin_cxx_malloc): Enhance commenting.

  I never quote the email address + date lines in ChangeLogs, but since Corinna
wrote most of the patch I think we should put her name on it as well as mine.

    cheers,
      DaveK
