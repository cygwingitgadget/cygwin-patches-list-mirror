Return-Path: <cygwin-patches-return-9215-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17617 invoked by alias); 23 Mar 2019 17:17:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17605 invoked by uid 89); 23 Mar 2019 17:17:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,KAM_NUMSUBJECT,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:448, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 17:17:41 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 48C23F34AE7	for <cygwin-patches@cygwin.com>; Sat, 23 Mar 2019 17:17:38 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.218.207])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 12AC519AD89	for <cygwin-patches@cygwin.com>; Sat, 23 Mar 2019 17:17:35 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca>
Date: Sat, 23 Mar 2019 17:17:00 -0000
In-Reply-To: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca> (Brian	Inglis's message of "Fri, 22 Mar 2019 21:45:22 -0600")
Message-ID: <87d0mh5x3u.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00025.txt.bz2


Hi Brian,

replacing one lie with another that is less easy to spot doesn't sound
the right thing to do.  How about ps if reported "N/A" or something to
that effect instead?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Samples for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldSamplesExtra
