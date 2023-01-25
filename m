Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id 3AF183858D33
	for <cygwin-patches@cygwin.com>; Wed, 25 Jan 2023 12:35:58 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McHM2-1oough3gKa-00cgBu for <cygwin-patches@cygwin.com>; Wed, 25 Jan 2023
 13:35:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 446F0A80CAD; Wed, 25 Jan 2023 13:35:55 +0100 (CET)
Date: Wed, 25 Jan 2023 13:35:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dsp: Fix hang on close() if another thread calls
 write().
Message-ID: <Y9EiK9AMeGIf0Jp6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230125105622.473-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230125105622.473-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:JM/2sXBisUm44oj/dKfoA1mAPFnw2+SpiRTO6jx+Rfl09aJSZw5
 G0oaOr5sbh/mYcsiRzO4NbtZCKJF+hf2D4qwWvJVIvCVavpyi6FNRrZKSjkD/a7UuCkjU+E
 mgnz80+nGk4X0AnZ7JwqZh0ItPqN+IqRoaaXkX3juxvJ0gaostzkuf1YtN2lqHoNGYWIyJQ
 3Kvqp+9Myf2PgI0Eim/WA==
UI-OutboundReport: notjunk:1;M01:P0:oAoou+1h7VE=;b1PfQwp1lktHCk1cTJpmr7giTeO
 kaVmPGR8FxaJQKZKRViTD6Eh7BehWJ72q2zPYCQNT6isDH4/eS/iSnRs2qyNR+3XgoD9Z3nNE
 6OEP4RFniPYxSv3tmdNXNoyXc6Noy7boZtVRQpMlaf/BsZj0jWpR1kpkveGUIuhk/l9clACeE
 TTPyo97codlZqANNz378JWMli+8jKNGC9D7dxIVVH9VbV37zchr9AkCOO2HQFRnPEuQWj/eBL
 vvsOprDaOW9Q//XBFENh2+MWuDCozDcw7lPQyuhlvxMVyK64BF5DZyeTPYnG1OXC4jA8PXp8z
 NUgF7fddYO9eZaXVjtk6Z0ScZPOl5/f4PBMyhrEl3N9TcPJmtTA4rhc6BnJ/sT25a4lxhZXkF
 JKDQefGkCa9zc9QznEwOWuhP2DZJ0PP3VnMdEPUROWWiQsLtWMAhaBTc9mKNzqKArb1PNxg0l
 iG2tUWfgsJ25yMFyO0H7OpXIaDrhyFgPbboBKt948axnlBXBR8IZCDGZo651fNAukBGC32TVS
 iU2Pr6FxVrBjhnzNODqAQM4Ezg8Vt0K8Zkape6z6SsZEChIreKhsyOtAUfMMiCf0Vfez0jXu/
 NvSB3taSPWG+GTjYlu7SZS9pn23nUwHPlQ+PIowW+ucNQZReY0fLns+xIIL0lEacusn7U5LRH
 aTQ9xrekQd5FsT0XFEC9JnAV1vYHgLEVP5j63xIUlw==
X-Spam-Status: No, score=-97.2 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 25 19:56, Takashi Yano wrote:
> fhandler_dev_dsp (OSS) has a problem that waitforallsent(), which is
> called from close(), falls into infinite loop if another thread calls
> write() accidentally after close(). This patch fixes the issue.

Sounds like a bug in the application to me, but yeah, patch is ok.


Thanks,
Corinna
