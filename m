Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AF1BB3858D37; Mon, 14 Jul 2025 13:11:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AF1BB3858D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752498719;
	bh=BQ4V42wZ96XANLLcvyzw4q6spRKCglhS6CncI1VVASo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qGpWBaM/zftdjPKes6ajIz/+riKB/yuVCDZ6BodK8GgBfKYGocgVnh9oPvZR1pxn1
	 RScQLwI+qlHz6qDa1jQwWSi2bpG8ZwR96Vo3ezjtFRNzJo/v6nN4NwuLCz3p6IGs0C
	 mxG0PNsLazL87fx1SYwgdGPdTJXk4oQMvm5HK8LE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EABB7A80864; Mon, 14 Jul 2025 15:11:57 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:11:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: resolve AArch64 linking by linking to onecore
 instead of kernel32
Message-ID: <aHUCHQvK7UKMepvh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB09239F1F48DD7D215E1A0B6E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB9PR83MB09239F1F48DD7D215E1A0B6E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Radek,

On Jul 10 19:14, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> As Windows Arm64 platform does not carry historical compatibility layers, the structure of Windows API DLLs is cleaner on Arm64 than on x64. For this reason, the x64 linking against `kernel32.dll` is not sufficient leading to undefined references to many Windows API symbols that are in different DLLs that would have to be added to the linking command explicitly.
> 
> To address that, there is a concept of umbrella DLLs (https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-umbrella-libraries), that can be added instead. The recommended replacement for `kernel32.dll` is `onecore.dll` (https://learn.microsoft.com/en-us/windows-hardware/drivers/develop/building-for-onecore#building-for-onecore) that should be available since Windows 7.
> 
> In case of Cygwin linking, there is one exception, `pdh.dll` (Performance Data Helper, https://learn.microsoft.com/en-us/windows/win32/perfctrs/performance-counters-functions), that is not included in the `onecore.dll`.

The pdh functions used by Cygwin are NOT linked against.  They are
runtime loaded (see autoload.cc, right at the end), so it should not be
necessary to link against libpdh.a.  Can you please check again?


Thanks,
Corinna
