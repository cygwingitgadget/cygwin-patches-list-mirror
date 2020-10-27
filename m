Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 1C9E3389700F
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 14:15:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1C9E3389700F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MTREY-1kwk9B2KoG-00Thte for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020
 15:15:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1E170A8104F; Tue, 27 Oct 2020 15:15:41 +0100 (CET)
Date: Tue, 27 Oct 2020 15:15:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fix return value of sqrtl on negative infinity
Message-ID: <20201027141541.GK5492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201027141037.38881-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027141037.38881-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:lDb3xkIhr/Pw09bK9fk9W56HFr0RsDXrAjaU8PqKsZaAsBEWq1t
 zDeQfX2xWYV9otU0heF5tuEwJys+01WhRF+ZoXJVZ4bYLoFWCHNxQnoi+vyBdjHWPxWL0qe
 1MPjJu1SrRp9SdRg6uc/wZvpFpU5Dc0eQV0VlScC4JPSBVjPgK6BG2tChOuh0vWRBsoG1d+
 mY4Ekt0NqhkhKzFpCeqmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m5O41SWQlmc=:1cRvTT/FtFUpeX3MZIEvVG
 3iegOMcwxzCgdkap0FckMmaC7zL2oOfV6N90X74YLpwEf5FsyF4/pmrp7EAdnYwxNWvgdosWw
 mPslz4AIa+pgZco3+ys+/KSJCS/COWaAnTe0bhtGokHZ+In16AnuqMxhyxffWcROJClKz09Gx
 rCKO8rj8YbmlyyPSwhCyCPBeY7SFsfzgl9+CtUdSToArqkKEH4cZsXXXZ7qd65g15Bwi/Vmju
 jjMEStzMc9dFnuJT32rRXhcjSwboIAYUVgPZxHwa5iR2kmtIz1zbanxWSyQ3Kt0rSRns9xA9U
 Hy78Mt9PoNFv5YjnpjqpaYpY/hhIttisvdeJAKrNJD2z7thdJxne3S2rUcMtnh2GQ/XLhdXwI
 WlUW74C1x4SOWo7792YqzNOEXXL/98ZH9YTSjPMJf4CbRRGMEE/ZiDzDp+JxTttHCKcsF91jp
 9mecktYS3w==
X-Spam-Status: No, score=-106.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Tue, 27 Oct 2020 14:15:44 -0000

On Oct 27 10:10, Ken Brown via Cygwin-patches wrote:
> The return value is now -NaN.
> 
> This fixes a bug in the mingw-w64 code that was imported into Cygwin.
> The fix is consistent with Posix and Linux.  It is also consistent
> with the current mingw-w64 code, with one exception: The mingw-w64
> code sets errno to EDOM if the input is -NaN, but this appears to
> differ from Posix and Linux.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2020-October/246606.html
> ---
>  winsup/cygwin/math/sqrt.def.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/math/sqrt.def.h b/winsup/cygwin/math/sqrt.def.h
> index cf8b5cbe6..3d1a00908 100644
> --- a/winsup/cygwin/math/sqrt.def.h
> +++ b/winsup/cygwin/math/sqrt.def.h
> @@ -73,8 +73,11 @@ __FLT_ABI (sqrt) (__FLT_TYPE x)
>        if (x_class == FP_ZERO)
>  	return __FLT_CST (-0.0);
>  
> +      if (x_class == FP_NAN)
> +	return x;
> +
>        errno = EDOM;
> -      return x;
> +      return -__FLT_NAN;
>      }
>    else if (x_class == FP_ZERO)
>      return __FLT_CST (0.0);
> -- 
> 2.28.0

LGTM


Thanks,
Corinna
