Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0076A3858D29; Mon, 24 Feb 2025 17:18:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0076A3858D29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740417497;
	bh=gaXUvxSfTDpcBArL4RIDFHsuRs/D9lwgAjcXHl29/H4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=gTaFK8RlbobsOU6aTCElQBG3G5qkXm8LJOPhh7AjR2hQaBqXxpNUqZ9lkJHxFWvw7
	 B9Yjd+GVk7RflprEazgprj+02Cn3aAp1hoFPWp/7zDh8kNan2aS+2sLX11Ft1zpBwo
	 Ej7pY9nSlGRTfiSTifzYoHUtE/OD1/uUgkJLMcf8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 97C37A80708; Mon, 24 Feb 2025 18:17:24 +0100 (CET)
Date: Mon, 24 Feb 2025 18:17:24 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: FAQ: Add section about sparse files
Message-ID: <Z7yppFXA8ZELYS_U@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <34c24623-845e-b765-2061-c896715000e8@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34c24623-845e-b765-2061-c896715000e8@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 24 14:42, Christian Franke wrote:
> Follow up to suggestion from here:
> https://sourceware.org/pipermail/cygwin/2025-February/257354.html
> 
> Possibly too verbose :-)

Can't be verbose enough.

> BTW: The MS documentation says that blocks are also not allocated if zeroes
> are written (instead of skip with seek):
> https://learn.microsoft.com/en-us/windows/win32/fileio/sparse-files
> "When a write operation is attempted where a large amount of the data in the
> buffer is zeros, the zeros are not written to the file"
> 
> I could not reproduce this documented behavior with NTFS on Win11.

I tried that too a couple of months ago and couldn't reproduce this
either.  I wonder if that was wishful thinking on the doc writer's part.

Or maybe there's some fsutil setting, but I can't find it either...

Patch pushed.


Thanks,
Corinna
