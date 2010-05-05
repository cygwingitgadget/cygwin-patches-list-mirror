Return-Path: <cygwin-patches-return-7025-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27994 invoked by alias); 5 May 2010 19:29:20 -0000
Received: (qmail 27982 invoked by uid 22791); 5 May 2010 19:29:19 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f43.google.com (HELO mail-fx0-f43.google.com) (209.85.161.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 May 2010 19:29:08 +0000
Received: by fxm14 with SMTP id 14so9363967fxm.2        for <cygwin-patches@cygwin.com>; Wed, 05 May 2010 12:29:05 -0700 (PDT)
Received: by 10.223.16.207 with SMTP id p15mr554782faa.99.1273087745662;        Wed, 05 May 2010 12:29:05 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])        by mx.google.com with ESMTPS id g10sm61410fai.12.2010.05.05.12.29.02        (version=SSLv3 cipher=RC4-MD5);        Wed, 05 May 2010 12:29:03 -0700 (PDT)
Message-ID: <4BE1CB8C.8020301@gmail.com>
Date: Wed, 05 May 2010 19:29:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
References: <4AC7910E.1010900@cwilson.fastmail.fm> <4AC82056.7060308@cwilson.fastmail.fm> <4BE1A2C5.4090604@gmail.com> <20100505175614.GA6651@ednor.casa.cgf.cx> <4BE1BFCC.6060703@gmail.com> <20100505191317.GA14692@ednor.casa.cgf.cx>
In-Reply-To: <20100505191317.GA14692@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q2/txt/msg00008.txt.bz2

On 05/05/2010 20:13, Christopher Faylor wrote:

> Yeah, I realized that two seconds after sending the message.  However,
> is this particular problem really an issue for DLLs?  DLLs should get
> their data/bss updated after _pei386_runtime_relocator() is called.  So
> it seems like you'd get the same thing being written twice.  It's not
> optimal but it shouldn't be fatal.
> 
> The program's data/bss is different since that gets copied during DLL
> initialization and before _pei386_runtime_relocator() is (was) called.  So
> I could see how it could be screwed up.

  Ah, right; I wasn't looking at how much later the dll sections got copied, I
just figured the safest and consistent solution was just to treat everything
the same.

> That's basically it and I have it more-or-less coded but I haven't
> finished thinking about DLLs.  Maybe that's more complication than is
> warranted.  I have to do more research there.  We could, and I think
> should, put most of the code in pseudo_reloc.c in cygwin1.dll, though,
> rather than duplicate it in every source file.

  Yeh, the only thing we need in the source file is to capture the module's
idea of its section start/end pointers, as we already do in the per_process;
we could consider passing pointers to the pseudo-relocs in that as well, but
horrible backward-compatibility problems could arise.  It would make sense to
inline the remnants of _pei386_runtime_relocator into _cygwin_crt0_common and
do away with the pseudo-reloc.c file altogether.

> This information is all recorded for fork() so it should be doable.  It is
> more complicated to do it outside of the program but, like I said, it allows
> us to fix problems by a new release of the DLL rather than telling people
> "You must relink your program".

  Yeh.  Unfortunately it's too late to help with this time, but it would help
any future problem (so long as it didn't require us to capture additional data
in the lib/ part of the executable but could be fixed with what we were
already passing to the Cygwin DLL).

    cheers,
      DaveK
