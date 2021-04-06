Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id D72013858034
 for <cygwin-patches@cygwin.com>; Tue,  6 Apr 2021 10:21:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D72013858034
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M2fHt-1lRFbJ0gIB-00483P for <cygwin-patches@cygwin.com>; Tue, 06 Apr 2021
 12:21:38 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A1520A80773; Tue,  6 Apr 2021 12:21:37 +0200 (CEST)
Date: Tue, 6 Apr 2021 12:21:37 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Use atexit() instead of hooking exit()
 for GDB.
Message-ID: <YGw2MWgCZodSOjj8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210406004013.841-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210406004013.841-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:HJ+NpSCWvz4soJ6+3yCmNfFCSaGzY2tZC2hUNMLZiBkQXEytJm4
 d47qwoSouceR7B0Pab6+k8J1xprDkrcCjiWgXxrKjPjq2YsoZz8zAjDGVsO71nMun2hLXwL
 Zu2TtFefhkXL9rhBsckT43sGPRzyXcvFveWiDmtv9vEWBbfToh32esqSQ7PUeuN026qencY
 VlkDpqBYVlJj8ljSgqlQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kcHrqfNKy8U=:v7Mc2UvX3HKzfMPd1w4FWV
 fZG05WcCniwmANWTBp0ZQa4NPXAnPYyDS3NDwoPQ2a39S855DKrXP6IMyFfdKvxeEpLXTKsmh
 MwpQWTY1MkQY9cd79zWPd/X1WlCeUvrbsKNBVJrn6bvT3orEtBs/pTBcIuDEZ+1hm1zQP9FQm
 TTGEflGTm8FVpwkQS+njt5aAC2xsvGv0jhRB0inQ0x7wBcwqdR9ESsaAtJF1P+xuAV4443nxS
 sJP92pHswBZo6uaK6vV2j0RXf3jwrF1XcMUM51WVLO3BrfiAmPuo9gV3hSguRiFdSncqQDuXf
 Gx+GASbWIdtatXnKR3sSTR8Euuc93DrlF/gFr+Fq+kMK4ZHRgHwBR4YVvoqDqFpmrEDNW87+d
 tArWMuB6D7PgtzE0JK05EqOehtXDW8PV46XuJ8Jj9Wnp34UYR3od9g6ahwChpE5zr4EXxmYOQ
 41qsokw3t/tf4JEyf7hMME4TuLhpuNt+e/Ok0TC3nPN0aaGFu6Nh
X-Spam-Status: No, score=-101.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 06 Apr 2021 10:21:41 -0000

On Apr  6 09:40, Takashi Yano wrote:
> - This patch utilizes atexit() instead of hooking exit() to clean
>   up pseudo console stuff when debugging non-cygwin app using GDB.
> ---
>  winsup/cygwin/fhandler.h      |   2 +-
>  winsup/cygwin/fhandler_tty.cc | 100 +++++++++++++++++++++++-----------
>  winsup/cygwin/tty.cc          |   2 +
>  3 files changed, 70 insertions(+), 34 deletions(-)
> [...]

All three patches pushed.


Thanks,
Corinna
