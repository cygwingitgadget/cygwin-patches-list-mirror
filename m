Return-Path: <cygwin-patches-return-9739-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30110 invoked by alias); 6 Oct 2019 06:38:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30100 invoked by uid 89); 6 Oct 2019 06:38:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.1 spammy=Emacs, H*f:sk:82d83d7, H*i:sk:82d83d7, HX-Spam-Relays-External:ESMTPA
X-HELO: mx009.vodafonemail.xion.oxcs.net
Received: from mx009.vodafonemail.xion.oxcs.net (HELO mx009.vodafonemail.xion.oxcs.net) (153.92.174.39) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 06 Oct 2019 06:38:01 +0000
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 4E3EC6055E2	for <cygwin-patches@cygwin.com>; Sun,  6 Oct 2019 06:37:59 +0000 (UTC)
Received: from Otto (unknown [84.160.192.162])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 207FC605E2D	for <cygwin-patches@cygwin.com>; Sun,  6 Oct 2019 06:37:57 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, flags
References: <20191004104457.33757-1-Brian.Inglis@SystematicSW.ab.ca>	<95be25ec-eeea-060e-fb40-ed5c7fc787c1@cornell.edu>	<82d83d79-b194-107c-3ff4-6b02e36ea198@SystematicSw.ab.ca>
Date: Sun, 06 Oct 2019 06:38:00 -0000
In-Reply-To: <82d83d79-b194-107c-3ff4-6b02e36ea198@SystematicSw.ab.ca> (Brian	Inglis's message of "Sat, 5 Oct 2019 15:42:02 -0600")
Message-ID: <87a7aecrb4.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q4/txt/msg00010.txt.bz2

Brian Inglis writes:
>> It would be easier to review if you would split it up into smaller patches, each 
>> doing one thing, to the extent that this makes sense.  For example, the 
>> simplification achieved by using the ftcprint macro could be done in a single 
>> patch that's separate from the substantive changes.
>
> Unfortunately, that was added later to make the got it/add it/skip it flag cross
> checks in Linux order more certain vs my own sequential tabular source.

I usually use Emacs/magit to split up a bunch of changes into a more
comprehensible series of commits post factum, but there are other ways
to achieve that same goal.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables
