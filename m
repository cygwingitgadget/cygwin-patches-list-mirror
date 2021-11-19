Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 6E80E385800F
 for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021 15:51:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6E80E385800F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MS4WT-1nFqHQ1lmN-00TQTR for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021
 16:51:07 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9C3A9A81057; Fri, 19 Nov 2021 16:51:06 +0100 (CET)
Date: Fri, 19 Nov 2021 16:51:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigproc: Do not send signal to myself if exiting.
Message-ID: <YZfH6jj7AqbpSTn2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211119115043.356-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211119115043.356-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:diZXKmhS42KhOeCkBXg2XXz2zRFJ1sCl52LSzur18rUpx+XU5Xc
 /CopFsfuoBH6JU0XYIkGdMhET2WhcBrAEuAnepdcpmvjszrtwR8rnPfH92mVxep70A3cokk
 b4YAiNxnm5oeGvMSD73og32MNFrA2JmlALxAR/bNcfVz+mIDyAIWTkBCq8tkZx1zjykVTfp
 XFm87844I7j/Kb26JrGiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N3fhczzmxjw=:3ZYiQYT1ptkS/FRlnu72wy
 4zy2h5lHtdEI2vWZzX67kMrFRbwP+mLf0kv9A5G3C4ZpiLDXcXez8XQIsZ8Ot44XtrsMCxB+C
 YayxQppkAQZ3jMpsWEjlIYHQV4po8gqIv5gEc4WlTrPRmEl84Z71tT6J0s5Uw/TBOV1n4+Ic3
 6Yc1zjaFE2XjImBsQPeofvIDN6DqhN0WfcXt5fksJzD/vON29nnOm617PJ+IHwmSx+RrUzSb+
 +rH3PbGgfoaRJKkbMiarfkH1UsaaFXMrW/buA5jR4tEEp8q5ZZl2iLUHtfOBDS73eGyYV97aN
 pw8YbIGmqw5gRC4lvrhyO1qxBv+GUAs2ALX4Ub3dhyu/4y8KdKnDWkb94WRN4WbkyROKQY+9t
 9n4UwBnIir3RFk+JfIil0zFJ/A++DosocMAXHfrxSG8Y1EjSOyw9IK1JpqICbEyYeSkLLUCi7
 nxIXvRHjSnRqfWceIqsB/lWCvmgVvAcaSqHNY1aZok4X9EF81hNk5ae5nneANx74+SCTG+nLj
 zk56QybdM/2jv3h/NjX6FEnJAvz8v0cgeo9HBU3lzjJk6l059DBKz1mnECtB0LsP+Zr95cyCE
 KX83gRvd1FuD8U5PEL3LZi3bvyPSItwUisT3034AKpveJ5kbYUGgvvfimQXDEKW1HlbhQdvvE
 SHTnxXWJeNycSS86YNBO5z5ByzJ9UarPD1EpS+sNSuj68hfq4o53UY0pS4q33cNcHka+yNOL1
 IcZC/duMNgN3KN/x
X-Spam-Status: No, score=-105.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 19 Nov 2021 15:51:11 -0000

Hi Takashi,

On Nov 19 20:50, Takashi Yano wrote:
> - This patch fixes the issue that process sometimes hangs for 60
>   seconds with the following scenario.
>     1) Open command prompt.
>     2) Run "c:\cygwin64\bin\bash -l"
>     3) Compipe the following source with mingw compiler.
>        /*--- Begin ---*/
>        #include <stdio.h>
>        int main() {return getchar();}
>        /*---- End ----*/
>     3) Run "tcsh -c ./a.exe"
>     4) Hit Ctrl-C.
> ---
>  winsup/cygwin/sigproc.cc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 97211edcf..9160dd160 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -603,6 +603,10 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>        its_me = false;
>      }
>  
> +  /* Do not send signal to myself if exiting. */
> +  if (its_me && exit_state > ES_EXIT_STARTING && si.si_signo > 0)
> +    goto out;
> +
>    if (its_me)
>      sendsig = my_sendsig;
>    else
> -- 
> 2.33.0

Isn't that already handled in wait_sig?  What's the difference here?


Thx,
Corinna
