Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 8D3EF3851C3B
 for <cygwin-patches@cygwin.com>; Thu, 20 Aug 2020 17:29:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8D3EF3851C3B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mhl4Q-1kdSIk04Z6-00drqV for <cygwin-patches@cygwin.com>; Thu, 20 Aug 2020
 19:29:54 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 53C2AA80D14; Thu, 20 Aug 2020 19:29:53 +0200 (CEST)
Date: Thu, 20 Aug 2020 19:29:53 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] GCC exception codes
Message-ID: <20200820172953.GT3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200820145600.21492-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820145600.21492-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:k6ORyFcyq8v+t+N0M+wK/AE4hW4a6hpKx3quPct+QUg4FxdvDGe
 o8n7FRHcgUmrqkZ70ansxEYffGK51JjFLPB0bDhnsJa58atujB3w7pFwFvR7ftHNbNpbcOK
 coH984ANBkrziGGcBehWUYOjeU5E+NWGebhyiT2NUc9/M72uNddWPauNfl7DsMigdawdV50
 VGufLIVde+eTvjWyDfqRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vtYC/Lp195k=:lURsOAy6RXMK65a8rbnSFu
 WD5jPJ84NFcpdC3WexhVHnE9oeRqd4p5QbcjrAn/rXXSMRXSyYQFF0SU5G26Vve+LMbISkdRq
 rcpXKZ9V03aWx8WKEkNBI4uswH13N9SqCXsNgg6KEJlM+qsiAlIXU2G+Wi2JzOlLk9ugCqMv4
 P6lPnHwU11h6Ifv/0Vq4gOav3cd65aBvETtNobCTZD6Rsg93HiA9wI/gUo6m9BoHDsai1oDUV
 +HcccoApnnKhytpSYabSOtVA6FuXJ4Peh2+nQ4f0qUoKZkOiPfT6H9MBxG54TDq5t6rwu53QO
 uprkW3pr+xVlfFY5Gp7hq8RKsumDbrzIu6hPlC2ymWUfAfoQMFeulaJ/qB5odVxw/75bS8hr1
 vH1UNgQ8FVxCiISXigzspkHAEG253iDUeq4w5J6WkTo17DdR1ybXoyT0kLa+ruyC0lqeAICJ9
 SYmb/y6hvvvdu5HxkHG/Zi3NXAS1Ud1vba9kOcmJDtJ/hHLDRMSWWg9lq3LiVP+XQlJv/Srg4
 sBX1v8UCCrMJK0o4F4zyzuHSJ3Ayp8FPOFaS4cEna9hUHSbhL3u1tzfihhGtY+e63mDTegAwY
 O4GrxrmdE7IQqA8fVQ9RppC9D83SC311aicJKbhRDXXIALvrbINtvUVgVh4yM1LPW8tYJmIxy
 fcHuU3QemPclT7x21E0ZWHOmdEztFcxgEPOqq3ADqHPQZMTUYG35UDOKrHvvoCInzWoex450P
 mogi9FxkNEQPWmAyFErx2cXem891VwwJPcySL2MyktwQqV1RYAJ16LBv7rIz8nAL6nBqsJOpd
 aFjs1K+4TMBZoRi0b4lQ3aYgK0KIQHzXWUE3CiKvhtDLCtFCQMVhZe4nIcV5oFfRasW4JTK3W
 Nw+Tcof76bFaaW3WnR3w==
X-Spam-Status: No, score=-99.5 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Thu, 20 Aug 2020 17:29:57 -0000

On Aug 20 10:55, Ken Brown via Cygwin-patches wrote:
> Ken Brown (2):
>   Cygwin: add header defining GCC exception codes
>   Cygwin: strace: ignore GCC exceptions
> 
>  winsup/cygwin/exceptions.cc | 10 +---------
>  winsup/cygwin/gcc_seh.h     | 19 +++++++++++++++++++
>  winsup/utils/strace.cc      |  8 ++++++++
>  3 files changed, 28 insertions(+), 9 deletions(-)
>  create mode 100644 winsup/cygwin/gcc_seh.h
> 
> -- 
> 2.28.0

LGTM.  Please push.


Thanks,
Corinna
