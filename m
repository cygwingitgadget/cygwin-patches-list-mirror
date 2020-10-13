Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 9C3B9385780B
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 12:10:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9C3B9385780B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MyJx6-1kG7RI33KG-00yl44 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 14:10:12 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3B392A82BDA; Tue, 13 Oct 2020 14:10:12 +0200 (CEST)
Date: Tue, 13 Oct 2020 14:10:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/8] Drop STDINCFLAGS overrides
Message-ID: <20201013121012.GL26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
 <20201012192943.15732-3-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012192943.15732-3-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:uzMoWOfcqIYyRkNy+ziPXbIb5FE/iTB/iO2G6js5pnDOC4yxfdJ
 t1mXzYYBBQOBmXiGf1MA79KsjShdJEJMsuqkxWsPYN8/7SvQSivY5igj4Vu1AmrM1H9G8zD
 UHCcRgOvI6a4M5RL1kmpmDJdeQEQrjo6wR3d6UHnyrg5O9H5fpcGKrDuGRWPq9Sxegc8duP
 T4SaPBSaIp73U8FemfKUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WD9PYPAmnAo=:InE2qSZg3GX6uRJ9gNvzDg
 FB/gxK9EHoVLRUhlw6vq/0FHANh2aLPL63a886imYurosLgEQSi2KyH0ZXsiOvVqnuZkrHvhU
 dfRvEhKT3csLiPu4FNzzxnuiqjNNS6LXA5Gwdrhb2IHO4VBXyQ2+riwMspbwbQ/iLYGjy6/gL
 WARkx/peAZmDLRAne5ig7Y9SB5lk2wwKXcNqKXh3TxsYTenMSNDfg7kw5I6TSHbkEhGv17Xyj
 p2PUJV2S7RhxqPtzO6BmOovx7H5LvAnufA7H0PU/gGX/Kpw7NXdXzwT0j4NhHPzeQ7atIDhE+
 tRoWYzDpZWUEgCGE+13fnnf1E1KcbUTC24ymNoCYB65NkZHnw62B+99imuVg4ishltlR0kvkj
 y4ZwY06y+DvwvZ/fxFCGk5sOxCVn+ed4ZYOOHPTjpOPWR86h147vY8mekmqlIuFx4Z9nLCZDd
 ZcbwKi4L26g498pDXGJdjfFBPyedajYl73pL0q6uLcZEBFduXeI2vqoJGitvaElpZdSdEfVfp
 mSXkpKs0QtpUX/L6QcQqXKpX1/Ae6xdNzypVXkyXWjIWdX1VmqjgOAmAod6/YB08M2s0YqCWV
 oJpwJ/4dVmWeWV1scAUaoKzRFD3sM8rnjDA3K0hHSozgB07eLxygwoUMK4qwEPLxAiI6OGqgR
 vzS2y1VV6Hqa3HT7qbz+xs+kn6gDhw//sTWPMqE2vEZmODTTuMmnw/Uhg9KVwIA6cuUVWfRJq
 susj9APfzaziqC+2z7wuC1djsKxbW+Rcp3c/yY2ih58fEUxiDeZfApTYaej84l+EZGQM91NBt
 /xooez/zA5b/jL5KCktTqZSGMUywtCgLq7xa08HUzTGczAP+Xpd2IZmA5TD82zPBjx8SVs+uA
 AQUclPtHGipBRFMFvvFw==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 13 Oct 2020 12:10:15 -0000

On Oct 12 20:29, Jon Turney wrote:
> This used to turn off -nostdinc on a per-file basis, but has no effect
> since 4c36016b.

I'd prefer a longer SHA-1, at least 12 chars.  Maybe we should
add a "Fixes: ..." along the lines of the Linux kernel from now on?

Ideally we'd get rid of ccwrap/c++wrap, too...


Corinna
