Return-Path: <cygwin-patches-return-9303-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3171 invoked by alias); 3 Apr 2019 12:33:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3162 invoked by uid 89); 3 Apr 2019 12:33:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.1 spammy=aka, hundred
X-HELO: mx009.vodafonemail.xion.oxcs.net
Received: from mx009.vodafonemail.xion.oxcs.net (HELO mx009.vodafonemail.xion.oxcs.net) (153.92.174.39) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 03 Apr 2019 12:33:49 +0000
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 9959CD9B021	for <cygwin-patches@cygwin.com>; Wed,  3 Apr 2019 12:33:47 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.211.111])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 72651199C48	for <cygwin-patches@cygwin.com>; Wed,  3 Apr 2019 12:33:45 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
References: <20190325230556.2219-1-kbrown@cornell.edu>	<20190326083620.GI3471@calimero.vinschen.de>	<1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu>	<20190326190136.GC4096@calimero.vinschen.de>	<20190327133059.GG4096@calimero.vinschen.de>	<87k1gi3mle.fsf@Rainer.invalid>	<20190328201317.GZ4096@calimero.vinschen.de>	<d4cb62f1-5754-aff2-c23d-7ce65f5a5726@cornell.edu>	<87o95u5eu0.fsf@Rainer.invalid>	<f8b66caf-7673-f92b-ed2e-127b387f1f09@cornell.edu>	<87tvfljvaa.fsf@Rainer.invalid>
Date: Wed, 03 Apr 2019 12:33:00 -0000
In-Reply-To: <87tvfljvaa.fsf@Rainer.invalid> (Achim Gratz's message of "Fri,	29 Mar 2019 21:11:09 +0100")
Message-ID: <87a7h7mfo8.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2019-q2/txt/msg00010.txt.bz2

Achim Gratz writes:
> OK, a bit more info: The whole thing runs from a perl script (actually a
> module) that opens pipes to gnuplot and ghostscript.  This code is
> _really_ old and has seen a lot of Cygwin releases, so it has options to
> either use temporary files, named pipes aka FIFO or direct pipes.  Using
> temporary files serializes the execution and using a pipe chain is
> _really_ slow (like a hundred times, which is mostly tied up in system
> for a reason that I don't understand), so using FIFO is the default.
> Your new FIFO code increases the system time by about a factor of 10 in
> my tests, btw.

So I've final=C3=B6ly got around to fixing the pipe performance problem by
fooling the programs involved to think they are using files: have them
reading from /proc/self/fd/0 and writing to /proc/self/fd/1 gives me the
same performance as using a named FIFO.

Incidentally, that workaround still works when I switch to the 20190402
snapshot, while named FIFO fails as with the older snapshot (as
expected), so that seems to take a different code path.  Maybe that
helps in finding the problem?


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf microQ V2.22R2:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
