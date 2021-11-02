Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 648323858C60
 for <cygwin-patches@cygwin.com>; Tue,  2 Nov 2021 14:48:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 648323858C60
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfqGN-1mFBu718Mj-00gFlD for <cygwin-patches@cygwin.com>; Tue, 02 Nov 2021
 15:48:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 89727A80BC1; Tue,  2 Nov 2021 15:48:17 +0100 (CET)
Date: Tue, 2 Nov 2021 15:48:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix a bug on input when signalled.
Message-ID: <YYFPsd2fzo8mjHIV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211102034010.1500-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211102034010.1500-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:ieLsBV0fN+0ZH7xno/NUnkFBaHVuLfNDi/xR9KiBl0Iq1DzRsQ5
 sMZ3ZCmIyvgJCiLSU9Ohz+Km13IVjYTacugzKccQOERPl8YZ6Ln18CBvH2CzAe6wRd6VDh2
 wKK5gx7Mem3efnFpR3Hr23R5k216Je4kFCiP5h0Z+E6Wrpm1FlmChewQykwi4kf3odSXkVU
 5xEb5IU/GdNq3rTyoxGWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GF2Ksn3Yilg=:1LX7L33CB0IM0LMIVuqhme
 ZazQAlYcKqoe9+ieFckoqkBIUJAffm3WtKtJcVnMxwf5S5shqJ4z1964D8PlwgbVKvNA+Ru9Y
 sFfCisDIKvk+w2CQahStAukUcAgTXXctj2r4yVelMKBhxe9cd1m+wQeh98pQYST3UaK08wt6u
 evWzdJnZcWXpXpFhuxg+Vnw8Z/ipLha9wOQ5OTiHpGAssJ1oZX0L6XEFx493lfPC75kDwdKzF
 a4bYGv8rWC8tO70cYd1rYk1MF+5xvj7WPFc10VBIM7F6WuVvSf3J3Iutqho7AkBaiUD61+mWv
 1l8WQbTgFLHggjud2OF1N3/iUFqMdtu0wYeCOAIVUwDycpAu9+JEJNkFSUSIpJI4H+uSBVXzc
 9syFBG+9/Gz/TDqrIqAcgmqAs6yKW/pVGVp941ivbyhn9ByA4+3bPNw2Bk7EyRmcnozhOUeCS
 LDF5wkR0AlgyRhvlssretmnlx3t752TKWzr6As5pF4OBtD4oxpZHaFsAFg6AQxZhker95vg8+
 uAwG3da1eOiOM2mvPoRhNrePfyuUPoCwnpHbRWq7/H9Rjgbcrq67sIMmxWVgRrxh1+RjMqC53
 SPAJYRn9B58AMlK13ZuUjU0iL1zONcwHlnAwApmXXuU5hPSY9QhnXei3rpfQhIqcEGI8vfuNx
 R66aHOWpvf2X5Z40da48ciZsOSKpf61+T1JnFV7c4qGM0bLaAQN1wCMwRO8DFfq4y9PkD5kEf
 jGHFiQNO3Slf+u5O
X-Spam-Status: No, score=-105.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Tue, 02 Nov 2021 14:48:21 -0000

On Nov  2 12:40, Takashi Yano wrote:
> - This patch fixes the bug that Ctrl-C sometimes does not work as
>   expected in Windows Terminal.
> 
> Addresses:
>   https://cygwin.com/pipermail/cygwin/2021-November/249749.html
> ---
>  winsup/cygwin/fhandler_console.cc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 940c66a6e..0501b36fa 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -1178,6 +1178,10 @@ out:
>    /* Discard processed recored. */
>    DWORD dummy;
>    DWORD discard_len = min (total_read, i + 1);
> +  /* If input is signalled, do not discard input here because
> +     tcflush() is already called from line_edit(). */
> +  if (stat == input_signalled && !(ti->c_lflag & NOFLSH))
> +    discard_len = 0;
>    if (discard_len)
>      ReadConsoleInputW (get_handle (), input_rec, discard_len, &dummy);
>    return stat;
> -- 
> 2.33.0

This and the next patch pushed to master and cygwin-3_3-branch.


Thanks,
Corinna
