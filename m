Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id E2122385782F
 for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020 09:48:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E2122385782F
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 07V9llbt018446
 for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020 18:47:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 07V9llbt018446
X-Nifty-SrcIP: [124.155.38.192]
Date: Mon, 31 Aug 2020 18:47:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-Id: <20200831184755.fae34e601863a9dcdd54864c@nifty.ne.jp>
In-Reply-To: <20200831081651.GV3272@calimero.vinschen.de>
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
 <20200828134503.GL3272@calimero.vinschen.de>
 <20200829042554.e18de504a93bb80da347e858@nifty.ne.jp>
 <20200829201228.b327d38eab10a64d941f99c0@nifty.ne.jp>
 <20200830124925.GQ3272@calimero.vinschen.de>
 <20200831122647.7c337aaaa77cd7e0be7743ac@nifty.ne.jp>
 <20200831081651.GV3272@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 31 Aug 2020 09:48:14 -0000

Hi Corinna,

Thank you for checking the patch.

On Mon, 31 Aug 2020 10:16:51 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Aug 31 12:26, Takashi Yano via Cygwin-patches wrote:
> > Hi Corinna,
> > 
> > On Sun, 30 Aug 2020 14:49:25 +0200
> > Corinna Vinschen wrote:
> > > I like the idea in general, but isn't there a noticable perfomance hit?
> > 
> > I have measured the startup time of non-cygwin process
> > with v2 and v8 patch.
> > 
> > mintty with v2    : 92.7ms
> > emacs-dumb with v2: 22.8ms
> > 
> > mintty with v8    : 94.6ms
> > emacs-dumb with v8: 22.7ms
> > 
> > There is not noticeable difference more than measurement
> > error.
> 
> Great.
> 
> > By the way, I have implemented timeout strategy for CSI6n, you
> > mentioned in the previous comment, for a test. This check is
> > done only on the first execution of non-cygwin apps in the pty.
> > With this patch, first checks if the terminfo has cursor_home
> > (ESC [H). If terminfo has cursor_home, ANSI escape sequence is
> > supposed to be supported. In this case, I expect not to display
> > garbage "^[[6n" even if CSI6n is sent because the parser ignores
> > unsupported CSI sequences.
> > 
> > With this implementation, pseudo console works in tmux as well
> > even if TERM=screen.
> > 
> > Please have a look v9 patch attached.
> > 
> > The performance of v9 is also checked.
> > 
> > mintty with v9    : 93.9ms
> > emacs-dumb with v9: 22.8ms
> > ANSI without CSI6n: 22.8ms
> > 
> > [the first time in v9]
> > mintty            : 94.8ms
> > emacs-dumb        : 22.5ms
> > ANSI without CSI6n: 63.5ms
> > 
> > Most of the results are the same as v2 and v8 except for the
> > first execution of non-cygwin apps in ansi terminal without
> > CSI6n. It takes about 40ms (timeout) longer than dumb terminal
> > in ANSI terminal without CSI6n support.
> > 
> > However, this causes only on the first execution of non-cygwin
> > apps in pty.
> > 
> > I think this is the most reasonable one I have ever proposed.
> 
> This looks good, but I have a few nits:
> 
> - Don't use GetTickCount().  Use GetTickCount64().  Otherwise the code
>   is prone to the 49 days tick counter overflow problem(*).

This does not matter because the code is
  if (GetTickCount() - t0 > 40)
rather than
  if (GetTickCount() > t0 + 40)
and because DWORD is 32bit unsigned integer.

If the overflow occurs within the timeout period, for example,
t0 = 0xfffffff0 and GetTickCount() becomes 0x00000002,
GetTickCount() - t0 equals to 18 (0x12) as expected.

If the code is
  if (GetTickCount() > t0 + 40)
and t0 = 0xfffffff0 and GetTickCount() is 0xfffffff1,
t0 + 40 equals to 24 (0x18)
so GetTickCount() > t0 + 40 is true against expectation.

> - get_ttyp ()->pcon_start is set to true twice in term_has_pcon_cap().

pcon_start is cleared to false in master write() if responce to CSI6n
is sent. Therefore, it is necessary to set again after the responce.
I will added the comment in the source.

> - Following the maybe_dumb label, you're setting has_csi6n and
>   has_set_title to false, but these are the default values anyway.
>   Also, setting has_set_title to false in the preceeding else branch
>   seems unnecessary.  Do you want that for clarity?  If not I'd drop
>   them.

You are right. I will submit the v10 patch.

> With these minor problems fixed, I'm happy to push the change.
> 
> (*) I just noticed belatedly that GetTickCount() is used in the tty code
>     already.  Can you please change pcon_last_time to ULONGLONG and use
>     GetTickCount64() instead?

Same here. That does not matter.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
