Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 2B9E33895475
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 10:04:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2B9E33895475
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5G1T-1ithkS3rTZ-0119FM for <cygwin-patches@cygwin.com>; Tue, 19 May 2020
 12:04:33 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4AA8AA80F7E; Tue, 19 May 2020 12:04:33 +0200 (CEST)
Date: Tue, 19 May 2020 12:04:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Call FreeConsole() only if attached to
 current pty.
Message-ID: <20200519100433.GS3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200517023404.240-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200517023404.240-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:ylSp3lSFlVZ9F/MtrTz3fWy2byzGXC031yCZpIsxzVqbiI9k6lk
 YOvxiL+nbDK+D0dLYnEhRkbWmnXUg9CDTwzxeFolS5GdgfxRp+6rGvUwD5Y08mDiN1IB/qf
 Le1H89/SOM73MOHe4aXSRTpXoEuHptHuvq1fN+WY+tbWw1Ii8XQCfz8sPnZZHyPiGs1Myte
 99dPYJoCjO26/Vkxx8Fgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:COqCm1dvwAk=:/ZQDCtipdq5CIobxowzNuo
 4WXXt8/ULIWLDtQghyHtsSeNXmiSVPzr+/7cFEODuJN8PwwH537EyIQR88Z22eY+vvZPu8meH
 evcvHnf7/56xgJTXVhfGjIoJ4wijEGuka6sJxi79xT7JfwMeJzMjGx6erDb4+fBtLMkwf6y5j
 BVZ4hnlPJJjyVFduOocQYf4eJTR+hDrP71te1vRtCUjeY1FJwbykFRXdSoIVPbICaKQ8M4IYK
 TZDQaaCJhuXhQNCU7TCgqpdN45nni5qXGPBVEOJ3mA3EqO1oLsgq9ciPxY582efi+QtBumAfU
 fMCAS39/4sO4R/EI+PR3m0nancvX9CUaa/vGnQQaB2pa9ckkF4DpGWjcI/gij6T020PuSCCo9
 zRRQNxsJF0Pk22wpHBBDjXuv0GgEcKw/5nCszSICVBTJmotu9eWKeyJAUvSg3XAycW5MQaqxw
 cx9MkReVDVk9EH2MEsBOypRVOrye5TI1nTDwUsvwr1pq06VYLel92E1xiYZVXUSVOok8sSF64
 UIdfdoenneVn+HKBSwQiJpHz8jvwF7wrDu2erepbfBTs6HrPYtDWx+rGcj+rbtfe9GmzEXkAZ
 NlZV9Nkg1rO4xsFKQrItSIaIGrI3A4hXhtxmbj5AmXIkq93EcpNre1AS+zjuG1ePod1mpJuCl
 hwpF+vskXjOeTlCSGOcevhsDlN5w+6rs4amDd9JHDxwJU9Xib9SdRKjmTKxdu6A7/yaR4V1EQ
 KELspO+mhd+u9wFcLEwSKvhhgFtq4PaOTIEr1l1IV6l4y1Zli65FEO2jxgRfGFybmdFNgcZ5z
 CKDiqvWgQN2dYoo+tupadQMXQC8ykyYPbcPOnJTmgbQQaoaaaVD8RAfeu0q8Q5M94O0EQxu
X-Spam-Status: No, score=-103.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 May 2020 10:04:36 -0000

On May 17 11:34, Takashi Yano via Cygwin-patches wrote:
> - After commit 071b8e0cbd4be33449c12bb0d58f514ed8ef893c, the problem
>   reported in https://cygwin.com/pipermail/cygwin/2020-May/244873.html
>   occurs. This is due to freeing console device accidentally rather
>   than pseudo console. This patch makes sure to call FreeConsole()
>   only if the process is attached to the pseudo console of the current
>   pty.
> ---
>  winsup/cygwin/fhandler_tty.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 8547ec7c4..467784255 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -708,7 +708,7 @@ fhandler_pty_slave::~fhandler_pty_slave ()
>    if (!get_ttyp ())
>      {
>        /* Why comes here? Who clears _tc? */
> -      if (freeconsole_on_close)
> +      if (freeconsole_on_close && get_minor () == pcon_attached_to)
>  	{
>  	  FreeConsole ();
>  	  pcon_attached_to = -1;

Given it's used three times, wouldn't it make sense to put the entire
"if" construct into a fhandler_pty_slave inline method?


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
