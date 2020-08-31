Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id A519D3857C50
 for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020 08:16:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A519D3857C50
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mow06-1kw8HV4BRe-00qVAv for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020
 10:16:52 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8841FA83A7D; Mon, 31 Aug 2020 10:16:51 +0200 (CEST)
Date: Mon, 31 Aug 2020 10:16:51 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-ID: <20200831081651.GV3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
 <20200828134503.GL3272@calimero.vinschen.de>
 <20200829042554.e18de504a93bb80da347e858@nifty.ne.jp>
 <20200829201228.b327d38eab10a64d941f99c0@nifty.ne.jp>
 <20200830124925.GQ3272@calimero.vinschen.de>
 <20200831122647.7c337aaaa77cd7e0be7743ac@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200831122647.7c337aaaa77cd7e0be7743ac@nifty.ne.jp>
X-Provags-ID: V03:K1:7LvBndtER0Ivu7b1XzAZXQ6Tp+oBIqCRsaEwhAwYByqQP9cPyW2
 QRHNgfTC9GKS8N6+LwlHV6KwramyDJE6nXpT2HUBWQyINDwI3ltEcJGxjNAG//jaLLj+3+e
 0HqFuu7xfGq82xgaDYocTwH73jnKgfYzpGfyHBX55xRgveRbU6BjV+55bkMg/wkVsUOAiCi
 BKIlNRogJ7SnYcP3x/ynw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1HrwFIWeoQE=:lHX+tr/Oq+dyf98hC5djFZ
 UOiKzNdtH9gpMVDJo6XWnsKmjF+aXzJksp9qu1G2dQYVGj8UyccFYjFQSj6pVc+Ukkzi36Qai
 6HzKLD1pqs3BIUazUH8agscHjNtX/JfJcq7kb+a2zY6SLcTlbhHMs0B2i6S7c0qqiYQs8FQv/
 E4rnWi7bTyFzyiwo+bVcRruIrGucTJn9+hu9TDiL1Y/SsrR+WYVTD6DCXU3ajq5pCJlq+QJBi
 AJp+kpFqvaSDziL2tjNeMkXUbjBSEKRARN0B5Yt7zQcxWX4hE8EojwnmryaYVFYn6zm9x6BMT
 ma6JwYjThpn7+nDYNRUzLebTUbTR6aNxUqh1DgL8j+g2VWvTo17dC0Ff5cQ8thCEXRLkG4ZLZ
 Kg/pp98UhqpOnXvpXwmgFDtoCf2AeYgH7erPh2fRvblZvbk29Yv1kNBj9wEWxwNBbMOGxmMnd
 mIi2XVMfY+jBJ0ZGdajApMy4nkpv98TZ3ZKcOyxI2Ks9CloJdpCmpIS3j3qGOtM67ml2jaomt
 zR8GZ57WkqpJoNYuEhBZ9srsxMPLks5iDXYwjROF8s+dOp6RxDThuOVSpwcNp0p6JMHDzuKB3
 DzOdJReg0qCSVax6sw4e0YCNCzJEKS9U6LAMp9Q3mbdP/mTtduSudCLVHkUBfKj8I5Rmvu0Xe
 Ju4UdjztNYLbHBBxEtsGeWRN1c1JYdUoBBLpNvKMt5VMMm4tWpqfvES5V9FjVHDYRkGn09TTf
 Lnx8+K9ROewqq2ry1+WOdGLCntxZF2yskp0cY8cCy97snghy1hyNcYQKsWmhI/aHSNCdBV3tq
 tnRpvH8N0Vo2uJ5lMAuXxA+5lWed9AeNeBUEzlRqBTEWCM9GXCXnS15vlHt8x2jTJWiOiImzH
 0d6eVoAxo4W3NYApKbiA==
X-Spam-Status: No, score=-100.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 31 Aug 2020 08:16:55 -0000

Hi Takashi,

On Aug 31 12:26, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Sun, 30 Aug 2020 14:49:25 +0200
> Corinna Vinschen wrote:
> > I like the idea in general, but isn't there a noticable perfomance hit?
> 
> I have measured the startup time of non-cygwin process
> with v2 and v8 patch.
> 
> mintty with v2    : 92.7ms
> emacs-dumb with v2: 22.8ms
> 
> mintty with v8    : 94.6ms
> emacs-dumb with v8: 22.7ms
> 
> There is not noticeable difference more than measurement
> error.

Great.

> By the way, I have implemented timeout strategy for CSI6n, you
> mentioned in the previous comment, for a test. This check is
> done only on the first execution of non-cygwin apps in the pty.
> With this patch, first checks if the terminfo has cursor_home
> (ESC [H). If terminfo has cursor_home, ANSI escape sequence is
> supposed to be supported. In this case, I expect not to display
> garbage "^[[6n" even if CSI6n is sent because the parser ignores
> unsupported CSI sequences.
> 
> With this implementation, pseudo console works in tmux as well
> even if TERM=screen.
> 
> Please have a look v9 patch attached.
> 
> The performance of v9 is also checked.
> 
> mintty with v9    : 93.9ms
> emacs-dumb with v9: 22.8ms
> ANSI without CSI6n: 22.8ms
> 
> [the first time in v9]
> mintty            : 94.8ms
> emacs-dumb        : 22.5ms
> ANSI without CSI6n: 63.5ms
> 
> Most of the results are the same as v2 and v8 except for the
> first execution of non-cygwin apps in ansi terminal without
> CSI6n. It takes about 40ms (timeout) longer than dumb terminal
> in ANSI terminal without CSI6n support.
> 
> However, this causes only on the first execution of non-cygwin
> apps in pty.
> 
> I think this is the most reasonable one I have ever proposed.

This looks good, but I have a few nits:

- Don't use GetTickCount().  Use GetTickCount64().  Otherwise the code
  is prone to the 49 days tick counter overflow problem(*).

- get_ttyp ()->pcon_start is set to true twice in term_has_pcon_cap().

- Following the maybe_dumb label, you're setting has_csi6n and
  has_set_title to false, but these are the default values anyway.
  Also, setting has_set_title to false in the preceeding else branch
  seems unnecessary.  Do you want that for clarity?  If not I'd drop
  them.

With these minor problems fixed, I'm happy to push the change.

(*) I just noticed belatedly that GetTickCount() is used in the tty code
    already.  Can you please change pcon_last_time to ULONGLONG and use
    GetTickCount64() instead?


Thanks,
Corinna
