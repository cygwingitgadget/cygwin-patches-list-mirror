Return-Path: <cygwin-patches-return-9274-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68882 invoked by alias); 29 Mar 2019 20:23:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68873 invoked by uid 89); 29 Mar 2019 20:23:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=explain
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 29 Mar 2019 20:23:40 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id B1462C053C	for <cygwin-patches@cygwin.com>; Fri, 29 Mar 2019 20:23:38 +0000 (UTC)
Received: from Gertrud (unknown [87.185.211.111])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 87223300539	for <cygwin-patches@cygwin.com>; Fri, 29 Mar 2019 20:23:36 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com>	<20190326182538.GA4096@calimero.vinschen.de>	<20190326182824.GB4096@calimero.vinschen.de>	<c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>	<87y350ytpb.fsf@Rainer.invalid>	<9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com>	<0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca>	<f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com>	<abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca>	<87sgv65eyc.fsf@Rainer.invalid>	<5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca>
Date: Fri, 29 Mar 2019 20:23:00 -0000
In-Reply-To: <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca> (Brian	Inglis's message of "Fri, 29 Mar 2019 08:42:32 -0600")
Message-ID: <87pnq9jupk.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00084.txt.bz2

Brian Inglis writes:
> Achim, thanks for the clarifications; could you please comment on the suggested
> approach for handling local production dlls and exes, or explain the best
> approach for migrating from test to prod and handling rebase on target systems?

I'm not quite sure what you want to know.  As I said before oblivious
rebase was invented for running tests that use freshly built DLL (I
usually package them before running the tests, so the package will have
the un-rebased DLL from before the test was run).  For this it suffices
to simply feed in all new DLL names to rebase.  If you were to build in
stages and/or combine different builds then you'd somehow have to
remember the DLL from each stage or build, or just collect all the DLL
names again each time you change something.  The important thing is that
each oblivious rebase needs to get the list of _all_ DLL that need to
get rebased, since the database only knows about the host system
(i.e. you can't rebase incrementally with --oblivious).


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf rackAttack V1.04R1:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
