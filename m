Return-Path: <cygwin-patches-return-9309-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124378 invoked by alias); 5 Apr 2019 18:19:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124365 invoked by uid 89); 5 Apr 2019 18:19:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=305, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 05 Apr 2019 18:19:10 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 36F0DC0527	for <cygwin-patches@cygwin.com>; Fri,  5 Apr 2019 18:19:07 +0000 (UTC)
Received: from Rainer.invalid (unknown [91.47.63.232])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id EE9A530008D	for <cygwin-patches@cygwin.com>; Fri,  5 Apr 2019 18:19:04 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com>	<20190326182538.GA4096@calimero.vinschen.de>	<20190326182824.GB4096@calimero.vinschen.de>	<c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>	<20190327091640.GE4096@calimero.vinschen.de>	<b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com>	<20190328091507.GM4096@calimero.vinschen.de>	<89dc8dca-c97b-ef79-6b90-bebb1b73c388@ssi-schaefer.com>	<87o95u3n2p.fsf@Rainer.invalid>	<CAOTD34b9nGSzitUeV244vWQzzeSrVNKUNVFEiW6p6TQKDQi=CA@mail.gmail.com>
Date: Fri, 05 Apr 2019 18:19:00 -0000
In-Reply-To: <CAOTD34b9nGSzitUeV244vWQzzeSrVNKUNVFEiW6p6TQKDQi=CA@mail.gmail.com>	(E. Madison Bray's message of "Fri, 5 Apr 2019 18:48:02 +0200")
Message-ID: <8736mw8gdp.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q2/txt/msg00016.txt.bz2

E. Madison Bray writes:
> However, I can see how this could be inconvenient for some Python
> builds where you might have something within the setup.py script
> (which, when building Python extension modules, is still usually used)
> like (in pseudo-code):
>
>     run_build_ext_command()
>     import just_built_module
>     # Use just_built_module to generate some files
>     run_install_command()
>
> all within the same process.  One could work around this by modifying
> the setup.py to call `rebase` as a subprocess and that should work,
> but it would suck to have to make such extra considerations just for
> Cygwin, much less get some upstream project to accept that.

Well, Perl has hooks for platform specific code in ExtUtils and
Module::Install, so that takes care of 99% of the module builds out
there and they seem to have no trouble accepting it into their code as
long as you can demonstrate that it woreks and why it's there.  I won't
touch Python if I can avoid it, so I have no idea what they do; but
again, it would seem a glaring omission to not have _something_ that
caters to the runtime platform at least.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf rackAttack V1.04R1:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
