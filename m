Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id D0AB83AAA0B0
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 11:46:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D0AB83AAA0B0
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mzhzd-1lrGIP2RlJ-00vfrP for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021
 12:46:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C3BA9A80D7F; Tue, 26 Jan 2021 12:46:19 +0100 (CET)
Date: Tue, 26 Jan 2021 12:46:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 7/8] dir.cc: Try unlink_nt first
Message-ID: <20210126114619.GM4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210120161056.77784-8-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120161056.77784-8-ben@wijen.net>
X-Provags-ID: V03:K1:txoZviYnCY/Yvxs6YUlJDuAoGQzDPZ4LSx1SqToVcdG93s0BmyY
 AtKZnDEzXJnLq/qiYIOxiBfkNhiHuklhcN6+v6/0nvcSucDmhBt0frUSE+hnLdNNpSZJz97
 6BZXAFxnOj/eJa3ranIVWgkDnoMDPerUk9coLmUgMk+WNvwvY8sxGoCmrRaZcbpAb4STVWx
 hHHgIEEy4XgGUUw+m4PTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wh7bMNqtGZo=:pCm3dHhNlXhLrK+SL90pU2
 lqfaSArvJBxO9tJHow7WsniAwETLsPl2xJmh2W7A1LIvMma8nMRjWWRvQEpkKCKco1ZqC9PpB
 xFvTvvKDpbWsCbkbmQ1zN9pkWZUS7gmbJel8zdwfeqJE62v475RPZxaHQWbz5DpbnBegvF54x
 j6P6YuPJiH4qRfnHRx4wXg4Vcp6QXTO/CLsbmHHsLFePBQvXLVa688ZP3Vim/Fx5fF8S2wVt4
 XNBtJ4jjwAIBNKx9KlnSsnEhn5c7IPfNgt2tokq9N2JrlkgQQG5Qmm7YivGSrsGxO/n0OvSA0
 cTLhXlnNjdnShr3fTEAo15EgNQTgpnI09jeQYgoeS4KxpIt0Wr3d/G6+1f+o0O+8JfDKKURtm
 tQlDZEHzZy+dYl6d2cYXHFyW0mV9b4gcgkerTC+Tvj5zoej/XYSy0g+naOn5DB4vpo56nfQKB
 L2P9M+wX7g==
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Tue, 26 Jan 2021 11:46:24 -0000

On Jan 20 17:10, Ben Wijen wrote:
> Speedup deletion of directories.
> ---
>  winsup/cygwin/dir.cc | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
> index 7762557d6..470f83aee 100644
> --- a/winsup/cygwin/dir.cc
> +++ b/winsup/cygwin/dir.cc
> @@ -22,6 +22,8 @@ details. */
>  #include "cygtls.h"
>  #include "tls_pbuf.h"
>  
> +extern NTSTATUS unlink_nt (const char *ourname, ULONG eflags);
> +
>  extern "C" int
>  dirfd (DIR *dir)
>  {
> @@ -398,6 +400,14 @@ rmdir (const char *dir)
>  	  if (msdos && p == dir + 1 && isdrive (dir))
>  	    p[1] = '\\';
>  	}
> +      if (has_dot_last_component (dir, false)) {
> +        set_errno (EINVAL);
> +        __leave;
> +      }
> +      if (NT_SUCCESS (unlink_nt (dir, FILE_DIRECTORY_FILE))) {
> +        res = 0;
> +        __leave;
> +      }

So what about /dev, /proc, etc?

>        if (!(fh = build_fh_name (dir, PC_SYM_NOFOLLOW)))
>  	__leave;   /* errno already set */;
>  
> @@ -408,8 +418,6 @@ rmdir (const char *dir)
>  	}
>        else if (!fh->exists ())
>  	set_errno (ENOENT);
> -      else if (has_dot_last_component (dir, false))
> -	set_errno (EINVAL);
>        else if (!fh->rmdir ())
>  	res = 0;
>        delete fh;


Corinna
