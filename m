Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id ED8E43893649
 for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2021 09:35:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ED8E43893649
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N79dk-1lvCEV2TZU-017XPb for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2021
 10:35:03 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1D011A80BC1; Wed, 17 Feb 2021 10:35:03 +0100 (CET)
Date: Wed, 17 Feb 2021 10:35:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Introduce new thread which handles
 input signal.
Message-ID: <YCzjR33VcmA+vTCc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210216113705.1358-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210216113705.1358-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:xSEpFiCf+NfK5LpcU9+UasHA7KHPSESZa6ePGbnED+HYMaLR1jK
 RWuy11BMnjAhx1Iq/h6h1GmjEWx7rJZD7PuIOwdgwVCdStqhrE8reQukBeUnxtssDi47Vin
 aoJh4sYIMqcdKvSmPUoz22gj/yeqH1mQU8jSpP9ZomdljxKSNRyNejUwFbnSOP0ZDacy6mm
 Ol5SWp3xsj8s0zjuyT5tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yll38O8jGKw=:kSTR3MgEaiRDRouE4N6W1d
 /Lz0wL5f3HVc404gfcPoIwN5eYM+U9aWtOvirlwpOrkpkOUN+Oojg0DarCuQKmJFbgU9X7+R6
 9+2DjtjeS8ru2XXIPjY+6ZPDPwahqu6pqzA5bH8sOBJzqcuDyKtKKC/b+sEGDWh/jeyAaM6cB
 FcRKm0T6dqPU1BBmyRagsjdVS2PCjrr8oY/F8aTuuvolUU7hNaVjPRiGL9tkXtQqiTPy8Vk4U
 80PAcMLy0F8XCbJ9fIGQO0XJmCrUXDbYXlOW7MTh/7mO44VvAKfAOrW4bcL4OOqwhyvlJ4tUI
 RtS2rvksCKnmkYQiT5rq2SlqjsHi42PA0ub6KDH8Kh627w+gbWlonJTN9nG9IAobkSM2jpAxU
 u6SYRIHfrQ3dKVgtknjxvMSmO2vyVNfKQWOu9jKj3eKqyI83qtgoj3q2OMnP7IsOgYx6M1Aqs
 AE0n5jxqBw==
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
X-List-Received-Date: Wed, 17 Feb 2021 09:35:08 -0000

On Feb 16 20:37, Takashi Yano via Cygwin-patches wrote:
> - Currently, Ctrl-Z, Ctrl-\ and SIGWINCH does not work in console
>   if the process does not call read() or select(). This is because
>   these are processed in process_input_message() which is called
>   from read() or select(). This is a long standing issue of console.
>   Addresses:
>     https://cygwin.com/pipermail/cygwin/2020-May/244898.html
>     https://cygwin.com/pipermail/cygwin/2021-February/247779.html
> 
>   With this patch, new thread which handles only input signals is
>   introduced so that Crtl-Z, etc. work without calling read() or
>   select(). Ctrl-S and Ctrl-Q are also handled in this thread.
> ---
>  winsup/cygwin/exceptions.cc       |   1 +
>  winsup/cygwin/fhandler.h          |   5 +-
>  winsup/cygwin/fhandler_console.cc | 177 +++++++++++++++++++++++++++++-
>  3 files changed, 181 insertions(+), 2 deletions(-)

Pushed.  This is great!  Can you please add an entry to the release docs?


Thanks,
Corinna
