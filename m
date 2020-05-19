Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 386DB3840C10
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 13:28:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 386DB3840C10
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUXlA-1jSCd104ga-00QPxz for <cygwin-patches@cygwin.com>; Tue, 19 May 2020
 15:28:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id ACCAEA80F7E; Tue, 19 May 2020 15:28:50 +0200 (CEST)
Date: Tue, 19 May 2020 15:28:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make system_printf() work after closing pty
 slave.
Message-ID: <20200519132850.GY3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200519113600.467-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200519113600.467-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:zQ67r9qp7B0iZR9VxuXvXBn+oLFwJgalf55TExsh6hsa5OswztV
 nRSQFk2+J2458kDyQujuePEedcpej27yEg9k1URbTCYnTbXoDwWj293m5PLOleJS3tAu/1R
 QmF0lpgCfdmILYrtlTZx+A7tFesBO351SjEYL2j2gODbkIaEzf3avG244y0n1IpDclxBqi7
 MtFADprmnxdiQ+3eV0Akw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GCrHOs93mVo=:BSSkK5XzqLFB+IBuu8kDJg
 2I/vBq7dA5bkGy3x/z+zcCmlVDKAbZ2w7tBvsatBEQrg+oS2rGXnHKKZshmkn9bL056jv76n5
 Ztp/b9fysea4xrOOtblC7MkweAavZoE7wvyrIpUFykwHqtnMkDdLaDIu2PNHhEuq4s1NSYdfU
 nwP5Ng50fcuVvEPQ53jlumD3k/A4hfGHlCjUiEV00bS1c0rD1JL/YgX0ogi+ue4ZA8Ezp6vh1
 PbYsFVkDqYCEndVsJ/I/X69tH0Wqr5EOZ35MhDiLWx5UpQoVHs9LJsscLmua9g1TFIIufmvoq
 9Ur/QadNI2ZuTcFxI02AOqoeOEsE29W6oMs9+AJTU8ppv2gRj4yTOJEYzl+QTeBb84nOiuING
 Dnkg1U+W7bmylmSPowlNi0yIGeEbpjf73gY6GtAwW0vYzgY86WfN4MgEQcXxTFnAoqZEpeXB0
 ByJ70vOBTAPDJsXNkLHsXU2nBgekxqfja5ex3M9q7TM7pUfjxcCCJfaEjzUhot5tUuzuX8eMB
 XCurBoCJQ9eJVNgQXQp2qgadP6s3PALxgWBntv8meXBM6WksbESVuN52+m1lg1GsHGcuWOVFb
 PACIZKsEr1GNkrlvvJnBnJs9twILxdpRRiLmXi6otrfzdC5SCMppOLKVM6Z8aH7zDqov0R4HG
 0r/HbJSsQCHOEw92zPknj22tfzaiXJJ1w6D3wONbvN2zxy6gPMu1MgpIa7fu1vhw/Yyo4cc2W
 ZqBom5zQnmZOicnmP8Il2EjZDch9yj5f2VTTgZWEsPXgOkI4Oj/q0Dl9yUXvoQJCor6JQWuma
 yEuoB3xqdfTvJjRi511hIDBUF/4VWjemxsAoq10DiHlNNs8DzgXqnR09ypFGNBJSQkUQXj0
X-Spam-Status: No, score=-103.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 19 May 2020 13:28:53 -0000

On May 19 20:35, Takashi Yano via Cygwin-patches wrote:
> - Current pty cannot show system_printf() output after closing pty
>   slave. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 5a1bcd3ce..02b78cd2c 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -948,6 +948,10 @@ fhandler_pty_slave::open (int flags, mode_t)
>        init_console_handler (true);
>      }
>  
> +  get_ttyp ()->pcon_pid = 0;
> +  get_ttyp ()->switch_to_pcon_in = false;
> +  get_ttyp ()->switch_to_pcon_out = false;
> +
>    set_open_status ();
>    return 1;
>  
> @@ -1008,6 +1012,7 @@ fhandler_pty_slave::close ()
>      termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
>    if (pcon_attached_to == get_minor ())
>      get_ttyp ()->num_pcon_attached_slaves --;
> +  set_switch_to_pcon (2); /* Make system_printf() work after close. */
>    return 0;
>  }
>  
> -- 
> 2.21.0

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
