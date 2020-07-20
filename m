Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 936FA385DC0F
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 08:07:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 936FA385DC0F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlsWZ-1kfsXa1FMR-00iy2i for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020
 10:07:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B2DADA8092C; Mon, 20 Jul 2020 10:07:42 +0200 (CEST)
Date: Mon, 20 Jul 2020 10:07:42 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix a bug on redirecting something to
 /dev/pty*.
Message-ID: <20200720080742.GF16360@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200718044848.1085-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200718044848.1085-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:zh1xfUiwPpNg5da0jEhuQt3ywAFt+g6mXrlbwonBuYNOMn5vGYH
 7a4Pmvh7ECIYpGpRK1XFPvL67g9FTbD4HTjZrrkIYxz7m8UJqK7YIYSL6n/1/R+ljbwEzJF
 sF0f1JbPOGApZ2pY4FBerc7IG4/bfeQg7HFEbl3c1xDfNtCWZVXgzOvTwlNjlvqIMlwBVA6
 1ptagroPCDzr1Uji3VssQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R5PDIcJ6SgU=:gRLRf+YZQimaIbsVSe/PXh
 6VugVe5OUMORqESUWbxu1mqGWQb9vIpKdweYNqjDiopX8jV5owkV2qXXdIYD/EiooPPA6PSFZ
 hWzQJoJgJovfQAvmnPZ3MWkqsQoK3xD2cTQ51AXSBAfjBdcKkWxafBVMzK/KKiHl55kAhX3mw
 ZbSxotIdRMCF93u5iY98KgG2rsuASXdXz46UhLZCyKVrskGOPEu+gbiu0ep0tfXCGXZWbFqmz
 v2zKLxR+hyBNcptKzqrj9cT4I27VMpnVp8q1E4YOQlqiLoFqzn/gZ4kj9Q9+IRSzaHLwj1uK6
 H9wHcjQPWscKF0HNKLMepNCIeotHmO7LBU4cZ1wrB8RoNF+vgTxcUiI8ierTHxZXYoIstSi7h
 Xm8RiOVXgQFLxw1XsTJyENlaXok3fkaewIRs1isAlBx/mHTc2wcyrCle19srSUTMfDO59zFMQ
 j3BgAaxon8Ru+uJpbG8DJbEqV/Hoffl1tv0/z2Q21gLZca3T8o0qlKkzftQTvuxUD2nL+A+z8
 WQzb6XG+ikI0l2R1Mo6a16iQyf9yN61/+ubPH1QsbRr9ugKO8mHI81Yr4ImoUTPaJc/CLvuGy
 AjCYzwvtxQ4u608nq3ifUK9vTGtpzsAERuvPUG+QwLcpgLN0fFEgOc8plpRcQG9YeSjSiXvVe
 6AvjNaAk0WzpzmNlaruDNyw3cObwBX0ZIvPEvVjD4E7xibszVCpczH8YjJ47Mxnv5FRHgSsKJ
 umqoTulPbHvwaAkoebjQ6tSnSn4n2erneUcfklftHWpveycrStjjSd1ZsbYX4oprSogIBA4EI
 jdBqPSKpTIlFc1IwB3poMNFMvNUYjt0Mdpul5nUWiFdcnvxqaE9/OanNVl/cbREOlwVC9m83H
 6yhKKGQFwhR3fVcv+2Lw==
X-Spam-Status: No, score=-104.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 20 Jul 2020 08:07:48 -0000

On Jul 18 13:48, Takashi Yano via Cygwin-patches wrote:
> - After commit 0365031ce1347600d854a23f30f1355745a1765c, key input
>   becomes not working by following steps.
>    1) Start cmd.exe in mintty.
>    2) Open another mintty.
>    3) Execute "echo AAA > /dev/pty*" (pty* is the pty opened in 1.)
>   This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index a61167116..6a004f3a5 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -969,11 +969,6 @@ fhandler_pty_slave::open (int flags, mode_t)
>        init_console_handler (true);
>      }
>  
> -  isHybrid = false;
> -  get_ttyp ()->pcon_pid = 0;
> -  get_ttyp ()->switch_to_pcon_in = false;
> -  get_ttyp ()->switch_to_pcon_out = false;
> -
>    set_open_status ();
>    return 1;
>  
> -- 
> 2.27.0

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
