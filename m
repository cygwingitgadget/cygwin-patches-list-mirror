Return-Path: <cygwin-patches-return-9217-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82382 invoked by alias); 23 Mar 2019 18:41:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82371 invoked by uid 89); 23 Mar 2019 18:41:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,KAM_NUMSUBJECT,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 18:41:49 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 42CA5F34C9D	for <cygwin-patches@cygwin.com>; Sat, 23 Mar 2019 18:41:47 +0000 (UTC)
Received: from Gertrud (unknown [87.185.218.207])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 13E3419AD90	for <cygwin-patches@cygwin.com>; Sat, 23 Mar 2019 18:41:44 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca>	<87d0mh5x3u.fsf@Rainer.invalid>	<20190323183653.GB3471@calimero.vinschen.de>
Date: Sat, 23 Mar 2019 18:41:00 -0000
In-Reply-To: <20190323183653.GB3471@calimero.vinschen.de> (Corinna Vinschen's	message of "Sat, 23 Mar 2019 19:36:53 +0100")
Message-ID: <874l7tbfh6.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00027.txt.bz2

Corinna Vinschen writes:
>> replacing one lie with another that is less easy to spot doesn't sound
>> the right thing to do.  How about ps if reported "N/A" or something to
>> that effect instead?
>
> 1 Jan 1970 may also be a good hint...

Well, that was the point: I can deduce just from that date that ps
didn't actually get data for the start time.  If it starts replacing
this with the start time of the system instead, it might take a while
for me to see what is going on.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptations for KORG EX-800 and Poly-800MkII V0.9:
http://Synth.Stromeko.net/Downloads.html#KorgSDada
