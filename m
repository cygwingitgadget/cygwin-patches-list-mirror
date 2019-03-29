Return-Path: <cygwin-patches-return-9270-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22443 invoked by alias); 29 Mar 2019 07:18:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22430 invoked by uid 89); 29 Mar 2019 07:18:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.1 spammy=race, HX-Languages-Length:857
X-HELO: mx009.vodafonemail.xion.oxcs.net
Received: from mx009.vodafonemail.xion.oxcs.net (HELO mx009.vodafonemail.xion.oxcs.net) (153.92.174.39) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 29 Mar 2019 07:18:04 +0000
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 8F9EED9B31D	for <cygwin-patches@cygwin.com>; Fri, 29 Mar 2019 07:18:02 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.211.111])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 61CE2199C28	for <cygwin-patches@cygwin.com>; Fri, 29 Mar 2019 07:18:00 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
References: <20190325230556.2219-1-kbrown@cornell.edu>	<20190326083620.GI3471@calimero.vinschen.de>	<1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu>	<20190326190136.GC4096@calimero.vinschen.de>	<20190327133059.GG4096@calimero.vinschen.de>	<87k1gi3mle.fsf@Rainer.invalid>	<20190328201317.GZ4096@calimero.vinschen.de>	<d4cb62f1-5754-aff2-c23d-7ce65f5a5726@cornell.edu>
Date: Fri, 29 Mar 2019 07:18:00 -0000
In-Reply-To: <d4cb62f1-5754-aff2-c23d-7ce65f5a5726@cornell.edu> (Ken Brown's	message of "Thu, 28 Mar 2019 22:54:22 +0000")
Message-ID: <87o95u5eu0.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00080.txt.bz2

Ken Brown writes:
>> I'm pretty sure Ken would be happy about an STC.
>
> Yes, please.  Barring that, is there any chance I could see the relevant code, 
> or at least enough of it so that I can see how FIFOs are being used?

Well, I'm trying -- but got nothing so far.  As the individual FIFO seem
to work and the error happens pretty early, I think it has something to
do with either switching between different FIFO (which the original code
does) or some race between fill and drain, possibly around a buffer
boundary (in my limited testing it always seemed to happen in the same
place for the same data).


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf rackAttack:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
