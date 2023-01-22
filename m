Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id D01673858D38
	for <cygwin-patches@cygwin.com>; Sun, 22 Jan 2023 09:01:15 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXpQA-1pBh7G0XCG-00Y675 for <cygwin-patches@cygwin.com>; Sun, 22 Jan 2023
 10:01:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 95FEAA80C97; Sun, 22 Jan 2023 10:01:13 +0100 (CET)
Date: Sun, 22 Jan 2023 10:01:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: fsync: Fix EINVAL for block device.
Message-ID: <Y8z7Wcwlr5IZOIej@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230122000846.54372-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230122000846.54372-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:f3bdavc/Xss+1Rvlx0k2DEXStVOj6uNm6pBBPKoTgEehl6sjV5s
 VHVdbQM4kfyITLiih3+cAIC/cDAB0MveRZuKSmr8IQGaev4HqIUeWQCdLNRzw6VP3IUP+rk
 97NViT++YBzUkmqIs0AFnXUsQHD3ulZdCcVBsC0C1WxNUuqwuqcfaR0btJPlw7G7Dai3Hsg
 XqH8afBYYMmzdrCekzbGw==
UI-OutboundReport: notjunk:1;M01:P0:HfyCeGQQot8=;sCPU+f33MGFjN4FwHdZMzNCCfm2
 3oworKXRmDxhY66dh24AgymlQQGUNVgtYPinCSaRP1PXiFVrmc5o4gajSdJ8bMX3TmeEG4+S0
 m2w3FER6OblXi9BtoQx0PWHBBTUZLpfSRRoWs0LgbqD+Y2kRywyYaMTJOgdX0XsKZYZ1mA8VI
 /zBlJZWAfLYiFdVbpT2EfvHrdaTCDJKwXrotIvs+3QWAXz/WjBVLZufELShAhU3VmoqsYfYfp
 A8ngkDO6KKfydwsyBqXrK2uq7k7YzmDtuUHNcGwhKDF0yOXIvEDYnsG9jBo3vg1eMD3dIp6v6
 Fp5yteN+ZOUIq7RwkTEpOJBhT3H/0Sy4WLWymPYe7gXjX4Kdy0jwwPZYl5SLyI9nbkagbNopF
 dgxNFKmSCT7Di0t/mm0oYQp4cWPH9tsPdPEy5avICHZkg+RRjz5dRIJ4b2s4aUudYGNy5qXIy
 rp1obnilwefKTxuGY70oa1gpy1UVo/MCppiOXrL1plHa/EpN881V0ruALLQtGnZYzfFMc37in
 aoozZmo8WH3dUMWkso8vSFPGFYQvN/vZ8S3APig2ZGZEmPobLR3hbjiSQUjb6SrnW95Z2yYE1
 Yi9vrrkRtiD5Vgw3gpqe8GHFFWVZlUpHrfJIkmdF5OHY7rjzdPv7difHOfaVprbWznfi+HRCq
 XxXRiAcmZI6KDP4pRtpCD/gz0D0RlTPF7WTU89bDsw==
X-Spam-Status: No, score=-97.1 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 22 09:08, Takashi Yano wrote:
> The commit af8a7c13b516 has a problem that fsync returns EINVAL for
> block device. This patch treats block devices as a special case.
> https://cygwin.com/pipermail/cygwin/2023-January/252916.html
> 
> Fixes: af8a7c13b516 ("Cygwin: fsync: Return EINVAL for special files.")
> Reported-by: Yano Ray <yanorei@hotmail.co.jp>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/base.cc | 3 ++-
>  winsup/cygwin/release/3.4.6    | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>  create mode 100644 winsup/cygwin/release/3.4.6

Thanks, please push.


Corinna
