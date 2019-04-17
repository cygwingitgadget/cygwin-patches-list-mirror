Return-Path: <cygwin-patches-return-9356-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55339 invoked by alias); 17 Apr 2019 17:24:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55066 invoked by uid 89); 17 Apr 2019 17:24:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=our, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx011.vodafonemail.xion.oxcs.net
Received: from vsmx011.vodafonemail.xion.oxcs.net (HELO vsmx011.vodafonemail.xion.oxcs.net) (153.92.174.89) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Apr 2019 17:24:05 +0000
Received: from vsmx003.vodafonemail.xion.oxcs.net (unknown [192.168.75.197])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id E9AD53E0239	for <cygwin-patches@cygwin.com>; Wed, 17 Apr 2019 17:24:02 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.221.231])	by mta-7-out.mta.xion.oxcs.net (Postfix) with ESMTPA id C273C3003A8	for <cygwin-patches@cygwin.com>; Wed, 17 Apr 2019 17:24:00 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/14] FIFO bug fixes and code simplifications
References: <20190414191543.3218-1-kbrown@cornell.edu>	<20190416112243.GR3599@calimero.vinschen.de>
Date: Wed, 17 Apr 2019 17:24:00 -0000
In-Reply-To: <20190416112243.GR3599@calimero.vinschen.de> (Corinna Vinschen's	message of "Tue, 16 Apr 2019 13:22:43 +0200")
Message-ID: <87o95435qo.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q2/txt/msg00063.txt.bz2

Corinna Vinschen writes:
> Pushed with v2 of patch 13.  Developer snaps should be up shortly.

I gave the snapshot some testing today.

The good news is that the named FIFO branch of our code works correctly
again and is faster than going through pseudo-file STDIO pipes.

The bad news is that there is still some problem that seems to hit while
forking.  I've got an empty stackdump file from sh (which gets used when
exec'ing due to the way perl implements that) a few times and also one
error message about a terminated thread due to "Windows WFSO error 6"
(hilariously the output file was produced correctly in that case).  But
most of the time the processes in my data pipeline would all have execed
correctly, but then none of them ever gets runnable again.  So this
seems to be something of a race around the exec.  If I kill the stalled
processes and start the same commands again, then everything works as it
should most of the time.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptations for KORG EX-800 and Poly-800MkII V0.9:
http://Synth.Stromeko.net/Downloads.html#KorgSDada
