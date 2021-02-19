Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 949003870914
 for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021 16:59:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 949003870914
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MX0TX-1lNmDU1Y41-00XJME for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021
 17:59:17 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 12EFDA80CEC; Fri, 19 Feb 2021 17:59:17 +0100 (CET)
Date: Fri, 19 Feb 2021 17:59:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add console fix regarding Ctrl-Z etc. to release
 notes.
Message-ID: <YC/uZXo3KdG5QaU5@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210218090242.1507-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218090242.1507-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:MQc6gSAq4d19EiS4Tc5UlELgmf/4CrFFB0X7jNrJgJ06FgKlxro
 U0Mm6QtIq1KrAapzjCDaJY339Ku5VIjcTeHcs825JnZ/P0kH7NgEgokhI7E6/MJhYSdl3/j
 EFkCn7Sej5S8khM/lOIhU3jYp9w1PZTLgifk8ktFworgPqcBkqCGSvAmmbppAPe6MRIzaCp
 BzQmuEng8PcFA5RW9kM4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UAZewj6jN1I=:SHEKSjtkgbqQsF/tWCOI7C
 rMv1x5BtG2PAZ8tSoV0HYvpmY4ijdij4b8GTzlRaoMu9z3PgRXgWFsPfDuMXPCSb+vGV+PfK3
 KdFGVCqjdpi+PvBfzjfy5Cwxfb8M2bvozMLUzYrdsoGd+cmDvsIG2vvWNMM6VSBWDS1me71QH
 LQrGY5BcH8Bii18qK1k62yVXfwzk7DIQ8w7OIN+jjVOIgQtWIEESyinyJHEqFoZumlCy0TMML
 3RJPe1a/UblS94hxepw6HRliA0nZ5gOmGfOkncg7NYuvrPfYg0C3XKNLOKPX2ueGzVi98krEp
 Z20qy6LdpgBBTZzmDA2wUQDEhP9Us4Grjud2mQYjbDVwPW3KOAMfmRIH+ZTkPGJs+fRTGacBY
 lmsGDD8faU6rE9NPEnoIAZJRyh8EsaRn68t4GiRCys4y58CLH2a547GzpmBOSrFJARERXGkem
 2TBzJ3aRCA==
X-Spam-Status: No, score=-107.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 19 Feb 2021 16:59:19 -0000

On Feb 18 18:02, Takashi Yano via Cygwin-patches wrote:
> ---
>  winsup/cygwin/release/3.2.0 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
> index d02d16863..d69ed446c 100644
> --- a/winsup/cygwin/release/3.2.0
> +++ b/winsup/cygwin/release/3.2.0
> @@ -9,6 +9,11 @@ What's new:
>    thrd_detach, thrd_equal, thrd_exit, thrd_join, thrd_sleep, thrd_yield,
>    tss_create, tss_delete, tss_get, tss_set.
>  
> +- In cygwin console, new thread which handles special keys/signals such
> +  as Ctrl-Z (VSUSP), Ctrl-\ (VQUIT), Ctrl-S (VSTOP), Ctrl-Q (VSTART) and
> +  SIGWINCH has been intrudocued. There have been a long standing issue
> +  that these keys/signals are handled only when app calls read() or
> +  select(). Now, these work even if app does not call read() or select().
>  
>  What changed:
>  -------------
> -- 
> 2.30.0

Pushed with a minor typo fix and I dup'ed this text to doc/new-features.xml


Thanks,
Corinna
