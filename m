Return-Path: <cygwin-patches-return-9698-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58829 invoked by alias); 18 Sep 2019 16:22:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58820 invoked by uid 89); 18 Sep 2019 16:22:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=wave, HX-Languages-Length:685, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 16:22:09 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 148E6F34D15	for <cygwin-patches@cygwin.com>; Wed, 18 Sep 2019 16:22:07 +0000 (UTC)
Received: from Rainer.invalid (unknown [84.160.192.162])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 967B419ADAF	for <cygwin-patches@cygwin.com>; Wed, 18 Sep 2019 16:22:04 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Revive Win7 compatibility.
References: <20190918142831.787-1-takashi.yano@nifty.ne.jp>
Date: Wed, 18 Sep 2019 16:22:00 -0000
In-Reply-To: <20190918142831.787-1-takashi.yano@nifty.ne.jp> (Takashi Yano's	message of "Wed, 18 Sep 2019 23:28:31 +0900")
Message-ID: <87pnjxy3qa.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q3/txt/msg00218.txt.bz2

Takashi Yano writes:
> - The commit fca4cda7a420d7b15ac217d008527e029d05758e broke Win7
>   compatibility. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 10 +++++-----
>  winsup/cygwin/select.cc           |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)

It seems like an attractor for future bugs to define the same constant
in two different places.  Would there be a header that could provide the
definition instead?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables
