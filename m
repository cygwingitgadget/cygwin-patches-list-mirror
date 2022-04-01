Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id E1723394740B
 for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2022 12:55:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E1723394740B
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N1Oo7-1o2MQb2YpP-012nWp for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2022
 14:55:46 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 40B1FA80D52; Fri,  1 Apr 2022 14:55:46 +0200 (CEST)
Date: Fri, 1 Apr 2022 14:55:46 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6] Cygwin: pipe: Avoid deadlock for non-cygwin writer.
Message-ID: <Ykb2UihKWV65bGEs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220401084505.2469-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220401084505.2469-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:F7p8gjpjDpIee6gY0S5E2yqkrV5EtNMTbQfT4OMaIN4WnjAsD7m
 8ilp4pWfrsCDwO9wl1aAYUIfVbsyldGpc1y/ysXqxAxS3N3LSSwdbf0roWlCUNdJvwCRNaM
 vpFk9Q08Y7lj/2yudb73fSRSYQLEHxGJCiplu3CM9llVKusPoRfY7Xnw6oCLJ62nOMTbjzG
 bESZhcvxBcgBVwIPrtkCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:irNr/5pugHo=:r7BALESiUGF0N7DOkFi9l6
 say7FHWeK/n1JyrQFtp1LJT3bUeB5WUeTRwoihT0IFpjmUwy/A8AHGlEdf14Em9K6i64cTvCJ
 PpfUEPrpuPclpimOEWnN7rFdUxwP1sBRst+SOEAMNe5u2WuFEOUZysXGpagD0IqJWNlrQRWbQ
 ivaCSZPsup36iOFk8hQOaLsnyoTWUsDzZZhZYe53LYwtRyYUVpZ+5nD8bDLSwjkjjTcs2mH9X
 lvryxku8WOfoV6TWNEcyOMwNExJBWkJBUVvq5H1xpRRQMl+ROB1+7/Ev4+RoAMtthXidAj6sI
 vSB9LBuMulELZezfT5EidWd/VZVnGZNA69X3vGzMGgy23NHf7PjwKRuk05B65aSDyo1G2epPT
 8PFdvJ9ppbn/W1NwHQjCSw7Ab0W8qWBnbkQz4+bWB217qZfB6YWpuaiYB3OQjIy4WEoiEbNFl
 dwDOIjFuf5bHDTDmMPq2ia4qPINUYHZFHF9njHNn7W3k/fljuu44sk606EtiIX/IoJvn17pKo
 pAwEYhNfgayTtxifrD2P95HVHEwVeJA6Hy2L7TefJrKTs0yj2v9xRCto62ztzQ5LjPkarYUWz
 gRaAL8R1jJyC+uf99LAtzHVcNe8idwGoco+yVqCHSdrQke9rA03DzPGhRE0iGX4G73asV6G7F
 eYzMTxGMTZMTJtK9nAyl5TPyXBMvCgFnuOpB9o+9vIiu2hmK0TQZ376UvsMIeRPkVB2TFdVjl
 QOIzQP+JbAaollpI
X-Spam-Status: No, score=-95.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 01 Apr 2022 12:55:49 -0000

On Apr  1 17:45, Takashi Yano wrote:
> - As mentioned in commit message of the commit b531d6b0, if multiple
>   writers including non-cygwin app exist, the non-cygwin app cannot
>   detect pipe closure on the read side when the pipe is created by
>   system account or the the pipe creator is running as service.
>   This is because query_hdl which is held in write side also is a
>   read end of the pipe, so the pipe is still alive for the non-cygwin
>   app even after the reader is closed.
> 
>   To avoid this problem, this patch lets all processes in the same
>   process group close query_hdl using newly introduced internal signal
>   __SIGNONCYGCHLD when non-cygwin app is started.
> 
>   Addresses: https://cygwin.com/pipermail/cygwin/2022-March/251097.html
> ---
>  winsup/cygwin/fhandler.h       | 20 ++++++++++++++++++++
>  winsup/cygwin/fhandler_pipe.cc | 23 +++++++++++++++++++++++
>  winsup/cygwin/sigproc.cc       | 10 ++++++++++
>  winsup/cygwin/sigproc.h        |  1 +
>  winsup/cygwin/spawn.cc         | 18 +++++++++++++++++-
>  5 files changed, 71 insertions(+), 1 deletion(-)

When you're happy with your patch, feel free to push.


Thanks,
Corinna
