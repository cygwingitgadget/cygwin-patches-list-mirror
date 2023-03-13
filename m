Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	by sourceware.org (Postfix) with ESMTPS id B7C5F3858D39
	for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023 09:32:07 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MhDEq-1qEa7I2Dh4-00ePdG for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023
 10:32:06 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2FA74A80D02; Mon, 13 Mar 2023 10:32:06 +0100 (CET)
Date: Mon, 13 Mar 2023 10:32:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix type mismatch on sys/cpuset.h -- relnote
 3.4.6
Message-ID: <ZA7tluJyrfjgeLP7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230311233628.18424-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230311233628.18424-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:CyQBWGcnWexfoVBixryZoLBVYDxWM5+BWYd7+OFj23lL1yEEruG
 lJQ2YN4QD+NSGXVumO0BTimoKTmR+Xt75BKaM0Ob2NhwBS0jubXm/b1nbjzkUMzVn8LO2qM
 GwVs3X1p9bUQhxYVUvlJkyifXl0Db8696mVucnnPaB+bJHEdHQ8qLw85fjE9twxi+iAanYB
 c8iuAPp98d7T98nX/frag==
UI-OutboundReport: notjunk:1;M01:P0:YSuk4n4EZgI=;WCxxohYCkH50Lgon+zH61DXHYlk
 Qh6PSEFYLeX2o6kMdnBsl5hQG4sEFmqV9NOoPYPZMPMjn+5OjgmvaIyD3jy1XcK+XxlBlMdBe
 8dz/2vD2efYpke/qzXizyj/NjOlR74EiVvad3nJp+sbH6lVuPYDdhD9lWLxEzcC1E+grrA/4g
 +/T34aFXeYx5mP4+67T9WqA08vXo8IZoLdjrNWBdXdtuVFIIMhpWVCyEpJxHuhdO37i5UcG6D
 aggaxubca813i9u9aRQCZXqgg2UUhNCc8BV+B2avnupTEgA+L967PQRowq7TepqUP7pq3ewcJ
 wBaZ5k+uHRjBzNQzJfVp6a3DDx+rrOx+oLh/T3zl7pCG37VLA3KxY1GTy/A8U73R6PKsvSYoD
 2Spvonwfp6rdoUD83Xayetn2rKRDk8YvUde+RlA6ZnFCRlUQhKmEFp+84C3PCr2tNbOGvf4KG
 +tyn6zGDJpOOUur9eelxpIoCP2+ssOqTstF+40cpCYHkCYJRheBSZqLunR8ScHoHhc0Z1MxZi
 PkIHSXmIf1W9XRRq5Au9nt/NGWl78uSRW6F9OMfXRqWLWJCkepeMSfFoTNeaGYeYYUnb0WrZH
 FZIo62Xes8kEWVDAyiQ2PpkSsQoG6YDs1GLjmxle209xpIP42rPEzvP0aGtOjcP2Wth3r7OuW
 kiD9CRu/bUTAr9AVrolHJbQE6hLHaExmSOnO3FKNKQ==
X-Spam-Status: No, score=-103.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This should go into the 3.4.7 release message...

On Mar 11 15:36, Mark Geisert wrote:
> ---
>  winsup/cygwin/release/3.4.6 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/release/3.4.6 b/winsup/cygwin/release/3.4.6
> index ccc168a95..ed124ed37 100644
> --- a/winsup/cygwin/release/3.4.6
> +++ b/winsup/cygwin/release/3.4.6
> @@ -12,3 +12,6 @@ Addresses: https://cygwin.com/pipermail/cygwin/2023-February/253037.html
>  
>  Don't accidentally drop the default ACEs when chmod'ing directories.
>  Addresses: https://cygwin.com/pipermail/cygwin/2023-February/253037.html
> +
> +Fix CPU_SET(3) macro type mismatch by making the macros type-safe.
> +Addresses https://cygwin.com/pipermail/cygwin/2023-March/253220.html
> -- 
> 2.39.0
