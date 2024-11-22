Return-Path: <SRS0=UNdZ=SR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 6E848385AC08
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 16:54:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6E848385AC08
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6E848385AC08
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732294453; cv=none;
	b=Wv2su6PbgjGAURotzh2Kp8tQ0qE5JJBkuT1UlVarjmckFPjgl1GnRPTtxAWgG4tTbeJ2u2yeVI9kZ8S4by1FyGfpniOHEz10Wi+uAg0Cw9m+aju4HAGbu4GA487ovGS89Z/ZiGCiVgSFm+kXpTNgsufabHqc9wHzYY6YLrcAHKI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732294453; c=relaxed/simple;
	bh=BGqCmFlk1JPiXBTloSgJG3x+OfZwH4VrslJLPoRkpIw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Nhrx5b2J5/Y2P+OlNUadcmcVpJzlSrmWp9GzTOQGgDMWy3DLsdv5SmPvB88rOW4Uc6v3HRqG2cCiJQtOIFRU1s0RzhSs74qfHXsDZts09htrQ9B+uVVPAWi+lGG5t7gFZ8yFiRhxPi5don1dtXuIWRenXueH4qKRDAcC8FgrB+M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6E848385AC08
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=hnL1wPON
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1EFAF45C3C
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 11:54:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=x0iRz56RRshiQrKLMFshgEaRSN8=; b=hnL1w
	PONY1lGA5HQi5oJW6p5iRt37iOsnGh0rBdpicLj9r24e/J5PRR9QeKZrZCy5PSiV
	6YhPcZi6pX2bB7c+9jk/JjeR6sTI0tDLnkBvmvJrepoHCdkq3xWiAoGOLUaxJY/K
	SDiG0aLpW4n85B6m6T6QxcGoYJ9RM5pWcjeAUo=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id E47F545C32
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 11:54:12 -0500 (EST)
Date: Fri, 22 Nov 2024 08:54:12 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
In-Reply-To: <Z0CAdVAJgJgvAONa@calimero.vinschen.de>
Message-ID: <89834a6f-50c7-b851-76ce-b640e8821f23@jdrake.com>
References: <d544a3f1-3b6f-0392-aecf-65125cf5e8f7@jdrake.com> <Z0CAdVAJgJgvAONa@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 22 Nov 2024, Corinna Vinschen wrote:

> On Nov 21 11:42, Jeremy Drake via Cygwin-patches wrote:
> > Note the elif defined (__i386__) case won't compile because it references
> > the no-longer-present `wow64` value.  This was written and tested against
> > 3.3.6, and the __i386__ case could just go away here...
>
> Yeah, just kill it.

That's what I thought

> > @@ -282,4 +284,30 @@ wincapc::init ()
> >
> >    __small_sprintf (osnam, "NT-%d.%d", version.dwMajorVersion,
> >  		   version.dwMinorVersion);
> > +
> > +  if (!IsWow64Process2 (GetCurrentProcess (), &emul_mach, &host_mach))
> > +    {
> > +      /* assume the only way IsWow64Process2 fails for the current process is
> > +	 that we're running on an OS version where it's not implemented yet.
> > +	 As such, the only two realistic options are AMD64 or I386 */
> > +#if defined (__x86_64__)
> > +      host_mach = IMAGE_FILE_MACHINE_AMD64;
> > +#elif defined (__i386__)
> > +      host_mach = wow64 ? IMAGE_FILE_MACHINE_AMD64 : IMAGE_FILE_MACHINE_I386;
> > +#else
> > +      /* this should not happen */
>
> It should actually result in
>
>   #error unimplemented for this target

No, because this is the fallback case for when IsWow64Process2 fails.
This should only happen on OS versions that don't support it, which in
turn don't support anything other than i386 and x86_64.  However, OS
versions that do support it also support ARM64.  If/when Cygwin has native
ARM64 support, this should not be a compilation error.  If anything it may
be a runtime error (assert?)


> > +  const USHORT current_module_machine () const;
>
> This is not necessary.
>

> > +extern const IMAGE_DOS_HEADER
> > +dosheader __asm__ ("__image_base__");
> > +
> > +const USHORT
> > +wincapc::current_module_machine () const
> > +{
> > +  PIMAGE_NT_HEADERS ntheader = (PIMAGE_NT_HEADERS)((LPBYTE) &dosheader
> > +                                                   + dosheader.e_lfanew);
> > +  return ntheader->FileHeader.Machine;
> >  }
>
> Just scratch that.  First, we're using GetModuleHandle(NULL)
> throughout to access the image base, but apart from that,
> the info is already available in wincap via cpu_arch().

GetModuleHandle(NULL) is the exe, __image_base__ is the cygwin dll.
Theoretically, with ARM64EC, you can mix-and-match x86_64 and ARM64 in the
same process, so the most correct answer to the question to "are we being
emulated" is whether the current module's architecture matches the host
system's architecture.

Yes, due to Windows already lying in Get(Native)SystemInfo, cpu_arch()
will tell you this, but with *different* enums, which means you'll
need a switch somewhere to translate between them, instead of just doing
an == or != with the host like this function lets you do.
