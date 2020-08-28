Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 07ABF393C860
 for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020 13:25:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 07ABF393C860
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M597s-1kCkJ82tTo-0019Ul for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020
 15:25:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 498F8A83A79; Fri, 28 Aug 2020 15:25:18 +0200 (CEST)
Date: Fri, 28 Aug 2020 15:25:18 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: select: Fix a bug on closing pi->bye event.
Message-ID: <20200828132518.GJ3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200827094620.591-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827094620.591-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:X7oZlc9NXDww5JLoLh/cgYR9SEUi8WPmmURUoTpB5Mn3JtREQ8N
 A2sjW7+1YzUUR9TiMrvEVhrAdr9jXuBGxcIv8O+VVOsHT/cFsdOAl50xPB25ZsG0wboxuf8
 Uh3jbfnjKNzdAcn3hA/xZXjHGtjisLJ7vELTzA1mcQbe9zOR2VxKvYxBOTljsFRkSPmFQBM
 Z0EpHl93vIX4QDt+S53yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uJ5O/GcAlCU=:MFifiHDvxiKqnfkBPWqfCh
 JB3Sc2EZhKRpT6kOvmke24+jCItxFvGz041A28btpdZzpbahcjyfnwArarYMzpB1gGw0HV/Ku
 D264a8H7NJ3LyxJb5yb5epxkVjw73PfRbkvbH4mfswUmBJinAHrfrx/WtHDPLzO/fVYnfx0XP
 HTmRcwweMhVnmyM6eqwuXHcMEC8PaNlDfAWnvzmUbTE9AU3/wL3OowC+CpG4UwBFNlVyDalVZ
 vMPjsT1Qy3qS8zKzpbjO4Ub6cH7Y1TAPMzDkzjBJHpPIt8KAerRTNG5lOC4p3x1+S4Fsp/sVt
 r9XcEzH2udI10R085Cpak8Q1RMDITGP6Y3NBHQhtGQ+zGcnqMTaMhRpB/IXBZH6FZJ3iwLqZF
 zl3fmLHe+uCzLpWgeyLux62svWoJS/UJzz0ZzWGqA1Ls/km3S5ZkBwKVatQu2oUoS1DNjtK8I
 i6eYsfct5WOZ9OJGDeTKluJflgjR+aqBlZlGQq0grQ3TDIpZYsTAS4g7AaH/b9GHlZNNKpjMq
 Gn5Gr2USc3i8sKYt4bVhTN8sM8mv2lSJ/XWnjGxMw1WW6qZE8cf46WaE4hv5wh+8X6KS04oXx
 2ScgVgdVrugWV2LM4JisPM+7Sw1h3bUsTL12Xngj1zOqR0FFuZSjH0/rk6DMCjEt9bZZ71qM6
 3wOFoRgdGr71nDXZ/1mcOmJhihLUb5CH1mjhA8BihxSuQME+SclgqrvmPeEMzOr2ABhA3/3Dg
 0fctfLJrUsuD3p9BXRCMcLkCpQxq9DFcmMJBbiecpjiCietAK+6dM+lt6BS6J9nY1R8+vrj/y
 K7QTjxTB264RYjCs9DMPgSuaMTR/FyV7rqBmn4LQv8fvG2a2gOKNUrZF5JnRmmDsCH0yED2VR
 RoW8PnUow+/pFTLkPnTw==
X-Spam-Status: No, score=-99.9 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 28 Aug 2020 13:25:21 -0000

On Aug 27 18:46, Takashi Yano via Cygwin-patches wrote:
> - Close event handle pi->bye only if it was created.
>   Addresses:
>   https://cygwin.com/pipermail/cygwin-developers/2020-August/011948.html
> ---
>  winsup/cygwin/select.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Pushed.


Thanks,
Corinna
