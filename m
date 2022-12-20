Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by sourceware.org (Postfix) with ESMTPS id C4E053858421
	for <cygwin-patches@cygwin.com>; Tue, 20 Dec 2022 18:14:37 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfpjF-1oeemL1EpF-00gF9p for <cygwin-patches@cygwin.com>; Tue, 20 Dec 2022
 19:14:36 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5821BA80D74; Tue, 20 Dec 2022 19:14:35 +0100 (CET)
Date: Tue, 20 Dec 2022 19:14:35 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pinfo: Align CTTY behavior to the statement of
 POSIX.
Message-ID: <Y6H7i5J+C2B179KX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221220124106.487-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220124106.487-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:Yfd6tlC5THe2/9EHI4wDWB8ULOhmVqCjI+8+MyEC/RkRPkUqHTY
 WIIlZkJ8eFBurs0OFRpGQnxHYB38Cef8cnYwInCllL8iQwT3+W4Zzlx0smjLIx4a5nU6oct
 /FHQlKpi7lgTr2FFv6R8xLfl2MYWsEHr+mfGWXL3s2SOZytHW+oNdDyxBiJ6BrY1w17gIrn
 T1G7nO1fAoyAd/c009Y5A==
UI-OutboundReport: notjunk:1;M01:P0:PGbi650F8MU=;r+ldLtU0RePxUMq2QF+h/PALXCz
 /LVCJ+PBWpY1fg5Sh0cmtemk+W6RQFrEOlD/LmoTfuUYbkzUgx5EafDloD7GTnMe7OnF7we8n
 A4i9EMFKI+8jIJDEU2S8YeV6sXL7jweN1FtkrUmJnT6wuJKJNx7K0+LhwWuG3NuUhIOHkMDOX
 V1f+QYZSK4aduOUuSULKfZVpYR0spXaTV7UPZtA0nbFoOUdqeLYD2yxKE9+JoF4pPFHl8oYaP
 rOb+DofDIriMYUAZB9IHKhKGQGA7+YaxNBYEzMsaODPu+602y4h0+fHw04VzGT1aMLFUGOVto
 bcs2x55K71o6FoPOZyyUUR3lpBvoj4fqm8UWqsPUiC2JjeCuyXpGPjYfRBZ5c47nRhYagJE2s
 P4py50eBV6IVZv5+8AFoplnYvISAXwEFLOjA/dsMEdcDf6iSTRwbsRfA3vf4vxsntaQ7vzIQm
 fxaIoNYX8NRuXJRTQGThAK1LlB+GbPwOQwZQh6eveOt8rHVcvERi7RgK7BV/d7axiK1JEZBb3
 Opos5mo+bNO36jhbReiZ/f86mUj4ZTozbcNdsEdUcsS3BG94fs93QL9jFwooe7oj/nG4c3C9/
 b7PH6L0yZsLHW+FFl6zU4YcnDS7r+f8Y+4BR3wzWrmWCJB3kWAR7fljUSejNC1zuhs+XRtIs+
 re798GzOKZaHr8g+5e31xqdpWn2drNCBfMhctk/Wgw==
X-Spam-Status: No, score=-102.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Dec 20 21:41, Takashi Yano wrote:
> POSIX states "A terminal may be the controlling terminal for at most
> one session."
> https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap11.html
> 
> However, in cygwin, multiple sessions could be associated with the
> same TTY. This patch aligns CTTY behavior to the statement of POSIX.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/termios.cc | 6 +++++-
>  winsup/cygwin/mm/cygheap.cc       | 2 ++
>  winsup/cygwin/pinfo.cc            | 4 +++-
>  3 files changed, 10 insertions(+), 2 deletions(-)

Do you want to handle this as bug (3.4) or extension (3.5)?

> diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
> index e086ab9a8..749a4064c 100644
> --- a/winsup/cygwin/pinfo.cc
> +++ b/winsup/cygwin/pinfo.cc
> @@ -528,7 +528,9 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
>  {
>    tty_min& tc = *fh->tc ();
>    debug_printf ("old %s, ctty device number %y, tc.ntty device number %y flags & O_NOCTTY %y", __ctty (), ctty, tc.ntty, flags & O_NOCTTY);
> -  if (fh && (ctty <= 0 || ctty == tc.ntty) && !(flags & O_NOCTTY))
> +  if (tc.getsid () && tc.getsid () != pid)
> +    ; /* Do not attach if another session already attached to the CTTY. */

I'm sure I'm missing something, but I'm a bit puzzled about the

  tc.getsid () != pid

test here.  If that's not the case, this process is the process group
leader and already has a controlling tty, isn't it?


Thanks,
Corinna
