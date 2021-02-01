Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id EC378383E81D
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 10:01:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EC378383E81D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MJmbB-1lPyiX2rEX-00K9wP for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 11:01:44 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 15DDBA80D7F; Mon,  1 Feb 2021 11:01:44 +0100 (CET)
Date: Mon, 1 Feb 2021 11:01:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/2] Make terminal read() thread-safe.
Message-ID: <20210201100144.GH375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210128141133.734-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128141133.734-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:Y5hPRk/IQSlaQGrhx2bQQCajJeRBhxALM2SKIw5qaHhquuLcKrb
 hvjNKoYcnLfNuTDEkvJlTFblciWBId5OijUsnpGlBgt3U6/iQ605Ohqtpwux3EWV+Bcd5W/
 wTiBlJ3PAywWGV980gP+XFh5gfQyRIr8CmtTrnZN/5QJv+4I9idpgJFLN+HYFxzyQE4F7B6
 qKGxB+O/vdb0e3SLQvkmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ndu5t0Zyot4=:yxSU4900TPC3q+CUoKuhX9
 lglLAorE1OWjCwg+elwygSmVeDOgRkVaxVPx5uO60l+7mbGSrcut/ogvYwMEHK7k2dHNwiTdJ
 SiGjcrIKuGBHLWlpdNRA6VFUlKewvHn9NTKp6dVZPhW+KnC9Cw24xFBXCYY/zoPZ3ks1uO+os
 LYELd4eH2uT5spJNbLk2St2H3o/pXwagIHDep0tAeWsBbJv1EgFsOXblNudxAPlm5J1iUsMMV
 xL1GZCZQLPv9L7Y+8wjmCASFYvDowxR4Mf15Sdnk6pChVG7jbqDrUCYSMedIJ5VKlCU7GgZQx
 2ZaNj3i9byLG2jwDeY28YoMmXiW129zbD5OaDeFoYkNjJef0cHDAEWqESCPzm1HNM/JEYEVKG
 V3JnfHt3HmosZ0Vj0EYQyGXwVsoIE7koJfktqvK54UYKIvSRAJ8Lud0hjiaW/FqPCvaHbU8be
 s7WTN/fSmM0fliKH7kXqGzbCdksosusC6ktQYL3wc62EPmX8fm1NNocLDQ7+maCB/0/hBoANU
 A==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 01 Feb 2021 10:01:50 -0000

On Jan 28 23:11, Takashi Yano via Cygwin-patches wrote:
> Currently read() for console and pty slave are somehow
> not thread-safe. These patches fix the issue.
> 
> Takashi Yano (2):
>   Cygwin: console: Make read() thread-safe.
>   Cygwin: pty: Make slave read() thread-safe.
> 
>  winsup/cygwin/fhandler.h          | 10 ++++++++++
>  winsup/cygwin/fhandler_console.cc | 11 ++++++-----
>  winsup/cygwin/fhandler_termios.cc |  2 ++
>  winsup/cygwin/fhandler_tty.cc     |  6 ++++++
>  4 files changed, 24 insertions(+), 5 deletions(-)
> 
> -- 
> 2.30.0

Pushed.

Thanks,
Corinna
