Return-Path: <cygwin-patches-return-9773-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33690 invoked by alias); 21 Oct 2019 18:11:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33672 invoked by uid 89); 21 Oct 2019 18:11:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=anomaly, wave, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Oct 2019 18:10:59 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id F2487F34E0F	for <cygwin-patches@cygwin.com>; Mon, 21 Oct 2019 18:10:55 +0000 (UTC)
Received: from Gertrud (unknown [84.160.192.162])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id C39EF19AD9F	for <cygwin-patches@cygwin.com>; Mon, 21 Oct 2019 18:10:53 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
References: <87mudvwnrl.fsf@Rainer.invalid>	<20191021081844.GH16240@calimero.vinschen.de>
Date: Mon, 21 Oct 2019 18:11:00 -0000
In-Reply-To: <20191021081844.GH16240@calimero.vinschen.de> (Corinna Vinschen's	message of "Mon, 21 Oct 2019 10:18:44 +0200")
Message-ID: <87pniq7yvm.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2019-q4/txt/msg00044.txt.bz2

Corinna Vinschen writes:
> That's not the right way to patch this.  devices.cc gets generated from
> devices.in by the gendevices script which in turn calls shilka from the
> cocom package.

Now that you mention it I remember=E2=80=A6  :-(

> Apart from the struct members you added here, it will
> also add some code.  Which, unfortunately, raise the size of devices.cc,
> especially troubling the 32 bit version.

So how about we only do this on 64bit as an added bonus for folks who
"get it"?  One particular machine I've recently worked on presented me
with COM144 to connect to, but I consider this to be an anomaly.  But
COM port numbers in the 70=E2=80=A680 range are pretty common on some of the
more heavily used development machines.


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf rackAttack V1.04R1:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
