Return-Path: <SRS0=q1Em=WO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3D8703858429
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 17:26:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D8703858429
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3D8703858429
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743096404; cv=none;
	b=E4pKo4YDJZQ3wgFdCfeikiwzSSz91WpBMFLmZYNyyIRcvt/IZtb8Hpk+1lciTQWQRNQq/kV9xBrzFY+JNv0M9LZH0S2OtGhdSCYFA1Niq0Q9m5wSSqIYlEDKGVSHtmVkgrkcG/eHcfUAPR6qmW0LrvnNGwqovZgDzO7UrxqERE8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743096404; c=relaxed/simple;
	bh=WHmaGwwGNVnREYtL26ZVBAKAL+7WkBVJG9C7X1NQzHA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=NWawLqB7ta350QwuZXZB7JSVBv4qugmyKJ0yPTbuJnARPbKtOYCGV9tvFBdVfYXOJWfWmwIT1kcuy5PD/Gh06pUOW6jqwl3iCJzQ6EzCs7E87I6WpCd5gACuCxppownsJqIkscj0YC9TDw2qo79FXNFcg/2kZHuI4a9ezo3/8nk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D8703858429
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=E4yVs68V
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 77E1E45CA9
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 13:26:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=ILPIw1PQgX93BclDpciJRPhXh7E=; b=E4yVs
	68VgLnOKPoxhVzXJBu4xDso6WWKSX7zuRLL0IuYl53y6cHNbxgv7j27oYZ+gDeiu
	EAkpKox0mX7YQnFi93Aj/9dbfuxqbjNPIVqPOVRpOrbl+FEZX9+2hHQWFhfiIKhH
	X5dlGJhpyjE37nxFHMvKF5CPMZjYNpyHoGBmf4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 601B045C8D
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 13:26:43 -0400 (EDT)
Date: Thu, 27 Mar 2025 10:26:43 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: use udis86 to find fast cwd pointer on
 x64
In-Reply-To: <Z-U5WFBxoUfeVwn7@calimero.vinschen.de>
Message-ID: <f7b8d776-ca5b-a0b3-63bb-02ea496e5bb6@jdrake.com>
References: <7d4f8d91-0a3f-4e14-047e-64b1bd7d9447@jdrake.com> <Z-U5WFBxoUfeVwn7@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 27 Mar 2025, Corinna Vinschen wrote:

> Hi Jeremy,
>
> ok, three questions...
>
> Q1: How does it compare performancewise to the old code?  Fortunately
>     it's only called once per process tree, so this shoudn't have much
>     impact, but still nice to know...

How would you go about finding that out?

> Q2: Would you mind to add more comments?
>
> Q2a: A preceeding one line comment briefly explaining the function?
>
> > +static inline const void *
> > +rip_rel_offset (const ud_t *ud_obj, const ud_operand_t *opr, int sub_off=0)

rip_rel_offset helper function?  OK...

> Q2b: Comment like "Initializing" blah?
>
> > +  ud_t ud_obj;
> > +  ud_init (&ud_obj);
> > +  ud_set_mode (&ud_obj, 64);
> > +  ud_set_input_buffer (&ud_obj, get_dir, 80);
> > +  ud_set_pc (&ud_obj, (const uint64_t) get_dir);

> > -     On Pre-Windows 8 we basically look for the RtlEnterCriticalSection call.
> > -     Windows 8 does not call RtlEnterCriticalSection.  The code manipulates
> > -     the FastPebLock manually, probably because RtlEnterCriticalSection has
> > -     been converted to an inline function.  Either way, we test if the code
> > -     uses the FastPebLock. */
> > +     On Pre- (or Post-) Windows 8 we basically look for the
>
> Q3: or post?  Really?  AFAIK, this was only an issue on pre W8, so it
>     affects Vista and W7 only.  Theoretically this check can go away,
>     unless you have proof this is still an issue in some later Windows
>     starting with 8.1.

I haven't confirmed what pre-8 does, but 8.0 appears to inline
RtlEnterCriticalSection while 8.1 and later call it.  Based on the
comment, it seems 8.0 is the odd-version-out here.

> > +     RtlEnterCriticalSection call.  Windows 8 does not call
> > +     RtlEnterCriticalSection.  The code manipulates the FastPebLock manually,
> > +     probably because RtlEnterCriticalSection has been converted to an inline
> > +     function.  Either way, we test if the code uses the FastPebLock. */

> Q2c: Roundabout here, I'm getting the impression we're losing
>      more comments than we gain.  This is not a good way to raise
>      confidence ;)
>
> Codewise I have nothing to carp at, but comments are a bit sparse
> for my taste...

I thought the only comments I lost were related to each insider version
workaround that was piled on top that are no longer necessary.

BTW, something I would *like* to do but haven't figured out how to
accomplish cleanly yet is to follow the registers.  What I mean by this is
illustrated by what I did in the aarch64 version: I could find the call to
RtlEnterCrticalSection, then work backwards, find the add whose Rd was x0
(the register for the first (pointer) parameter in the calling
convention), then find the adrp whose Rd was the Rn of the add.  What I
would do on x86_64 is find the call to RtlEnterCriticalSection, find any
mov rcx, <reg> before, then find the lea <reg>, [rip+XXX] (where reg would
be rcx if there wasn't a mov rcx after the lea).  Unfortunately, the
variable length-ness doesn't lend itself to iterating backwards, so I am
not confirming that the lea actually ends up in rcx for the function call.
The only register correlation I do is that the register used in the
mov <reg>, QWORD PTR [rip+XXX] is then used in the next instruction that
must be test <reg>, <reg>.  The old code required that <reg> to be rbx,
but I don't see any reason that rbx is required...
