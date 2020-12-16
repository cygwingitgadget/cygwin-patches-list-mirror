Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id A64193844011
 for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2020 09:40:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A64193844011
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMXYH-1kZAvO3XWR-00JdY1 for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2020
 10:40:01 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D42D8A82BD8; Wed, 16 Dec 2020 10:40:00 +0100 (CET)
Date: Wed, 16 Dec 2020 10:40:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Revise the workaround for rlwrap.
Message-ID: <20201216094000.GG4560@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201216091058.1938-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201216091058.1938-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:5lGVq04+33uqfJuyuQNh0l6MpAQwVjjBmSLh7fQa4Un9F76uhw0
 cg1f/2X0oq6R75V749rmpga0LtZo8NU/vXtp6pw8zV/qWNs7/v59Qymvh7OR0KE/LoDKj3O
 fxB4qwRjkO9ON4UW3YIB6FCUhrfmfZhksUv0NWXU29nMuaiH03kZycmTXfM39FtiA1q3xPL
 WP1ZOrBKyZVvXTR2+vUMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jgl6lghdbng=:trEvThe9jYG+e7M0+wpwOh
 6DoV55tYv7QxuvFWleQjzFXNGawIGOVdCgCvVW5pfcP/ipEs5kug9fqmYa8moOJkOL75pzZyU
 Ic52jC6EFKZkS5r583JTvTuPLNtAsLjxU9g1yH8yqBWAEF6TQhz5ZvRfPencKdX0SAosBF4cU
 U9bGCeMUEFriYggSY2dj2ZynFp+pHCI1i8LJGsicClHhqMFwrNiQ3WuvTVQwF0W1Yv+2PO+nT
 O92PR2Obg6wshT7BTOj0Cx4ODVKKCpeILuDfueA0ReCR/W+XvJAU3x5L76YWwPWNpx4ahfON7
 3nAmmwZ8lkpl5GBr16zcxfmrYBuompLIqQLrdmF1EBmc1AhNJBdgAcIEo9GjREdKvT7nBT9Zy
 tS8BQFeYla3Bu25q5eYKp+0ggaazoDDgGGcDCA9xHVmZLm5cI+yyL89JFgc4TtRl8o+Al8pXM
 8+IDk9DbrQ==
X-Spam-Status: No, score=-107.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Wed, 16 Dec 2020 09:40:05 -0000

On Dec 16 18:10, Takashi Yano via Cygwin-patches wrote:
> - Previous workaround has a problem that screen is distorted if up
>   arrow key is pressed at the first line after running "rlwrap cmd".
>   This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 77d9d9b47..77f7bfe43 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1111,8 +1111,8 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
>    *t = get_ttyp ()->ti;
>    /* Workaround for rlwrap */
>    if (get_ttyp ()->pcon_start)
> -    t->c_lflag &= ~ICANON;
> -  else if (get_ttyp ()->h_pseudo_console)
> +    t->c_lflag &= ~(ICANON | ECHO);
> +  if (get_ttyp ()->h_pseudo_console)
>      t->c_iflag &= ~ICRNL;
>    return 0;
>  }
> -- 
> 2.29.2

Pushed.


Thanks,
Corinna
