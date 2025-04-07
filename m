Return-Path: <SRS0=0RUn=WZ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 188D43858C60
	for <cygwin-patches@cygwin.com>; Mon,  7 Apr 2025 17:22:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 188D43858C60
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 188D43858C60
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744046548; cv=none;
	b=jpM90Z5fywx/awdk+d04NTvDxO/AuoaUVchoI46JQgOxtIiFmn0/denZasSK40VY6M8/TgozWLmG/D/1plnGCO6BeUVZF46L+LDzrp6JSHhER5UOg0hn/D/xtFoWAac/3OoO57V7XBIyvD2Kz4KDWqbWCWOcVoYllCkfgdD8LiQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744046548; c=relaxed/simple;
	bh=1y3dbybuQjRhNfmLT0rzFxhJHWt6yJ3PmzV8XztPBfE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=UtxVWOcuautzfDPXpjCserdApANtr7g5jW+uLuJoc7aZQ5UI1wkUJl3YNj4ww2+XvYeZskGL8uPq4DlAyYHUL92zlucekikJyS71gMSfb9sAfIOpYxuIA5qOmLPhOLHmBW+xHAix7fg7KzMoNw0g8ErURjny8ATnwdXnGulliyU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 188D43858C60
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=b6JNvmbz
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 5FC5A45C68
	for <cygwin-patches@cygwin.com>; Mon, 07 Apr 2025 13:22:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=1vZp8DtBKjId+vbPQzqeK17p8QM=; b=b6JNv
	mbzaUWvyeAGQw4FfU+BfTyn1LjcEQ6cULXKHEnOLZchQyPvmx56qA89TQo36TBQR
	1BS5XZSTjRhdIQXiN6mukNXdYja39t8ImV4kCuDmEJiG6536YdHcoBfiKWqPS3pr
	boAFU/P+yLIxuZs1q9BfRtfFwSB/xsMlX4ujQQ=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 5996745C63
	for <cygwin-patches@cygwin.com>; Mon, 07 Apr 2025 13:22:27 -0400 (EDT)
Date: Mon, 7 Apr 2025 10:22:27 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Don't increment DLL reference count in dladdr.
In-Reply-To: <e1ea4725-bac4-d351-5bfd-d7e2d9a85acf@jdrake.com>
Message-ID: <fc464fbd-3038-0248-1a75-b7f80b1046be@jdrake.com>
References: <e1ea4725-bac4-d351-5bfd-d7e2d9a85acf@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 5 Apr 2025, Jeremy Drake via Cygwin-patches wrote:

> Unlike GetModuleHandle, GetModuleHandleEx increments the reference count
> by default unless the GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT flag
> is passed.
>
> Fixes: c8432a01c840 ("Implement dladdr() (partially)")
> Addresses: https://cygwin.com/pipermail/cygwin/2025-April/257864.html
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/dlfcn.cc      | 3 ++-
>  winsup/cygwin/release/3.6.1 | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
> index f029ebbf2c..10bd0ac1f4 100644
> --- a/winsup/cygwin/dlfcn.cc
> +++ b/winsup/cygwin/dlfcn.cc
> @@ -408,7 +408,8 @@ extern "C" int
>  dladdr (const void *addr, Dl_info *info)
>  {
>    HMODULE hModule;
> -  BOOL ret = GetModuleHandleEx (GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
> +  BOOL ret = GetModuleHandleEx (GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT|
> +				GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
>  				(LPCSTR) addr,
>  				&hModule);
>    if (!ret)
> diff --git a/winsup/cygwin/release/3.6.1 b/winsup/cygwin/release/3.6.1
> index c09a23376e..280952c91a 100644
> --- a/winsup/cygwin/release/3.6.1
> +++ b/winsup/cygwin/release/3.6.1
> @@ -36,3 +36,6 @@ Fixes:
>    subprocess failure in cmake (>= 3.29.x).
>    Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257800.html
>    Addresses: https://github.com/msys2/msys2-runtime/issues/272
> +
> +- Don't increment DLL reference count in dladdr.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2025-April/257862.html
>

Is this OK for me to push (to main and cygwin-3_6-branch)?
