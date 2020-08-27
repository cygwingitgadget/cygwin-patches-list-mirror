Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id A29EA386F419
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 08:53:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A29EA386F419
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIxJq-1jvDFT1MWw-00KO3k for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020
 10:53:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E3965A83A77; Thu, 27 Aug 2020 10:53:36 +0200 (CEST)
Date: Thu, 27 Aug 2020 10:53:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Replace WriteConsoleA() with
 WriteConsoleW().
Message-ID: <20200827085336.GX3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200827033504.1949-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827033504.1949-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:8Tk1G9aCPZLBJ5Ub6xy0Jftmh0S0ISkWkGGE9CRfk7fRhXU/yX2
 aQpCRrz917gYSa8IvNE59s8f7ug4WM5asLzLAedFYeQMgYFt+wwQQeSV6Qj9d2zfW2T9LLg
 hWkzzsbkMoXT2iXM7DfdO2Hv6zTeF+eiaYKXfL7TBursTmjs1Abu7CMfZwibi4SS3HzVln6
 KibIvGuj3/TxPQ/rig6+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q0GMnPkqd0k=:dRdyGU81vazu5kgD2ISXcT
 +z9Pno2Ra58DHcssh/gViVqNuxh6vgZ7whHK5SfLQZkORJs/R1cyx4YvkXTKhQy6jf6R3PvKN
 xaLtpEVfol1Y0IHPJrN90NJfmiZ9/bZl1H2hgJ9AJwiQq0LsdHXcuAKJndr2OzXzr56yUrBr4
 E12GsfSwzOptz8JXvXmtwKj8IEoaK+AZmM3rfSy1CDtNl8bZ/2ON0cz3FoOT0jaW2N3LcmyKW
 gwFvc1jcu2IXoOwg3K63bm+OcoMTHP6KTazaEqUiGULbAV39+47yC/1otgVrPIPAPRWEa9Vjd
 flVCLC2HG+ePlaGtQ+dGVofy90ouR8wDSXvD1ETL3pgkWkiyS5JGFnB88CfVrT8mpO4khlMGX
 /8kjSOT3Kvvbv3mMG39DSIEwgFU6I7DGtkmk3tJfpcae/Nxpk4ItV41CNGzeND0ZmPsZfP8Rs
 lT5jrGs59mfbxT85ZG1wVxMG3hAjmVP3hK9nUYrVYtHYe4mK7CLjiErwTWOwbuqE3+iuLaBXx
 Ey4G+18/w5kmv+pPa9ycHH7+reBEi//dZd468rKBurFIRpueO3OtZrAzfPM1g9GSiuid2VV0W
 uQqnXBmofledZaLGBzftg18m5zDnZ3uLtq2b5PJ4fh7T7gR+ws1GcvYk0AF2bFaiAp/dguUdW
 o62YKTCiXWlILarTYzG3EId9vp4rsmkmflOS/fmn0ux5qp0K0asyrQUC6WPjp8pM2Ou7wpbmU
 aOLgOBcdcxO9T/OeK9tJk6M8SUdondEWFmaN5KzwPvXpc0kFZXlHQshfsQIceMJD9Vcs6mCER
 QAOiv00ipy/FR567x26EZy4St2hcsITYU78QA1HIm6DdwvOd/mec+MA3rkXDR4GfRI1FjRLBp
 lZv99u/Joro90S1tFG7Q==
X-Spam-Status: No, score=-99.8 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Thu, 27 Aug 2020 08:53:40 -0000

On Aug 27 12:35, Takashi Yano via Cygwin-patches wrote:
> - To allow sending non-ASCII chars to console, all WriteConsoleA()
>   are replaced by WriteConsoleW().
>   Addresses:
>   https://cygwin.com/pipermail/cygwin-patches/2020q3/010476.html
> ---
>  winsup/cygwin/fhandler_console.cc | 89 ++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 42 deletions(-)

Pushed.


Thanks,
Corinna
