Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 6BBD93858401
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 14:32:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6BBD93858401
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4K6z-1nAT7Z3scD-000MMi for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022
 15:32:08 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 316A1A80D67; Wed, 19 Jan 2022 15:32:08 +0100 (CET)
Date: Wed, 19 Jan 2022 15:32:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: resolver: cygwin_query() skip response header on
 internal error
Message-ID: <Yegg6MxTbArol2ol@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220119131255.27821-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119131255.27821-1-lavr@ncbi.nlm.nih.gov>
X-Provags-ID: V03:K1:mBpWb9njY2DvcFwrTXQCi/o8jzXS2SxzQKAIAmyYzPQUbUgBWj/
 n9E/ATz9wPFhjKcYf5bMpStyAYY7miWcpEv9WmgjDB4BcPFy7sLftL4N+LBXp9Oy0cv+L4l
 GYRxaSYMOI8XX+eeuBT0jRBBC+OORcISct4EtNszP2Hk+XH4vOVWjVVNLXwV6k04YR1PZUz
 5fdotAkNodR/6SXtHfZ3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l/i5KrvNUK4=:OVhJavteTJt5sZw+COuqy4
 fLhfvRm8tqU9OCWaUGNqPaMoCxoXmuXGrOmZ7O9UOSLnXhqxjdOWqYX9VQB7INr/oMVSkn6MI
 Oi9IvySWoH/NURv//EtGjqBiBmh5gOJiWhBMHtDum0fraFLlBQS4AcVyw/q0Lo28FDYEw9pwr
 q8xTH8xEXwVZY8+mQ4TlH17ywoO5f+jELs4g9x2zIHbLqxfm7SlZPgBpoTp+91dViKUC/EvAy
 gzZwcvq2MEaeaYJJ/SJbemlO4vVnMP4bqq8ubNymgYzGJPdrd7vzePjtu0tKGbhUb0tdPlR8W
 qaUFHnBJx205nlor3yR6UVG/Zh4s45J3s8pDzGF2GJ4kKxP92F3KtA5XyZ77oexqM0vO9jo8e
 NPfI0wHdIclptjvBc10qpXIQgf4t9YT7+YV6hj08hC3bRNqgZPJmcZdbZFJ9vddyRcZxsz0Br
 20uJozQq72duSOQBRO5wccP9ytxWFYYzLVUkGHarVluuuq09HeTaJvg4F8p2n0/WwokzMM4+A
 Io4sKVKD48VihDovm2+lJT4wesDD+ezVojAeq2zed4YEc22ItwBGtfa4D4GP8D3PY7Nh77arC
 71lHJ5qhsNAunDR0FlpBzeN5jq3zEMIXuZxuY1vaRzWZTF7WASAE4OYWXJ+uO5gXXrKsT41DL
 5HRTRpAL8a8cze6imKwrMJg1BtYrThGA3OPYl6tKgReuFfU/YAMCQUB4QZBDdhS6MNchP8WHW
 po340A/4xf9fwiGc
X-Spam-Status: No, score=-97.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Wed, 19 Jan 2022 14:32:11 -0000

On Jan 19 08:12, Anton Lavrentiev via Cygwin-patches wrote:
> - When dn_comp() failed internally there is no longer any need to
> fill the response header since it's now all cleared upon entry
> ---
>  winsup/cygwin/libc/minires-os-if.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Pushed.

Thanks,
Corinna
