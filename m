Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 1C204384A033
 for <cygwin-patches@cygwin.com>; Thu, 13 Aug 2020 08:21:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1C204384A033
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MsIfc-1kzTEX31ek-00tlEc for <cygwin-patches@cygwin.com>; Thu, 13 Aug 2020
 10:21:47 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1D617A805A5; Thu, 13 Aug 2020 10:21:47 +0200 (CEST)
Date: Thu, 13 Aug 2020 10:21:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Change the timing of setup_locale() call.
Message-ID: <20200813082147.GX53219@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200813054220.1844-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813054220.1844-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:z/dr/OIZHozdwhk+PVRnElpwqAi4izgNbCpEzwx3eTfyMhlqdeA
 wGtQ1JK8y3v1kVvPvP1D1Z6hLIYPmnCeaHxpguN5osjTLEQAOifs84zQJlBFqZm+/pPHStd
 6pTKgDWUy0S9yGHzue7y1TLQ5/wC8fFyHETCuNIEEw7Z7yeIY/6xq1e3bV8wW6RKeSxMK99
 tpU5J+6A23KfviIhBCp8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FgM1TVntt0E=:JBj+pd+M3ol92VUH4jCedS
 CgWNa2KO31cDR2ISrvcY9CWx124DIqjjLF/EM0B6ZYJr+dcEKQueN2wtCjGxMo2z3T+d+5WBl
 /jbPvWDtCBps2wfvGRiK79kSe7QG7eyEAAPVywyYytKkKl2icmp9cICMIt2vUClRssxkYvDeW
 2BtMCFfqizG4DHgoTpFzqLCXOQlXH25aCw9dadVc33L+NkN/g/cv9kVLauKTKpsyPeJy1DPQh
 ug5HJoa0dllnRiip9dgf8SiEQ8otSqJisgb+DwiOnrzOMNp2Gj58SsZ9iip2aXRnmsjHSz66b
 rRB/04E2/SMBWS5sHhrazfECkYocUSWPKS+/omTelZ/zpNZSes/000F4byJ/5diaBPXNBoDi1
 k2eoph+cdGx18K67sgTVehtx1iHuE9dnRpuzP+5K5rorwpOORI0zwICW9NmOkAONjrK+EaK7Z
 PSWyJcjv2JEgNxljyOnBbNDtmK0aNlaLAj4TbPny2LGdxKVXrGxt/i64KrV5z2mZAA3EAxKk2
 81G1hxql9rIw7D8D46jPORUaP9dRftDq68jtXi0h/hZakz4GXMb2C5N91e0GNz2affS63N+x6
 ykNloAX4ySSjTCrMCS/MrCGt7e//8KKHweWIc+klUr+rLN/Z4D/IrGKb50Ks2Ix9oUYsa4CCo
 YztnevMeSc8TA551fUlU/+wlqgKCSdmpx9VldN87U6FXi/xpNDpTYHd1OG9NpFrHF/gK01IsF
 gJkHEFiyxlhp3HAaG3KK5HlLKo1q0q4v4Qv6SMTc9xvkhFXv9P4BMTPNjQK7MgZSEOWkmgxzx
 6A02fr6WhHz4yfH9SaLwiKBEX0VwgzyyxATZEz4tK27Ne7apEvUVYnR9Chu2WGraTyrHATVs0
 dRIfD58OAt5Y/HGDmcjA==
X-Spam-Status: No, score=-104.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Thu, 13 Aug 2020 08:21:50 -0000

On Aug 13 14:42, Takashi Yano via Cygwin-patches wrote:
> - If native app is exec()'ed in a new pty, setup_locale() loses the
>   chance to be called. For example, with "mintty -e cmd", charset
>   conversion does not work as expected. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 92449ad7e..40b79bfbb 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2983,6 +2983,10 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
>    // fork_fixup (parent, inuse, "inuse");
>    // fhandler_pty_common::fixup_after_fork (parent);
>    report_tty_counts (this, "inherited", "");
> +
> +  /* Set locale */
> +  if (get_ttyp ()->term_code_page == 0)
> +    setup_locale ();
>  }
>  
>  void
> @@ -3020,10 +3024,6 @@ fhandler_pty_slave::fixup_after_exec ()
>  	}
>      }
>  
> -  /* Set locale */
> -  if (get_ttyp ()->term_code_page == 0)
> -    setup_locale ();
> -
>    /* Hook Console API */
>    if (get_pseudo_console ())
>      {
> -- 
> 2.27.0

Pushed.


Thanks,
Corinna
