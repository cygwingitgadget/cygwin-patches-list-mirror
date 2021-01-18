Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 5B7F238460A3
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 10:24:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5B7F238460A3
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4roN-1l0ctP1TVP-001xCA for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 11:24:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BAB57A8093E; Mon, 18 Jan 2021 11:24:19 +0100 (CET)
Date: Mon, 18 Jan 2021 11:24:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: document a recent bug fix
Message-ID: <20210118102419.GP59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115175215.16678-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115175215.16678-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:WmEcDl67R5GGiwnJadZMrChaE85PL0QcE2hUJ2pto4mhffeSs0O
 9JxY7XeRY7xbSH3W8dvK5Ok2tPQ9fdOiR85JR31xfm0BPMYdgYLSuhLXxeDCQmd/nYI5g6v
 8LDv7Uf3gbGvTRsfoDI5TyfYa/vLWynuix6cFIXyPoEQoDSwfFqjPoPoBUuO/Ieno4hFZMx
 e4dFz62R5UVWfMoRLVqSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aPCn4cItO1o=:XAz9aEYCcE7wKHrCYuPLUl
 DyNIuhRM90HrTS1pL1V2Y7be5p53OLEF2c5a+DnjRvXfLEjAOK1HDIvO11aeQ0WzC/aIso/Qu
 brhn2u1t1TGmVliwPApvs1zCvYsc+RyrNU6Dj0YzCLYZojLM7F9CWmuaQ3Amc7BICJqCtQ1Sj
 Rbyt16jGIhGHSUijcmjqQMELVhjH/6bzQPZwCRe5vER/1aZguRlqOTIBV7NP/AsmgxAQGuBvJ
 u/4WBqSyWUjxKxc9N7+v6LLTD4mCIcACzhsQjxzNtKzIiDmWCdR0UZm/qn7QAc6n/BmVHwc8a
 QN7vDsSJM4XlVOrwGW7py+uLKDD0J/08O4Wfz/SM1q0Felad4dRn+I6iqNHR/3AtG9LRrNoqR
 KPO44JKfIsnTK0IXmg74S3sHzhVQPjCNLHyI1vy+aaG2yVs4brwUbijxbzwq/h+k4MZKzgbvq
 jVIFkpzVRA==
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 10:24:23 -0000

On Jan 15 12:52, Ken Brown via Cygwin-patches wrote:
> This documents commit aec64798, "Cygwin: add flag to indicate reparse
> points unknown to WinAPI".
> ---
>  winsup/cygwin/release/3.2.0 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
> index 132d5c810..c18a848de 100644
> --- a/winsup/cygwin/release/3.2.0
> +++ b/winsup/cygwin/release/3.2.0
> @@ -43,5 +43,8 @@ Bug Fixes
>  - Fix return value of sqrtl on negative infinity.
>    Addresses: https://cygwin.com/pipermail/cygwin/2020-October/246606.html
>  
> +- Fix a path handling problem if there is a WSL symlink in PATH.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2020-December/246938.html
> +
>  - Fix a bug in fstatat(2) on 32 bit that could cause it to return garbage.
>    Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247399.html
> -- 
> 2.30.0

Please push.


Thanks,
Corinna
