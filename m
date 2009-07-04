Return-Path: <cygwin-patches-return-6554-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17819 invoked by alias); 4 Jul 2009 14:57:42 -0000
Received: (qmail 17809 invoked by uid 22791); 4 Jul 2009 14:57:42 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_82,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f213.google.com (HELO mail-ew0-f213.google.com) (209.85.219.213)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Jul 2009 14:57:34 +0000
Received: by ewy9 with SMTP id 9so3333416ewy.2         for <cygwin-patches@cygwin.com>; Sat, 04 Jul 2009 07:57:31 -0700 (PDT)
Received: by 10.210.61.16 with SMTP id j16mr2449914eba.37.1246719451432;         Sat, 04 Jul 2009 07:57:31 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 28sm3717507eyg.14.2009.07.04.07.57.30         (version=SSLv3 cipher=RC4-MD5);         Sat, 04 Jul 2009 07:57:30 -0700 (PDT)
Message-ID: <4A4F70D0.3060107@gmail.com>
Date: Sat, 04 Jul 2009 14:57:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: AttachConsole broken autoload
References: <4A4F4F5B.8090806@gmail.com> <20090704141721.GA11034@ednor.casa.cgf.cx>
In-Reply-To: <20090704141721.GA11034@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00008.txt.bz2

Christopher Faylor wrote:
> On Sat, Jul 04, 2009 at 01:47:23PM +0100, Dave Korn wrote:

>>
>> 	* autoload.cc (AttachConsole):  Correct size of args.
> 
> Yes, I think that's an obvious fix.

  Ta, committed.  Libstdc++ support (and gcc-4.3.3-1 to go with it) on the
way.  After that, there's a few strict-aliasing violations and similar I
noticed when I tried compiling the DLL with 4.5.0 which I'll send patches for.

    cheers,
      DaveK
