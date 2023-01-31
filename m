Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	by sourceware.org (Postfix) with ESMTPS id E83E03858D35
	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023 09:28:43 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2EHo-1oe3SJ2P2U-013bGe for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023
 10:28:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9C7E4A81B7B; Tue, 31 Jan 2023 10:28:40 +0100 (CET)
Date: Tue, 31 Jan 2023 10:28:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dsp: Implement SNDCTL_DSP_SETFRAGMENT ioctl().
Message-ID: <Y9jfSM8nB6Z+eT3O@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230130130916.47489-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230130130916.47489-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:d2zY3oPlxytA7K377aDmrxlKDCKDh8PncIpSZIKF1lqzHhBfOqY
 KFFomSYODZgnjkIIO/TgvgQxV2F6+8HRcuGYcTON86pm9Kw/wyKj1+Mq3FyoE77Vzwoxdnj
 h0XbIHSH1kM/t7HJTFQ4xx6XtO1MUahAYKEBgx8rZQZO9gIpkUYj9/2YUtXAFpEkGglRh9e
 7V7J7CSfKYVQPBJDALbLg==
UI-OutboundReport: notjunk:1;M01:P0:2EjnlmLXgtA=;ylyvTC4Vl4llPkT2WS+6K3zF7CS
 +y7gHsG9biGUBf6W5iduXEjvVqSkWKw4wqirHthJrhWZow/F0DAxm4F7kgPXibsC9AdhRZ7Sh
 znhhWB4zBpWw3EGP3zpsGpnO64Vttqua03rQ8Q71Z6wr3AEZq7HyM/gnkLbQT+iQcWPfSoKy0
 2tXD+VP3oHI1R2DHOXt9xjGmUFn9lbi1TavrehHT6jTiavT9m/yeLu0O4eOZPtM5u+lv20hbT
 i6b/6M/7Izap+TQNc+phtOuVFfv0azlappcexjtDAJzi0Xl2z5fN1ZiZpkwgJhB/CGHJpHGSV
 5ug+FdCD+1kcJXxDbQvSrpV0YQXtph9ULizin1OHk7K7A7sykFMLWx/GNNr2IDY6Ikv0x7qWK
 aR9RM1+wgfq+2VG0w/ansvt+xE49gZ/ElS5h7wm9zJyrCiKvcxKfJQWYLN8JAG8XkQk3vP6Px
 yQDq1vRzGehV6BdqlLRnkJMRS9bQFefkmxT80zIkaqRsv8tyQVR5pBeFqgysAsZK+Xw2zTYUc
 uNxINL+aZTGZrlAs5nKDfpdbaqtHIKyL/c69PFepXo1qwl9mmYWjC85RkfuASyVCLRtyh6Fcy
 zl5mOUxR8aGF4W+JN+0w+pEFiWSXeDOp8PCP+KeQYj3OfBxQ6VpfzUitxUsF19MhZNHiDlNwq
 ESnbkpHoPrInAXO4TIeap1DmIututL01Wn49fAlvRQ==
X-Spam-Status: No, score=-97.1 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 30 22:09, Takashi Yano wrote:
> Previously, SNDCTL_DSP_SETFRAGMENT was just a fake. In this patch,
> it has been implemented to allow latency control in some apps.
> 
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/dsp.cc           | 78 ++++++++++++-------------
>  winsup/cygwin/local_includes/fhandler.h |  3 +
>  2 files changed, 42 insertions(+), 39 deletions(-)

LGTM.  Given how much I *don't* use the audio stuff in Cygwin,
would you just like to take over maintainership for this code?


Thanks,
Corinna
