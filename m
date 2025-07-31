Return-Path: <SRS0=C3iS=2M=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id DFCC43858D32
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 20:05:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DFCC43858D32
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DFCC43858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753992320; cv=none;
	b=fUvqAO3MOo06E0aWLAGrtxfYTA03M4pfLBLBIfMLjlpp6Z7r5I2roSiVVWM7Vab3yeAfnxaxe+NUDoTQK6ZhaTwKtFmhMHSVP30cit+IdJkeJOsZafvuXZ4IGOMs63gvT6mcMqkMee9nI13P3JuocibXFxmB6YixQZXWZBYF+zc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753992320; c=relaxed/simple;
	bh=lBNchWD/xWhkEnzD3ZuzcsbnTM8OESCcZvlUOOGPZ0g=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Y/owRjs/SaeqRl4qgrNNe5SmaRVnfE4VYlCOHBWcIlbCg2EiXRhdIRVH9ceziXxmAEIilM5tQUHelrpSFyKgT4WA7GoFBKk7T5nkU0/58TliyslXHjIklG3LS5elumxTbMh26V3j0C8e9nLNj+mpxzLMjkhG54NbW/TBn8ltKoU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DFCC43858D32
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=uSvHH/7n
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id AC32145CE7
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 16:05:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=LYYDAUiojtqjyx0ETh42m4JE2Js=; b=uSvHH
	/7nUx8btZkzhewUWKPpd1Zmiu2ixovs24dmTK5/R81a1QTuxWDmB18E1Do1AON49
	LgqtjTAasN25UVqgRPLmijx2XqEMfA2RPRMHh0KKFuuj7GlBWMNlbUbvtGoDyZnz
	RtspgXXdnQqZ89zdpNUyJULjXa2kwUeI5nEyDQ=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id A6C5945CE5
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 16:05:20 -0400 (EDT)
Date: Thu, 31 Jul 2025 13:05:20 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
In-Reply-To: <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
Message-ID: <1cc0cf0a-7641-21d4-6802-ae5ea8ca43f7@jdrake.com>
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com> <aIoOKpzb557bX0cE@calimero.vinschen.de> <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com> <aItALodM1WC7KP_C@calimero.vinschen.de> <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 31 Jul 2025, Jeremy Drake via Cygwin-patches wrote:

> On Thu, 31 Jul 2025, Corinna Vinschen wrote:
>
> > As I said, newer apps against older DLL is not exactly supported,
> > vice versa should be.
> >
> > The problem is that the usual approach of API checking as in
> > CYGWIN_VERSION_CHECK_FOR_EXTRA_TM_MEMBERS (we had more of these macros
> > in the past, we got rid of them with the switch to 64 bit-only) doesn't
> > work from inside the application, only from inside the DLL.  While
> > _cygwin_crt0_common is running, the version and api fields are filled
> > with the values from the time the application has been built.  The
> > values of the currently loaded DLL are not accessible.  We could add
> > another cygwin_internal macro to return a pointer to the DLL's
> > version info for this purpose.
>
> I noticed that dll_crt0_1 calls check_sanity_and_sync which performs some
> checking on the per_process struct from the application, including if the
> application's api_major is greater than the dll's.  However, this is after
> _cygwin_crt0_common already runs.  I tested by downgrading to
> 3.7.0-0.266 and running an executable that I had built with 267 (but not
> using the new wrappers).  It didn't crash during startup, but it did seem
> to crash after forking (it was doing a posix_spawn).  So maybe the
> api_major check could catch this after the fact but before the corruption
> caused any more issues.
>
> > Otherwise I don't see how a new app is supposed to know the size of
> > per_process_cxx_malloc of an old DLL.


I tried bumping CYGWIN_VERSION_API_MAJOR to 1, and this results that new
apps exit quickly with an old dll with " fatal error - cygwin DLL and APP
are out of sync -- API version mismatch 1 > 0".  Loading a DLL built with
this new version at runtime also gives this error and exits the program.
