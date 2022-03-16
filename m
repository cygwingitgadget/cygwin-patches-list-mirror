Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 57C0D385E83F
 for <cygwin-patches@cygwin.com>; Wed, 16 Mar 2022 07:47:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 57C0D385E83F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MI4gb-1nIa0x3LWx-00FAxR; Wed, 16 Mar 2022 08:47:40 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id ABD88A8071E; Wed, 16 Mar 2022 08:47:39 +0100 (CET)
Date: Wed, 16 Mar 2022 08:47:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup: disable fortify source
Message-ID: <YjGWGzZmlpoP7AEo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mike Frysinger <vapier@gentoo.org>, cygwin-patches@cygwin.com
References: <20220315032053.10985-1-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315032053.10985-1-vapier@gentoo.org>
X-Provags-ID: V03:K1:xa39zZlkeYL1u5Q1RJpkeSHwZfOkZjuT2NixAQz1of08p3fmD0i
 VoOeAaK26u9gtFGrG8eqvMtrmrYw8XNyczTseuWXTmNok8CfZnauJ0suo2qdCuxhghPUtfq
 JwvxbBSEJddEzEgbD/Rq/lTZqqL62q0xatoGCKfIWyz2McKC9PlA75r/PDBohz+1sX0SKWJ
 Nd7RFBXvRLiMsQSsnf/CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H4QjNc7pPow=:wi2TJWq9tsxPeeM6wy20V6
 kiqtLEQ0nSHasWwuoBurXendBH4Z3Xt57wQzbv76M1TauxfUnkxQkSaND0tca5I89qqTEAIYQ
 vhml32KFAjPEbtiLMHUTPQQ7F3TCyubnLHOAIXIiKoEQnVPDM7vSvdOgbkzhZoASxQJvoZa+J
 ppt2HpRPlTdxIdQ/Ti7kOAHcgCAPSdwG+fW/HTIbsokJBUUyjhCl5ZXZ1aSJxW8rA7LkzrrIb
 nL4gCi3BQY+W8268pQa77PBzVyD0Y+KrFTPcjCRQSxODCgY5oa3mCh18CWfUzL7NHDlPXNWAe
 2VnIMIxT1quz+Cn/00p+0i6URGEhBwTgkwoM6cbmLQK3xiufKN2NpNbPBPne7EYaBrFQ/Q1Qo
 LTryOs52j6jmgkeODB8XBZnwD6+VGLGViumZcNkMyt20u5eayVEiX3B/fLKPyvNY5+LNpm9J6
 mkgjvi8QDiun9SdG5v0iAWhKgVlv/VWAjbOOFkiYq4WSGKnAfYbQ4c/e8+130cuyuB7FSPBPR
 T44cHZXTZxTI6pYGH2ARyYGXH5fEAcAkMOCvAyt4yNgxm4Jzn7Rs5TOS4HsA9QrzZFKrFA4hb
 v/HPAWfVLS4/8+tfFbOkXanwmhuSB6ZJYfXdyg3R95TKcumnxcxPDcjM+skjPLc2AurFB8mD1
 U1COOzmkBXF3lsURJpwvULFOKyXRsyAlw0mgO/3yymb2Os267y1vlPs80KvQ3nuLHQsza8ook
 948HB89TO3RwQBYK
X-Spam-Status: No, score=-103.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
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
X-List-Received-Date: Wed, 16 Mar 2022 07:47:47 -0000

On Mar 14 23:20, Mike Frysinger wrote:
> When using a compiler that automatically enables -D_FORTIFY_SOURCE,
> building winsup fails with errors like below.  Since winsup is not
> setup to compile itself with _FORTIFY_SOURCE, disable it for now.

Yeah, the Windows headers are a problem.  Who would have expected that...

> diff --git a/winsup/acinclude.m4 b/winsup/acinclude.m4
> index 7c900d70719a..ffd15aaaa86b 100644
> --- a/winsup/acinclude.m4
> +++ b/winsup/acinclude.m4
> @@ -16,7 +16,7 @@ if test -z "$newlib_headers"; then
>  fi
>  newlib_headers="$target_builddir/newlib/targ-include $newlib_headers"
>  
> -AM_CPPFLAGS="-I${winsup_srcdir}/cygwin -I${target_builddir}/winsup/cygwin"
> +AM_CPPFLAGS="-U_FORTIFY_SOURCE -I${winsup_srcdir}/cygwin -I${target_builddir}/winsup/cygwin"
>  AM_CPPFLAGS="${AM_CPPFLAGS} -isystem ${cygwin_headers}"
>  for h in ${newlib_headers}; do
>      AM_CPPFLAGS="${AM_CPPFLAGS} -isystem $h"
> -- 
> 2.34.1

Thanks, please push.


Corinna
