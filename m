Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 6E2CB3861020
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 14:23:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6E2CB3861020
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6DnM-1jvKqF3u9Y-006dMA for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020
 16:23:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4357BA82B92; Mon, 20 Jul 2020 16:23:03 +0200 (CEST)
Date: Mon, 20 Jul 2020 16:23:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
Message-ID: <20200720142303.GJ16360@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200720133442.11432-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720133442.11432-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:pdqy+SHw8k54EYpbvX6/H73IbmmHWn/KWoXsDi/Hipl/c76Gr3P
 GX7wwnhko8a8AANipiYdjk9SyiVqpkCd/0AEm6B2ESJ+9G6SqlKjPLfpncsxgq7eDPmrsY3
 NI8K/FrhcGhFpI9KcN759wnzwmao46B4THAETT0d3oDqqKBg+rNqa+3VEXxAVfjk+D4h7E0
 miHIhp/RAB32/fUxAZ1vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LNDMtC18CUM=:IDjH1fu7EuOBoN+9/c2sFM
 sBc0LNmlMKYPSXXcziq3FVZiIMpkxshcgWwpLRfr9irYVQXfIM9s4vmpF2P+4wrIi+snqL+w8
 vlDyaVv0tw/L6pWn6fznmGQP+kDAD9mFsBYdLeoqaWoEj8O2ebOUck3M1CZgOHQGaVIKskgNo
 bECkSxK/Ihp5aW7G6exDpNVmBoyj8h3Whznrt6r/Y78sPMBiJE6c7WcICGtA/R5Gm9PyPzE5Z
 7Bz/79vx4fW7zLRhdHm48aFjuuZg5S+ZM8RmkGoGHG1VV1EgdwbkXhutJks2kUXVRJeSclGAJ
 BVIGfRN4tIVeW/op3/YblOnt/yX/6bGfiAFqZrwwPhZjgl29OXw7b38ULyI7ESH+SKdaFWS4P
 nYyPN34i/l1EvWBRoncM+xdWTc83hL8GmCPlRK/NKBElf6aRasMxv0Wx5Mg0Pv3xYNnBbOzHF
 sWgnJn+Wnnota9JElU1PElx7XQdbvdJgKBn8EmhpPfteuiBCI/xvPQxEUTNcLrD7Ohqe8y4yk
 L9XWB0nZIAbb71/DXY35ffjaWJB46ZnJTEcmgfa83DqwdKxoysyJpVcpZK3Jry4aABM9EmZP1
 oHxXyVg9NLtpBUrvE197eKq3gzmD+tPSkKX63/LOM9SXemyMSz2mfF9KmXQjKDue4gU82nD84
 xkzH5+JFDi/DHzPZiojK3HKjfOd7PeCesQnNLha/KldbEr8L5HGtDZFe5IBaOFLBjUtqLr33I
 PO1iGeTNksxtF3M6GTySeyCLzLrNQm2trBLGchiTAt0AQb1cUk7x22C7fQJPtFyMa15FrnOom
 Z2ep7tIbEZbZO1C02QF1xfcOhulA+lh/gROCbSsUDBYrdk0fbSul/fqOpUWjtBC25FCnQt1MX
 e1OfSo1hujhXm0cf3J8w==
X-Spam-Status: No, score=-104.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 20 Jul 2020 14:23:06 -0000

On Jul 20 09:34, Ken Brown via Cygwin-patches wrote:
> Commit 605bdcd410384dda6db66b9b8cd19e863702e1bb enabled mapping beyond
> EOF in 64 bit environments.  But the variable 'orig_len' did not get
> rounded up to a multiple of 64K.  This rounding was done on 32 bit
> only.  Fix this by rounding up orig_len on 64 bit, in the same place
> where 'len' is rounded up.
> 
> One consequence of this bug is that orig_len could be slightly smaller
> than len.  Since these are both unsigned values, the statement
> 'orig_len -= len' would then cause orig_len to be huge, and mmap would
> fail with errno EFBIG.
> 
> I observed this failure while debugging the problem reported in
> 
>   https://sourceware.org/pipermail/cygwin/2020-July/245557.html.
> 
> The failure can be seen by running the test case in that report under
> gdb or strace.
> ---
>  winsup/cygwin/mmap.cc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
> index feb9e5d0e..a08d00f83 100644
> --- a/winsup/cygwin/mmap.cc
> +++ b/winsup/cygwin/mmap.cc
> @@ -1144,6 +1144,7 @@ go_ahead:
>  	 ends in, but there's nothing at all we can do about that. */
>  #ifdef __x86_64__
>        len = roundup2 (len, wincap.allocation_granularity ());
> +      orig_len = roundup2 (orig_len, wincap.allocation_granularity ());

Wouldn't it be simpler to just check for

-      if (orig_len - len)
+      if (orig_len > len)

in the code following this #if/#else/#endif snippet?


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
