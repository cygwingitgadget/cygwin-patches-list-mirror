Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id DDB83383D033
 for <cygwin-patches@cygwin.com>; Mon, 12 Jul 2021 18:49:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DDB83383D033
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mlvr3-1lLjoD3fGt-00j2r8 for <cygwin-patches@cygwin.com>; Mon, 12 Jul 2021
 20:49:10 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id ADE40A831D1; Mon, 12 Jul 2021 20:49:09 +0200 (CEST)
Date: Mon, 12 Jul 2021 20:49:09 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: cfsetspeed: allow speed to be a numerical baud
 rate
Message-ID: <YOyOpWGCz2g47WG6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d2c4a9cf-6ab0-26ca-596f-bdd7c0eec227@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2c4a9cf-6ab0-26ca-596f-bdd7c0eec227@cornell.edu>
X-Provags-ID: V03:K1:5aF2725UJkvr+AlPAu+9FmlGsJCObTa27EUTfuDO1WYGJkfI7Ng
 OGwaxUiXxFp4gKU1eCF+yOyn4+yAgfR6OSzZqwS1pPCLQRjOd+ikT4nFIeRbMIR2vMG6FUG
 Q3Qe7S7sqFyOXkWRsuuYu2V8QQKThm3IBWphvNvLDPHxpKlwKUjKsz9nYINqC29IGjbZYSx
 va1TmVjSjM7VXiasReMWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sqapvzZFRIw=:pobXiOe+QVOMR/Vt/w3rme
 UQBK2d+sich37RQQw+c6RDJ3h7kubgp8wsHHdutdAZJh4CMj49wfBjnV9ifwDR0QQRcPL4JSJ
 DlKRLONYJGbaT7EaLif9nLI0nUUdqsmoTF4dNgeDZwDbmFd27elGunboNBzDp1luI/Z7uUvmV
 9HXQPz5odnDAyRa37iaG9+bEbY1Xhq/alMRM8G19o0HW4Ti41kvvyEOmI9gZi3+D19KvAktdW
 rbolJ7VT4cDVAR45Tp4kk52thVer00ALbQ5hWNnguMit/89x5JJ5N5pSbD0Y087wHhHBev+A7
 lH4RmPGtj9uEacRMG0/Oq2PBPkXVYPSvRIIo5yMDN2dLVzWY9SjxPy3uHD3W4z3suioFwWNIF
 WUnfpxcIgjiiSb+X5OJi1AgvHfGMkplO6+XQw4ft2S/My+gLTt4g7Z9eOBEXXNizqZ22jY6EN
 LD/eqbqK6PS0tLH1/gswPIOavSDa9ASrM4HwBPiRtUrIyN03SrzvpISMzhdq0r95uurqdLPfo
 3KS3eqVxVLxnnBjhaAW0RDndMA+VPqI0mY+6QbHqfmjSgSuEOCt2CrWnxs47YRQWJsavCLNuC
 2CPmF1/O89T3hTGdkEtD+pTD2z5VBgTuiuXh6+G2V6jCPLEBcBhZH1F5rIACQASJOEXPjasCm
 DFBSp/fq+Ims1TzIVVUVuRjCM76HNEUPAuI7sUNtCWVf13wdNPG7hF4lKUHDDU3jzCdR1sW/U
 jPYb5iN6SjuKr08O/NlfofBoZpPzwOfA7KLR0wNnpdQGk1hR7Vwjv6vinvhLsfr85clI3X0ll
 Pi31sa9rIynurSGt3jXw7Gp+oN3rMQhr2HWQz9MviulEAEUKfspsJfAN6SYGaPimZLdwjVURy
 ZWXI+Sg3owFTqGLfLBkQ==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 12 Jul 2021 18:49:14 -0000

On Jul 12 08:57, Ken Brown wrote:
> The attached patch addresses
> 
>   https://cygwin.com/pipermail/cygwin/2021-July/248887.html
> 
> I don't really understand the GPL issue, but I hope it's OK.
> 
> Ken

> >From 0321ecd99050ad702a528797af48ea4d01531508 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Sun, 11 Jul 2021 07:04:58 -0400
> Subject: [PATCH] Cygwin: cfsetspeed: allow speed to be a numerical baud rate
> 
> The Linux man page for cfsetspeed(3) specifies that the speed argument
> must be one of the constants Bnnn (e.g., B9600) defined in termios.h.
> But Linux in fact allows the speed to be the numerical baud rate
> (e.g., 9600).  For consistency with Linux, we now do the same.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2021-July/248887.html
> ---
>  winsup/cygwin/release/3.2.1 |  4 +++
>  winsup/cygwin/termios.cc    | 59 +++++++++++++++++++++++++++++++++++++
>  winsup/doc/new-features.xml | 11 +++++--
>  3 files changed, 71 insertions(+), 3 deletions(-)

LGTM, please push.


Thanks,
Corinna

