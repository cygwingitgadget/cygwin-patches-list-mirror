Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id B2E843858034
 for <cygwin-patches@cygwin.com>; Mon, 22 Nov 2021 12:45:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B2E843858034
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mv2gw-1mXTFf0cbo-00r3Nr for <cygwin-patches@cygwin.com>; Mon, 22 Nov 2021
 13:45:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7C51BA80D65; Mon, 22 Nov 2021 13:45:10 +0100 (CET)
Date: Mon, 22 Nov 2021 13:45:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigproc: Fix potential race issue regarding
 exit_state.
Message-ID: <YZuQ1nUy1bdFvNRt@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211119183905.1878-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211119183905.1878-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:mCjtNFvc7pWNeuGGxg8OjY5ycrvICwk6pLunP8Bl6+T+eVmCh7U
 lC7rffcuSF4cdeycJ2gGYQb4CG25wUgOf/L4VCtkAozZpD0JgtzmL6sDxy/X3t1eLCyOsKI
 M3MQoqv6wUmdhesvz8ZVupoi1evfYG5PBgOFqQwQicBGP6T1gOXtDpGv5H/Jy5ph2yXm9Gp
 tB8TCNlemVmkuB0Ra5Tag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UCMTpA8owEM=:HjT5M21lPVShm2MFcXzxBu
 Eok1Cmwu9XFzo/Gba+lgP0PbBbpbwjgQGU69OzMgRGfUEqViPtns41VdNnOL/ZpM11MfnKSRu
 t/psKFPFbNqcSm4bezqYUajSr04gfI6HhpSX6vSprTiXrMGeVX11clXAlPtlSvXY846sqow18
 6+EAFC/BEz2RPMVNcYx7IasSy2gj+r5DiobWAo6G1aUyupWSJeZI04F2pTDKD7I0Y0w95jJg8
 +zhWgQZ4rQCc0pdMUsgA/dkchh4u0vRwrMzn2xecMb6Ob3/RWMIx25I7lheJ1V1EFGX2PPl+t
 Ecv9jPWCtGIHOKmIx2CNFMwTpaqTaULRhas92cxZS1dGh5Y9q8nEIQkbxZe13ZPgh86RFnHqV
 QuEhVTCHTjiJvJ9if8kh7Jnw8mykyQij2fcOSNH9c97UOZq5xwFac9TocaP9WV9xMJJu6fKmx
 lwPBlMy++moaOgy/Kxf+EtX4g67IX7JSWkr6VZmFOe+VDKRiivuqD6zGCFhRwlG6NZw4qokAr
 o4JgyQ3FStLp7bG8asc+/LO8uLW/V4eRpr4zY6vf0n2TykcavvPKX4aXZqn9JoXwDASva+12Z
 8qYgdlFYb8SrFuci+uDe6tuItNKnjadAk6aIBDWdl4OQFeenWtHKBtR8q987JDS9buh5Jv/cD
 dZw0RlWmPkxERe/DsSmLZVOAEUn4RQXEQeehDSzEbkEaQiTap3wLShAWl+ybLUdbN1rsQ6YoE
 hu9EKkoNXFZaKcHD
X-Spam-Status: No, score=-99.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 22 Nov 2021 12:45:14 -0000

On Nov 20 03:39, Takashi Yano wrote:
> - If sig_send() is called while another thread is processing exit(),
>   race issue regarding exit_state may occur. This patch fixes the
>   issue.
> ---
>  winsup/cygwin/sigproc.cc | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Please push.


Thanks,
Corinna
