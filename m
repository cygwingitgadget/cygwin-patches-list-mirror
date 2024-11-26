Return-Path: <SRS0=DNbP=SV=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 88A1B3858D37
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 22:27:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 88A1B3858D37
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 88A1B3858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732660049; cv=none;
	b=jBlpBsl6kqwlPdsssWPgrzGFYk2x49oLG8FVWdE+FWqEZ4pdOZBGfRGgKR8Z/UwdwSePhFw371TQ9ehv2wznQeTfL70/4OwG9ptN+CcsdSbE/3EA+4IS1yY1D5vBe6vf4G1b5VGmnXxIqZetFjWFG8gK0YkcUolSXzErLAkCXNI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732660049; c=relaxed/simple;
	bh=Z/wyEgojGwcEi/l4cjv4M5lvwdJiiOBjsRRAM+bkw/Y=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=xKa6WQyBehHZihIhJUbz0g9KrSx8Z+8T3EeflcIp5vob36nbIjKTT9518vMM8sI/AUZSeSoOhPlXwQpakvynqIZwTCLh+oYBrqMs4qmNm1ym/XfDeMH7I5Cf5Ic0W5qrugXv/NkDbC0T79+FDlpwfSzSfXMYjDnJOT8JUC7TLJE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 88A1B3858D37
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=URsu4JhG
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 601F045C9B
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 17:27:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=RIQBk+RKORHq07a0q57CCjx1agQ=; b=URsu4
	JhGbGNkeZqhP416LXq+MpSiyWSW6nYc/wzsZR+wIAuTHql9sXGJ3HNPpY1P3OHZX
	TNpDawsPn2gT/RRck1OISUqDu6O4ijrP1ZRYj0x8894E/3n08Tq8H2o707KJKg9j
	T2fLbU91zCxz24wRXNF2V/y4m/vwzs0WLB0fcI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 3667145C99
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 17:27:28 -0500 (EST)
Date: Tue, 26 Nov 2024 14:27:27 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: uname: add host machine tag to sysname.
In-Reply-To: <Z0XNgZoVQI_P5FMD@calimero.vinschen.de>
Message-ID: <42819a86-1e9f-6569-a08e-fd719115a2c3@jdrake.com>
References: <ecdfa413-1ad4-ea0e-4f01-33579f1616e9@jdrake.com> <Z0XNgZoVQI_P5FMD@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 26 Nov 2024, Corinna Vinschen wrote:

> On Nov 25 11:24, Jeremy Drake via Cygwin-patches wrote:
> > +      switch (wincap.host_machine ())
> > +	{
> > +	  case IMAGE_FILE_MACHINE_AMD64:
> > +	    n = stpcpy (buf, "-x64") - buf;
> > +	    break;
> > +	  case IMAGE_FILE_MACHINE_ARM64:
> > +	    n = stpcpy (buf, "-ARM64") - buf;
> > +	    break;
> > +	  default:
> > +	    n = __small_sprintf (buf, "-%04y", (int) wincap.host_machine ());
> > +	    break;
> > +	}
>

> You can greatly simplify this switch.  We don't support 32 bit systems
> and we will never again support 32 bit systems.  Any combination
> including a 32 bit system can just go away.  Theoretically, only
> the IMAGE_FILE_MACHINE_ARM64 case should be left.

Is the above edit enough, or do I need to remove the x64 case entirely as
well?  If you truly just want to handle ARM64, this whole function could
be inlined into just an

  if (wincap.host_machine () != wincap.cygwin_machine ()
      && wincap.host_machine () == IMAGE_FILE_MACHINE_ARM64)
    strcat (name->sysname, "-ARM64");

For a little more future-proofing, nested if/else so non-ARM64 gets the
hex fallback from the default case above.

