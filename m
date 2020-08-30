Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 3671E386F801
 for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020 12:49:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3671E386F801
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVv8f-1k4QoC43d7-00Rokv for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020
 14:49:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8F260A83A7E; Sun, 30 Aug 2020 14:49:25 +0200 (CEST)
Date: Sun, 30 Aug 2020 14:49:25 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-ID: <20200830124925.GQ3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
 <20200828134503.GL3272@calimero.vinschen.de>
 <20200829042554.e18de504a93bb80da347e858@nifty.ne.jp>
 <20200829201228.b327d38eab10a64d941f99c0@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829201228.b327d38eab10a64d941f99c0@nifty.ne.jp>
X-Provags-ID: V03:K1:dn1qSp2LxV//mTDrDbdcoul/F2ZGu+lNEiEVOOe8MczuQySzwqL
 0w/L7qCtl0NBKf/yMBiZ0rPnHhHmlWP8HJWybk1ZRwiFJK8G7M7mmUvboUX3nE/vjRLHHTU
 QJr+7Y+Lx+6XOtMQBHy/f9PDpwwYXH7MMIpeL6pzjuiPyZXetjWbOOY5D+NuC4mFa8ahGEY
 0Oin1Shbdb8ab896gdfcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WWYmg/xxxRI=:11isRz8fbzNekY1xJT3S3v
 pP1X78gLtIl3d7WL+G7z2zODio9JACEaRCdKhdJoGc5HwN3kSi3mNFpZ9Ke9SDV9T0wWagRSs
 QZO3bMsnop0vsdPME3o33kJVswFfsBZI30Lq3aoKCF3njsgeen7/qJREgbdRRwB54/C9q3Nb1
 okbhSHfKJAlyr0bLr+TPhTnh/cwRTJz+8eBX1DQWaS/8xVzRa0vBUhirWmE1CMkD/ILafke13
 7aCxEL7e/L7+0exWDZfMSaT2dGuGnu7uVKDJLk/cqDVf5SVYf2zR7s7iXE5H7x1AyEiR/MH47
 Q5B+KQ+XaLpbHPNamuVDRiThEdDq6cMFch8DVv3NNLnMjWZk24MDAuHRNBsmvex3dgBTYgqT2
 CrhUWPuYlRCszJzAwM+V7NGovimyX64NSKQH8ILUAbBFsWMECmwM+6gWxMzH9CXzM6AE7pCEU
 jjc80jXOI5gd8Do/MwDDUwZXhsCZWDNd6FBV/fosjMb99vfWvRfy5DHAoG3kpgGcEgtoGHnNM
 J/LQwPXDWvC01WwBmhf+emLzRYH/s5AHgZ47oJ/sMFp1s8h7znNZWs0bEOOsU4RBorqxONdtW
 lkg83t3b4mdJhWr3soiPq3vqKZftdNTrMfsEuMt+chbD7hrFqKC5BgxBcevPGhBODVd5nDc/q
 ngCgwuysKS4uEQpACLxfW1DX2a51di7ZFPo0pMLPMKeJv+PrR9DU7OGLWZEqYYf9KkIAzjiq9
 dLj00FZd75IY4EHRW16+sS1K3/gl0I08mTbnpHNNSL1RgyhPMXxqk/99U3oJ3OY/srVBTz+KI
 Tw7ShhUtmbDJ7wtsceSDCZokwTwGiQC5k0njPrOAR8rz1V/9Lb/zwZtcxS+ZRvhHbQBIst/qY
 iDL6tl5LzNsQaBi6XL+Q==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Sun, 30 Aug 2020 12:49:42 -0000

Hi Takashi,

On Aug 29 20:12, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Sat, 29 Aug 2020 04:25:54 +0900
> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > Hi Corinna,
> >
> > On Fri, 28 Aug 2020 15:45:03 +0200
> > Corinna Vinschen wrote:
> > > Hi Takashi,
> > > 
> > > On Aug 26 21:00, Takashi Yano via Cygwin-patches wrote:
> > > > Pseudo console generates escape sequences on execution of non-cygwin
> > > > apps.  If the terminal does not support escape sequence, output will
> > > > be garbled. This patch prevents garbled output in dumb terminal by
> > > > disabling pseudo console.
> [...]
> > > 
> > > Would you mind to encapsulate the TERM checks into a fhandler_pty_slave
> > > method so the TERM specific stuff is done in the fhandler code, not
> > > in spawn.cc?
> > 
> > Thansk for the suggestion. I will submit v2 patch.
> 
> What do you think of v3 patch attached? With this patch,
> terminal capability is checked by looking into terminfo
> database rather than just checking terminal name. This
> solution is more essential for the issue to be solved,
> I think.
> 
> One downside of this solution, I noticed, is that tmux
> sets TERM to "screen", which does not have CSI6n, by
> default. As a result, pseudo console is disbled in tmux
> by default. Setting TERM, such as screen.xterm-256color,
> will solve the issue.

I like the idea in general, but isn't there a noticable perfomance hit?


Corinna
