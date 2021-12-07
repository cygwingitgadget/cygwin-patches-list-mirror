Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 66FA2385842D
 for <cygwin-patches@cygwin.com>; Tue,  7 Dec 2021 14:16:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 66FA2385842D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7auL-1mvQkX3OaT-007yTZ for <cygwin-patches@cygwin.com>; Tue, 07 Dec 2021
 15:16:56 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 42DB5A80A6B; Tue,  7 Dec 2021 15:16:56 +0100 (CET)
Date: Tue, 7 Dec 2021 15:16:56 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Update configure.ac to use AC_CONFIG_HEADERS
Message-ID: <Ya9s2HC0cQnw8Xy4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211207132933.6796-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207132933.6796-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:tJpGsprByUpIrKpbMmtRqjAuZPzWHwRNYaFkstua70WYHrU8oYb
 gTri4ql6mY+XqWwIrhuYt14A76kLTKRkIuQonBfh32NB9ooxxN82iTHXtfmsR1zZf/PTqWq
 J+oJVweS+BJ+crW6w12u2l3JFw6xo4lOlNq6qcxzdc5lglUGinCzZ+ZgGRYd5fzREIvsPSj
 1mHIkGN53wS8acXG94RBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xVnCQQFzLf0=:mawRf96Op49yKzM3/EOYx2
 edqWqwfmuDy88ZvkTpCoIVzNifhGbZ3nO2erW544Vl2JDvIHwmwo4O69JiCJoyV+jCBclsShA
 lmXGGCyKVF5vtn5kKtG17ppROVsxg0M5UOC8J6Wmz1F53ndkhFT2nBLCV2w4Iz70R535FsYK+
 PAYuwb9hpjVwlcdoMZMo2icZkqmsC9DJ9aaKqa8Y0lRj/8xF6a4nPQtnVp+H1Shfbx0LynKMi
 JHJuJ2u9afuss3SYR4lNAOcL4w7Q/7n/0Vlb7HUjwZCA679QuDIlW2ptb+TuwfD/ZGsc1BLzs
 JK5nmrSEOh/KMHQoSkDXYTpqPArb999cCw+lYOvEuVkNRY7Z7rELc97o7uL1Iq90skx8y/Czy
 TiIj/7Ki1jqTTDRYe8I2vovGjL7IhEbYB6zrWwK1WB4A7W+EMpvfb7AcU2KkDf9C3GoF7NKAA
 728wu7LF6NCcncM/XBF6KhMPW+HbrBlCLdOSHMVuesGZwvFbWs92v3S7yIL+91KnQ7MlIWnEr
 NKeiVxuTmF8s7MK8qhX5xs6U3tZLOufJUHD2806ELg7eXT4mi42LlrKwPUaDX+l1dFS328ihp
 M28j6IV52L/mIPlsu24QOFgLE1CStswa5O1MysZAppMLoJmNU+6pMPQmW5iIwWJUIA6JAUI5k
 AbiXC9FTDvZlrL52Xhu1X6xgVIeGXIwrybx+3AFS7IMZjuTcoVDWyHAl+iibt2xnV9NmiiSSh
 08IkDysC4hmOgGYq
X-Spam-Status: No, score=-105.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 07 Dec 2021 14:17:01 -0000

On Dec  7 13:29, Jon Turney wrote:
> This avoids warning with autoconf >= 2.70:
> 
>   configure.ac:47: warning: The macro `AC_CONFIG_HEADER' is obsolete.
> 
> AC_CONFIG_HEADERS has been supported since before autconf 2.59, the
> minimum version we can be using, controlled by AC_PREREQ.
> ---
>  winsup/configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/configure.ac b/winsup/configure.ac
> index 9a11411ab..79e78a5fc 100644
> --- a/winsup/configure.ac
> +++ b/winsup/configure.ac
> @@ -44,7 +44,7 @@ AC_ARG_WITH([cross-bootstrap],[AS_HELP_STRING([--with-cross-bootstrap],[do not b
>  
>  AC_CYGWIN_INCLUDES
>  
> -AC_CONFIG_HEADER(cygwin/config.h)
> +AC_CONFIG_HEADERS([cygwin/config.h])
>  
>  AC_CHECK_TOOL(AR, ar, ar)
>  AC_CHECK_TOOL(AS, as, as)
> -- 
> 2.34.1

Sure thing.


Thanks,
Corinna
