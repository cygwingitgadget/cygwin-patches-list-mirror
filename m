Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id B05493857C76
 for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020 17:36:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B05493857C76
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYvoW-1k6fuo2EPw-00UpvM for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020
 19:36:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1EFBCA83A75; Wed, 26 Aug 2020 19:36:06 +0200 (CEST)
Date: Wed, 26 Aug 2020 19:36:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-ID: <20200826173606.GP3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:GxH2XB+XtsdH5ax8+bBLH1xMXq49V0BAPSTtD5o2McsZSJ373Mh
 nSkZ+EsAyAHArPld/AnSHMty84TS7ERlIGYUeuMZV6UQ4pKOP6J+jddF40eHtSkovOUNsIb
 SAxSxO5X8LHUrUnoFeyKTLY7pLW2k3Ub8zHyIDXM1VO2uXKxzF0mFIW0jRaBp4MdbbhR0DK
 2VYQv9yHjtKj3J/gishYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6fXoMRddP4o=:jtu/vwhXAVrtFNWqNRvo+j
 /fEF/Qb7ovI5pT5fnHIvZcCQ2qQ6ZxP8bD0leiRClmNe7gM/7j7Bc6fpxojHaWRVlS27QnnHX
 /EPOgv7N8jegDQkrKrzaoCoZTM7kS1jll3m199qHV/qkaFMI6sUCOSmNjOEYNO7YQaqb47u5c
 MR11OcU1Cmoh2wxxR1jBzzBkqCSoY6cWMjLO7kCOzdg1vubI/ZxmwGqfGcm8vbfmSV8YGFeVj
 L+FJl08KF8RAkFuk6KXVNbjDlmdFCn6nZwxJzZ1Y4oPRfwbduuVqFh2YWo1DLQIV2JrRHu71I
 Lm6QzMrYt/bHpnACnXp8CcbbqSKC4LgyUlyobct58VPaSj9yEN2a1Clbe8qgFNf6PEnyU5OEr
 /mUGLmL99VuB3m7YXDCq35vNquTg5QzIb3DGdszi0+xm1XPQaVz21ggKio36wR8gwB61b5rf1
 tCokB/cjKEkWBpnQbrGf8mhGsr0ohyOCj5DOASTE1pPLsGaIQCf1NdjQLDuYL+cM3BOyoPRqs
 FBQGYlkpG2btXYkCtxnqhBEm2tR42BOcqvLFy7Sss8wAuyNrkeMTW32En4QbEseFy7kYkK4jp
 7U3yxG9GyCg3E0l8iU2U07U/LMjJRofRHJENXQxEpx4xpvZ0n5R6weVl+Ngvqtuf9WICcXQSN
 Y2Rs/dEGW5fkjPZJvNjUs5N8nPmQjMe6eObZEfdErsWIU7HQGJs7B8A7n10PpyRYg4e5XZJcz
 4ECoGiBS3G9oUl34FcphfeswUsqB5IZ7kJhlyJ0jdU4zqAPPTNNkKXsDL9KtROPZxQ8K/Yi3C
 r2r6MhuKKxl/GOJG/SWyEcLluG4l6VFS69A/fDPeO3coiFpTCi++WH0Jw2HwJuWcTSP9meFOd
 33/e+v9MJc1KDeynCQAg==
X-Spam-Status: No, score=-99.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 26 Aug 2020 17:36:09 -0000

Hi Takashi,

On Aug 26 21:00, Takashi Yano via Cygwin-patches wrote:
> Pseudo console generates escape sequences on execution of non-cygwin
> apps.  If the terminal does not support escape sequence, output will
> be garbled. This patch prevents garbled output in dumb terminal by
> disabling pseudo console.

I'm a bit puzzled by this patch.  We had code handling emacs and dumb
terminals explicitely in the early forms of the first incarnation of
the pseudo tty code, but fortunately you found a way to handle this
without hardcoding terminal types into Cygwin.  Why do you think we
have to do this now?


Thanks,
Corinna
