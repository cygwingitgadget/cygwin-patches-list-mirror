Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id E14F83858003
 for <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022 10:39:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E14F83858003
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MqatK-1mW08N2Epk-00maa9 for <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022
 11:39:19 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DDEDAA807B2; Mon, 17 Jan 2022 11:39:18 +0100 (CET)
Date: Mon, 17 Jan 2022 11:39:18 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/7] Debug output to show both IP and port # in native
 b.o., a few little cosmetic improvements for consistency
Message-ID: <YeVHVqx2kKnjt7DV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
 <20220114221018.43941-4-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220114221018.43941-4-lavr@ncbi.nlm.nih.gov>
X-Provags-ID: V03:K1:7wmykv5+Ou6Z/GS3YdUHAA4w2P3t/FyBMNhHIb90VKYBGD27utL
 XveV3TBDDUEtFnsb6K8y8sFju761ggL/200tJ9S6GOCbVj15MjpKhrjN/8fYkiceUvv7Fe6
 TI6dAizwTnslstxFj54TxOfGQFJBLC4fsApLbawd+rA/d1wVLH3WNTS9xOiSZivRXPKZDXF
 sNW1nisrltD7FGcMWx7FA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z+l+zDIXtrE=:GXzCvklzZR32DtLKfDKIXa
 pBFzmr2Djr8ZzzDQHS58vw4bbZE3u7duLpGFpXYvEcL25k+9jBBX0HbgAyyPptXy8c+4EZ+CV
 pQufakNO6H0ori+tWJGAqevH91vi6QZb3VSLblkGOpRcwyKYFafjR58bOQWYEAI3hlc/kgLBn
 JjY8jAWl5PmEhkrycwtKhE8Jnt+EbGJbmV/2txN7JpgnNfpuby2wwGki8JoGNNIFvYcSsTNwy
 wqXRKxGBdYRRIfZMALBBQzc/4x4rSfNHs4dFIoU9HQp3RGz4QoD3/K5ktKyoCKjnbZq3elj/f
 h31Pqhn+CuVFfWkpo6rAG2sSUBang04Mlb+RlpssQ0sHjzyTWoVH7/5tpdXjtlsJwy9ls0n8P
 Q0aAlQnLkXptSk9JJHxg/4HNF/09coys7aAWELvrRmx9mNFeLRLMWgjZH45IvTY5JUa/cvGW/
 VFBwv0sMDKlQrWuCP1OCQzeMHcPRHw0Oz3YRjQV6LVeCuBFIX3uEMrL62XfLmRZvnKrUnsLao
 c9ufu8I3geYlChB9DGWl9+mloCyAQC+XiJPtXPCo84GBqqzB08o9Dxhgj8p5a4aZrVHa2lhlr
 WwcXn+AlEo9CTVlrxdD6E0Q40y/fAJQoy2IVnKlzWFeaf6hflbWSXTlb6gExr9mj8MWxMfSb6
 /Yqj1ww28uxipYdevKWhptnCKFCWf0ZQ+W1g7LPdYd1y08xyF95cKL3Lo1VSGF7g7Hvy5bIwM
 HtN6jFw8qFEHGoel
X-Spam-Status: No, score=-95.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 17 Jan 2022 10:39:22 -0000

Hi Anton,

I pushed the first two patches.  However...

On Jan 14 17:10, Anton Lavrentiev via Cygwin-patches wrote:
> ---
>  winsup/cygwin/libc/minires.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

...would you mind to shorten your commit caption (aka subject), at least
to less than 80 chars, and outline your patch in the remainder of the
commit message, please?

In fact, a short subject and a bit of explaining text in the commit
message is preferrable in general.  See the DISCUSSION section in the
git-commit(1) man page.


Thanks,
Corinna
