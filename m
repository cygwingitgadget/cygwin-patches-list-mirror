Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id BDC34385356C
	for <cygwin-patches@cygwin.com>; Thu, 27 Oct 2022 11:32:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BDC34385356C
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRmo8-1ocMGk0LCk-00T9MV; Thu, 27 Oct 2022 13:32:44 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B3AAEA807CD; Thu, 27 Oct 2022 13:32:42 +0200 (CEST)
Date: Thu, 27 Oct 2022 13:32:42 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Hamish McIntyre-Bhatty <contact@hamishmb.com>
Subject: Re: [PATCH] Fix typo in faq-programming.xml
Message-ID: <Y1psWqiNnWpDSGDs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Hamish McIntyre-Bhatty <contact@hamishmb.com>
References: <20221026132616.280324-1-cygwin@hamishmb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221026132616.280324-1-cygwin@hamishmb.com>
X-Provags-ID: V03:K1:k4BjXHsbaAizYq/k6Vv7WORVjIYARTVl7VpCUmn1AVFGw3QBjXf
 fhOwoeOqxcyyLHE63k8IWBOs3MOlWTKrGUnKTzNUNCCHxmky/eVPuNS4+CLI2Hd0Mo34Fux
 IL6c8jv/5EiCi4C6n+hdy9jfqBSoKZC4vb17xYD0h1VNJViEoRGwALlK85oBggLwID55TZI
 6amjcpKnIJ2KFs2N+QKsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tQN17/m0+cE=:7CTZWUmk4uPf4Xstr5GvBn
 aHD58rtXrksB3UjVMHVL5f55qvRMp/E7K3tA2JRB7X2ThwitlVOgOCIHNS58aZyiik3/kWO/Q
 Lcx6SV0JEDSoGVdnZqYoeZAAwEemMnTgZYXOwRmhimsiypBivg/jZmqW9Y6Kv1iL7Fh3xLVUs
 PkiFS5ZXVk/ZA1k+SwpCJJUWbMBYqnzo5p95DR+tb+KxEs5LZRQyyDPjWr1Ed5X93BzoBYxAR
 K8GL1f7OsDZAmjpxp04zgwFRSqzQ5brhvotq5bg1cIpcE8FPNX1fmD5Ek8tw6kutxYzQVubZQ
 Ds0iAE7z6jaqXqInyWdms4T2/yNG83kXyHxE5QNKCk11phIKPhmVl0OsdJQgWuqpNmIV61dkU
 QdPbQO8/LrH6x7kaJnpgsJ8QLeM3+V3bXoJPEGmgN5+2Lp6Lb3yI/XH9sk5TgQk9UM2x+Y0xM
 R3ukkUUqJLAtKMZz9t8/TzF9mkQe6RqVsxBnp+/oyg5M736yygjlfY7S+KX0wFmJixYftDdwg
 gHsg7c2Oe7vY5qcTCGL9Dh/NXn1ZS6F3tzVRyVT3L8S6yuH55yhK0c3U/64gfo6vH4xigvOWZ
 0c8AZ93wgoY6c12DkFGtTNiR5gfkUJRVVQWq1DoMJSoS28m92Yty8btzxsYZIG9YZKp0ZWpto
 fBEZBiIe/oYU9UUwhnk3l3zLuE3LdBTefEzFKcLr0oAYbhTI7eEE26nHz49NWaM6LhLRnNHgh
 +nbWRCqDPEVmiy4VpJlKz40oBrV29a/cdYqTCQ1dTcqEB3121oP0wgyaSmh9jt0ywmRwOwH4U
 fgBBIaevOkJXlCkpJYViNKsch2rvQ==
X-Spam-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Oct 26 14:26, Hamish McIntyre-Bhatty wrote:
> From: Hamish McIntyre-Bhatty <contact@hamishmb.com>
> 
> ---
>  winsup/doc/faq-programming.xml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
> index c2c4004c1..7945b6b88 100644
> --- a/winsup/doc/faq-programming.xml
> +++ b/winsup/doc/faq-programming.xml
> @@ -1051,7 +1051,7 @@ a Windows environment which Cygwin handles automatically.
>  <question><para>How should I port my Unix GUI to Windows?</para></question>
>  <answer>
>  
> -<para>Like other Unix-like platforms, the Cygwin distribtion includes many of
> +<para>Like other Unix-like platforms, the Cygwin distribution includes many of
>  the common GUI toolkits, including X11, X Athena widgets, Motif, Tk, GTK+,
>  and Qt. Many programs which rely on these toolkits will work with little, if
>  any, porting work if they are otherwise portable.  However, there are a few
> -- 
> 2.25.1

Pushed.

Thanks,
Corinna
