Return-Path: <cygwin-patches-return-9785-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12901 invoked by alias); 22 Oct 2019 17:37:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12389 invoked by uid 89); 22 Oct 2019 17:37:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=xtk, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx011.vodafonemail.xion.oxcs.net
Received: from vsmx011.vodafonemail.xion.oxcs.net (HELO vsmx011.vodafonemail.xion.oxcs.net) (153.92.174.89) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 17:37:07 +0000
Received: from vsmx003.vodafonemail.xion.oxcs.net (unknown [192.168.75.197])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 3EA7659D2CE	for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 17:37:05 +0000 (UTC)
Received: from Gertrud (unknown [84.160.192.162])	by mta-7-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 108655399F8	for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 17:37:02 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
References: <87mudvwnrl.fsf@Rainer.invalid>	<20191021081844.GH16240@calimero.vinschen.de>	<87pniq7yvm.fsf@Rainer.invalid>	<20191022071622.GM16240@calimero.vinschen.de>
Date: Tue, 22 Oct 2019 17:37:00 -0000
In-Reply-To: <20191022071622.GM16240@calimero.vinschen.de> (Corinna Vinschen's	message of "Tue, 22 Oct 2019 09:16:22 +0200")
Message-ID: <87d0eo65s5.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2019-q4/txt/msg00056.txt.bz2

Corinna Vinschen writes:
>> So how about we only do this on 64bit as an added bonus for folks who
>> "get it"?
>
> I'm not hot on doing that, and I'm not sure shilka likes ifdef's
> inside the %% block.

OK, then let's forget about that.

>> One particular machine I've recently worked on presented me
>> with COM144 to connect to, but I consider this to be an anomaly.  But
>> COM port numbers in the 70=E2=80=A680 range are pretty common on some of=
 the
>> more heavily used development machines.
>
> I just checked and changing ttyS%(0-63) to ttyS%(0-127) raises
> the size of .text and .rdata by 6.5K and the size of the final DLL
> by 7.6K.  That should be ok.  Just provide the patch so there's your
> name on it.

You mean just the patch to change device.in?  Can do.  If I also need to
re-generate the other files then I'm afraid I won't be able to do it in
the next two weeks, maybe a bit longer.

> ttyS%(0-255) takes another 23K btw.  Even that should be ok, if
> the need arises.  Alternatively we could shortcut shilka as for
> /dev/sd*, but that involved much bigger numbers.

As I said, I don't think that this is common enough, so let's wait until
somebody complains.  Getting rid of the static entries sounds like a
good idea, but that's for later.


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
