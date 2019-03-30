Return-Path: <cygwin-patches-return-9276-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122858 invoked by alias); 30 Mar 2019 08:22:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122847 invoked by uid 89); 30 Mar 2019 08:22:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=permanently, distributed
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 30 Mar 2019 08:22:35 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 57FBDC0570	for <cygwin-patches@cygwin.com>; Sat, 30 Mar 2019 08:22:33 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.211.111])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 2DEB7300626	for <cygwin-patches@cygwin.com>; Sat, 30 Mar 2019 08:22:31 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com>	<20190326182538.GA4096@calimero.vinschen.de>	<20190326182824.GB4096@calimero.vinschen.de>	<c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>	<87y350ytpb.fsf@Rainer.invalid>	<9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com>	<0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca>	<f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com>	<abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca>	<87sgv65eyc.fsf@Rainer.invalid>	<5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca>	<87pnq9jupk.fsf@Rainer.invalid>	<a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca>
Date: Sat, 30 Mar 2019 08:22:00 -0000
In-Reply-To: <a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca> (Brian	Inglis's message of "Fri, 29 Mar 2019 15:48:45 -0600")
Message-ID: <878sww93g9.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00086.txt.bz2

Brian Inglis writes:
> On 2019-03-29 14:23, Achim Gratz wrote:
>> Brian Inglis writes:
>>>> If you are packaging your own exes and dlls with your own local Cygwin distro,
>>>> you should point to your local utility directory with a path in a file under
>>>> /var/lib/rebase/user.d/$USER for each Cygwin userid on each system, or perhaps
>>>> you might also need to add your own production exes and dlls into
>>>> /var/cache/rebase/rebase_user and /var/cache/rebase/rebase_user_exe: see
>>>> /usr/share/doc/Cygwin/_autorebase.README.
>
> I was wondering as my first para above stated, whether rebase_user{,_exe} would
> be the proper place to add 3rd party Cygwin dlls and exes, that are distributed
> with Cygwin (internally)?

Well, if you are distributing something (even just locally), then
preferrably you make proper Cygwin packages and you will never have to
deal with rebase yourself.

The options you allude to above are meant for cases where that just
isn't possible and so you install things without using setup and often
also outside the Cygwin install (permanently, not temporarily until it
gets packaged).  You still need to run setup after each change so
autorebase can pick up on it.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf rackAttack V1.04R1:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
