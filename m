Return-Path: <cygwin-patches-return-9248-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53920 invoked by alias); 27 Mar 2019 19:59:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53909 invoked by uid 89); 27 Mar 2019 19:59:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Spam-Relays-External:ESMTPA
X-HELO: mx009.vodafonemail.xion.oxcs.net
Received: from mx009.vodafonemail.xion.oxcs.net (HELO mx009.vodafonemail.xion.oxcs.net) (153.92.174.39) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 Mar 2019 19:59:36 +0000
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 232B0D9B085	for <cygwin-patches@cygwin.com>; Wed, 27 Mar 2019 19:59:34 +0000 (UTC)
Received: from Gertrud (unknown [87.185.211.111])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id EC911199C3F	for <cygwin-patches@cygwin.com>; Wed, 27 Mar 2019 19:59:31 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com>	<20190326182538.GA4096@calimero.vinschen.de>	<20190326182824.GB4096@calimero.vinschen.de>	<c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>
Date: Wed, 27 Mar 2019 19:59:00 -0000
In-Reply-To: <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> (Michael	Haubenwallner's message of "Wed, 27 Mar 2019 09:26:46 +0100")
Message-ID: <87y350ytpb.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00058.txt.bz2

Michael Haubenwallner writes:
> As far as I understand, rebasing is about touching already installed
> dlls as well, which would require to restart all Cygwin processes.
> As the problem is about some dll built during a larger build job,
> this is not something that feels useful to me.

That's exactly why I introduced the "--oblivious" option several years
ago.  It'll let you rebase a set of DLL while benefitting from the
rebase database, but not recording them there, so if you later install
them properly there will be no collision.  I needed this for testing
newly compiled Perl XS modules, but you seem to have a similar use case.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables
