Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id B84C13857003
 for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020 12:41:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B84C13857003
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MPoTl-1jyOGQ3AHb-00Mr7f for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020
 14:41:29 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0F385A83A7E; Sun, 30 Aug 2020 14:41:29 +0200 (CEST)
Date: Sun, 30 Aug 2020 14:41:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigproc.cc: add comment
Message-ID: <20200830124129.GO3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200829100157.27707-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829100157.27707-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:5V3q3l9Xn5VgZell1L70WLeVwLYk2/LalFnjp0hDywYUe7MZbhM
 SCbWqhGcug6DqQbJ7QlS/zHVlYXc+CoOgr9IwZtseJc/bskQJyxAl7S8JLqtndrGa7yQWhi
 YLTpruSxREd+sDyxOo96V+jvQz4/UPmL9PnzSVig1JDTn740xcurvyJPQBcDThDptLFUqUk
 R9I9yy5WfgY2LefAFTMcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SEfVZLXofHE=:zElaha89N47UZ30SE2+OjC
 lN3bNPwLfOgm0mORlAhCTmaIk6BRUfzdmf6IMW+vtIEXUyI+/+ds0O02FfcP6d6ED5WAv6U2h
 ezjfO+ovhaWyaZadeIZSWNFK0nAQ1fZfwzuc67joh6SpKDLzZYMBe42wLYYJdtD4QsWI4e4Aq
 t0u4ec9V8oIL37ODK3oAu5UtmLyQbyYH0PXELxCwUDLB0z+mf99xhjnn8Ve6BAzFkklQTzBfr
 8RpSPy2lBgjIYJADSYF0iMfUgfNlQkQccfxYnl5d6O933fmwqADX0u5V74rHpavJQss+j476R
 641A8tydFDxZ9dwceaOPmnJhkc1DG2VTYaTe/ktWmKeaM4l7opCN6FJ4KizlRqlYrujQ2hWKA
 TUA7XIEHd/QDMrF3INhlMCcFFdlx2bo0CP66cmaTO/JrYbjEe3xfLyX+sc1/I33e6rMzh6lzs
 DY076mBq4ZXeIwAcVkijRviUcRrKT65jGsne1WCp2O2WWwSuDBBk/drQHEA6clmYBxe0fHbGj
 2Zl/LZhXrg94aWMP6tg9aw9hpuInRPLAL/KFUI2JlajeuhydOO/U2TuXqXIJSZva89hSvfIsQ
 AGr/v73pUVJSEDfE7vPdgs7beLyLViWqLIIzTvNHvsXqIVeyiM/J/6zdtka0YmLYyQlkD/dDw
 SvKGv2H6UZnui8bWaSP9jJLGFieillqCU9ami57WRohbTIkISrTjSl2P4f2WV02FoQXcLscTa
 6VF0MmWqAaAw5Rg6/w7X2asKrwrW3PIG75y5nbOLLSDMpsNs6yzg5dOr4MMQFQ3sMfIzYsVmf
 6sBewySb8N9yeZfRvhRqhvrckliFz5qTkBw6wxnLUUVr72eOJx3ASHWpuha7Xy0pGR2BbD2Of
 4JSZE4VWLg+qXD5PerfA==
X-Spam-Status: No, score=-105.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Sun, 30 Aug 2020 12:41:42 -0000

On Aug 29 06:01, Ken Brown via Cygwin-patches wrote:
> ---
>  winsup/cygwin/sigproc.cc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 2a9734f00..47352c213 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -44,7 +44,11 @@ char NO_COPY myself_nowait_dummy[1] = {'0'};
>  
>  #define Static static NO_COPY
>  
> -/* All my children info.  Avoid expensive constructor ops at DLL startup */
> +/* All my children info.  Avoid expensive constructor ops at DLL
> +   startup.
> +
> +   This class can allocate memory.  But there's no need to free it
> +   because only one instance of the class is created per process. */
>  class child_procs {
>  #ifdef __i386__
>      static const int _NPROCS = 256;
> -- 
> 2.28.0

Sure, why not.


Thanks,
Corinna
