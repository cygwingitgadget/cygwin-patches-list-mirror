Return-Path: <SRS0=Iaxo=2O=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 75BC93858D1E
	for <cygwin-patches@cygwin.com>; Sat,  2 Aug 2025 17:53:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 75BC93858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 75BC93858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1754157205; cv=none;
	b=d+sTRtEwGq8qJyT6HHv6Q2JL3CUPAak6ecR1z/zHFeHTAPEa5mwhEX1I7OiJwVndAmCohYeDcBAzL+Or1x2kXlhErW3JCgGWYZ3V4R3fwIMlSCD1emwbq4e4tkjloVwD3eqn8qZR2Mvl/erVNw/qJX90z9YdOeoZZrmWUOSc0NE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1754157205; c=relaxed/simple;
	bh=7ohHNeyxqPJUZpsaFpZyQCFauJpGiGFODGXi+hXHmWw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=MAf+nClWoj/53WXyjnWg4cIeSohHCov5XNTtfhwhA9zijisLEIrB3n13dDxmyhVuIkMRdxgxdSShyD7BICLywtPwvBBW6t5UJjgWw+fuBoy2R1p64V4JB2EG7ibhEHTNuJlrszzs/xfY/JrFUR2YyCMkv7sdBY7yA9MSosFuka0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 75BC93858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=KElQaT1E
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4D4B345CE1
	for <cygwin-patches@cygwin.com>; Sat, 02 Aug 2025 13:53:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=V2P6DU0Adjjqq6Kue8yEj4qgH4c=; b=KElQa
	T1EfrCTaByVVSA3TQx25bc5ipsPF9CGt+Ne9EQPpS748mRkxfNbq7NTkFurudadL
	/3JWoJrzda+dSFaUNO2A19izpXQgiVENdzEZUWWELcqJbbGbbolmWm0AI7JiOW/e
	zM1/vHjdTSHC6qlNlUPpaTmjieycmfY79kqCUg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 3083445CDA
	for <cygwin-patches@cygwin.com>; Sat, 02 Aug 2025 13:53:25 -0400 (EDT)
Date: Sat, 2 Aug 2025 10:53:25 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add api version check to c++ malloc struct
 override.
In-Reply-To: <aI42aRxXOsYFOzpq@calimero.vinschen.de>
Message-ID: <4f3bd8e1-b32c-9e9e-bc94-5dc0d0bd52a9@jdrake.com>
References: <ff5e8cb0-205b-4d08-7eba-51f112e9619c@jdrake.com> <aI42aRxXOsYFOzpq@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 2 Aug 2025, Corinna Vinschen wrote:

> On Aug  1 12:18, Jeremy Drake via Cygwin-patches wrote:
> > This prevents memory corruption if a newer app or dll is used with an
> > older cygwin dll.  This is an unsupported scenario, but it's still a
> > good idea to avoid corrupting memory if possible.
> >
> > Fixes: 7d5c55faa1 ("Cygwin: add wrappers for newer new/delete overloads")
> > Co-authored-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > ---
> >
> > I left out initializing dll_major/dll_minor in dcrt0.cc as these fields
> > are initialized in globals.cc already.
>
> Oh, yeah, I didn't check that for my POC.  But that means we can
> do the same for api_major/api_minor (setting them in globals.cc,
> that is).

OK

> > I also continue to update the
> > __cygwin_cxx_malloc struct even though I don't think anything should be
> > using it (rather the default_cygwin_cxx_malloc via the user_data pointer).
> > It's not static for some reason, so something *could* be accessing it I
> > guess.
>
> I don't see how anything is supposed to access __cygwin_cxx_malloc.
> You'd have to know the symbol name and what it is.  Not even gcc
> or libstdc++ use it.

The else case can go away in the CONDITIONALLY_OVERRIDE macro then.

> So I wonder... rather than changing CONDITIONALLY_OVERRIDE, why don't
> we just write to __cygwin_cxx_malloc and then change the pointer?
>
> There's no good reason that user_data->cxx_malloc points to
> default_cygwin_cxx_malloc, other than to prime __cygwin_cxx_malloc.
>
> And then we could just
>
>   newu->cxx_malloc = &__cygwin_cxx_malloc;
>
> This survives fork, but not execve.  Do you see any reason
> that we shouldn't just overwrite user_data->cxx_malloc as above?

The comments suggest that it used to do that, but a prior bug resulted in
it being changed to what it is now.  I'd be concerned if the struct is
expanded again in future that you'd have a hard time telling which version
of the struct the pointer happens to point to when DLLs built with
different versions of startup code are loaded in the same process.  I'd
rather keep it pointing tothe default_cygwin_cxx_malloc struct to be safe.

> > diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
> > index 5900e6315d..87f3e8042b 100644
> > --- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
> > +++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
> > @@ -124,6 +124,9 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
> >  {
> >    per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
> >    bool uwasnull;
> > +  bool new_dll_with_additional_operators =
> > +       newu ? CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS (newu)
> > +            : false;
>
> On second thought, why do we check newu for being not NULL again?
> I added a comment to lib/_cygwin_crt0_common.cc back in 2009:
>
>   newu is the Cygwin DLL's internal per_process and never NULL
>
> but never followed up on this.  We can be sure that newu is non-NULL
> *and* we can be sure that newu->cxx_malloc is non-NULL.  In contrast
> to u and u->cxx_malloc, but those are never referenced.

I'll drop those checks.
