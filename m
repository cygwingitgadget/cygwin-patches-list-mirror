Return-Path: <cygwin-patches-return-7028-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17628 invoked by alias); 6 May 2010 03:08:28 -0000
Received: (qmail 17617 invoked by uid 22791); 6 May 2010 03:08:27 -0000
X-SWARE-Spam-Status: No, hits=-2.7 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 06 May 2010 03:08:23 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41])	by gateway1.messagingengine.com (Postfix) with ESMTP id 8A620F2F91	for <cygwin-patches@cygwin.com>; Wed,  5 May 2010 23:08:21 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])  by compute1.internal (MEProxy); Wed, 05 May 2010 23:08:21 -0400
Received: from [192.168.1.3] (unknown [24.110.45.162])	by mail.messagingengine.com (Postfix) with ESMTPSA id 305144A6014;	Wed,  5 May 2010 23:08:21 -0400 (EDT)
Message-ID: <4BE23275.1030009@cwilson.fastmail.fm>
Date: Thu, 06 May 2010 03:08:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
References: <4AC7910E.1010900@cwilson.fastmail.fm> <4AC82056.7060308@cwilson.fastmail.fm> <4BE1A2C5.4090604@gmail.com> <20100505175614.GA6651@ednor.casa.cgf.cx> <4BE1BFCC.6060703@gmail.com> <20100505191317.GA14692@ednor.casa.cgf.cx>
In-Reply-To: <20100505191317.GA14692@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00011.txt.bz2

On 5/5/2010 3:13 PM, Christopher Faylor wrote:

> That's basically it and I have it more-or-less coded but I haven't
> finished thinking about DLLs.  Maybe that's more complication than is
> warranted.  I have to do more research there.  We could, and I think
> should, put most of the code in pseudo_reloc.c in cygwin1.dll, though,
> rather than duplicate it in every source file.

I disagree with this statement.

I spent a lot of effort trying to synchronize our version of
pseudo_reloc.c with the mingw and mingw64 versions -- specifically so
that we could leverage Kai's v2 efforts.

If we -- meaning cygwin -- move most of the guts into the cygwin DLL,
then ... we either
  (1) fork our version from the mingw[32|64] version permanently, and
lose the possibility of "easy" code sharing between the three projects, or
  (2) this portion of the code lives in both places (pseudo_reloc.c and
some-other-cygwin-dll-source-file), but is #ifdef'ed in pseudo_reloc.c
when compiled on cygwin, because there's this other identical copy over
in some-other-cygwin-dll-source-file.

Yuck. (I don't mind "losing" the effort I put in, because whatever
happens we now have v2 support. But...why make it harder if somebody in
mingw-land invents v3? Or make it harder on them, if WE do?)

--
Chuck
