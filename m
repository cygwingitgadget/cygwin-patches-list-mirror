Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id DA38139DC4D3
 for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2021 09:43:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DA38139DC4D3
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mgek6-1lpKyQ1PHY-00h30z for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2021
 10:43:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6ACE8A80D37; Fri, 12 Feb 2021 10:43:17 +0100 (CET)
Date: Fri, 12 Feb 2021 10:43:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Reduce unecessary input transfer.
Message-ID: <20210212094317.GI4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210211090942.3955-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211090942.3955-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:VLzLD7sPAljZA4AVNWBsc2N9d+vqqESi/Cw41LmWY/gRWYEP2eZ
 /OVqpOQXlPG/5OgVjSsOktzRULeSWbElijIs9qHECNN7BhWz/0S7IqBewcGXdpvGRVDK0EA
 7aG1hwjBwO9eldfpIiWR/WUHe1yZKz5hrDNuuOa6pS2Cxj4gNVYVRZTMBugRf8PupREmTo6
 r2N5byMQd51XfKXBE20mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dV8E32OP2Vs=:DKGzKyoOV2U35+MITN7hcr
 cPEX8qrcrUckqGhVeEnuuabCKDa95XLcXNja+Hkj+YQY3k+BNMTY5ZN8vNkr7u18+8lGRMrdU
 247rRqL2F5yeUE+cBeRUj5CiOfOTB358i+0Ad+NFPfAczqSwnOgFDTlLG6owqa9tavFzS9T+s
 yIC992BesIgn82Wt8X1CXwNaCbngrJuAP4gWHra0gNY64saRUHLHyFpwk4zoMZYHxvDyt9C1H
 bBoHYjqPHSJh9GVtsh+HgKCebOdcALXZ/Pch3cLjvfVkoxqjowtwaTjPRJL2T0Vgt4GjrceyF
 AMtL0yIOT7IgkvY421NWs0aMnphF+oXh696+b5pT4h2g/mJu6s1OddktSFCPWu/kGwRWxA2B9
 rbUKVQNQsoNExWB3g3zvBuWfEyscVhBmb2Ar2c6ltpCo+V20Ufy1kCjfE+QusndNoa+5am+ID
 M9PivCwogQ==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Fri, 12 Feb 2021 09:43:22 -0000

On Feb 11 18:09, Takashi Yano via Cygwin-patches wrote:
> - Currently, input transfer is performed every time one line is read(),
>   if the non-cygwin app is running in the background. With this patch,
>   transfer is triggered by setpgid() rather than read() so that the
>   unnecessary input transfer can be reduced much in that situation.
> ---
>  winsup/cygwin/fhandler.h      |  15 +-
>  winsup/cygwin/fhandler_tty.cc | 377 ++++++++++++++++++++--------------
>  winsup/cygwin/spawn.cc        |  78 ++++---
>  winsup/cygwin/tty.cc          |  89 ++++++++
>  winsup/cygwin/tty.h           |  16 +-
>  5 files changed, 376 insertions(+), 199 deletions(-)

Pushed.


Thanks,
Corinna
