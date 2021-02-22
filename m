Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 46215389682E
 for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021 13:57:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 46215389682E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MiMIY-1ljO7e0bzy-00fSOE for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021
 14:57:08 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 742DCA80D43; Mon, 22 Feb 2021 14:57:07 +0100 (CET)
Date: Mon, 22 Feb 2021 14:57:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix segfault caused when tcflush() is called.
Message-ID: <YDO4M0jllqibv4aq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210220224516.1740-1-takashi.yano@nifty.ne.jp>
 <YDN+lx5V2I3W3bbw@calimero.vinschen.de>
 <20210222204100.698efc916f1eacacb89b9ab8@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222204100.698efc916f1eacacb89b9ab8@nifty.ne.jp>
X-Provags-ID: V03:K1:hVZyr0p7HZeSv1TlAI+e/6bnoRvat8UVqzAJ6vKCdyNIrYqOyZ/
 +ynkoObBR0lp+k1dr8HtNM0/VeAAzzWM0PtFY/E+aYM4UDe8EXnMudrXWamMsH9UzKKPVXL
 EW2VQ1QB303pbTZ0HSuK5fk3z+5SG7IXKCWjZoz5CK/65kcrtOCBiwRWQuqX4Ugtbc3/Az1
 5LMvmdSGesJel1jlpwVIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DXlWFT+9T5U=:SmSEvmWJZeK2KM/yfNpI1Z
 SHKu8w/Bgkky0XptUIAZz4uLFuILrX3Bv+4XbHntCZdpNa6C04Ch/of80RNC2Z3GWdbnxoY25
 h5WyXfbikvlXMxunxPUiJocws7l6kjaRGzgczaVEOvAx1cQG2KES47AppAHS19mt7HNKCdV2F
 pgOFztSNIX+KVqDmc0p5XAd9+K7bpA1vYmti6TEVh0Hk3+G4Lu45rSMtaq+zQ3rbl49taZY7H
 9EI/K+7JETMCZKRJ1mOJ/SRIXt8T2XLxR3RAz5KCqO2xzN1+75kM63pTJtpZ5OkQq/R0UcF70
 vEIIoCcTd+VPaoEpoz/SgTvF43MyF3baXY3jvLcW2jw8EIVVVQZ2d89O6H7HqEbjT4LdMjNwS
 SE5KFvMos6akuGSmPObbTtpZB0dY+Tvx7Sqk8a0oBUZFtZkqr94YG9uWIOZ9PrzZiIQGLqwER
 sA+kLfgcig==
X-Spam-Status: No, score=-101.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 22 Feb 2021 13:57:11 -0000

On Feb 22 20:41, Takashi Yano via Cygwin-patches wrote:
> On Mon, 22 Feb 2021 10:51:19 +0100
> Corinna Vinschen wrote:
> > So, what do you think is the state of the console code, Takashi?
> > Shall we start a release cycle next week?
> 
> I think all the fixes and improvements that come to mind at this
> point have been completed. As for releasing, I believe I've done
> enough testing, but honestly I'm not without anxiety because total
> amount of changes for pty and console code is relatively large
> since the beginning of this year.
> 
> On the other hand, I also want people to use new features as soon
> as possible.

Then let's do it.  I'll start with the usual test releases...


Thanks,
Corinna
