Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BABB74BB58AA; Wed, 11 Mar 2026 14:54:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BABB74BB58AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773240898;
	bh=xpjuR5A9JPic5AKLViFl4ne8chqmySEyT4QlDhNMyDY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vnSG9rzAr/EiqKCGaOtichB2UTIEsJE7WMqSBvhvKVBehRvD/PnT/J6/zrmLVllW/
	 eA55dMJCjDYUlMve4/dskXMZkz/p9MCfDwZCOIWCo7yEI8D1WK14iVQBK5/1XYPoe9
	 G3OpRCx3mHnq1BnInThpW0+Yc9imAfQX/WWW/ZBQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D2CE0A80859; Wed, 11 Mar 2026 15:54:56 +0100 (CET)
Date: Wed, 11 Mar 2026 15:54:56 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 2/2 V3] Cygwin: gendef: export _alloca only on x86_64
Message-ID: <abGCQB-jNOmxRQQH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB3082B2BA4E9D476168C4DB919F65A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aYpCJ6Tybk0mGTLa@calimero.vinschen.de>
 <MA0P287MB3082A6AAABBF6611C1B989349F62A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB308238F12BC9D259C02CC7EC9F6BA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB308238F12BC9D259C02CC7EC9F6BA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

On Feb 19 19:30, Thirumalai Nagalingam wrote:
> Hi,
> 
> Resending this patch to apply cleanly, as the previous version no longer applies due to changes in the dependent patch (https://cygwin.com/pipermail/cygwin-patches/2026q1/014647.html)
> 
> Thanks,
> Thiru
> 
> In-Lined patch:
> 
> diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
> index c3518f480..7709a0653 100644
> --- a/winsup/cygwin/cygwin.din
> +++ b/winsup/cygwin/cygwin.din
> @@ -144,7 +144,6 @@ __xdrrec_getrec SIGFE
>  __xdrrec_setnonblock SIGFE
>  __xpg_sigpause SIGFE
>  __xpg_strerror_r SIGFE
> -_alloca = __alloca NOSIGFE
>  _dll_crt0 NOSIGFE
>  _Exit SIGFE
>  _exit SIGFE
> diff --git a/winsup/cygwin/x86_64/cygwin.din b/winsup/cygwin/x86_64/cygwin.din
> index 12a49b009..f352b5e8c 100644
> --- a/winsup/cygwin/x86_64/cygwin.din
> +++ b/winsup/cygwin/x86_64/cygwin.din
> @@ -4,3 +4,4 @@
>  LIBRARY "cygwin1.dll" BASE=0x180040000
>  
>  EXPORTS
> +_alloca = __alloca NOSIGFE
> --



Both patches pushed.


Thanks,
Corinna
