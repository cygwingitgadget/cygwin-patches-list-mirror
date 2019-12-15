Return-Path: <cygwin-patches-return-9864-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32714 invoked by alias); 15 Dec 2019 08:49:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32705 invoked by uid 89); 15 Dec 2019 08:49:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=H*i:sk:adcab3c, H*f:sk:adcab3c, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Dec 2019 08:49:57 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id B3253159D368	for <cygwin-patches@cygwin.com>; Sun, 15 Dec 2019 08:49:54 +0000 (UTC)
Received: from Gertrud (unknown [91.47.60.226])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 88A89159D590	for <cygwin-patches@cygwin.com>; Sun, 15 Dec 2019 08:49:52 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
References: <87mudvwnrl.fsf@Rainer.invalid>	<20191021081844.GH16240@calimero.vinschen.de>	<87pniq7yvm.fsf@Rainer.invalid>	<20191022071622.GM16240@calimero.vinschen.de>	<87sgn4ai3n.fsf@Rainer.invalid> <871rt6rbvb.fsf@Rainer.invalid>	<adcab3cf-3162-f692-e4f5-2dceb8401869@SystematicSw.ab.ca>
Date: Sun, 15 Dec 2019 08:49:00 -0000
In-Reply-To: <adcab3cf-3162-f692-e4f5-2dceb8401869@SystematicSw.ab.ca> (Brian	Inglis's message of "Sat, 14 Dec 2019 23:04:07 -0700")
Message-ID: <877e2yht1v.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q4/txt/msg00135.txt.bz2

Brian Inglis writes:
> On 2019-12-14 11:38, Achim Gratz wrote:
>
> s[6] == 'd'?

Indeed.

>>   if (len > 7 && len < 12 && s[7] == 'd'
> -   if (len > 7 && len < 12 && s[7] == 'd'
> +   if (len > 7 && len < 12 && s[DP_LEN - 1] == 'd'

Yes, that's better.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
