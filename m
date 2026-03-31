Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7F0FF4BB58B4; Tue, 31 Mar 2026 15:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F0FF4BB58B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774972270;
	bh=n3hMuf5gUn6bOjbyUYrQORb0cZCRrEq5t4l2UID7eFc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EjHUIsjOPoiR0YkjZTaS8NpOA89uM0NcILxYKVjhhwdrXhio+2Iu3Zw7lTVvIs/MM
	 diSxTMKN+MP0AwVUajTJfUqW0pHTK3iVDWxLG42KM38kmFIM+goIoZBWWP7sWAnbiQ
	 Tc7Fucv0YGHpSQFHMTqwFHZv8RnpZaxeD5Axp0PU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6F05DA80BDF; Tue, 31 Mar 2026 17:51:08 +0200 (CEST)
Date: Tue, 31 Mar 2026 17:51:08 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
Subject: Re: [PATCH v3] Cygwin: SEH: Fix crash and handle second unwind phase
 on AArch64
Message-ID: <acvtbIu--Oafeca9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
References: <acu6Bt7BbG-_Cyrr@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acu6Bt7BbG-_Cyrr@arm.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Igor,

thanks for the patch.  Quick question:

On Mar 31 12:11, Igor Podgainoi wrote:
> diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
> index 289f395e4..0b5255495 100644
> --- a/winsup/cygwin/local_includes/cygtls.h
> +++ b/winsup/cygwin/local_includes/cygtls.h
> @@ -344,21 +344,26 @@ public:
> [...]
> +#if defined(__aarch64__)
> [...]
> +/* An SEH directive that switches back to the code section.  */
> +#define SEH_CODE ".text"
> +#elif defined(__x86_64__)
> [...]
> +#define SEH_CODE ".seh_code"
>  #endif

Do we actually *need* the .seh_code on x86_64, or would it be sufficient
to change this to .text for both targets?


Thanks,
Corinna
