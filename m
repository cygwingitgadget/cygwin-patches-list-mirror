Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id A32A23858D28
 for <cygwin-patches@cygwin.com>; Sat,  5 Feb 2022 09:48:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A32A23858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MspyA-1mNMe12HRA-00tBzy for <cygwin-patches@cygwin.com>; Sat, 05 Feb 2022
 10:48:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8A9DAA8076B; Sat,  5 Feb 2022 10:48:40 +0100 (CET)
Date: Sat, 5 Feb 2022 10:48:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: wincap: Add capabilities for Windows 10 2004 and
 newer.
Message-ID: <Yf5H+DgpvRIGa9ys@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220205080719.928-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220205080719.928-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:0f5fwclq8pzGu4ncvLUnkh6AHHOAWmrCDidmzO3y76XZrfocuLe
 HD9FlnRSqfwvvcR5Xow/ETdSwAAGn+wuGNnU2FZyBKXjZGhzrnnJ7BmlkQOzBUHjFQegItq
 eq4ra4hBPQy3LzoIR0FrwH4GVlKXL0vdNhY8uLNXvhE6gU/cWwUaT3xU515FAf1Fr0Kx8kK
 14UIbGuAICI5T+u7O+SiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ogdjI0TP0aw=:zMx7+unNd4qM4R973NEhs0
 E4MoONltuSD/7cvlXG8+2QhG7fOp2Hfe30Egsb2d5mSmGWphC5OcO7PTlab8LVDRy36wf06Cy
 zZdEoDGBJGbXoG1TqRfsyWHmdFvBG4iPOhTCXoUQp8+L/0ojZLbX1K6A5bw3xSNWT6sHOz3m/
 bo44rFeHonMDTfp7Xhiu2LdzswZAMYn0/0JFD5R3jG300FWMV+XqqyvvF0BpZcq8uVIg00Ro9
 9dYc4LY2l6meRRYZ5qaOock6eMgY5M0cofhS5kNGj9t7ORti/cEodXSkedYL+6iY6BKHzPYHE
 Mpr0UCSXTpiXFZvv0ruXF2frtMvF1NN6RJfo13Jh9boVXZgZMBnZP2aAuBXTQwkKb5vEMsYTh
 zpsBO2EmcaJP8ukrVyiqA5bltx55PDr0lT7lVxQQS12gAxaMNQNaWZpQs5XdhJ44Xrscarupy
 wCas4W2bk/4zbAq07xEtM2PrkIhBTX0V3XVS7K1LVu3JjgJDBC8WJlzyCtl2jg5cakPN0JKZp
 oe9i0wZjAT9mp0zXQc7Y8IOpFpuT+I31nY/NmkD936Caq6ozLC55fzj6p8KOdKtl22y+7GLVj
 bAPc/Yt1Dd42WwUAr9WmrHD7EbE+qGoaRgEtiOju+wPTy5RVhi6kdDuXTsKWk/Jq9U97HWAaz
 OQSF+LH9bPTsAk+GGK3wmQJT+PRVk6lPUg2kHe8tT1JsUKe9dYFzStv6a5NsBajGNluq82xWu
 o+oe2E5ynDEzq+y7
X-Spam-Status: No, score=-97.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
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
X-List-Received-Date: Sat, 05 Feb 2022 09:48:45 -0000

On Feb  5 17:07, Takashi Yano wrote:
> - The capability changes since Windows 10 2004 have been reflected
>   in wincap.cc. (has_con_broken_il_dl has been changed to false.)
> ---
>  winsup/cygwin/wincap.cc | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)

Sure thing, please push.


Thanks,
Corinna
