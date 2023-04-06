Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by sourceware.org (Postfix) with ESMTPS id 071963858D32
	for <cygwin-patches@cygwin.com>; Thu,  6 Apr 2023 08:37:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 071963858D32
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9MYu-1qVcA93GNw-015JHx for <cygwin-patches@cygwin.com>; Thu, 06 Apr 2023
 10:37:21 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4CB25A80C68; Thu,  6 Apr 2023 10:37:21 +0200 (CEST)
Date: Thu, 6 Apr 2023 10:37:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 4/4] Do not rely on `getenv ("HOME")`'s path conversion
Message-ID: <ZC6EwQgygFo/GkNL@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1680532960.git.johannes.schindelin@gmx.de>
 <cover.1680620830.git.johannes.schindelin@gmx.de>
 <8ac1548b9216b5b014947bb3278f9c647103fa91.1680620830.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ac1548b9216b5b014947bb3278f9c647103fa91.1680620830.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:SHkewYpJFXXXbHMU3zsuErOwuEAWaZG2KxefC9WI2PlljBWXHX3
 JyXIACWkVY+oKJx8SQOKs+dV0UaWXWaMm6wBJ+kq7kQh1qZpnkfFDX2/Pn9sZaf0ZkcROQk
 3GkYG6Tqj7gaS+LGwmx669djzIJzPsCPcRduD1GIQfNKF4yyABtPy6QoVsKRrCQhk7Qz8NI
 zmFrHhC9RKTLySDgHeGGg==
UI-OutboundReport: notjunk:1;M01:P0:ZDlYqrI1n6g=;PWuANbsPAJDU5DRmdupLffCNwuW
 7qsDyL6Tcb4SybL231I/6XedOrcoW/1E3EoCO6MBGM3D8uuK30V9ov9l/Q6DjAfiayt4RtLwZ
 YHMYlVnpdLwUW6U7khuCPhrNvH+bIpdtO5bYVHvR6lybKoVgAWxpSB6NJ+NXDnXo8o5w52WR5
 NUb41VIeEzzmMSUB9TXJP9s00jKJSwSNEbkrp5S38YF1yBiZgZB236pJFWVpD9F2eRj28iZ4s
 TZsQTwuI6NRtMufnye0OMHhbo7AUXZ8fgqPP/n8PzGNSAgwHfAOSlKhukp8Anp389J9VQGzfW
 tRPTR0gh+NSRTYgjOKY7JkO7XGzz4Q7u80a9GSojvyj2l24yAUBr3NdMzyOhodkyqhbW7fizh
 Li0vkV6fXAuvtGFy+Nnsk1QtluJCaq4R9HZU3drC6ZRRGyDkY3yLZ6Z6PRYg4cmRMWF7ofTJr
 gxXb30i3TkZtK7rX47me1uu+tYDeayXODe9dk+JhcgKtx+nNrW1sOhX/Z8OI9LQFzo7t3SPiF
 ZsUtORzHKW1sPVIM/RXM4KnZDhU56cm4MwiQxySJLwJIt++LauG/ESLpKo5vnRt8m3hsNkxTA
 66xi8kkanPES3gkssLZh/9pcuYgb4qZ/89hrNeKYJ2UBiQ+TixEPEdIqO5rEiwgZ2LJ4vx3Bp
 D1ucSYE6KmvbMcyk9Wo9/KHz4fJJy0NWGARJevrHVA==
X-Spam-Status: No, score=-103.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Apr  4 17:07, Johannes Schindelin wrote:
> In the very early code path where `dll_crt0_1 ()` calls
> `user_shared->initialize ()`, the Cygwin runtime calls `internal_pwsid ()`
> to initialize the user name in preparation for reading the `fstab` file.
> 
> In case `db_home: env` is defined in `/etc/nsswitch.conf`, we need to
> look at the environment variable `HOME` and use it, if set.

I'm a bit puzzled by this.  HOME is not a Windows variable.  You're
usually not supposed to set it to Windows values, but to the POSIX
value.  I'm aware that Cygwin makes the conversion, too, for historical
reasons.

But why on earth would you set a variable you have under your own
control, and which only makes sense in a POSIX environment, to a Windows
value?  Why should we actually support this scenario for such a special
case?

> When all of this happens, though, the `pinfo_init ()` function has had no
> change to run yet (and therefore, `environ_init ()`). At this stage,

  chance

> therefore, `getenv ()`'s `findenv_func ()` call still finds `getearly ()`
> and we get the _verbatim_ value of `HOME`. That is, the Windows form.
> But we need the "POSIX" form.
> [...]
> Let's detect when the `HOME` value is still in Windows format in
> `fetch_home_env ()`, and convert it in that case.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/uinfo.cc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index 5e2d88bcd7..bc9e926159 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -929,7 +929,13 @@ fetch_home_env (void)
>    /* If `HOME` is set, prefer it */
>    const char *home = getenv ("HOME");
>    if (home)
> -    return strdup (home);
> +    {
> +      /* In the very early code path of `user_info::initialize ()`, the value
> +         of the environment variable `HOME` is still in its Windows form. */
> +      if (isdrive (home))

While the description is clear on the colon problem, shouldn't this
catch UNC paths as well?  I. e., just check for strchr(home, '\\')?

> +	return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);


> +      return strdup (home);
> +    }
> 
>    /* If `HOME` is unset, fall back to `HOMEDRIVE``HOMEPATH`
>       (without a directory separator, as `HOMEPATH` starts with one). */
> --
> 2.40.0.windows.1
