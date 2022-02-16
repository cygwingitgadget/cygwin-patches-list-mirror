Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id CE8993858D3C
 for <cygwin-patches@cygwin.com>; Wed, 16 Feb 2022 08:32:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CE8993858D3C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQuwR-1ng1Th1nyJ-00Nwyr for <cygwin-patches@cygwin.com>; Wed, 16 Feb 2022
 09:32:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C52ADA807A1; Wed, 16 Feb 2022 09:32:01 +0100 (CET)
Date: Wed, 16 Feb 2022 09:32:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix bad bits in
 last change
Message-ID: <Ygy2gQVkfD1VXKfm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220215215420.40254-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215215420.40254-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:PZNmyeYEM7fMa5KO1daFvx1kmX6xb+lNkytScxeftuQe9j4TQkr
 Nk6xQ8uRTsnwIMFLHktHzvS1+l/EjfpTD9lhIlOTi5BPLUEGfbK4h+66gpujkjci6oA3rR/
 8RIpJgSZgP5gzBf/Hp1m0HvfWv1E0elYwBDY3lf2a1x+CutySdOBq50F2Pr/CXKx0zB0D2J
 ujXmrDQJQwSN5wDuCzrcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VfP2wQ7FjPM=:eKrAoj07dvE60tJDknTN8L
 21STjdDkYrdWr2r9VgxvY/6a0FFiLwHYZcdxZzGyQ65Uir6HxAYHaSTsFelaFp2xlXm8fT9U0
 WHMEMNHQ4qvEff4c/S1FaA/VrKPCPXTHb2A/VBcR3J4I1BWgGw/v4lXOee8N3VQPNNvApyGvB
 KZm/Gh3rgWH1/RovDD/acfFy8ieQooeO4lcyiEBHgE6WUQEJG0jVZqu3+NkIDt/um6aUtXgDJ
 lyKtPfsJ33q1LcguKvet8vR2HcZq6Q69x5Be5USJN4bN1XD5Afv0NWGmViR7g0QVIn8j1Ayml
 HwhqzUUoUnXwzAHrvn7srIHkJ8gy6/s87TuNS8pHhQYVijFD63HuDoZMln6N5TzFv9F7QCGFl
 DKzhuOEI+93TBkTwHpS+Kuy/2PWPDdppGdRge215fTIEFhX1t7snEoExFzgGpwS5bvz7ie90F
 1RqX7+W38W8h3rhAgzTPsILgWI/b0p2M24/aKO1hneWXUpRwtqfqNpXYCJPV8A2wwUyDwjC7s
 mCOn5siZ0iH6FwGz50jH+20P8ks7PuCCXZ4yvPLij/hpeUNvv9Cz+Xcra5I/myAHwxbY7F8Ok
 v0eyeNHheBriB89jWjLZjFXcS/WNyvi/B0FBtdpUPEGfQx4Bf7INMebiumymCmUgeuK92n6qM
 WTw5HneB5DY+BdLFy9azjIQfjE4bcyN2db2IxCNGZkXOMMJ+smwBN6OO/0f4biFwbwInyi+lc
 ecg0oGgLfGF86Il1
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 16 Feb 2022 08:32:06 -0000

On Feb 15 14:54, Brian Inglis wrote:
> 
> move Linux 5.16 Gobble Gobble flags to 5.17 Superb Owl correct positions:
> 0x00000007:1 Intel Advanced Matrix eXtensions:
> 		 EAX:22 amx_bf16 Brain Float 16 dot product
> 		 EAX:24 amx_tile Tile matrix multiply
> 		 EAX:25 amx_int8 Int 8 byte dot product
> 0x00000007:0 Intel Advanced Matrix eXtensions:
> 		 EDX:22 amx_bf16 Brain Float 16 dot product
> 		 EDX:24 amx_tile Tile matrix multiply
> 		 EDX:25 amx_int8 Int 8 byte dot product
> ---
>  winsup/cygwin/fhandler_proc.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Pushed.


Thanks,
Corinna

