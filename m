Return-Path: <cygwin-patches-return-9313-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19982 invoked by alias); 8 Apr 2019 17:09:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19973 invoked by uid 89); 8 Apr 2019 17:09:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.1 spammy=ring, HX-Spam-Relays-External:ESMTPA
X-HELO: mx009.vodafonemail.xion.oxcs.net
Received: from mx009.vodafonemail.xion.oxcs.net (HELO mx009.vodafonemail.xion.oxcs.net) (153.92.174.39) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 08 Apr 2019 17:09:35 +0000
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id A0CDCD9AF0E	for <cygwin-patches@cygwin.com>; Mon,  8 Apr 2019 17:09:33 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.221.231])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 6FA1B199C42	for <cygwin-patches@cygwin.com>; Mon,  8 Apr 2019 17:09:31 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com>	<20190326182538.GA4096@calimero.vinschen.de>	<20190326182824.GB4096@calimero.vinschen.de>	<c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>	<87y350ytpb.fsf@Rainer.invalid>	<9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com>	<0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca>	<f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com>	<abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca>	<87sgv65eyc.fsf@Rainer.invalid>	<5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca>	<87pnq9jupk.fsf@Rainer.invalid>	<a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca>	<878sww93g9.fsf@Rainer.invalid>	<97aec921-d9b1-3b0e-de7a-d492832ba481@SystematicSw.ab.ca>	<236d3269-1b0b-9da0-9816-ed84e489f73e@ssi-schaefer.com>	<87ef6jmfwv.fsf@Rainer.invalid>	<437a6a24-4428-ad14-f6bb-16ff23679c30@ssi-schaefer.com>
Date: Mon, 08 Apr 2019 17:09:00 -0000
In-Reply-To: <437a6a24-4428-ad14-f6bb-16ff23679c30@ssi-schaefer.com> (Michael	Haubenwallner's message of "Mon, 8 Apr 2019 15:03:50 +0200")
Message-ID: <87mul0zanq.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q2/txt/msg00020.txt.bz2

Michael Haubenwallner writes:
> Well... once installed, a dll may get in use quickly, because I can not require
> to shut down all Cygwin processes.  So I need to rebase and register the dll in
> some staging directory before it is installed into it's final directory, hence
>  I'm about to add some new '--destdir' option.

I don't quite understand yet what you're trying to do and why, but
"--destdir" doesn't have the right ring to it for my ears.  If I'm not
mistaken you want to strip the staging prefix from the database entry,
which incidentally would be where a

make DESTDIR=/staging install

would have placed the files?

> When I install rebase right within Gentoo Prefix, the rebase db is stored there
> as well, to not cope with host Cygwin's rebase db.  Other than cygwin1.dll, no
> dll should be used by Gentoo Prefix binaries anyway (except during bootstrap).

Since cygwin1.dll is always at a fixed address anyway, then you don't
need to do anything extra, I think.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
