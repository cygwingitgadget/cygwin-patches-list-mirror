Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 29C273836C62
 for <cygwin-patches@cygwin.com>; Tue,  9 Mar 2021 10:27:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 29C273836C62
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N0nvJ-1leHFk3D2z-00wkyl for <cygwin-patches@cygwin.com>; Tue, 09 Mar 2021
 11:26:57 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2D532A80D38; Tue,  9 Mar 2021 11:26:57 +0100 (CET)
Date: Tue, 9 Mar 2021 11:26:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Transfer input only if the stdin is a pty.
Message-ID: <YEdNcdqs8MVBWFM6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210309032334.1197-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309032334.1197-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:XefxTq3Ip9gWilJ9Zdk3d1d7Xf+O1QzEqTQywMog3XYwLM2CXr6
 8dem4Z+n1bsPjaswI3zAEd9bBzyNFrK7wWzdvCAYU7jFDQDCoVUtJcDieOoV6f1iwgBiG+i
 uDDjbMykz+1nHRotjaWAfF4XL6/2qMvEXNkABfGx/ernwfD4MIYvi3hN0Kzqp6s7OpYIbvq
 7I2XOdV8s/XW0a2fnFBhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:STvPDzAMiZQ=:hPb4qqIeo3sPBj160a5Pyd
 l1Y4y4ZVZPlaGcvAAF4gTdLXNrBKFi4G9+/B6lkZ7OkwpRkyzRt3MjrFVDLF5jVGob9tY4nbW
 4YhcvqpP11Nvc8DB0L4UzYdKvOYvy1tyO8JQeQ7UhToF7Ap0goYy5txp8RVLvuU3J91o0crQM
 fbXON1i0eih0Y+tZCl/W7UohYavoOAo302hJLhUf9iPHNTreGHSoRK4yqnwQCXxbgu8qSBj1R
 lLC4Cfp+VcFl22pdZ573jVCQrRzCO0Kr3lkNM4flaAUxWXIYPvogdtfOu/R3iTowU8uHQxTm4
 xJ7E2A/9m0csyZMODJWNF2ug83HFKFbNe6F0gzh58jlwsXV0Tqwd8/zk6gxRxGsy2YEFvpTxa
 JaSxJrPajycmWnNfxEpxrPVYSXVg535pxcy/JQmzvIBB1B+C903heytqb7cRMz7ZGwNP7pHLH
 Cv0zeTBS5A==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 09 Mar 2021 10:27:03 -0000

On Mar  9 12:23, Takashi Yano via Cygwin-patches wrote:
> - The commit 12325677f73a did not fix enough. With this patch, more
>   transfer_input() calls are skipped if stdin is redirected or piped.
> ---
>  winsup/cygwin/fhandler_tty.cc | 10 ++++++++--
>  winsup/cygwin/spawn.cc        |  9 +++++++--
>  2 files changed, 15 insertions(+), 4 deletions(-)

Pushed.


Thanks,
Corinna
