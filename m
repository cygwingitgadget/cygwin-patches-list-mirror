Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 9A62A3858D39
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 11:05:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9A62A3858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MyK9U-1mONhS3Ttk-00ygRt for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022
 12:05:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CBF92A80BAE; Tue, 18 Jan 2022 12:05:01 +0100 (CET)
Date: Tue, 18 Jan 2022 12:05:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] path_conv: do not get confused by a directory with
 `.lnk` suffix
Message-ID: <Yeae3ZsFhRZgo/gS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <e4230b2bc45903850a4007c6f556bffe1507cc9e.1642450788.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4230b2bc45903850a4007c6f556bffe1507cc9e.1642450788.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:zEZckAlSP4zAYhEnhxVROwC2bgJUGqw7IT2X2rl940pN+yWAvA/
 QNrHd1d8aizJjCMFO1jT+9yV4cQROo9QuCFTDVOjej5t1V9j9QCc7WrTRvKNkxQbk5a90N6
 BPfeEELDQiUwuMBe7x5dpMhc/pQn2cO/J6zQUaayYbCdWSSE/t5izBDQdS9U7srQIhT1hKH
 2gX+FJJiJ3QLtYgxSA+aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PhoHH3jyXmY=:vUhOwkRQIACcv3we3q3vr4
 dZo3mGUiex0J7IPGyYyFxfJCeY1dnOlrD9/N33RIP8BnjWwJ8VJbSoQJu9NnCIhA7vfIPp781
 lZNg+sjacaWqDxToEh900I3MuMrFctYOPaoIKIwBS/la+KWFa3mZbcWq8smt2ANXwcWarbpXs
 1DacPcFlJQc5g/kO7HRCf7eA+ZLsJq7Mw7yLsaEW4d5q4y82T6aCc1TRMlL0bkGxqAiWkrhCL
 kmieMYRC4mjbt1v3P64HtotQf/EdDizY3ZhRX890i056MhX4gfaat/uNCXzzyQ3jmwN22jOpb
 o9oa8T3hOPpVVL502YoAp8R9QQaLjavV6FwGOu8OcR8vRnH9YL12m4QjLXLzpAjHJlnqbtkj5
 50Ut+vzQZyly9bLYN2/Xr4tVEDYk+VMMPHsSrEyQu5C7XYU6gdsLmq89owGK0ki2hzuXpbug/
 W8L6hRKimRHAmcHcX3KeVAT5zB9LRBRyVGQ8hdqZo6GPowy+kf1td4G/U5+B0dFqnMSJmvDVY
 50QevVWtO0Qe3W4FSrY0nd+TycTC08TdNqrSCQaPd70nFTQJl10InPi4kvnvbSa0EOJSfX3r5
 pRxsTD0odQWGnlaNDo8Jju7KTEW7cHAkq/SqYz9cp/h9Rk+g6e/d09tVmvNh4pAt9VUygdOI7
 8MO0G+lQOv4oHNaB0U2pXNg5+MfJh0TKX5IdR+MBi1A6hEsV4y5+FJOuBwCgwh6SRKcOaRbTw
 LvbEhODoO/GrpabL
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 18 Jan 2022 11:05:08 -0000

On Jan 17 21:20, Johannes Schindelin wrote:
> When trying to create a directory called `xyz` in the presence of a
> directory `xyz.lnk`, the Cygwin runtime errors out with an `ENOENT`.
> 
> The root cause is actually a bit deeper: the `symlink_info::check()`
> method tries to figure out whether the given path refers to a symbolic
> link as emulated via `.lnk` files, but since it is a directory, that is
> not the case, and that hypothesis is rejected.
> 
> However, the `fileattr` field is not cleared, so that a later
> `.exists()` call on the instance mistakenly thinks that the symlink
> actually exists. Let's clear that field.
> 
> This fixes https://github.com/msys2/msys2-runtime/issues/81
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/msys2-runtime/releases/tag/dont-confuse-a-xyz.lnk-directory-for-a-lnk-file-cygwin-v1
> Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime dont-confuse-a-xyz.lnk-directory-for-a-lnk-file-cygwin-v1
> 
>  winsup/cygwin/path.cc | 1 +
>  1 file changed, 1 insertion(+)

Pushed with adeded "Cygwin:" tag in commit summary.

Thanks,
Corinna
