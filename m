Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 8A0193850415
 for <cygwin-patches@cygwin.com>; Wed, 26 May 2021 09:06:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8A0193850415
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MPooP-1m7dST1Sj5-00MscQ for <cygwin-patches@cygwin.com>; Wed, 26 May 2021
 11:06:02 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5B292A80D78; Wed, 26 May 2021 11:06:01 +0200 (CEST)
Date: Wed, 26 May 2021 11:06:01 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygdrop: fix return type of usageCore
Message-ID: <YK4PeWdpbeNssxCO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2105251635120.14962@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2105251635120.14962@resin.csoft.net>
X-Provags-ID: V03:K1:GF/wQMFnOw6ey6eoI6iUuJBBYMcq9H26OYIfZAmnWG6SEYppIT6
 q+nBuVYy3nAdKAdYOUzrt1JjNyMbfo/uuzTGfNbAJYSEPSMzr4ZetOZeXOHsfedxV+7Jtxs
 WKV/vb7L6KBntIgJL/sXJYr35uUBozS6Cjcf3AY1cfgr7hwNqol6o0KM/90dRlXPYubt0mo
 j2/Mzry8yvP6YMGMRoHQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VYwEkdWWYmg=:2AiQ20HmQQiURQ+HWZ1Xk3
 +tVkU8tBkxQmsOz67tSee3UNmoGj9sH3J8CC7aW/iXa7XrWHbLZcuwouqKm/492B/fzzrcSac
 49lVJRqFdjqpHgwZ7tt1TNezeH1al5Ti1g5/FbJ0EXPgxDPt00JydbNUjARpxSYfHD5HkCMop
 wZYkaSftVx1jymGHEKAcyqenHjSP+i0m8MXKve4DXNI+nSrnjCiXTYCjsAKdacUcgLEJnGklt
 lQ0eZfxcn2IfJA3VSuU4J+qejYwtIM7fOidieRLwbus0Tey0OKVpNz8XX5s2VpX5Tpu8iAcZS
 dqmg+hsAwXCVKtVYFX4iBxBbBEHB9QzZroxoIJ9hw8AGwwkqlQqWczvFHKR+M+ha0pzFy/c95
 gfzHQUQ/J85aFoW34YE/Lttbkhe5+aLW0b5hjLdPzQEt+8gEy0bOTjZo3Q6g8Wos71eBPpSH0
 K7LiG1nUGowoK7Y3VQhTD6VMEBsa3M/PTNoT1X07y8p8i4w0E7ISCIEGSH0k3Nb5U1y9WGyke
 2fBl+XTyFadXRe96EyUPWk=
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 26 May 2021 09:06:04 -0000

On May 25 16:36, Jeremy Drake via Cygwin-patches wrote:
> Fixes a warning "no return statement in function returning non-void",
> and solves a crash running --help.

Patches not affecting the Cygwin repo but other package's repos
should really go to cygwin-apps, please.


Thanks,
Corinna
