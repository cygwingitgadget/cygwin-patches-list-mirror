Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id E790F3950C1A
 for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021 12:04:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E790F3950C1A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQvH5-1lYOWk42EB-00NwB7 for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021
 13:04:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4B3B5A80D37; Mon, 15 Feb 2021 13:04:41 +0100 (CET)
Date: Mon, 15 Feb 2021 13:04:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Abort read() on signal if SA_RESTART
 is not set.
Message-ID: <20210215120441.GL4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210214094250.1245-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210214094250.1245-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:o5t4bErFeGh6eohCqPmEvAwP7tKraQKeMI7lrvbiKpxTF96Ttlk
 kYtbFO6zIGGqpQD/qtveKmYGUKhrP1u00ur0VlWLGAz+trq5NPUNcOt53KpUIV8i2FKWjnk
 gRdvUb/TMiNTKZ5AG5yeC7Pp15Ac3iSaUHC5oNbWJoBgE2Czbzve9c6orkyoZN7RsasFirS
 IRar7vyr53sCr8Pt5tsnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1EyxgPSXm2E=:OE0PBEY1+z4rV5g7+zzugk
 gTqUFWdrZrX9rmOZbHEpYEr7ZfYIuvN9gjcqFxiP8xP+2ghbM2ZE+Yxqn8GJeiSt8YrwtEA25
 s3j1UMJL68Wbozvp82/zZmrfaySVTNKWDRsZUNk02FJSnJFTm4SWiaWytREzsZhN3RNacwCJw
 S6ULqQ9Ulb3yH12zVb+xPI3HpvLzVs2MoP3kL8q5qviTZjml/jxSoRv0qO+XrCBaVtRTwWZol
 ho1Xv9Il+4dvw1Zyz6tjarbGauucWA5IVGM3ZUatsPviOWZJ8WJF7UWCPoMFKiqFztKWm6P0e
 n3FH++i7meGPjyNOUM8lO6wT3jjYnWIHiaKeElNL2y97MFfVo1fWXXX6jJ1kfwdtohNubnLN/
 KsHnff0RRqfbIEkAFYTvrN66CUQ3l8dCOGMU9frfm2sg8pm/zHjmVevYkMDswH5CL2t1Zisud
 CIOQnbZEvg==
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
X-List-Received-Date: Mon, 15 Feb 2021 12:04:45 -0000

Hi Takashi,

On Feb 14 18:42, Takashi Yano via Cygwin-patches wrote:
> - Currently, console read() keeps reading after SIGWINCH is sent
>   even if SA_RESTART flag is not set. With this patch, read()
>   returns EINTR on SIGWINCH if SA_RESTART flag is not set.
>   The same problem for SIGQUIT and SIGTSTP has also been fixed.
> ---
>  winsup/cygwin/fhandler_console.cc | 7 +++----
>  winsup/cygwin/fhandler_termios.cc | 1 +
>  winsup/cygwin/tty.cc              | 1 +
>  winsup/cygwin/tty.h               | 1 +
>  4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 3c0783575..78af6cf2b 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -586,12 +586,11 @@ wait_retry:
>  	case input_ok: /* input ready */
>  	  break;
>  	case input_signalled: /* signalled */
> -	  release_input_mutex ();
> -	  /* The signal will be handled by cygwait() above. */
> -	  continue;
>  	case input_winch:
>  	  release_input_mutex ();
> -	  continue;
> +	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)

Shouldn't this check for last_sig != 0 first?


Thanks,
Corinna
