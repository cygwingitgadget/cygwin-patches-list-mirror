Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 4C1163939C04
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 14:03:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4C1163939C04
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQeI4-1l4Um70Jrq-00Ng8j for <cygwin-patches@cygwin.com>; Mon, 08 Mar 2021
 15:03:05 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9B2F0A82675; Mon,  8 Mar 2021 15:03:04 +0100 (CET)
Date: Mon, 8 Mar 2021 15:03:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Attach to stub process when non-cygwin app
 inherits pcon.
Message-ID: <YEYumE2YRiE6TnVh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210308131458.1736-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308131458.1736-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:/fjf392vYF4vBAu0lGIaiORLFLTysaLHs+eub0cjVMfJzxm0egH
 Ep4MgOwZZ35iAmzHS5JHkCYAR2lpaNjpFZNgtFiv1Oj8UgadYkAI9VSks2/MZHgQdrZOkuD
 c26j6Dq8Kvlp7HEB+uj+qTBVdmAy1csvwb3ZU23MxgKNM8kGxDwTV8oRfxGE7HRz9fxBldF
 piSAX5ByfWhhxYGm++GlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dotw4VJdTDM=:ZV7+/Q45lETQhf7bjbB4Yl
 SwN1kueVt7F/WHQha5eL2SCOHlcXDJNB3lWcC8eZZ9+EFkCIlCieVL1617Jt7L1Jppee30KmY
 46t98dXrxj9BpShZzzRhygkmrjH4h6eIlF8k3eQ/9UHFny2CeGm9LXYzyoiPtBSrziRbd91Mq
 QQlN88ExdZ1gGDU77SVL0SkTbEwOgH6mjkz/yfUVu0mmtRHHIjuzlVcKUv6w7MdhFAxbNgbZc
 Ls2CgAfSDT8V9BkD0wedFMhCMWVoIUNE/E0L/0qX8lQAk/skzh4GjOim9u1HR7zb1mKDPfubz
 gJDKH8lbfFGDTR1lcBM8GoCuP3m+6MDwIUEAhwItYR3u+Zpu1B7LVQLRRMDj6awhFWLBTI3HB
 o01TUul0VEqwBdRBzrj+EhZBFqhLpSmk0SUPByiaz2yQwEOQeEid0yVbl7nnJ4WyvEmr4sz3U
 Ww/AtVo3Fw==
X-Spam-Status: No, score=-107.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 08 Mar 2021 14:03:07 -0000

On Mar  8 22:14, Takashi Yano via Cygwin-patches wrote:
> - If two non-cygwin apps are started simultaneously, attaching to
>   pseudo console sometimes fails. This is because the second app
>   trys to attach to the process not started yet. This patch avoids
>   the issue by attaching to the stub process rather than the other
>   non-cygwin app.
> ---
>  winsup/cygwin/fhandler_tty.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 4358bceec..3bfc8c0c8 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -3104,7 +3104,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
>  		       0, TRUE, DUPLICATE_SAME_ACCESS);
>        CloseHandle (pcon_owner);
>        FreeConsole ();
> -      AttachConsole (p->dwProcessId);
> +      AttachConsole (p->exec_dwProcessId);
>        goto skip_create;
>      }
>  
> -- 
> 2.30.1

Pushed.


Thanks,
Corinna
