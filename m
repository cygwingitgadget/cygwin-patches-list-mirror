Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id EB807385841F
 for <cygwin-patches@cygwin.com>; Thu, 24 Feb 2022 19:46:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EB807385841F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MploR-1o1bXy0LxV-00q8pr for <cygwin-patches@cygwin.com>; Thu, 24 Feb 2022
 20:46:03 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 60F60A80D68; Thu, 24 Feb 2022 20:46:02 +0100 (CET)
Date: Thu, 24 Feb 2022 20:46:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pinfo: Fix exit code when non-cygwin app
 exits by Ctrl-C.
Message-ID: <YhfgelSUkIv1JGx+@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220224142429.888-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224142429.888-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:aM86ehFKPXCa3GkFZTcrv+BKzW8whc3pMrr+nYCXRgpvfGLeFqX
 1WrdT8782PB7ZrjbkqXrQm23fd7L9NWOgx80f6FnlUHYhZW+lX1tB3l2LaKydt2yyt23sRS
 CY2jnbjV8fha02j3osYX1bPts2jIxsGDKn0lh2fqGUOzIcpm5tlWh9r7P9XPH2Tvvuk2Vvj
 2MdOaQAMxWjiQYp8iGEcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cWtFiVakP0U=:KjjrZiAR3bw6afjE4yHi+m
 K2ms7FQCbpOeXnG1l2XNODunT7oFN54sEGsypDNd0LeTB4BNMJ2qt7HYmgapn5d5RV3JYsxzI
 goQCH5UZaWZsN6DPBAA0/UH6yhS6ocI+sl4rpeAwuZx0n2j8Ji1sJQnN6JRjA1I5hwfQg8JHs
 V3XjdO06gikEJdSlQ9y8KTI94z04bURf3uMvVbrAAsGJJ+VyuLYcHgxTjo+PAHXcOLCvIfl5V
 URPp4Dh8ZHXJlpFdgZ7bZuV3cSDUI1r+aJq4Pjf/TPr3R247knScPHSM2U5pqcmIl4A+8F5lW
 e6pOmWIyeV3M4GrXCLuK9IeA32d9yDPvCXq0TEht9DeALkA15TJJsMCkAIAMGnK5Q5lVapTRX
 AV8lT8m5PYpa0Bum5Wllzvg9oWahNzFzXZ5LPSiAJoHWb7M6ygjLmMfR0bIU3a9ffkkBzbdAR
 3tMCB0Bn4FdQx7yPPWZ4GGKSL+ek83ArapN+pKQdOsw+3SRCBj3jw/5DYS9EaLObUv+5OYzU9
 hjRVHXRG+z6s4WrhaVzspaeexMo0Qz/zi8cbJHDMnr/6EAVbYZmbXdLhji5UbkLIvp3+GQ0xI
 NT4rKXOO07BkdvCF/b+TeGJkwV+nW6ySkPJYuosr/P7YToke/W59UYk65HEAY0GApDr5L0qpV
 xllBKuWBNySAHwKtnCoQ/dXSglDZMe4/Ud9WqH0r1OsGtMPYFGypUtQ3CdmmkESRpJIRbXQYq
 XqS8nwfyoydQ/Mdj
X-Spam-Status: No, score=-96.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
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
X-List-Received-Date: Thu, 24 Feb 2022 19:46:07 -0000

On Feb 24 23:24, Takashi Yano wrote:
> - Previously, if non-cygwin app exits by Ctrl-C, exit code was
>   0x00007f00. With this patch, the exit code will be 0x00000002,
>   which means process exited by SIGINT.
> ---
>  winsup/cygwin/exceptions.cc | 6 +++++-
>  winsup/cygwin/pinfo.cc      | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Looks good, thanks!


Corinna
