Return-Path: <cygwin-patches-return-9358-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 93489 invoked by alias); 17 Apr 2019 18:58:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93480 invoked by uid 89); 17 Apr 2019 18:58:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=brown, Brown, singles, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx011.vodafonemail.xion.oxcs.net
Received: from vsmx011.vodafonemail.xion.oxcs.net (HELO vsmx011.vodafonemail.xion.oxcs.net) (153.92.174.89) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Apr 2019 18:58:44 +0000
Received: from vsmx003.vodafonemail.xion.oxcs.net (unknown [192.168.75.197])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id DCA383E0398	for <cygwin-patches@cygwin.com>; Wed, 17 Apr 2019 18:58:42 +0000 (UTC)
Received: from Gertrud (unknown [87.185.221.231])	by mta-7-out.mta.xion.oxcs.net (Postfix) with ESMTPA id A7EF4300233	for <cygwin-patches@cygwin.com>; Wed, 17 Apr 2019 18:58:40 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/14] FIFO bug fixes and code simplifications
References: <20190414191543.3218-1-kbrown@cornell.edu>	<20190416112243.GR3599@calimero.vinschen.de>	<87o95435qo.fsf@Rainer.invalid>	<f477bb3d-1918-3b25-9682-a3b187a12dc2@cornell.edu>
Date: Wed, 17 Apr 2019 18:58:00 -0000
In-Reply-To: <f477bb3d-1918-3b25-9682-a3b187a12dc2@cornell.edu> (Ken Brown's	message of "Wed, 17 Apr 2019 17:43:34 +0000")
Message-ID: <87h8awa278.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q2/txt/msg00065.txt.bz2

Ken Brown writes:
> Thanks for testing.  I have STCs for fork and exec that I used when first 
> writing the code, and I forgot to retest those after the recent changes.  I just 
> tried, and the fork test succeeds but the exec test fails.  I'll try to debug that.

Take your time and thanks for working in that area.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
