Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id C04503857C72
 for <cygwin-patches@cygwin.com>; Mon, 13 Dec 2021 13:53:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C04503857C72
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MkYHO-1mFVfN1MQI-00m7Xe for <cygwin-patches@cygwin.com>; Mon, 13 Dec 2021
 14:53:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CE480A8146F; Mon, 13 Dec 2021 14:53:10 +0100 (CET)
Date: Mon, 13 Dec 2021 14:53:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Use AS_HELP_STRING for --enable-debugging
Message-ID: <YbdQRo1BzgpI2aPs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211213133648.2643-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213133648.2643-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:caR9jc0UQeofDydw0IZUHiX6cAaYb270Kt0Sx+PPNOJM/haLG2/
 qCfdmbWhaFrNXyfIAm6RrfQs3i7AIy/zbjMDohQq18xVaVHic94mM5b89ALROAYv28t2lc9
 XKY9OhfAX5o1tAw4GB+5Y+rDTh51lseABrQUPJhfF6IpfHsRzP+xU+O06IMicdRePcUXuTk
 T+YSZGJ72AlmSN9aCltBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IzLU+GiiVFY=:LqrNxSDowAyTL75xXQFoJy
 MBEVra+GndnpCKQ59tndQf60qC6Ir4wyIITYrHSQSIx/0ZhK8//1B5qoIhtYTM7QCcYV9Goyj
 tc0KStY63761Al529nP1wZJnrIBSyNzoluO4tKLWg6nPgwuKUddf7VSld0dhJylB+b5CtbQuW
 D70WHgnGM2Jd1djyZZ6Twjv3cygzd6u5dbe5HA3HC4UUHrb8OtnZC01pV+nu9EpeUv0pnlLi5
 QcnJr4u1CsfqDnecwTGh37CFVm6/A46fEZhoaHtqHHq/gAqtgbGnIb2zFHyydZit15/TRNYEC
 ugrGFajhdwrhq/eGa1NNEJR47DADGS0H6/eytai0HWIJmz/K8fZatw82G8ykQdaSoU1GYw9oQ
 yo7Qmz1XjnqgOcgFa9qYf2Hh+QQbxQdg1ZULix+g2q+do1NavPwYvR5sIs7OCVbcQV9QWHaVM
 KckbzZnvEslMNf6U97L9qvr4BJgdwDxgqJjn4IIE9pfPUVSoRKLfi1zyL3anye5y864TQmB2h
 nQ47YPVLbGvoOy3/I/sESng2LGYdhiw4xT3+/lVvO/m25PNKlauOTwlaLQArLnK+Y09pV9cnX
 BkqajmRVxhEpobno0d5YpiNjotECGy74wrzkkUCAI3+oRfE44FLfvcAZMhidv53wtdLBZnJE0
 VSSDLObseNQ17hG9k5zCABDFx/yzM5xwb5+C51TW3tzVFevN60pZJQl25ZBQHSoC1210VnkcX
 Z9DeLk2eLCcURRlW
X-Spam-Status: No, score=-105.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 13 Dec 2021 13:53:14 -0000

On Dec 13 13:36, Jon Turney wrote:
> Use AS_HELP_STRING in AC_ARG_WITH for --enable-debugging to ensure
> correct formatting in 'configure --help' output.
> ---
>  winsup/configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/configure.ac b/winsup/configure.ac
> index 79e78a5fc..cf1128b37 100644
> --- a/winsup/configure.ac
> +++ b/winsup/configure.ac
> @@ -58,7 +58,7 @@ AC_CHECK_TOOL(STRIP, strip, strip)
>  AC_CHECK_TOOL(WINDRES, windres, windres)
>  
>  AC_ARG_ENABLE(debugging,
> -[ --enable-debugging		Build a cygwin DLL which has more consistency checking for debugging],
> +[AS_HELP_STRING([--enable-debugging],[Build a cygwin DLL which has more consistency checking for debugging])],
>  [case "${enableval}" in
>  yes)	 AC_DEFINE([DEBUGGING],[1],[Define if DEBUGGING support is requested.]) ;;
>  no)	 ;;
> -- 
> 2.34.1

Please push.  You can treat this kind of autoconf/automake bugfix or
improvement as pre-approved.


Thanks,
Corinna
