Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 3266B3870883
 for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021 09:57:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3266B3870883
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MiIhU-1ldcx701pu-00fObj for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021
 10:57:43 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2922FA80D4B; Tue, 19 Jan 2021 10:57:42 +0100 (CET)
Date: Tue, 19 Jan 2021 10:57:42 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Lessen the side effect of workaround for
 rlwarp.
Message-ID: <20210119095742.GO59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210119092702.1339-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119092702.1339-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:nJAZL0tH2KCyQ9XjghO9/sCqP3fygew4KEV0SWew+AtWkSQd0Q2
 4gy7ynaOYfC9LSXoIGbXLV7bZ1oxCoIocvbGKR6Za8pATfijxEXBdfKJxOrtkxe3P0B04zG
 U7qOiTcWZMe6AjD8AwAwE4dqLQ4rSQVjtnAQ9/5lXRSMggv5fRwt1kHx67zZwXuXQN9tW8T
 FvaT7gw3Sfj236sJNjkCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dRxTCHZWC/A=:SZLbAJW90aoJmMd27mlmte
 LbPb7c2tWYhvHG0XvM4HS18RT38hPpQWwQ0Iq+ussKpuI12N3D0xM7yJCYgSJOoWyAtC2sTmy
 Y1RndROBoS8ibUrNZ+wP9mu0NeUdOik4q8mEFxiRJ8CYHlmxYA5VWSAhv1L8a6kLqO/RWuLTX
 JjDK8dJfXj0AKJr63K1ssBZ9xop493sy5TpYiHZ/luWW2Tq2mlH/PCH7oHq4eWxNuVnOP1JxM
 3MOdbxZGC5eYcAxXctmHhUacsuG1Do+A9WuMNdKD7DMuHbZjhqME0O3xLRf/BiM5GRLE+zNeh
 0I5oqBziae29KT2CsDm0lre9jvHt7aFNJNvwEcbnGZ3aJewGK+zbagNGnSYVkU5mW/3eGBhvm
 8255SMjJLXwq49y3Vc3KoHU9dv8cnVpxRAJb037zIOXkRHkp+FIs2/coTlXdx3TbkGA7KY61b
 xUSb2dORsg==
X-Spam-Status: No, score=-106.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Tue, 19 Jan 2021 09:57:45 -0000

On Jan 19 18:27, Takashi Yano via Cygwin-patches wrote:
> - This patch lessens the side effect of the workaround for rlwrap
>   introduced by commit 4e16b033.
> ---
>  winsup/cygwin/fhandler_tty.cc | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 473c0c968..c78e996e8 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1176,11 +1176,19 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
>  {
>    reset_switch_to_pcon ();
>    *t = get_ttyp ()->ti;
> +
>    /* Workaround for rlwrap */
> -  if (get_ttyp ()->pcon_start)
> -    t->c_lflag &= ~(ICANON | ECHO);
> -  if (get_ttyp ()->h_pseudo_console)
> -    t->c_iflag &= ~ICRNL;
> +  cygheap_fdenum cfd (false);
> +  while (cfd.next () >= 0)
> +    if (cfd->get_major () == DEV_PTYM_MAJOR
> +	&& cfd->get_minor () == get_minor ())
> +      {
> +	if (get_ttyp ()->pcon_start)
> +	  t->c_lflag &= ~(ICANON | ECHO);
> +	if (get_ttyp ()->h_pseudo_console)
> +	  t->c_iflag &= ~ICRNL;
> +	break;
> +      }
>    return 0;
>  }
>  
> -- 
> 2.30.0

Pushed.


Thanks,
Corinna
