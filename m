Return-Path: <SRS0=C3iS=2M=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id CAD643858419
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 21:05:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CAD643858419
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CAD643858419
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753995902; cv=none;
	b=WoVYxjLvIkWROka93l3b8pkpk0NUNYpZXPmRMoT31+IqOrjrCrR6J1uztsXvVNim6g8mgU+8xgjqyAk632avpqYbBCg2ZayR63pGw1IRbJ/zS6EVLgHBrs1PXb2lucQlbcM3d5jKfIiKay3fyBz289SvHcpslqhRJ5zPaiziNVs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753995902; c=relaxed/simple;
	bh=t0Kmd4EvKuMJrhO27KgkqHxusFXbO7C2XXDMu1RKfIc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ZyCWcAkuJ3EVh/4OzC+FeiMO3l+4S/4lJUOP9/1ZUKZZIvs00hRpiXKl2wCTCa5JmL7ulHA5J3O6q+Dw95Mcc3d/Nqjg8KO/gxgrqPVaxRdpxLfqNJ2G6kjjMPKVohdoOsqyaaM1BsW1yo1SiVoykFliT1/hnz2t/ZZ99mf/JGg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CAD643858419
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=w5N1At31
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 86E7145CDA
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 17:05:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=cJvAvj2EJ5cnvcXaMMLsFu3Q7+s=; b=w5N1A
	t31Hxa7GDJfY0RdBjJ45RLc7G8u8kWU6vTyEN6T0slpSa7EutOQEsh21H1cvQr8o
	qSj8ShBEZ5mWZq3+az9uFHOfyr9/hlqD1b/kaWvaFHVFQtMgQM+luUJpKuH3TwM8
	tJ40GcvrctJvlQpYCP26W08P33+akSS8RrkL6c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 6EDE345C1D
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 17:05:02 -0400 (EDT)
Date: Thu, 31 Jul 2025 14:05:02 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
In-Reply-To: <aIvTxi4eB6kmuT-j@calimero.vinschen.de>
Message-ID: <a5299499-c6ee-598a-dca4-f7a6bbedeb07@jdrake.com>
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com> <aIoOKpzb557bX0cE@calimero.vinschen.de> <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com> <aItALodM1WC7KP_C@calimero.vinschen.de> <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
 <aIvTxi4eB6kmuT-j@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 31 Jul 2025, Corinna Vinschen wrote:

> > > > The sticking point would be libstdc++-6.dll once it is rebuilt with
> > > > the additional --wrap arguments in GCC, because it would define all
> > > > the operators and thus be incompatbile with older dll versions.
>
> ....and the new libstdc++-6.dll, we're fine.  You wrote that the current
> libstdc++-6.dll already uses the newer new/delete calls, right?  Looks
> like this works with old DLLs except overloading the operators will have
> no result because these operators are unused in libstdc++-6.dll?
>
> I do hope I got that right...

I'm not sure it uses them, but if it does it would not work with
overloading the operators because they are not wrapped yet.

>
> > > Well, the SO version of the new libstdc++ would have to be bumped to 7,
> > > i. e., libstdc++-7.dll, that would solve half the problem.
> >
> > I hope not.  The SO version of libstdc++ is 6 everywhere, and has been for
> > some time.  It's ABI hasn't changed.
>
> Yeah, but the DLL version number doesn't *have* to be the same as the ABI
> of the DLL.  If there's a good reason to bump, we can do that and IIRC
> (but fuzzy), it wouldn't be the first time.
>
> Oh, wait!  It just occured to me...
>
> We know that old DLLs don't write a value into __cygwin_user_data.api_major
> and __cygwin_user_data.api_minor.
>
> But what if the new Cygwin DLL does just that?
>
> Assuming dll_crt0_0 (definitely called prior to _cygwin_crt0_common)
> writes the current DLL CYGWIN_VERSION_API_MAJOR and
> CYGWIN_VERSION_API_MINOR values into __cygwin_user_data.api_major/minor.
>
> Then _cygwin_crt0_common could check this before api_major/minor are
> overwritten with the app version, and then use this info when
> performing the CONDITIONALLY_OVERRIDEs.

> +  if (newu)
> +    new_dll_with_additional_operators = newu->api_major != 0
> +					|| newu->api_minor != 0;
> +

I'm considering 3 cases for _cygwin_crt0_common here, order in which they
happen
1) running from a linked dll's startup (ie, libstdc++-6.dll)
  newu would contain values initialized from cygwin dll's startup, would
  write its api versions to static struct per_process in
  cygwin_attach_dll, OK

2) running from exe's startup
  newu would still contain values initialized from cygwin dll's startup,
  would write it's api versions to newu due to assignment of u = newu.
  OK for now

3) running from dynamically loaded DLL's startup
  newu would contain values from exe's startup, not zero, so would always
  write the new pointers to cxx_malloc, memory corruption.
