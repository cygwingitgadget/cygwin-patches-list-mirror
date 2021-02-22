Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 9BC483890418
 for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021 09:51:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9BC483890418
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8XHV-1lrSzB1mLZ-014S54 for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021
 10:51:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E9824A80CFE; Mon, 22 Feb 2021 10:51:19 +0100 (CET)
Date: Mon, 22 Feb 2021 10:51:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix segfault caused when tcflush() is called.
Message-ID: <YDN+lx5V2I3W3bbw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210220224516.1740-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210220224516.1740-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:dyxiA4Q1g48m8bHzd9bPY8E6ZdyYalohn1XkkhzDLOS6IZLUVnE
 gHI4Zv+0hRxrwPplM1Y8LzNKrjHCupHj4pV77IhDZHe6LNPo3cXG5zWzErwt7xbF/iRTMIn
 iaMnYdSP+hjgaK5Nye149eIZJqBCwUBKELO3OfEpHNfzOrs7xnJzzOHrV8f5BeHcmldGlDU
 3chF3A/P5OWgnLDA68NuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WtPtDzUwqWE=:gNW7E0JZ5L3YWlpd9p7IST
 7ZtzSFAVyjDI13tQXeCBDFSRNstHvuKgdgXiJbriwsQZwZsgKTfUh/XyGg4RboF1iavwbpwbJ
 KVVdgi/tSfZBq3raZT17Qmf4KDGFU7dNYT11z7lntyJ9PqWP9VQ5FGvU6uK798T0sxyH0v+pG
 IMVXE8Jb2VzXF8+1A+nAV0ZguRVAhhIYEjk+mDxI6SlvjMXTT6kacv9+RBFKc5QstrsHKC+20
 KRl4QXtwOZCU9Vntxu0laf9asqOwh696X7I1RLGgBoxLKHXkfBFp55CXKvV4ve0yZwHhdhDut
 2pq03mvBnU5jAD1m6Um0TTbUTvtTHi8jhbqK7NtpDL0wgBInZJhTBDzJuiHBgJr+wqI3pVN5B
 G6x0wId73v7PHE7YezM+b2JQHp2xOkZYggBzJXIHAROHfyRWZ5TRTR75JaVsx+M21HXLXE1N7
 6InNXgMU1w==
X-Spam-Status: No, score=-107.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 22 Feb 2021 09:51:26 -0000

On Feb 21 07:45, Takashi Yano via Cygwin-patches wrote:
> - After commit 253352e796ff9ec9a447e5375f5bc3e2b92b5293, mc (midnight
>   commander) crashes with segfault if the shell is bash. This is due
>   to NULL pointer access in read(). This patch fixes the issue.
>   Addresses::
>     https://cygwin.com/pipermail/cygwin/2021-February/247870.html
> ---
>  winsup/cygwin/fhandler_tty.cc | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index d30041af1..3fcaa8277 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1474,8 +1474,11 @@ wait_retry:
>  out:
>    termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
>    len = (size_t) totalread;
> -  bool saw_eol = totalread > 0 && strchr ("\r\n", ptr0[totalread -1]);
> -  mask_switch_to_pcon_in (false, saw_eol);
> +  if (ptr0)
> +    { /* Not tcflush() */
> +      bool saw_eol = totalread > 0 && strchr ("\r\n", ptr0[totalread -1]);
> +      mask_switch_to_pcon_in (false, saw_eol);
> +    }
>  }
>  
>  int
> -- 
> 2.30.0

Pushed.

So, what do you think is the state of the console code, Takashi?
Shall we start a release cycle next week?


Thanks,
Corinna
