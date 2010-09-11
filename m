Return-Path: <cygwin-patches-return-7100-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10900 invoked by alias); 11 Sep 2010 11:43:07 -0000
Received: (qmail 10890 invoked by uid 22791); 11 Sep 2010 11:43:06 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-wy0-f171.google.com (HELO mail-wy0-f171.google.com) (74.125.82.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Sep 2010 11:43:02 +0000
Received: by wyb29 with SMTP id 29so4537045wyb.2        for <cygwin-patches@cygwin.com>; Sat, 11 Sep 2010 04:42:59 -0700 (PDT)
Received: by 10.216.236.149 with SMTP id w21mr2118185weq.65.1284205374156;        Sat, 11 Sep 2010 04:42:54 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.5-4.cable.virginmedia.com [82.6.108.62])        by mx.google.com with ESMTPS id v16sm2405180weq.32.2010.09.11.04.42.53        (version=SSLv3 cipher=RC4-MD5);        Sat, 11 Sep 2010 04:42:53 -0700 (PDT)
Message-ID: <4C8B707A.6080502@gmail.com>
Date: Sat, 11 Sep 2010 11:43:00 -0000
From: Dave Korn <dave.korn.cygwin@gmail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add fenv.h and support.
References: <4C8A9AC8.7070904@gmail.com> <20100910214347.GA23700@ednor.casa.cgf.cx> <4C8AD089.9000605@gmail.com> <20100911051009.GA25209@ednor.casa.cgf.cx> <4C8B2B9B.8060801@gmail.com> <20100911080929.GL16534@calimero.vinschen.de> <4C8B6671.6000200@gmail.com> <20100911111759.GQ16534@calimero.vinschen.de>
In-Reply-To: <20100911111759.GQ16534@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8
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
X-SW-Source: 2010-q3/txt/msg00060.txt.bz2

On 11/09/2010 12:17, Corinna Vinschen wrote:
> On Sep 11 12:22, Dave Korn wrote:

>>   How's this look?
>>
>> winsup/doc/ChangeLog:
>>
>> 	* new-features.sgml: Mention fenv support.
> 
> I would remove the opengroup link and just keep the gnu C lib one,
> but other than that it looks good.

  Sure thing.  Committed with that change.

    cheers,
      DaveK
