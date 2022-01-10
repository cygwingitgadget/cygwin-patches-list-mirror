Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 556543858402
 for <cygwin-patches@cygwin.com>; Mon, 10 Jan 2022 08:48:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 556543858402
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUooJ-1mxfOA3uhl-00QmHp for <cygwin-patches@cygwin.com>; Mon, 10 Jan 2022
 09:48:39 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3A0B9A80D60; Mon, 10 Jan 2022 09:48:39 +0100 (CET)
Date: Mon, 10 Jan 2022 09:48:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: do not build MinGW testsuite/cygrun
 --with-cross-bootstrap
Message-ID: <Ydvy57lXWPeceJ1+@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220110033449.216876-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220110033449.216876-1-yselkowi@redhat.com>
X-Provags-ID: V03:K1:TdhHex1lBN+xiJ/r5YFjLFYljGWBz3M9crlXhSN9FaaZXHfFNmc
 aFtwXpgeMAbxGGpEkpBSgpE/B+US5n7RU5mpCHjE9tWz8So4vZdSsc2Dpme/AnImCXw6U8L
 Z7RZp7AgLYDfFEpU4V5hB6mqQiCYRYrvsYa/Zn4at4395DfC/k8XSNwBWQkCqIyWIOsZaKV
 pNRKJsymtkuLfA1UKXVdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AN+7leHoRQU=:XEjxjDb4nKr7SWzWJRaf79
 LS9hBUIoZSLBH87sNhCAxEoPhv/H5erpHBpWQ+p2eC75JVSyluPtiDjmpsFWRK8sBPfOwji52
 EDLxELNla6GtUOFy03Y5mzVrPQdSBoaSWNM4QAsXb41pqFn6AtD3TIzIiqMIhk06AvBlx4d9h
 4W7267lds0cy8kwYQ7QKi7q2NElhdpPBpwNf76+wzB6H+Z0yZQIstfY1SRuDp4KPTiVr9v0yY
 VNIl2LKjbao+mtzr0kJglTNVB3ZfAIvAyAhst/CYd42HH5Zx5NhyIhz4mpMcUCt00mOZnyrbY
 djv7eIvs/rQ5zNBVdm+/b041f9Qlm3Jr8l5vmPuejnOWLvAW6gONug33TXx7GlT/FGcSrPMmi
 eGJe4ErJLwSyOGeY5YzWrniCy0nhWPdXo7EFWUd5nnmaTG/4K6cZHTRYz55vBnGNibNd7sdIs
 hbXGJdxwMgBNYMZzPdNaE+TT49MCaQr6B+JuHBlYMxnY4c8gurbxODMG0OqfCnPUfYUS4I4hz
 0PzDNL4QI/s3lbLd9WSLFsDeC+VisXZ7VculNLIaDPwmcyEs755uGIGF6+uLFtplnZdc9zsyN
 U3UUNc9twjV8u6O8UxF6nmq2FwnaiFE8H7geY1LaZEnua6eaIy1M7BakZLzmVmgFWySCh5MkJ
 oOCzNa0+WFrPCjQx7p25FDnFzNlLtftEwFok9oRxbelDNxtNmH8ThFjwNPrjG49YIkMF5ck6d
 nHKFe/jGp1e+B4YV
X-Spam-Status: No, score=-93.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_FAIL, SPF_HELO_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 10 Jan 2022 08:48:43 -0000

On Jan  9 22:34, Yaakov Selkowitz wrote:
> ---
>  winsup/testsuite/Makefile.am | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
> index 4b8c7dbb7..ac68934d0 100644
> --- a/winsup/testsuite/Makefile.am
> +++ b/winsup/testsuite/Makefile.am
> @@ -61,4 +61,6 @@ EXTRA_DEJAGNU_SITE_CONFIG = site-extra.exp
>  clean-local:
>  	rm -f *.log *.exe *.exp *.bak *.stackdump winsup.sum
>  
> +if CROSS_BOOTSTRAP
>  SUBDIRS = cygrun
> +endif
> -- 
> 2.34.1

ACK.


Thanks,
Corinna
