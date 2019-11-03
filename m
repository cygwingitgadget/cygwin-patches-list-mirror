Return-Path: <cygwin-patches-return-9799-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126183 invoked by alias); 3 Nov 2019 19:13:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126171 invoked by uid 89); 3 Nov 2019 19:13:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=btw, H*Ad:U*cygwin-patches, wave, searched
X-HELO: vsmx011.vodafonemail.xion.oxcs.net
Received: from vsmx011.vodafonemail.xion.oxcs.net (HELO vsmx011.vodafonemail.xion.oxcs.net) (153.92.174.89) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 03 Nov 2019 19:13:42 +0000
Received: from vsmx003.vodafonemail.xion.oxcs.net (unknown [192.168.75.197])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 75D0259D4D5	for <cygwin-patches@cygwin.com>; Sun,  3 Nov 2019 19:13:40 +0000 (UTC)
Received: from Gertrud (unknown [84.160.192.162])	by mta-7-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 4FC6D5399FD	for <cygwin-patches@cygwin.com>; Sun,  3 Nov 2019 19:13:38 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
References: <87mudvwnrl.fsf@Rainer.invalid>	<20191021081844.GH16240@calimero.vinschen.de>	<87pniq7yvm.fsf@Rainer.invalid>	<20191022071622.GM16240@calimero.vinschen.de>
Date: Sun, 03 Nov 2019 19:13:00 -0000
In-Reply-To: <20191022071622.GM16240@calimero.vinschen.de> (Corinna Vinschen's	message of "Tue, 22 Oct 2019 09:16:22 +0200")
Message-ID: <87sgn4ai3n.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2019-q4/txt/msg00070.txt.bz2

Corinna Vinschen writes:
[=E2=80=A6]
> ttyS%(0-255) takes another 23K btw.  Even that should be ok, if
> the need arises.  Alternatively we could shortcut shilka as for
> /dev/sd*, but that involved much bigger numbers.

I've searched for some documentation (anywhere the glob syntax %(1-128)
would turn up, btw?) and I think Cygwin is misusing shilka a bit here.
It's a keyword scanner, so the arithmetically coded parts of the device
shouldn't be targeted at all.  Instead, only the device path prefix
should be searched via the shilka lexer and the rest of the conversion
done in code.  For the disks we might keep the globbing that gets us the
device major part.  That of course means we construct more devices
on-the-fly (or even all of them) and have a much smaller table of static
device entries (which get searched linearly, so in the end that should
be a net speed improvement).



Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
