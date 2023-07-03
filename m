Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 55C213858D1E; Mon,  3 Jul 2023 10:54:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 55C213858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688381682;
	bh=bULpD/LG/rWlaF+0BJG+KnW/2E+Q4amasYyZQsTl+88=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=s4CVcleoJ70DZUZPHSMmxqmkaeh4MlruXlk/AHYBsaxHkK0wtFc1rVoBykBBNzw7Q
	 WDiTbGB8GvRwHUjRsBcXdFvZjW46T6j6o9kGDAtEFVzdWl1WOJC8r+lA2WxTMB/cIB
	 8DZ+wGMqJHkcCNf2kENw7hIOXaOxsZ4PXTJlFh4A=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A291DA80D55; Mon,  3 Jul 2023 12:54:40 +0200 (CEST)
Date: Mon, 3 Jul 2023 12:54:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fchmodat/fstatat: fix regression with empty `pathname`
Message-ID: <ZKKo8Ez3nIf7klxz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Jun 27 22:51, Johannes Schindelin wrote:
> In 4b8222983f (Cygwin: fix errno values set by readlinkat, 2023-04-18)
> the code of `readlinkat()` was adjusted to align the `errno` with Linux'
> behavior.
> 
> To accommodate for that, the `gen_full_path_at()` function was modified,
> and the caller was adjusted to expect either `ENOENT` or `ENOTDIR` in
> the case of an empty `pathname`, not just `ENOENT`.
> 
> However, `readlinkat()` is not the only caller of that helper function.
> 
> And while most other callers simply propagate the `errno` produced by
> `gen_full_path_at()`, two other callers also want to special-case empty
> `pathnames` much like `readlinkat()`: `fchmodat()` and `fstatat()`.
> 
> Therefore, these two callers need to be changed to expect `ENOTDIR` in
> case of an empty `pathname`, too.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Looks like a good catch. Can you please also add a "Fixes:" tag line
and move the tar error description up into the commit message?


Thanks,
Corinna
