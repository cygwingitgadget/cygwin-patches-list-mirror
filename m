Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 524343870914
 for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021 17:05:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 524343870914
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRn0U-1lJ5Dj0FkA-00T9Ef for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021
 18:05:57 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AD567A80CEC; Fri, 19 Feb 2021 18:05:56 +0100 (CET)
Date: Fri, 19 Feb 2021 18:05:56 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Reflect tty settings to pseudo console mode.
Message-ID: <YC/v9DL2XE2Wkl1g@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210218090539.1560-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218090539.1560-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:b89A/aiXiQ0P295dub0Ys1uGYFT6dV8kBUkffDeNFkLplwhEQlS
 Vnt0qmYVh2HE0SNMywlJz5SddySVQZV9TMFDD2LHCgcz+6MiFDRAJJawmqTquQlwU3+5OWQ
 Mg7TovcGsoCU6rUFSZWbcnAr22bHu3Aaz8qZeej3LeOeeZwDKa3jpuPmJ0dJMSLe3cDmQxu
 lA0p7x3e4xfTjMXIhmhng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FAtHFQZMlkc=:15eULouXy42X0eDR9j7+Mh
 f4YBau5ZdrBoGM86RwScyBCZS2dfVQ8hWfZQ8ftvGOsRIE4XhVeuupnTx4fMDsgXLmQkgiCFl
 C+n+gsL+nWkXufxk0V4aTlsvgvjQpuhLrEaShSl7AqcJqjQ2t3yYd5LONZJgfZbGJdI2hO92x
 +T+y8Sa74UOOiVQLunz249hODqahwMS8WXIioQjwJCk+s/I8a1HULVw+aRvM9emvu7/CgK8YP
 uVkfhw4uC0BmoCuQJKl3KTI5aAfxv3/j6+ngqt1wHm/OKprjCPVS/NyW7MT41RvEtBqGSryjb
 brSn0Qrh1cZlVDDI+U2TlUkM03zAO65REptBTbhmi5eLeJ5wpJmKR66nj4CX/YlP3jDUgk/JM
 VX/vIYjilfcJpUW+oWxw1L3Am9cAznjweHOxaagVCfZtrdFDrJ5G9KI2eKn6WbrpQxxGBhL0s
 82JEbq+Hkw==
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
X-List-Received-Date: Fri, 19 Feb 2021 17:05:59 -0000

On Feb 18 18:05, Takashi Yano via Cygwin-patches wrote:
> - With this patch, tty setting such as echo, icanon, isig and onlcr
>   are reflected to pseudo console mode.
> ---
>  winsup/cygwin/fhandler_tty.cc | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 5afede859..e4c35ea41 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -3261,6 +3261,33 @@ skip_create:
>    if (get_ttyp ()->previous_output_code_page)
>      SetConsoleOutputCP (get_ttyp ()->previous_output_code_page);
>  
> +  do
> +    {
> +      termios &t = get_ttyp ()->ti;
> +      DWORD mode;
> +      /* Set input mode */
> +      GetConsoleMode (hpConIn, &mode);
> +      mode &= ~(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
> +      if (t.c_lflag & ECHO)
> +	mode |= ENABLE_ECHO_INPUT;
> +      if (t.c_lflag & ICANON)
> +	mode |= ENABLE_LINE_INPUT;
> +      if (mode & ENABLE_ECHO_INPUT && !(mode & ENABLE_LINE_INPUT))
> +	/* This is illegal, so turn off the echo here, and fake it
> +	   when we read the characters */
> +	mode &= ~ENABLE_ECHO_INPUT;
> +      if ((t.c_lflag & ISIG) && !(t.c_iflag & IGNBRK))
> +	mode |= ENABLE_PROCESSED_INPUT;
> +      SetConsoleMode (hpConIn, mode);
> +      /* Set output mode */
> +      GetConsoleMode (hpConOut, &mode);
> +      mode &= ~DISABLE_NEWLINE_AUTO_RETURN;
> +      if (!(t.c_oflag & OPOST) || !(t.c_oflag & ONLCR))
> +	mode |= DISABLE_NEWLINE_AUTO_RETURN;
> +      SetConsoleMode (hpConOut, mode);
> +    }
> +  while (false);
> +
>    return true;
>  
>  cleanup_pcon_in:
> -- 
> 2.30.0

Pushed.


Thanks,
Corinna
