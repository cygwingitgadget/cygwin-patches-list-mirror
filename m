Return-Path: <cygwin-patches-return-9334-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83750 invoked by alias); 13 Apr 2019 07:36:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83456 invoked by uid 89); 13 Apr 2019 07:36:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=wave, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 13 Apr 2019 07:36:53 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id E5F40C06A4	for <cygwin-patches@cygwin.com>; Sat, 13 Apr 2019 07:36:49 +0000 (UTC)
Received: from Gertrud (unknown [87.185.221.231])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id BB079300597	for <cygwin-patches@cygwin.com>; Sat, 13 Apr 2019 07:36:47 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: use win pid+threadid for forkables dirname
References: <869d6cb0-9c14-d1f6-fdf2-f87ff815029b@ssi-schaefer.com>	<20190412180140.GE4248@calimero.vinschen.de>
Date: Sat, 13 Apr 2019 07:36:00 -0000
In-Reply-To: <20190412180140.GE4248@calimero.vinschen.de> (Corinna Vinschen's	message of "Fri, 12 Apr 2019 20:01:40 +0200")
Message-ID: <87ftqmxsok.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q2/txt/msg00041.txt.bz2

Corinna Vinschen writes:
> On Apr 12 15:32, Michael Haubenwallner wrote:
>> Rather than newest last write time of all dlls loaded, use the forking
>> process' windows pid and windows thread id as directory name to create
>> the forkable hardlinks into.  While this may create hardlinks more
>> often, it does avoid conflicts between dlls not having the newest last
>> write time.
>> ---
>>  winsup/cygwin/forkable.cc | 26 +++++++-------------------
>>  1 file changed, 7 insertions(+), 19 deletions(-)
>
> Pushed.

Hmm. Is it safe to use such easily predictable names?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf Blofeld V1.15B11:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
