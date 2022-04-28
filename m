Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 201AE3857346
 for <cygwin-patches@cygwin.com>; Thu, 28 Apr 2022 14:06:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 201AE3857346
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6DnM-1nmFaI3oQS-006fu8 for <cygwin-patches@cygwin.com>; Thu, 28 Apr 2022
 16:06:38 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5CCAAA80A6A; Thu, 28 Apr 2022 16:06:38 +0200 (CEST)
Date: Thu, 28 Apr 2022 16:06:38 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Unconditionally require win32api >= 10.0.0
Message-ID: <YmqfbjXDYVJeKUjQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220427203515.13607-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220427203515.13607-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:VfZZCa3GEOE/G3EPia3GL4CKp5h3mtl/pE7H2nw/1U9OYFrKm2z
 K/5w1rjMKCoFK03kJCmT5IdRL9hl/L9vG9PKbDuHOmRk5Y7img7fndA7HBjUnItIKyvfH21
 neSlx/Lcw+0od1Ds35LiD7FkQBHKermUPHpGsnhYfdox6D3pF7gI1WoWJG0wlMuizYsSN5Z
 HGDiHJkCFSWLfAfASbnww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RGZoEUYLg3U=:cusTiOte4Q6DQOilfrDOON
 QOksCWgb/BphiLEtZQWsDY6LXZLfzVr1wUD4lrOfoPbxn9ygn7vDjF/3yF6KyZ8YIUjQRPNVl
 19bI8IMD0a9ZzwFHp0vGQd+uG/Whz01oNdMvtJB7EnoEKlnRkNrp6t6eHUAzfft1wy/Tjh6BC
 Hn6ee4qratdemfMThaXDaI4FoasDV0RWkQNiHgbky7fGVNjEBAOBW/L0sRX8oWJz0Ex/seR9w
 qxnV215t90Ih11o6of0csELQVyUsx2SdH26K7jhBUJDNgt2cjbEnT5KENFujHuopL56RROpC6
 9jkk691BOxcqMVreZigkufd5wpMDMJKZwhQVoLrwVyEWdEqMCXCODnqEugICBGndIiSYaHdCs
 9Ah0a3qwxnGo0dsXYzorSzIi35G2Xw/Tq9Yjscc9z/FfP8msewdokx2sgeLglN3gn91QFySsR
 697Skp6inO0GXTqHv1A8LeQ17XP6P0WQmg5nIBuOcGlm3+lASTUmMZN9SNRwVZgyTIGSuXVGY
 DwxQN6JwClE54MMXMCRE+lIlYWfjMNpuGzYCekWkYhduTT2w18zvn27S+eNibxLZCSU7ybWQP
 P5Tug7BoiTHIDcFhXlT7ueg7oGs7Vop21IeIWS8wXCY9Gipil2GP+gNPgS6DkA8TzYk1KKjwV
 QWpTBGcVw45F3INHqVehG9JOlmFvbYpV49dkez4I72RRCZWnDGjx2pxDJS9M8MLVNjYcTS8tl
 7guojx5qSgskPHQf
X-Spam-Status: No, score=-94.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Thu, 28 Apr 2022 14:06:45 -0000

On Apr 27 21:35, Jon Turney wrote:
> Unconditionally require win32api >= 10.0.0, and check for it at
> configure time.
> 
> Note that there remains a use of __MINGW64_VERSION_MAJOR in
> pseudo-reloc.cc under !CYGWIN (since that file is shared with the
> MinGW and MinGW64 runtimes).
> ---
>  winsup/configure.ac       |  9 +++++++++
>  winsup/cygwin/ntdll.h     |  6 ------
>  winsup/cygwin/sec_auth.cc | 19 -------------------
>  winsup/cygwin/winlean.h   |  5 -----
>  4 files changed, 9 insertions(+), 30 deletions(-)

LGTM


Thx,
Corinna
