Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 032853858406
 for <cygwin-patches@cygwin.com>; Mon, 20 Dec 2021 09:55:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 032853858406
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MWRe1-1mxpIg1e3f-00Xx7E for <cygwin-patches@cygwin.com>; Mon, 20 Dec 2021
 10:55:45 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5742BA808FF; Mon, 20 Dec 2021 10:55:44 +0100 (CET)
Date: Mon, 20 Dec 2021 10:55:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Conditionally build documentation
Message-ID: <YcBTIABhBeOeIHWv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211218174721.12448-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211218174721.12448-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:Th7raIwmNolJXOaKzRN8463KnDZX4xwEPdXk0/UUQ/qbo+NK1Zd
 p9NSE5eJvj18pphCixsKeal3rIUfwbKxQr0EUDeR4A9PdOpYVPU6fZvtQIqLjOE5vUEjQqB
 tviLRtKeQIVtKWaC1fBmyGTSoSpcPZRzGNnFoHlLP4yVKmnGcprpu83QeF/qfiycIdWlrKJ
 0YadyzjBKumDp1ipf2n8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PKLFdDtlzJU=:aP1XX336hMBUu2ilKBHZB3
 Xg4IGabQaB1Qt8MGteABQAr0za496Ga0HWv0Xq/q1BcfQg9Ue3SYEyoJtJLMoB5C8FcgnA57o
 pLoTkaBwyZdRV11YvEBio0nWJREpnpvXn7cxjG2cdmDlUdNs3nBY6iwpW7JytwDLr9ZpKgFeX
 bI3VUPqdzy712aA/l8g6PF2qBUv+VX2sd604SYO28v30nl321u6sSJfWXq5QPh+4BgTCajujT
 PX96nAFsbWk6Iowmrm/SzOOABLXUIWzREnwZyEa1wVrj38UCYq+TUDGGhxUSEpT4p5cKBW5fl
 AwA2d41LE6B08ykqrl3mBUZfePGsvUwWnHxWohIn2NcHxE5Lg+OYQb2Di8wDb1kAVYiYjClDq
 JKv4fPw2vlHT8OrNbfun+Cdzd03bTXshOb2Ylns8NmVykbEvleKxpIVCIsc+uzZVn2r8SULKX
 yxhvNjKlcusWH4vjixQtU013PxIrTv1c6kRKBI69RbtNHpHJvVfu5b4LAQrLbNvI+Z7DRh4Xi
 JIOtl/mDxH3siV+Z3NLjyI+1WVEqtVuJ3lc4q4wgsV6By7c1PJhQQeCt+lnpff6/E6mSoqttJ
 stceR2/lhyJCi8ULKeGDl0YBihkUX3ci9OU31VgWPiN+mZy81GOzXhFDtEsklieudmLZVRnsJ
 OILjVLETh6wjPvytEo9igFQddEhoLa3bHb0zqVcjZAzVRDPq/H2TLmP5QgcCQDyd2Hr2gY+eE
 mx3cDWPtNxNh3arm
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_FAIL, SPF_HELO_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 20 Dec 2021 09:55:51 -0000

On Dec 18 17:47, Jon Turney wrote:
> Add a configure option '--disable-doc' to disable building of the
> documentation by the 'all' target.
> 
> Check for the required tools at configure time, and require them if
> building documentation is enabled.
> 
> Even if building the documentation was diabled with '--disable-doc',
> 'make -C doc' at the top-level can still make the documentation, if the
> documentation tools were found. If the tools were not found, 'missing'
> is used to issue a warning about that.
> 
> Update instructions for building Cygwin appropriately.
> 
> (Building documentation remains the default to increase the chances of
> noticing when building the documentation is broken.)
> ---
>  winsup/Makefile.am             |  6 +++++-
>  winsup/configure.ac            | 25 ++++++++++++++++++++++++-
>  winsup/doc/Makefile.am         |  2 +-
>  winsup/doc/faq-programming.xml | 14 +++++++++-----
>  4 files changed, 39 insertions(+), 8 deletions(-)

Please push.  Both patches.


Thanks,
Corinna
