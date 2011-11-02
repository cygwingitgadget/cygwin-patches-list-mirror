Return-Path: <cygwin-patches-return-7531-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22231 invoked by alias); 2 Nov 2011 19:53:55 -0000
Received: (qmail 22220 invoked by uid 22791); 2 Nov 2011 19:53:53 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,TW_CG,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 02 Nov 2011 19:53:39 +0000
Received: from fwd00.aul.t-online.de (fwd00.aul.t-online.de )	by mailout09.t-online.de with smtp 	id 1RLgsT-0000lD-4S; Wed, 02 Nov 2011 20:53:37 +0100
Received: from [192.168.2.108] (bRXIFTZd8hoCzi33qXl2NI-7uJsYUjxlFcLP0SBBKNouT59hjd9KwfsolW-Z2bJZhN@[79.224.122.93]) by fwd00.t-online.de	with esmtp id 1RLgsP-0c5Y120; Wed, 2 Nov 2011 20:53:33 +0100
Message-ID: <4EB19FBB.5060800@t-online.de>
Date: Wed, 02 Nov 2011 19:53:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110928 Firefox/7.0.1 SeaMonkey/2.4.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Prevent restart of crashing non-Cygwin exe
References: <4E037D68.6090907@t-online.de> <20110624075743.GR3437@calimero.vinschen.de>
In-Reply-To: <20110624075743.GR3437@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-SW-Source: 2011-q4/txt/msg00021.txt.bz2

On Jun 24, Corinna Vinschen wrote:
> Hi Christian,
>
> On Jun 23 19:52, Christian Franke wrote:
>> If a non-Cygwin .exe started from a Cygwin shell window segfaults,
>> Cygwin restarts the .exe 5 times.
>> [...l]
>> 	* sigproc.cc (child_info::sync): Add exit_code to debug
>> 	message.
>> 	(child_info::proc_retry): Don't retry on unknown exit_code
>> 	from non-cygwin programs.
> This looks ok to me, but cgf should have a say here.  He's on vacation
> for another week, though.
>

Problem can still be reproduced with current CVS. Patch is still valid.

Christian
