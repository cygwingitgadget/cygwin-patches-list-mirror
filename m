Return-Path: <cygwin-patches-return-6681-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30066 invoked by alias); 4 Oct 2009 07:12:53 -0000
Received: (qmail 30053 invoked by uid 22791); 4 Oct 2009 07:12:52 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f218.google.com (HELO mail-ew0-f218.google.com) (209.85.219.218)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Oct 2009 07:12:48 +0000
Received: by ewy18 with SMTP id 18so2426468ewy.43         for <cygwin-patches@cygwin.com>; Sun, 04 Oct 2009 00:12:46 -0700 (PDT)
Received: by 10.210.96.12 with SMTP id t12mr1752725ebb.71.1254640365995;         Sun, 04 Oct 2009 00:12:45 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 28sm1854350eyg.12.2009.10.04.00.12.44         (version=SSLv3 cipher=RC4-MD5);         Sun, 04 Oct 2009 00:12:45 -0700 (PDT)
Message-ID: <4AC84E5A.7040203@gmail.com>
Date: Sun, 04 Oct 2009 07:12:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de> <4AC74BB5.9060503@gmail.com> <20091003130644.GJ7193@calimero.vinschen.de> <4AC75235.1070403@gmail.com>
In-Reply-To: <4AC75235.1070403@gmail.com>
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
X-SW-Source: 2009-q4/txt/msg00012.txt.bz2

Dave Korn wrote:

>> Apparently.  There's no line containing __wrap__Znaj in config.log.
> 
>   Yeh, that proves I'm using the wrong sort of autoconf test.  

  No it doesn't!

>> While you're at it, there is another problem.  When building gcc-4.3.4
>> as cross, the auto-host.h file contains
>>
>>   #ifndef USED_FOR_TARGET
>>   /* #undef HAVE_GAS_ALIGNED_COMM */
>>   #endif
>>
>> afterwards.  That's quite unlucky, since options.c contains an
>> unconditional
>>
>>   int use_pe_aligned_common = HAVE_GAS_ALIGNED_COMM;
>>
>> So, right now I had to define HAVE_GAS_ALIGNED_COMM to 1 manually in
>> auto-host.h.

  Got it.  The cygport-generated diffs don't include patches to the generated
configure scripts, only the *.ac templates, so you need to manually reconf the
sources after applying the patch.  Check the cygport script for a list of
which directories need which auto* tool run on them (I haven't tried just
blindly autoreconf'ing the whole lot from top level but in theory that would
work too), and don't forget you need autoconf-2.59 and make-1.9.6.

    cheers,
      DaveK

