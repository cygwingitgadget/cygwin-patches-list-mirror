Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 0C176385843F
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 09:21:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0C176385843F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MoOpq-1nztyv40O8-00omnD for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022
 10:21:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D0EDAA80CE4; Mon, 28 Feb 2022 10:21:32 +0100 (CET)
Date: Mon, 28 Feb 2022 10:21:32 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pinfo: Fix exit code for non-cygwin apps
 which reads console.
Message-ID: <YhyUHPKAQkHi3uQT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220227004607.2051-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220227004607.2051-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:tXV2I8Gr2b3uR6oit/d4pzf6kARrNkQTNcInmZU2j+Ib9ZnpmgM
 Cgoq2L2/yCCSn4ocSta0Wxxqy7CK8h5dpC43pn88Fr0ppX5Tda/qhrMmjGvn9TkhIqJQuYl
 PaLx6W+2PzY6AUIgK2BRpjZc0mCwa1dynf9AQQ8ZRskz4Q3mqnVQIOgXzL4RSnBHYM1M02r
 /ZL7q+AdYQWJxEXbEEO9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oLekFS6z24s=:735pn6vg3Z7goa04MZBS+Y
 YJefSxBRalMJxkJQ3tjlj9LCdq96YcotAIf3cCy6Heisid+aKMly0onbrpJhqSEaw+wBYsTkE
 A3xt/P/8ybLwNMYkiiIGb+2p+TfeopOIaVHTucKWH6jZ6HKuh8MtUdxxBR0cF+IQKsnjp8SHV
 YA/8JaWtLRw5Y9WC9xq3x8YbGM0xMnJUg0Kp6qlA5xt3yGY0arkk3USB9Cn0uPYuR0M9nC4d8
 PGQ+QF/AoGoO2uecxG6/U9ZRtB3bESrsx5FVQZHI+609rWJbJaFu05I8xllOCeR9zlcDS4SIB
 gCiFH8fQMykiy1kCbn7I5lJ2g69J3w4853EEajw4s/XpVJQsDtdaWV2ItAmpScv6JXRQbT6Yd
 Cuam7tVJj1w5mBvRqyKbJ7XI3GMYFjk35XlQw5rw/FU1t3TYec80rLRMP0FPaeinpmuYGaI6V
 Rgn0nT47UTRmSpoXKbzaeutN/0uz8FVbDTOlBjzAV6qCUwqxBgBO+BwobeEAQVm1gsdAa8wh9
 CREhvZL6x8PCsgrpOR0C7lLGcoSWynRzzS1YHna5QGA8qIVz6kHMkvI+Fn7Co7POf2gX7JlEc
 ouUUO8GAQ6+vQxV4MkS5cIh6ehB7ch8ja27pRNpwr7ixxMt6apyV/0UJCnWciFLJN2732C8Ey
 mSOl3NyOHrM5fpE1b6npdquck5qIacfAQlcf/oUsHxuTlYB1X62MDIQ4MjuHyQzj+jhLwuy21
 ZAHfc2z6BpXwfrwz
X-Spam-Status: No, score=-96.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H5,
 RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 28 Feb 2022 09:21:37 -0000

Hi Takashi,

On Feb 27 09:46, Takashi Yano wrote:
> - The recent commit "Cygwin: pinfo: Fix exit code when non-cygwin app
>   exits by Ctrl-C." did not fix enough the issue. If a non-cygwin app
>   is reading the console, it will not return STATUS_CONTROL_C_EXIT
>   even if it is terminated by Ctrl-C. As a result, the previous patch
>   does not take effect.
>   This patch solves this issue by setting sigExeced to SIGINT in
>   ctrl_c_handler(). In addition, sigExeced will be cleared if the app
>   does not terminated within predetermined time period. The reason is
>   that the app does not seem to be terminated by the signal sigExeced.
> [...]
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -953,7 +953,15 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	  if (sem)
>  	    __posix_spawn_sem_release (sem, 0);
>  	  if (ptys_need_cleanup || cons_need_cleanup)
> -	    WaitForSingleObject (pi.hProcess, INFINITE);
> +	    {
> +	      LONG prev_sigExeced = sigExeced;
> +	      while (WaitForSingleObject (pi.hProcess, 100) == WAIT_TIMEOUT)
> +		/* If child process does not exit in predetermined time
> +		   period, the process does not seem to be terminated by
> +		   the signal sigExeced. Therefore, clear sigExeced here. */
> +		prev_sigExeced =
> +		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
> +	    }
>  	  if (ptys_need_cleanup)
>  	    {
>  	      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,

Is it really necessary to run the InterlockedCompareExchange in a loop?
What about

  if (WFMO(..., 100) == WAIT_TIMEOUT)
    {
      InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
      WFMO(..., INFINITE);
    }

?


Corinna
