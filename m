Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id A75F03858D37
	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2023 09:25:35 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMFdY-1pWtFw0xUM-00JFsD for <cygwin-patches@cygwin.com>; Mon, 09 Jan 2023
 10:25:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 84900A80CBD; Mon,  9 Jan 2023 10:25:33 +0100 (CET)
Date: Mon, 9 Jan 2023 10:25:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pinfo: Additional fix for CTTY behavior.
Message-ID: <Y7vdjTREYWiLAJ9N@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221228083516.1226-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221228083516.1226-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:LhGTF9HE/CN4s4dfuM5fEsYQxhXhhzI/2lEZfJBB95EkGGEhh84
 j1rSFAtLd/QDmIqCky3rPn3St02Mc8vHW67886lFB3Id+TUb2yFwlsn2AAlsX5GzOLcebWI
 4DvK5L0hKp5YOINm0dbDcPz+wOnDumjcT8ufsConsC/3nryn7Mx0Oi9aRh/fpXodBOJNmp2
 B6WzbXeN6SikNlodqe/zg==
UI-OutboundReport: notjunk:1;M01:P0:MZmYcshHq68=;IkwogjQ1U0SsSH2S15QIUcwnd2W
 ecNsQtAvsROq4Y+3qNBVAWgP1IJzVc0oV8X+B0lyJ4iE3GGFLBVWM8iYB/mVKR0E3tqcOC7Uh
 DNpyOoaB/hKLsJWBUO5mTcFlZcmkX0WR4+rmVXNs1bLc9YqJk9jO1zxp+m8UiRD5RvWUnMMGC
 m0/cZYxjIcSS2IGic4MMsg0lvhRhRMinsOu8MdR2AcYXT5SZFF0GETYsijPhQxfe2FKfHVKAp
 DJI6nnvNDUa7gSr3yZom1yRtmiCLQXJdp/7SgtfSdZbO6lfJROmkpCz9S3ubKpqKWRmn9O1N8
 2X1pLZ3DuhuisE0HdXeXVlsNf5+N6dzBTmeB1Bp95j17mbh14wF3hBb708iW6BnFsyz/fFExr
 5WFe1oPQEkxiUaG82OKUvpXFhM7tAEc8uFsSt5vgXXJV4i3SGdKAQs7XHDyH13UVeMk10tbUr
 5jds43QAhmXPbBQD7hPpCuueUTBW3sT8+psaAcucnyFnINW/FX6r8IxnXOlRP5xfoOQAgp/i+
 /GuSTpMCYPLmKOqInmN6A6J/hPxx6PdwzR+ce1zvNrMxgKILq6wbnqnkD5X63ieaYLuW1OMlK
 nO+HEXYywqI9BX5jh+1BLnkHsCcX/HMZDbTVkpVy0WjoQ1MfsFtu2edvBIKjIVvHu/XVNRzHy
 GFEoAUeh9hVnyJasSh9GmT0mec1X6WQbZOSTpaeFAQ==
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Dec 28 17:35, Takashi Yano wrote:
> The commit 25c4ad6ea52f did not fix the CTTY behavior enough. For
> example, in the following test case, TTY will be associated as
> a CTTY on the second open() call even though the TTY is already
> CTTY of another session. This patch fixes the issue.

The patch is ok, thanks.

But while looking into this patch, I realized how confusing the old code
is.  An unsuspecting reader will have a really hard time to figure out
what ctty values of -1 or -2 actually mean.  The CVS log entry from 2012
isn't enlightening either:

  On second thought, in the spirit of keeping things kludgy, set ctty to
  -2 here as a special flag ...

Would you mind to introduce speaking symbolic values for them and add
some comments to make them more transparent?

Also, given this was a "kludge" from 10 years ago, is it really still
needed?

As I said, it's confusing :}


Thanks,
Corinna
