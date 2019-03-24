Return-Path: <cygwin-patches-return-9229-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3381 invoked by alias); 24 Mar 2019 08:18:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3367 invoked by uid 89); 24 Mar 2019 08:18:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,KAM_NUMSUBJECT,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:824
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 24 Mar 2019 08:18:29 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 44E17F34C32	for <cygwin-patches@cygwin.com>; Sun, 24 Mar 2019 08:18:26 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.218.207])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 1902919A7BF	for <cygwin-patches@cygwin.com>; Sun, 24 Mar 2019 08:18:23 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca>	<87d0mh5x3u.fsf@Rainer.invalid>	<20190323183653.GB3471@calimero.vinschen.de>	<874l7tbfh6.fsf@Rainer.invalid>	<4dfdfce1-245d-98fe-0c49-890ba8ec8dd4@SystematicSw.ab.ca>
Date: Sun, 24 Mar 2019 08:18:00 -0000
In-Reply-To: <4dfdfce1-245d-98fe-0c49-890ba8ec8dd4@SystematicSw.ab.ca> (Brian	Inglis's message of "Sat, 23 Mar 2019 14:37:40 -0600")
Message-ID: <874l7s65yv.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00039.txt.bz2

Brian Inglis writes:
> Are there non-startup system processes for which boot time is misleading?
> If you need the truth use wmic, procexp64, or run ps in an elevated shell.

I don't seem to get my point across.  I'm fine with getting no start
time value when that ps wasn't able to obtain that information.  If we
have to use magic values to convey that information for one reason or
another, then I'd rather opt for one that is obviously pulled out of
thin air than for one that I have to compare to some other stuff before
that becomes clear.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables
