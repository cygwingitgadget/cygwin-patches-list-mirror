Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 70728383E802
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 10:02:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 70728383E802
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MjSwu-1lq4Nu0O5K-00l0lW for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 11:02:08 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B9702A80D7F; Mon,  1 Feb 2021 11:02:07 +0100 (CET)
Date: Mon, 1 Feb 2021 11:02:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: exceptions.cc: Suspend all threads in
 sig_handle_tty_stop().
Message-ID: <20210201100207.GJ375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210129034626.157-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210129034626.157-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:+KfNEKUUHqvYeKkjy+gpYZ1ayOgzokNhIBRjftflsmya6Tstc3z
 kBa1QyxcKbt6BibPcsPWhpUh1vZ6UNmNXjkpjsmLDxlC+/SaLtAYW7Jcon8iivztRh9ERu6
 NeEBCRJXN0ppG23yMZ8g3OU5XjUmPyBpmKELbe7n+LJ/oHr1/o8C4zWWeKtuJaga6DAw+Lw
 cVnM7cSlJ0+MF4esMUkFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ipc1uEK4vhc=:id9Lq4S01QEuif20h4Ynm3
 4Iby8plb7UodEmYOnk7wk98vo6cH2jbfDKqsL0bGfrdDhKpynWnIJEEQfk3PqpOik8odDkxST
 IKdKObRGAl6WsCcwaJKSK64ij5/+JY2j2i8wj1+F29n28k04ySu8tHSRt0Xf9GkHGYwMMkOtI
 YIv3/6ksUccYkdVb5P1Ka73NJO/KyJA6yNv+lzL1uWHg9MguyI7Y7bn4Uadh5KqT30SLpuudF
 Rni1Sath4ek7tm8xKfglMG1F+0DNsvDWAQSqVsjcTZ8B4hl+sacSHHxR+ruu0udu+Pbz+YHRY
 Tf4uFQUtWxprDIAjxbrorv0zv+dw1DMB2Y+zhzucljBSekCN7SLdjPhVj456Ygzy6VpIQiESF
 yWhdZ5t9EXH5Pk4TMT1GZ8e/q+svjqXoutOVbYNygiL9/UQCd4mHRbFrrTJdYtVIZhk2EyFrJ
 PzEjjIO4GQ==
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
X-List-Received-Date: Mon, 01 Feb 2021 10:02:14 -0000

On Jan 29 12:46, Takashi Yano via Cygwin-patches wrote:
> - Currently, thread created by pthread_create() is not suspended by
>   the signal SIGTSTP. For example, even if a process with a thread
>   is suspended by Ctrl-Z, the thread continues running. This patch
>   fixes the issue.
> ---
>  winsup/cygwin/exceptions.cc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index c98b92d30..3a6823325 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -902,7 +902,9 @@ sig_handle_tty_stop (int sig, siginfo_t *, void *)
>  	 thread. */
>        /* Use special cygwait parameter to handle SIGCONT.  _main_tls.sig will
>  	 be cleared under lock when SIGCONT is detected.  */
> +      pthread::suspend_all_except_self ();
>        DWORD res = cygwait (NULL, cw_infinite, cw_sig_cont);
> +      pthread::resume_all ();
>        switch (res)
>  	{
>  	case WAIT_SIGNALED:
> -- 
> 2.30.0

Pushed.

Thanks,
Corinna
