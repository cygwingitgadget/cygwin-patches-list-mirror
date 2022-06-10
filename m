Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 8F556383EC69
 for <cygwin-patches@cygwin.com>; Fri, 10 Jun 2022 10:21:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8F556383EC69
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfGs-1nHEOQ34Zm-00ikVy for <cygwin-patches@cygwin.com>; Fri, 10 Jun 2022
 12:21:28 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C5EEDA80970; Fri, 10 Jun 2022 12:21:27 +0200 (CEST)
Date: Fri, 10 Jun 2022 12:21:27 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Have gmondump support ssp-generated gmon.out
Message-ID: <YqMbJwftMtPm+R6I@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220609044731.30872-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220609044731.30872-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:pv0DmekV7ibr+tF0bLcTrXRD6EauRCAsZ2cfbXUw3kx9Fp9+RW8
 gWSX6hsMBCeldkIUgv9wS2ii807Cz18PD5aKtytYCdzSd00/1apvMlTK7bBbkG5IO+vDSid
 jw+SAqYlpn9L3rZPdff2v/qzakDVAL3+s9h0SqjpRxFVA7dV8Ilz2DI+oC6QTV+7zmhAY/z
 jrigR5clOP8DfrEr2lLAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xnvUupRMgEk=:c4aDzdYq/pSoqCIrtYK4E3
 75ZuoAx/B0hf5ubMnQ3OPqZcQ3xFJ5A4l01nonPHKfKO5AtwDMW4fh8KhMP08EM+VeqtkGFtY
 BlKcBLXYC9UjQaaevqv6ZY8ZgFiSU46vWerQRtHAyn4AVh7ixHAM1WuHwclbqe77hyAWx/d/q
 fO4tJtwKXGSOzvDYfvKw/2VHx5A67oDEfW1TLxqODLyS/LXMBxcr8EBv7/ghKJ5+nfXboc4Ku
 g9Gkg9POMz7DNZeRkdV5TyLbc6czDry6Zq3zLDLR+WFBbIBFiXw1rVxQlvaPk3il1dan6gOag
 aSeoHTzMZh1VtSv1VCDMF5xKwbf2kmdjRvCORrPldcCk7re+Ny1T/A1Pc8E70ySwkd8/X1hSx
 h0XPvwpkL6mYeqZ1p7pFgAS9bYyIbU8PAeGUUYxDwp8NGzEoV4wxz2D3l6QjguKBqrSVFEh0M
 vD6wrqVzxgPD1na23GQjKuaFMpfWjXSxDcqy4N2tcW2Bxe6g0kJcDI77D6zTv+DseUNNixu5Z
 UXnV2Djstea1xIB/Xichdt9aDKAz0S9nDo/PnZ/aDf3Dx0qhmZEcaApG/7Qc3dYOzy5oW5JdS
 oDyMtEFvQbhERacvq+US/bDIIidw+nWimSHcL9C0RF0ieHftO6pat+DA6KdOrRweT+cDD4ehG
 Qy36FrZB2Xj04pMlDZNMGY+Hax0S8+kk3skxc3Xp060xoYJ0yt+2tVICrG+ZmroRRHw29xqh2
 4cg/lJX7H47SzhnQcV7bSg+m8RbYt7PDEACRWEIt2z9e/zpkm15aJU5ytJ8=
X-Spam-Status: No, score=-95.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Fri, 10 Jun 2022 10:21:32 -0000

On Jun  8 21:47, Mark Geisert wrote:
> Cygwin tool ssp generates gmon.out files with different address
> resolution than other tools do. Two address bytes per bucket rather than
> the usual four address bytes. Gprof can deal with the difference but
> gmondump can't because the latter's gmon.out header validation fails.
> 
> - Remove the offending portion of the header validation code.
> - Make sure all code can handle differing address resolutions.
> - Display address resolution in verbose data dumps.
> - Change "rawarc" to "struct rawarc" in certain sizeof expressions to
>   avoid buffer overrun faults.
> - When "-v" (verbose) is specified, note when there is missing bucket
>   data or rawarc data.
> 
> ---
>  winsup/utils/gmondump.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)

Pushed.


Thanks,
Corinna
