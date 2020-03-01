Return-Path: <cygwin-patches-return-10151-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90916 invoked by alias); 1 Mar 2020 13:56:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90905 invoked by uid 89); 1 Mar 2020 13:56:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*MI:sk:2020030, H*i:sk:2020030, H*f:sk:2020030, wpbuf-bench.cc
X-HELO: mailout08.t-online.de
Received: from mailout08.t-online.de (HELO mailout08.t-online.de) (194.25.134.20) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 01 Mar 2020 13:56:36 +0000
Received: from fwd24.aul.t-online.de (fwd24.aul.t-online.de [172.20.26.129])	by mailout08.t-online.de (Postfix) with SMTP id B878D41D4374	for <cygwin-patches@cygwin.com>; Sun,  1 Mar 2020 14:56:34 +0100 (CET)
Received: from [192.168.178.26] (VmHr1yZL8hTb25Hv5rcG90sWF3k70yYg4h-DCJ0LCG4cmq0mc9+NeipNDh-BcNeQpO@[79.228.65.18]) by fwd24.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)	esmtp id 1j8P58-0VZsDg0; Sun, 1 Mar 2020 14:56:34 +0100
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
To: cygwin-patches@cygwin.com
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp> <20200228133122.GG4045@calimero.vinschen.de> <cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de> <20200301153342.cbc54c2b14687b71679f993a@nifty.ne.jp>
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Message-ID: <49f801fe-3c86-d2ab-1ea2-b7eea7ad7c5f@t-online.de>
Date: Sun, 01 Mar 2020 13:56:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200301153342.cbc54c2b14687b71679f993a@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00257.txt

Am 01.03.2020 um 07:33 schrieb Takashi Yano:

> However, from the view point of performance, just inline
> static function is better. 

I don't see how that could be the case.  Inline methods of a static C++ 
object should not suffer any perfomance penalty compared to inline 
functions operating on static variables.

> Attached code measures the
> performance of access speed for wpbuf.
> I compiled it by g++ 7.4.0 with -O2 option.
> 
> The result is as follows.
> 
> Total1: 2.315627 second
> Total2: 1.588511 second
> Total3: 1.571572 second

Strange.  The result here (with GCC 9.2) is rather different:

$ g++ -O2 -o tt wpbuf-bench.cc && ./tt
Total1: 0.753815 second
Total2: 0.757444 second
Total3: 1.217352 second

And on inspection, all three bench*() functions do appear to have 
exactly the same machine code, too.  They may be inlined and mixed into 
main() somewhat differently, though.  That might explain the difference 
more readily than any actual difference in speed between the three 
implementations.
