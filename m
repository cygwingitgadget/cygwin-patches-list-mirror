Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id BFA43385801E
 for <cygwin-patches@cygwin.com>; Thu, 24 Feb 2022 14:24:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BFA43385801E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 21OEO1Dw000719
 for <cygwin-patches@cygwin.com>; Thu, 24 Feb 2022 23:24:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21OEO1Dw000719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645712641;
 bh=eWd+wXm6hJ4wCAVc+YOH8ZklsGJPu9/sSZZ2Tsl7UQY=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=v2UOU9CzrX71aFIBrfAM/9EscVh8QTWpQ68ZK0K2rZFSfHPeia36y37WCxQXzv3bc
 LJPSWm7Gd34isngjN49a6zv2f3mCBd76U1DF15KRvo4KtFazOEYZo2Q8Ws4Syf7FbN
 fmgSSgVONURdFRd9/dLv9tQCUT4elxu7xYLoRzzvXI++5vy0K6iDn+f75fLLniGfCd
 kcMqrOdoUjwB+LabRZ7LRK/StlmG4HnP9DZ9NjNRrcAPHuopSXTI9sF2OX8E79tcmk
 vMb0gQOmraBoBHo6ObiQZ/b7zQCwXR13bIpC8V33Zx7rQLPRjUyrNmdPW9kPxoh+/3
 9jP/RKM50dypw==
X-Nifty-SrcIP: [119.150.36.16]
Date: Thu, 24 Feb 2022 23:24:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pinfo: Fix exit code when non-cygwin app exits
 by Ctrl-C.
Message-Id: <20220224232404.475a9505b3ba7fccc862848e@nifty.ne.jp>
In-Reply-To: <20220224134335.603-1-takashi.yano@nifty.ne.jp>
References: <20220224134335.603-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 24 Feb 2022 14:24:22 -0000

On Thu, 24 Feb 2022 22:43:35 +0900
Takashi Yano wrote:
> - Previously, if non-cygwin app exits by Ctrl-C, exit code was
>   0x00007f00. With this patch, the exit code will be 0x00000002,
>   which means process exited by SIGINT.
> ---
>  winsup/cygwin/pinfo.cc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
> index bce743bfc..bb7c16547 100644
> --- a/winsup/cygwin/pinfo.cc
> +++ b/winsup/cygwin/pinfo.cc
> @@ -156,6 +156,9 @@ pinfo::status_exit (DWORD x)
>  	 a lengthy small_printf instead. */
>        x = SIGBUS;
>        break;
> +    case STATUS_CONTROL_C_EXIT:
> +      x = SIGINT;
> +      break;
>      default:
>        debug_printf ("*** STATUS_%y\n", x);
>        x = 127 << 8;
> -- 
> 2.35.1

This was not enough. I will submit v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
