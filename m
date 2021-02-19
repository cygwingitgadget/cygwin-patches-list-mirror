Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id E313E398C81F
 for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021 17:06:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E313E398C81F
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mcp3E-1llehQ2Rbm-00ZujJ for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021
 18:06:06 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 31155A80CF4; Fri, 19 Feb 2021 18:06:06 +0100 (CET)
Date: Fri, 19 Feb 2021 18:06:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make tty setting NOFLSH work.
Message-ID: <YC/v/qy/64WZFRA/@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210218090711.1612-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218090711.1612-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:OZciuNl0B3vb/ZKyI7lOGv92HsGUaU5wtne361WJi6jdmSY1gS/
 C+niV2j1TwgoP2TfAjPIs2Pi6wD8GrrVUuU6NMQT1NWpOiJVckPJ8nnx5mvj5a6mdjuroxs
 Gv1Jc40agGHjmJfzrfkDCQemlXpDg4pujGQCKkwlLVv2EUTEB73HGV7HYRTFy5Gzujk5Ghp
 j7kt+iRZRQl2Gh/hkAP4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tmS9acBxHcQ=:RnmLHET5AiDAG9/3RMjCm3
 7cuWwmk/q5BhUpOsQmCldAAEgW3qUhnZrZJs+rf3YiIFJZ5A2ri8vIj3MFqot0hyHxN51EJFk
 O/Sw5X0EZlViOmg2TEb+zkBoh/YnvK23TxQ0NwxAbKh0goLNPovdbITsCykIuzIfukQbk8sd9
 J5s6wpCQcQJb0Cor9G/L89pQi/FJVz2WiA6YEtXeaTh/G+O85Bo3GqcAbZc8S8NDBGWWnnigI
 h93du3BXQsyB2NmUiYG77qSdSB8JRGbviN9TfwvxyPZ0DmdzMydnxcPlEHERketo1BC0BHPvI
 SWO7zIagYj9MvzU2GT3Tdxuyllpe5lNEJEUC4oYSVjt25J4drBZFL4Tk9i0b7D+zL0DWGZ8te
 SJQP7Szdts4ewSblPpvAqc66aN22uqLsEGWz7/kT8sID2GY9P0wvqRdZGL7a6R8MNGCRVU9W5
 CyaC49zBog==
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
X-List-Received-Date: Fri, 19 Feb 2021 17:06:09 -0000

On Feb 18 18:07, Takashi Yano via Cygwin-patches wrote:
> - With this patch, "stty noflsh" gets working in pty.
> ---
>  winsup/cygwin/fhandler_termios.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
> index e8daf946b..ae35fe894 100644
> --- a/winsup/cygwin/fhandler_termios.cc
> +++ b/winsup/cygwin/fhandler_termios.cc
> @@ -332,7 +332,8 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
>  	    goto not_a_sig;
>  
>  	  termios_printf ("got interrupt %d, sending signal %d", c, sig);
> -	  eat_readahead (-1);
> +	  if (!(ti.c_lflag & NOFLSH))
> +	    eat_readahead (-1);
>  	  release_input_mutex_if_necessary ();
>  	  tc ()->kill_pgrp (sig);
>  	  acquire_input_mutex_if_necessary (INFINITE);
> -- 
> 2.30.0

Pushed.

Thanks,
Corinna
