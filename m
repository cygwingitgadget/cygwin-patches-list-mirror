Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id E32BE383E802
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 10:02:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E32BE383E802
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MbBUc-1lhmee2hKK-00bcvb for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 11:02:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4E2C4A80D7F; Mon,  1 Feb 2021 11:02:00 +0100 (CET)
Date: Mon, 1 Feb 2021 11:02:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Align the behaviour against signal with
 pty.
Message-ID: <20210201100200.GI375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210129034544.109-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210129034544.109-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:dvKnZYCYFajNQRxKImqbqs8SGj9avWWBj7j9KbDlxo4cwQb/w5k
 qfVMmuLTEF3BExHIZWeBOb8XD793urHxTkayfuV5v+jN8cTio3oFYyaCqwcrgUIfg57sSZE
 7kXE3tsytg94OTl+6VEUEZ5rRmpVAs66rmfaTwDg5aWuIdluMi82OWM/7IqWkNVyn18TWCI
 qXRwdEs4GV5vn3pZY/2DQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x8FvvTIEAEg=:AjuQKvyfpfw5/70hwbSzE+
 KnHSDwZ7kV8iaJ4D5PVCrkCF2l4X1V0hOSVPZBFJuHVzgQkrAIbvUCubrKalblIJKtPUsd55I
 9hNOSYrGypev8DdpNv+FBI2eOy7hiFSJwsHdK4ilzCvCZ0oz40yOHUChYtrszcvrQo6ZJ8nnb
 BwoayAA6fxESXqa2F8zOt0NQecx3K8G6kn5Km6FJQoqHAQY+pNSnsguk6rdnVhbcVB2gUkvaD
 Q0hA1/MuivkZiLIDUv3KIzrPBi7hQYyMgbSh/mW6ovsiP3/uQhMtmjAUy4XL77FFE23oumsPk
 3sNJFxJ9nSul93FmLA4Dh4Kz8v42m4kaAyx/Zu3BMRzD3dqP9eNvIR1h9Svk6Wz3Cn8EDRIaK
 amCCO6BKi/5zOGRoqe0ljhHdNPOtuV7R/zq2VmQcIBejhmiI37d4EijGuerJLaj640CDFZDhK
 3f4m+kIGvQ==
X-Spam-Status: No, score=-107.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 01 Feb 2021 10:02:06 -0000

On Jan 29 12:45, Takashi Yano via Cygwin-patches wrote:
> - Currently, read() returns -1 with EINTR if the process is suspended
>   by Ctrl-Z and resumed by fg command, while pty continues to read.
>   For example, xxd command stops with error "Interrupted system call"
>   after Ctrl-Z and fg. This patch aligns the behaviour with pty (and
>   Linux).
> ---
>  winsup/cygwin/fhandler_console.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 0b404411e..3c0783575 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -587,7 +587,8 @@ wait_retry:
>  	  break;
>  	case input_signalled: /* signalled */
>  	  release_input_mutex ();
> -	  goto sig_exit;
> +	  /* The signal will be handled by cygwait() above. */
> +	  continue;
>  	case input_winch:
>  	  release_input_mutex ();
>  	  continue;
> -- 
> 2.30.0

Pushed.

Thanks,
Corinna
