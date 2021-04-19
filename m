Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 34249385E013
 for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021 14:19:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 34249385E013
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McH1O-1m4Gig1pz2-00cf2u for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021
 16:19:10 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DA2A0A80E8B; Mon, 19 Apr 2021 16:19:09 +0200 (CEST)
Date: Mon, 19 Apr 2021 16:19:09 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make rlwrap work with cmd.exe.
Message-ID: <YH2RXQG9RT0V5WNG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210419115153.1983-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419115153.1983-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:qJpclQduIzxjl9kg9kfi2IsAlwnXrVNxcn+OjWy2SDWLoXDNBr/
 pjmqZXfrjNUaEhqp+CTVgiA72Uzo4cwwtJIlbBoQLqEgfC2s7KzFmqIY22V1fPqYLGmdD4Y
 NR03eb4XCMXjIQwHUlbU2p5Avv/Jvb/wVpXXRWA/MxYB5yW/8pvXNAxVwV/aQuZUjWO6wCC
 MEI+uX6QhMS8wIxwehhwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQaknhMdZ4I=:mvokeldPVswtA5KSOYz0Jd
 CsS5d9LWueyC51BGxFYHptkQpeBOXWLu9zVWmwItaphCS0uCVJo6bveGykmzog1e2GJ1iliuP
 7xICWHTc25oZ2XD/S2DGkAvHmILVkuyYDsweIkzCwrHUDvds5CkbqsB7KnANknv9PR7ARw7Zv
 NCNBnyRbFdH7OkYpCUXMY69J0cDfGLKp0FTR4Xmj/5rB0IK3QK3L05MgnjsPAR7j8d+hcHD0f
 aLdkeuj2kZoeU3O01RYUSaKdgwslwViE3UB08pDlaQSySLbWJKzc1LLdkgURhGIdFuRIkJQ/m
 sf7GvtISkTPqC+bjR6eW7l33JJk3vpfdfNqANjqqOd/npKWzE/u5iB+YhSR5YEE5b9YANZDiD
 fGJts5vERpIiKs4RGeZE3h9Smd1Vs9Nk2c6HOw5SxKePCL1ckYoAFumWkIAzZnnHOlUHpIsQU
 a2Vy2F0IFzCdt3f3VZG4/FRkl+kqa4o9EJUJitj9UE0bG7niWRYROzsZRpYxZ+Yp8VmAqT5jU
 HBWb837d2uoa78y2H32P1w=
X-Spam-Status: No, score=-106.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 19 Apr 2021 14:19:22 -0000

Hi Takashi,

On Apr 19 20:51, Takashi Yano wrote:
> - After the commit 919dea66, "rlwrap cmd" fails to start pseudo
>   console. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index ba9f4117f..d44728795 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1170,6 +1170,8 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
>      }
>    if (isHybrid)
>      return;
> +  if (get_ttyp ()->pcon_start)
> +    return;
>    WaitForSingleObject (pcon_mutex, INFINITE);
>    if (!pcon_pid_self (get_ttyp ()->pcon_pid)
>        && pcon_pid_alive (get_ttyp ()->pcon_pid))
> -- 
> 2.31.1

this patch doesn't apply.  Does it depend on the race issue fixes?


Thanks,
Corinna
