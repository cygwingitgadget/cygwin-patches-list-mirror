Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id A74F0385843F
 for <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022 10:44:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A74F0385843F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MgeXk-1mfrVe1RDI-00h7XN for <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022
 11:44:26 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id ECA06A807B2; Mon, 17 Jan 2022 11:44:25 +0100 (CET)
Date: Mon, 17 Jan 2022 11:44:25 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/7] Debug output to show both IP and port # in native
 b.o., a few little cosmetic improvements for consistency
Message-ID: <YeVIiWS/NGobR/gr@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
 <20220114221018.43941-4-lavr@ncbi.nlm.nih.gov>
 <YeVHVqx2kKnjt7DV@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeVHVqx2kKnjt7DV@calimero.vinschen.de>
X-Provags-ID: V03:K1:E+v+1EzIKDw1fQQNy16tfy6EEr7CWadCjaep2TlO3ZXn/vvE3l2
 LYCu5Hr1sBoBrHI3gpcv7QPwc1r8yfk8gjdjKWoawAwkFgw59hYLGBK9F8ETsLHUEPCkk0e
 424NU/3EqK7dm7FIklKQf6yf4Ys/RhqRwoNQu79+IIJ+3KQtyA9mcKrgv/l4ZlvZ/wMaRs0
 8SVMrYLTp/4dU/Wd9j49A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SqI/HWIIqgM=:ti5MpSN1p/YPo1EKe+y+h2
 cC5C9fcq2rActURYJxIq2M799LsmHbf2Hx51EUWMJhO7mUIxOCQiKV/VtuJgvtulRVC9vbkbM
 BiuoJ1ek7JCv5CsJ3BohFAdVrc1hR+QtHqvcWGyz9aAXciKHPWHiKU3VropV5eSIXtR4MNep7
 l7iGU4EfTxcRbugOkRwaUQX4Hcbs0BU62R5TAwKeGx9tK9fIIMe2eoRuQFK5SR80yu4MUFdZl
 laiwLhioCsJKcJ0xZogoAa2Y1E1cQE1oZ2z/+6QJWnDSm6J8T7ZI8S/WfLkTYWFnoDckcIvg7
 3Ty4MuElJ+4i8SXw3f76ytNeWUr2bP74qph7zI+tQ+0wXEc6eXqNmumTJXZJ91buwdXeODazH
 /Jpfq2Ssr5DIMFD+lc9qM1DPvNC7rhe76LzvvMwCJVd8j8T0TEMWgBMnqecgjFO4QPgS5zj7U
 yl4PwGNGsh0iPHeP772nYvQpXplkF9INyj9nB8S4BKGmHa9Tj4f6lYhnGIDluQ27DCvZDPg2q
 AklXO2/90S9PStchbQiuNcQ6ZGFDXQpaa99hiN8EX6Jrl3gmoXFz0acRnY4x0I1O/mVGve+wX
 TCTsTIxLcVF6/gq3JPRsxZuBdXAfDlR/QwMDMX1RnotZ1KT5vCVfdfCfBpecr9fZp4O1sxnRo
 Gfk0zlSx4gXEDq141IhFOjYp0MB3hGC5yFkkdIm1WT6OQbGhapGpi/j6o9yo0YHNaIloa7E8e
 m8nEbOWIiUGKYOAP
X-Spam-Status: No, score=-95.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Mon, 17 Jan 2022 10:44:29 -0000

On Jan 17 11:39, Corinna Vinschen wrote:
> Hi Anton,
> 
> I pushed the first two patches.  However...
> 
> On Jan 14 17:10, Anton Lavrentiev via Cygwin-patches wrote:
> > ---
> >  winsup/cygwin/libc/minires.c | 28 ++++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> ...would you mind to shorten your commit caption (aka subject), at least
> to less than 80 chars, and outline your patch in the remainder of the
> commit message, please?
> 
> In fact, a short subject and a bit of explaining text in the commit
> message is preferrable in general.  See the DISCUSSION section in the
> git-commit(1) man page.

Oh, and, while we're at it, please add a prefix to the subjects of your
remaining patches, i .e.

  Cygwin: resolver: blah

I forget that for the first two patches, but we should do this a bit
more thorough.

Other than that, the remaining patches look good, except, adding a short
description what patch 7 does to the commit message would be great for
later readers of the git log.


Thanks,
Corinna
