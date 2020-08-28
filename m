Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 4EDD3384C007
 for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020 08:37:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4EDD3384C007
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MpUMc-1kwnoS47BM-00pvXO for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020
 10:37:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 93AA5A83A7B; Fri, 28 Aug 2020 10:37:36 +0200 (CEST)
Date: Fri, 28 Aug 2020 10:37:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigproc.cc: fix typo in comment describing nprocs
Message-ID: <20200828083736.GG3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200827224032.6553-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827224032.6553-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:KFs5+VCqCiTJYHZwaJKDEsN+M+QHGmXS7NRi7YQex36pcjPfvFw
 0HxrJrnLfq2tUiTDaDJYwKrKu648FwFhV7k+LYEl/bQ7uj8jYss8OEbM4mnryLzR/SQSusT
 19weR2rPup8rzTxaovqei0II+4kI8YSKXkwVzLMZmb1Ifl53K7kdGTmevC5x4PlfKaXYimp
 U8wlOE9Ww376mU6/toUzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dGMMEK545QU=:tmZ0W8p4T+wQBp7S4/zHWj
 j5RTpK/XUvs73U0BWcrr0DBTOA+yFSur0jEObr7hz7yScXaoE0r49uZBesp6tOZHWNJnk8d/J
 sEpb52aLF28Ewdxh0MtyiIObvJVEsNXNa3/EtuiRNm/2gNlVIe+f07RG1wL3rVIGnVcZp87tX
 8Uyqe+kusGhn9kTYDnpplB2JfvS6YLiZOXdCR9FywSGyvDW5e2U9NluKoEw+C5gYon+U+DXHt
 5vlwnes+lBOgAzQDa4SSi61Hv2ymKRLoM1rYQbvrvVOEHD2NAw+ManYNTcnsVn6uJ1o5bzsJi
 b7thJZ3W0ZlglvwfhDZZzrH1Wj7bTbkSUPv+9l2KEkBR87IxGHpDpM/sec4vNKBtm53Dm40Ez
 4C+oahYp85f9BDux9PLFjif/pKeu5pybrO3jOP6+rvHOsgfNXOpi1ZCA7RrQ0GtkfVAdAHXtH
 4THeq+77U2PqUsCDnkj8mjqKPwjkTPxslFmCphstg49e3R+aR3tE/WtS96gW+EsGod+qMjx+6
 LPVA+JzPUGayE+d1Bam8X6yqfFM945wYBcqnERNg/uaGrEO+gTiJ+M5CjduPsLN4YvJISf4pz
 6+bOzzCNmp5yHoM942r7PdydfaTWcs9de13gtP4ATvPLtb83EGNa5PeAfqGjleEj6+pptp56o
 W8v9gjPWqWr/c4/vS6H3d+EELT9WjbVk+PDRnviM0k4LrPfKg2IG74oX9PL4U1StetzETViac
 B0GQ5sqNGyxuTxgUXfZcyO9azVzGNxzxXZeuea9PFlpsPB1iG2IPPvN465OSP40kDtVpi6+9s
 1lEDz323fPBLXOuNt9w+rLFE52PTq84MC3dKGli+zBdY1BVDwHzyK/n9fVhEhfE2z75IMKIsq
 9ql0Bys2ADfXK7WkjkHw==
X-Spam-Status: No, score=-104.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 28 Aug 2020 08:37:39 -0000

On Aug 27 18:40, Ken Brown via Cygwin-patches wrote:
> nprocs is the number of children, not the number of deceased children.
> The incorrect comment used to apply to a variable nzombies.  The
> latter was removed in commit 8cb359d9 in 2004, but the comment was
> never updated.
> ---
>  winsup/cygwin/sigproc.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index a5cf73bde..30c799f8c 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -44,7 +44,7 @@ char NO_COPY myself_nowait_dummy[1] = {'0'};// Flag to sig_send that signal goes
>  #define Static static NO_COPY
>  
>  
> -Static int nprocs;			// Number of deceased children
> +Static int nprocs;			// Number of children
>  Static char cprocs[(NPROCS + 1) * sizeof (pinfo)];// All my children info
>  #define procs ((pinfo *) cprocs)	// All this just to avoid expensive
>  					// constructor operation  at DLL startup
> -- 
> 2.28.0

I have this already in the loop together with other changes in that
code snippet.


Thanks,
Corinna
