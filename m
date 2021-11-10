Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 635343858404
 for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021 10:35:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 635343858404
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5wc7-1mm9yw298N-007W3G for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021
 11:35:09 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2B4CCA80D3D; Wed, 10 Nov 2021 11:35:09 +0100 (CET)
Date: Wed, 10 Nov 2021 11:35:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Handle WAIT_CANCELED when waiting read_mtx.
Message-ID: <YYugXVHfJ7qmuydm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211110082352.1253-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110082352.1253-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:BQSyZ0rymmgm26H/uZB3/xiDeEmpQiPMvzoIl9LhEu0S9hg3gru
 RUSXw4SK5FDvU6ZbTUGvx6hl4OcOwyVrVGL9CyiXlPPi0dRiguPVDs7wxphlId/r9sziSpc
 xdSgynZfJhk2Fy9lkKz1gBk197EMlIIxYWxwh5qiHKhEw2KFWFtLiI8FfgD5DEEI5qG+iFw
 dZ++R4soKG2UhJnyF7dmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:new6zNLKgkw=:RLLPhZqs9vJI+8wuUedbz4
 2l1ZYsQecv/Kioa3SfnDgd6RCJgPJnbhMlhICNNX6H6iUPbSgjJatheJrk3iyE66HiB3GFKoD
 oy7+HZhpzKw22V7JjNveyjjojOS9eTFci5hfu7FAQ9gMwl/gFT9e90/XdK9/R9xJxKqMzCIYI
 hAl9xG0dZgOXU3WFUtuDCHyJk0yKdMi9azv4UcX5PkLSg3/bEqntvTDu4rWUgzk3OjvyZCZuh
 LPcr4qfRAcxYtuQhYGfiwoYMAAjqkSPWwLL+02EF4DWgS4KQVA0NDbNYBvVaAHTxxR4WnQtI7
 SzYhz3mcfijkT/uB8vEviLd4rWH5jcO3d6+W58kyY3kiayBOwlDHNyP+1R/MiKgDI7riUh9uL
 y1umYN7JyzF+9S2opTEtFwbeRnUlIdTIzh72AAYlMSszgK2yuEFSGmN8KUOkhNT40q//oaf4T
 oZj9NVnkG09+gQ1Gqa3CCdkM81u7+1krmJk4GQdVBizOJczMAmk3CHsKf+CBSp09+l7U7Hpsv
 O0gn+6QKJlVTKh6GagVYvw4owNjcuhVjlauslt1LDtrb1Yyhnk3cjWZepmVyfHGctN6tVeq9Y
 ZSLIz1lET1POq5GwkzlshqpdseQBpRn7KzhOPstD6NiyHtx73iqOJgZheGZjrtJvav11JYFqE
 uNMnorZLtZylFIQC8fmZD8e9q8aEllakF+sGQjbcDyzJCIH7uFv1X8/YD2g+fc0FGTliB70Kl
 0eGVImdMQHuDM1mL
X-Spam-Status: No, score=-105.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 10 Nov 2021 10:35:12 -0000

On Nov 10 17:23, Takashi Yano wrote:
> - Add missing handling for WAIT_CANCELED in cygwait() for read_mtx
>   in raw_read().
> ---
>  winsup/cygwin/fhandler_pipe.cc | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
> index bc06d157c..13731437e 100644
> --- a/winsup/cygwin/fhandler_pipe.cc
> +++ b/winsup/cygwin/fhandler_pipe.cc
> @@ -302,10 +302,18 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>        set_errno (EAGAIN);
>        len = (size_t) -1;
>        return;
> -    default:
> +    case WAIT_SIGNALED:
>        set_errno (EINTR);
>        len = (size_t) -1;
>        return;
> +    case WAIT_CANCELED:
> +      pthread::static_cancel_self ();
> +      /* NOTREACHED */
> +    default:
> +      /* Should not reach here. */
> +      __seterrno ();
> +      len = (size_t) -1;
> +      return;
>      }
>    while (nbytes < len)
>      {
> -- 
> 2.33.0

ACK.  Please push.


Thanks,
Corinna
