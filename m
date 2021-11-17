Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 9D0EB3858400
 for <cygwin-patches@cygwin.com>; Wed, 17 Nov 2021 14:25:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9D0EB3858400
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mo6zD-1mLC7n413T-00pgaB for <cygwin-patches@cygwin.com>; Wed, 17 Nov 2021
 15:25:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2262DA80D57; Wed, 17 Nov 2021 15:25:52 +0100 (CET)
Date: Wed, 17 Nov 2021 15:25:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Correct the release notes 3.3.3.
Message-ID: <YZUQ8NoTRNIckCCE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211117080908.1811-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211117080908.1811-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:zXmHTG0EKvY1ywq+7+J8t8OrLwOduDOC8TfFc+wDqpN8PmkmhHA
 ScWTjg0HqQps+cIUgEHyX9OAXT0d7SzKY+Cqld15RrQDcaP9b//9mMDA7ko5k7XvPkV0nQd
 Rp4ZYd/Qyag+ZCb8iDRhUA8QzWmjFMsFecm7ZbL1pVi+FVm6f5s6sPn/+KROX4beAySHViT
 6kBym7kytWEjVa+kbGXBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:shauDxxUeR0=:0gwpbmeciju1yqJ6tcWBzD
 pczt/fGUO5x0R8sACFdvZOhhXOAHC4Z99zjuF/h/Gr0qUqf6KykdpCMIwdgXGgOZQ3aCFgB89
 FdRECjIfvYB/S8sCj3Jd/tfMryFiVgJvdsM6k589Il2Mm2V6vmiZYAi3rTMOed/FDfexsIZSo
 +f2xZ5nV/1AskjYlUhhs/jyTGwTvj72sQqrWs1Zwht089+/SZ39ncodHEA+pm+EyspV0T8hds
 DYeIBxnpwDUv58vXL7v62oAbFgikdSMpcODto4GTvmZ9/vAB2bN8pTsT2BPoTeuknqTgHLBCC
 1it/UdFuJJWIIuAOgZxwkjD4/rBTynweu0rKxCRoMa5rQrRQTGi68EekFJnCDoWAW1jj1YGI1
 wpSitYfC0A9chsPSNC/yJZ8c6tneAEx7i2zI2wwfh0n2sUzo08HJMmwdRg6GYkrp22uSu+6Bx
 0ASuOfz9mCOZNsiGoluInLtC0sIqYShfkBZtQnHFJqVC1fDEVfcSUEzoyWOQ9MHZMiX6tpfaj
 7ahsRDC7rfcEOvQcT6Ac7HnTiF8vAY1COJF+TBEG6Mt3bT6cSm7mDjTNA6GNhhmendBQGUxkE
 Gb66pAezuOruba4OAYLMWsj+77b7Gn8PCMWMy3VMJiVofhdZzNEQY2vdFfY9YZrXJh8I7QUM4
 fKrDCFVwCnX+Wy8qPstqlgyN6ZI248PgRZPl9WB00YuJD2j5ARm7D/bhG7O7Hpk2RGn3vMhDc
 ndNSWvmgTonDK7YN
X-Spam-Status: No, score=-105.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 17 Nov 2021 14:25:56 -0000

On Nov 17 17:09, Takashi Yano wrote:
> - Fix incorrect description of the bug fixes part.
> ---
>  winsup/cygwin/release/3.3.3 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/winsup/cygwin/release/3.3.3 b/winsup/cygwin/release/3.3.3
> index 7248302a3..c947816db 100644
> --- a/winsup/cygwin/release/3.3.3
> +++ b/winsup/cygwin/release/3.3.3
> @@ -3,6 +3,10 @@ Bug Fixes
>  
>  - Fix issue that new pipe code doesn't handle reading zero byte reads
>    emitted by some non-Cygwin apps.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249777.html
> +
> +- Fix issue that new pipe code doesn't handle size zero pipe which
> +  may be created by non-cygwin apps.
>    Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249844.html
>  
>  - Make sure that "X:" paths are not handled as absolute DOS paths in
> -- 
> 2.33.0

Obvious fix, just go ahead :)


Thanks,
Corinna
