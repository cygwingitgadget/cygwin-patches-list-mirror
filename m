Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id CDC473858004
 for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2020 10:04:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CDC473858004
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mn1iT-1kMXVb3tWZ-00k6D1 for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2020
 11:04:12 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E81BDA82A8C; Mon, 14 Dec 2020 11:04:11 +0100 (CET)
Date: Mon, 14 Dec 2020 11:04:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Skip term_has_pcon_cap() if pseudo console
 is disabled.
Message-ID: <20201214100411.GG4102@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201214082533.631-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201214082533.631-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:iZ37vkKnLJESUD5c91HGrt8mEipr6Uja9BqP++tqDxf8e89gSTc
 jo/jrn36iYP5/wo9PsWx2gFpOdZNND6JGWKC0vP1jAq4LJmfNReguRMHYSJRMftFIDaCG1b
 2+RgCwMxKx5q4lqynb7Ed2bUY+aIIM5W4dPm1Rv5JpQMlEM8663criZQQGTRm4cmHnZ58nN
 1//nY+IUqpvVrpvCl6Knw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:inFPsQ5ZFy0=:aE0hm0XB35idteCLsq7WTx
 sajI4Kz77km4wyh5MTRXPCPCHrfHV551upA1sedz+xxlqGoZmLmwYqAY2hqdFjDzwgtgkBRlO
 yxh3W+BkUhlGxDzqX6uWUOZTMGz1BIZhjlfnz5GVjfmXswWPqaOC0fHU+ilbbJ+GPCiPquV06
 aBSca0Esev321u8+1xwFn/9tqNpZGWe/GgbBKQPmJKGN5Jk1ee9SuGvWTLQrOOHLtFDUIzJaj
 5pJqwlfRYaKWlVlK0TWzmk9lBOUjV1axqYTODul/EycQG6C41Im8UnS+N4GYeVRp0Wgsq2EPc
 Xu3seLrsRv51BtpAP4tPWedGVvZ/kVF4ZQTbQk5cBcVvrcjGBLeL4K9L+OsmTFXA/rqKrs2zg
 qGkHCjKEGCpJEL9JhDTeY96TXYndhSrrDyB3EvolBlFYHq1rnR7D9cqStRAdFs31UYo7pmUVU
 Aq0Y0eemCQ==
X-Spam-Status: No, score=-106.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 14 Dec 2020 10:04:16 -0000

On Dec 14 17:25, Takashi Yano via Cygwin-patches wrote:
> - This patch skips unnecessary term_has_pcon_cap() call if pseudo
>   console is disabled.
> ---
>  winsup/cygwin/fhandler_tty.cc | 2 --
>  winsup/cygwin/spawn.cc        | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index a6dc8e93b..845e51184 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2459,8 +2459,6 @@ fhandler_pty_slave::setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon)
>    if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
>        && !!pinfo (get_ttyp ()->pcon_pid))
>      return false;
> -  if (disable_pcon)
> -    return false;
>    /* If the legacy console mode is enabled, pseudo console seems
>       not to work as expected. To determine console mode, registry
>       key ForceV2 in HKEY_CURRENT_USER\Console is checked. */
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 83b216f52..5057af932 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -656,7 +656,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>        if (!iscygwin () && ptys_primary && is_console_app (runpath))
>  	{
>  	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
> -	  if (!ptys_primary->term_has_pcon_cap (envblock))
> +	  if (disable_pcon || !ptys_primary->term_has_pcon_cap (envblock))
>  	    nopcon = true;
>  	  if (ptys_primary->setup_pseudoconsole (&si_pcon, nopcon))
>  	    {
> -- 
> 2.29.2

All three patches pushed.

Thanks,
Corinna
