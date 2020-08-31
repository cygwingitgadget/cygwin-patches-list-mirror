Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 8D2D83851C17
 for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020 14:48:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8D2D83851C17
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdNHa-1km5rA0oiG-00ZQ4U for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020
 16:48:20 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8823BA80797; Mon, 31 Aug 2020 16:48:19 +0200 (CEST)
Date: Mon, 31 Aug 2020 16:48:19 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix a bug in the code removing set window
 title sequence.
Message-ID: <20200831144819.GA3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200831120213.1706-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200831120213.1706-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:2vH7jXyHNeFWTcCJgmuo8T1f458Xg01uxXbgaOWbiqQOK5UpKVn
 wir2oLdb5RGOfkClo2eg0PVQh4vGiXZ5zfJOC7ZEAebg3vbrr+Xf3skiZAA8k6L4XfJjqB0
 yGQ24tmXgHC1I1USGIpAxiU6977DsvEnaHdqQIOG8eXwaRQ4caKx7gkkAaPwrHL8CCu9igW
 c1D9kMuFf8jgEyVZVzDgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lXhvq7WhZaA=:a7s4s+YofhYci3hvFh6NnS
 cWf1VTe8PqlFjY2UzAXtwJN/klz7GMLO9PFyrDJvEE4dFKxVmtif6rEfWDaay7XJuENk3xRXs
 19fxVMLL5jJaPPFHaQiTTJlGqqlZw387Q3/XcgnvvZ/4yC67+QOLYhkee6YqFnJGrHJfxcN8B
 TYHlHLRVlvzkUWPB+Hh4K3rXJHqS2hdmuaWXT3ftVge8VKoHgSGGDd8dVtjBieB44vsKSlZXe
 68hsjtqXnhL9FxhtfToZLfJDFF3+eTPKrKwPRvJ2tRnVHnQyLLb2QxcVaqVK9vYsjsZ98YUCM
 w/+J3n4meJwEfEfZHuxScEcTP634hYyAaYgjGUz2iIMOkUR9VYETpG0MRuuGRhN+VZMoAx/QI
 48ogSGBVFnGN1hqbTymTZJQTQpyMn9qPgscRPqk3DCshFEUQN3fvYGBY6yw+7gimZW0wS2WG7
 y+IPaiwYPBw3g0yfaCjwjoR6vEPc2gSH4ZF6olxszzD8oY2+4T0ZTCvCjRBfad2yRHAISHLrj
 9dCUgdQKQXE07ZuTLhsnGQF1JMuspQrKmEoC8J4aHhjjugF95jxn498nB9ZJUyQE9UPcXQOlD
 UBDnOV+Q9/Xus2f9bENw0a3Wt5qTQyv94x7efJKYS8hx61pLrWoj2COXl+sK3chJl+4DxNHQi
 lMxqpMaXXLLc425WLlVNwlgg2hkQy4JK5UNiODq5whx2P0QGeW0U8kiOWHWZqO1W8zo1KpLIV
 jSp/1cgR24H+3RCaf/j4prHv5sxaVym/GOwJj0RZkXasJEUYMJh45kb9NHQ0ztND1+IUHlu2t
 D/hJ2lcRO1gs1X2WTsCD5X8yPQkbvHLDDYpkzXd/nixNE3FKk9TPkmucNj5ylRCx3Ct8T79k6
 WVIyfNdv5GkSZ4ouev7g==
X-Spam-Status: No, score=-105.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 31 Aug 2020 14:48:24 -0000

On Aug 31 21:02, Takashi Yano via Cygwin-patches wrote:
> - Commit 4e08fe42c9f3fdba63a57a8e3a6d705c4e10f50f has a bug which
>   may cause infinite loop in pty_master_fwd_thread(). This patch
>   fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index e4e94f114..8bf39c3e6 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2168,15 +2168,12 @@ fhandler_pty_master::pty_master_fwd_thread ()
>  	      /* Remove Set title sequence */
>  	      char *p0, *p1;
>  	      p0 = outbuf;
> -	      while ((p0 = (char *) memmem (p0, rlen, "\033]0;", 4)))
> +	      while ((p0 = (char *) memmem (p0, rlen, "\033]0;", 4))
> +		     && (p1 = (char *) memchr (p0, '\007', rlen-(p0-outbuf))))
>  		{
> -		  p1 = (char *) memchr (p0, '\007', rlen - (p0 - outbuf));
> -		  if (p1)
> -		    {
> -		      memmove (p0, p1 + 1, rlen - (p1 + 1 - outbuf));
> -		      rlen -= p1 + 1 - p0;
> -		      wlen = rlen;
> -		    }
> +		  memmove (p0, p1 + 1, rlen - (p1 + 1 - outbuf));
> +		  rlen -= p1 + 1 - p0;
> +		  wlen = rlen;
>  		}
>  	    }
>  	  /* Remove CSI > Pm m */
> -- 
> 2.28.0

Pushed.


Thanks,
Corinna
