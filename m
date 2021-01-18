Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 25F5B386EC7A
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 11:06:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 25F5B386EC7A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MLQl3-1lJG5h3FTP-00IWTs for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 12:06:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3DD47A8093E; Mon, 18 Jan 2021 12:06:02 +0100 (CET)
Date: Mon, 18 Jan 2021 12:06:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 04/11] syscalls.cc: Use EISDIR
Message-ID: <20210118110602.GU59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-5-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-5-ben@wijen.net>
X-Provags-ID: V03:K1:Rbq00d2eSwsmIOJtQaK9235i7Io+OIuvt2h/ZYszxLHEPBkDE6z
 7uFGuLAgPAfcQkV0zCsxJvZjD0ExGzeJhHLEXBE9DxPm5WFGpo8iEDS15pkczHF2tx0LMfB
 x2enUhLEfZRwv6s2Ik/+EdOP4b6Z5uRFHeDPnMHUK03eFfxOhs0Rf+JqJ/vnpLXqRZdZPbk
 xwbciNqd6PMe2bGPH9nUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:51jSZmty0fE=:2N4KXumSjN1HNSAR33dVbW
 vRmoe4qP8DaFIONDkJUJM+ZGZcG1gnI+7O1SmVfcJk6EyabwmpJarQ/5CA0d+Vgd03Cj75S6S
 9Y9sSBzndTbSJ7gMvHlAX4CUofAAa9S6kR9z4+3koXcti9+Dw/CH+K2cz3qvaBhGuXLy+Gyee
 a5UQzr+bOUAC+tcjaEbr02LYAxmy/drDGYLMM7FJlnjnsTWY5EeWBLLc2ThTg2L3hm1oQPyp1
 71xgQc9ZCM2OPOwwwloqBhpcRHE2t0LNKsNRHd4DsV5uYJ83TckfbNLC/GYkKEwbVDJCq1GNl
 3vpVM3ji+Qz9J0lJai/zDjt6JW2wC88/HXL5i9C2Swcz8LX61QGD/vGo4VJWJF1VayfTvHVhs
 89DpLBQr0mOw74hdA2EXVWhCtrX8rEsVEoe0glGIG4QVmGwyHPu9qWRXqXSgbAiOE590yMMoH
 bOCr2OomYA==
X-Spam-Status: No, score=-107.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 11:06:07 -0000

On Jan 15 14:45, Ben Wijen wrote:
> This is the non-POSIX value returned by Linux since 2.1.132.
> ---
>  winsup/cygwin/syscalls.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 227d1a911..043ccdb99 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1118,7 +1118,7 @@ unlink (const char *ourname)
>    else if (win32_name.isdir ())
>      {
>        debug_printf ("unlinking a directory");
> -      set_errno (EPERM);
> +      set_errno (EISDIR);
>        goto done;
>      }
>  
> -- 
> 2.29.2

Pushed.


Thanks,
Corinna
