Return-Path: <SRS0=DNbP=SV=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 8FF863858435
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 18:16:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8FF863858435
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8FF863858435
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732645000; cv=none;
	b=fxZ8Gwqeivp8bybz2r+L7y4yllvlfFiT24M3yZknYNo4Z+s1dOzjItdfMT6BW6xSov0cMHEqE6bfTNO2NaB6kH51NiEoQDYwwE4PC8Bc35Pyqk2V9fwanEHPdWdnx6QjSouz2Z1d04dsqVByPMSx4iEnkhc8b8I8U5xnpEKe3GU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732645000; c=relaxed/simple;
	bh=hPZkM9pcWuVt3kOlNUdHWFfwLpjyfToqgpYAqwyp4kM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=NrF3+wNFlr7PKoy3TwQtoQkiqwZFkNugoATDYlelt+M0hysYLUYROVle+9TCtJbqU2WZnwbFVTqyoFNZM6L53K9Klecspu6TfJDsO6beUSm2HhkM2I10qTc0B5Wf+sqsfWZHyPjDCuJNkBHor3GRjJsfISfaWEv0Zf1Nz/kOhUY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8FF863858435
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=KHChi9vU
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2F08845C93
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 13:16:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=44sDVEOdnULqA7tAuITSecsF8+g=; b=KHChi
	9vUSaPsqnoTXu1a/yTKbxFeIG5cFhGJNlCEz+PhVDR+oD2Rq6g6oDXvQnz2zSP0m
	7HiBptXsy9TLFiuaHBSvrE05hZ1OtlBSHj9bvlC2GiZ0KJOCtkcdBBV0IXtTCmXa
	7FZbpZDJc9oSNkYv8csiMomLyAPyTG4+EkyEDI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 01F6045C91
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 13:16:40 -0500 (EST)
Date: Tue, 26 Nov 2024 10:16:39 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: cache IsWow64Process2 host arch in
 wincap.
In-Reply-To: <Z0XK-JE0c950m0um@calimero.vinschen.de>
Message-ID: <a943634d-7c63-9383-442c-d9162497b516@jdrake.com>
References: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com> <Z0XK-JE0c950m0um@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 26 Nov 2024, Corinna Vinschen wrote:

> On Nov 25 11:21, Jeremy Drake via Cygwin-patches wrote:
> > +extern const IMAGE_DOS_HEADER
> > +dosheader __asm__ ("__image_base__");
>
> On second thought, shouldn't we just use GetModuleHandle ("cygwin1.dll")
> instead of going asm here?

I was hoping to avoid another place where MSYS2 would have to patch the
name change to msys-2.0.dll.  I almost went with GetModuleHandleEx
(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS|GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT)
but the overhead of either call seemed silly when the linker already knows
the address...

If the __asm__ setting the symbol name is an issue, pseudo-reloc.cc also
accesses __image_base__ like so:
#ifndef __MINGW_LSYMBOL
#define __MINGW_LSYMBOL(sym) sym
#endif

extern char __MINGW_LSYMBOL(_image_base__);

&__MINGW_LSYMBOL(_image_base__)

I found the __asm__ method cleaner.  But I could name the extern
__MINGW_LSYMBOL(_image_base__) instead of dosheader to avoid __asm__.
