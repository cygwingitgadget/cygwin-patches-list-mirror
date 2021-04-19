Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 6223F385E013
 for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021 14:19:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6223F385E013
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N1PLB-1lfLR23hDn-012sbt for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021
 16:19:48 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8A111A80EC7; Mon, 19 Apr 2021 16:19:47 +0200 (CEST)
Date: Mon, 19 Apr 2021 16:19:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix a bug in the code to fix tab
 position.
Message-ID: <YH2Rg7NdcSwK3ZtO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210419103151.21887-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419103151.21887-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:yeND7qBNmz86bpT9sihihTxdJ1kNGMb4MHXN8ru16AU0SoNawcZ
 6+6Gaq8VwI/qtEQjxjkJKh4tORSYyxkJLkHgJ62SbPvHOPCrvxDlxLaPCiuxTyXBYgqXNH/
 qGLwwt0lAigwvpmStxdzzjYJyhPJAMsSVL6RHKRtDO8ImhGRk3WonLakp4C/pZuAiKY5y59
 U6HpUfH4D+0YJg+5q7r0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t1E3bs50McU=:GfxH1cvyOqXjbjm4AQIVx9
 RLaZJSqa60CrR8TvR8Q2zFmdhVoeLyo2S5GLmjAFmhgCBf/qzpJww0xig8YLMc8UgGv+9Y6Yw
 Rn0VQDy+E+ozHSl4oNLL7Q+mZH1sjr67jY2bRvuSYgOlgTqdqD9x5x+U4pwsVfT06tOHHGVIG
 ZBb4nYTqMO0G9WyqMQQh6547X1hKsVzrqrvBLeV/X4z6mNxL8mDVFZwp9rsGadtEgEYWmeFeC
 W/5HtxX2pJ3D4rhOhcDCv9G3JDmgSMaFH+L+prWMyO5HRb4bqEgnJgbYAxva18Woo58I/6qC6
 kwJCbQvPI/J49ahN1zRaBsaP06q/uOxYbXiwzgoErrr/jmPRGdOf9Qq7drdaIpM/ow+vMd7qf
 UdSu4dQVfBiEBY6iuFc1G5qH0EGfZ3fHf3Jt2m2UaVisUNQAm2tevr60GC3avxRQRsscp8GNy
 Su/zUAkuBC6CIkrPiWc/nmKt2f94cp/UND3jLRN/xxmP6l+7twzuSatHMrRmn8AeuR/N8guA+
 4Au+moby0dIP3nNtJ2yZ0g=
X-Spam-Status: No, score=-106.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 19 Apr 2021 14:20:00 -0000

On Apr 19 19:31, Takashi Yano wrote:
> - With this patch, a bug in the code to fix tab position after
>   resizing window is fixed.
> ---
>  winsup/cygwin/fhandler_console.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 43e404ed6..0812e91f0 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -308,7 +308,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
>  		      /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
>  			 fixes the tab position. */
>  		      set_output_mode (tty::restore, &ti, p);
> -		      set_input_mode (tty::cygwin, &ti, p);
> +		      set_output_mode (tty::cygwin, &ti, p);
>  		    }
>  		  ttyp->kill_pgrp (SIGWINCH);
>  		}
> -- 
> 2.31.1

Pushed.

Thanks,
Corinna
