Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by sourceware.org (Postfix) with ESMTPS id 41FA43858D20
	for <cygwin-patches@cygwin.com>; Sat, 21 Jan 2023 14:53:40 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MidPj-1ooZC12TDD-00fgDn for <cygwin-patches@cygwin.com>; Sat, 21 Jan 2023
 15:53:38 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 89CCFA8079F; Sat, 21 Jan 2023 15:53:37 +0100 (CET)
Date: Sat, 21 Jan 2023 15:53:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fsync: Fix EINVAL for block device.
Message-ID: <Y8v8cdscNlnXbVxE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230121124403.1847-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230121124403.1847-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:lLFVpvXB1cH/r8hrBQTb7WlRKDvPozt9h4YFN2z7iB7fj5HHMqa
 6zFO2A5ClAglzNLg+ZlGOG4+CCTVL+ltotI3nBO/gld2fQ3gn0M+zxMozg3OXyERYVE6a9y
 59PNCcbNwD+opYv4lS5d3/sAiq9SewTbK5Enhvixf1XtDHDK8rDXswtx0tcNxU3zbfL2MCo
 uQTTYc7didvXd8nWjuV2w==
UI-OutboundReport: notjunk:1;M01:P0:1bK09uho+QE=;9Yps6kvdT4DcfQFDGNRhoE3ULq0
 TPSq4Mdh7s7mXb1o7ut4y6dejoB856mSKvGf37dq57pHWVByFKQ/qKhyAG2jFpx95TI6WHXiA
 q8xd7zOIkMl4eMm+4tsicnj+hJEQHDyHfCsfpUwO0r0zPTpUqMkJsU0/sMPJ+p5x3Q9LGVi/u
 EH3cxpKBVrxY+Qo2ZZbaoiyH8L/8+OlIDX7P42guLk/AVwXuYHeTNnhCfYXupk60pieTsbd75
 Jdtb3iJRxRRax6QWND76iSwp0j/bFmbOeG9DSQOoLWexHtQTmkq5Xe70T19VEg4CMmfsvrX4w
 36FlEigQPAnWxhCzN3KDScIIolJBbU796OWPYk/rjVDC2AJom+4iXt03HIPOvAv3zxsA1n1mj
 fPZwvPCnawOoQQezNnxHCEnZOlGet97TPQEwaUVLfibaB7l/X/wY1J3q6hNGV3mgbAcXGimXT
 zEtpKV7hSSBa4o7IERpqKW66k7QD/EYNN8FUYQotJc9Z3CmiP7YqHkHyDlVT0U6A+F4FB8SII
 mf/wGo1P3mPhS+ZVucOmVDIxLzr9F018fv3CVQ66IyrlraZh+PeGNgkhxTM0xaSdc/JwSw58H
 FJX65dL/t8BcyYuNtoNcpcCg5N47vUop2W8x0Aa7XP4FaERoRIIx0lpZVZXJ4iiBNFt4/i4dY
 N9hR+CidTytSJvJpjxU1TdpJ8JGHltIbwaUIZVm60g==
X-Spam-Status: No, score=-103.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Jan 21 21:44, Takashi Yano wrote:
> The commit af8a7c13b516 has a problem that fsync returns EINVAL for
> block device. This patch treats block devices as a special case.
> https://cygwin.com/pipermail/cygwin/2023-January/252916.html
> 
> Fixes: af8a7c13b516 ("Cygwin: fsync: Return EINVAL for special files.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/base.cc | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
> index b2738cf20..fc0410522 100644
> --- a/winsup/cygwin/fhandler/base.cc
> +++ b/winsup/cygwin/fhandler/base.cc
> @@ -1725,10 +1725,31 @@ fhandler_base::utimens (const struct timespec *tvp)
>    return -1;
>  }
>  
> +static bool
> +is_block_device (_major_t major)
> +{
> +  switch (major)
> +    {
> +    case DEV_FLOPPY_MAJOR:
> +    case DEV_SD_MAJOR:
> +    case DEV_CDROM_MAJOR:
> +    case DEV_SD1_MAJOR:
> +    case DEV_SD2_MAJOR:
> +    case DEV_SD3_MAJOR:
> +    case DEV_SD4_MAJOR:
> +    case DEV_SD5_MAJOR:
> +    case DEV_SD6_MAJOR:
> +    case DEV_SD7_MAJOR:
> +      return true;
> +    }
> +  return false;
> +}
> +

You shouldn't need that. Just check S_ISBLK (pc.dev.mode ())


Thanks,
Corinna
