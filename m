Return-Path: <cygwin-patches-return-9263-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67179 invoked by alias); 28 Mar 2019 18:01:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67102 invoked by uid 89); 28 Mar 2019 18:01:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=PDF, plots, delivers, our
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 18:01:06 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id DD3D3C05C1	for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 18:01:04 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.211.111])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id B45FD30029B	for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 18:01:02 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
References: <20190325230556.2219-1-kbrown@cornell.edu>	<20190326083620.GI3471@calimero.vinschen.de>	<1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu>	<20190326190136.GC4096@calimero.vinschen.de>	<20190327133059.GG4096@calimero.vinschen.de>
Date: Thu, 28 Mar 2019 18:01:00 -0000
In-Reply-To: <20190327133059.GG4096@calimero.vinschen.de> (Corinna Vinschen's	message of "Wed, 27 Mar 2019 14:30:59 +0100")
Message-ID: <87k1gi3mle.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2019-q1/txt/msg00073.txt.bz2

Corinna Vinschen writes:
> Done.  I also pushed out new dev snapshots.

No good deed goes unpunished=E2=80=A6

Whith the 20190327 snapshot our main data processing application is
broken.  It looks like it should almost work, it doesn't crash or
anything, but the pipe that delivers a script+data into gnuplot seems to
either skip or overwrite data and then gnuplot bails with a syntax
error.  Depending on exactly which data I try to plot I get the first or
first few plots out through the whole processing pipe (that ends in a
PDF file), albeit sometimes with incomplete data.  Doing each of the
steps manually (i.e. writing the gnuplot script into a file, then feed
that into gnuplot, then the output from gnuplot inth ghostscript) does
work correctly.  I have not yet been able to reduce this down to some
simpler test case, so I had to roll back to the previous snapshot.  I
still have it installed on the development system, though.


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf rackAttack V1.04R1:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
