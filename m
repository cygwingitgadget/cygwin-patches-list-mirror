Return-Path: <SRS0=cuRN=VB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 697643858D26
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 19:25:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 697643858D26
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 697643858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739215507; cv=none;
	b=PXQdhZEgFWjSwiRPhixtkrCvtKWaehZgtvq+Zkv1W7nBPZ2RJt/FRCZI3KrINNVhk9Jv0C3z5v4VBnEG1DrEZPrTNbdgMTRy4wuGH3mJb8twVzdsP5D8garUmozwKMOLG4UPB5Si0arJXyFMHhALw6Tznk643IfaEvfOvvwD9vI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739215507; c=relaxed/simple;
	bh=HhI9AuJ2OSsu30f+4uEMxIy9jyNvK2/79L6Jpfvy4cg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lzElh40CufwRq/Gs93BZC8tcit8WasvhpGrYn63ggoSOGyemR0IDG7lyJ/5uVpyIOrubeq0Y+CZcyzSE4QpFsueD41jOslBEZT0yMayPyAkHUdnlP2FuR2jKKbPhtptMxA/5ePDkZt9/pbJeo7e27UESrkfpEBEYkapgPjeQhOk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 697643858D26
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ZRxiX9Ue
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id C772B45C6E
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 14:25:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=NJ4Yr0JaTFGnMdncI2Yxven3UN4=; b=ZRxiX
	9UemTP6Rji9vzrvl2mGX94V9Zrhm/U2IlEBIvqpha8wyIN1Pa+yhZpcpcFIPhGNZ
	awFtnX/s3eHUyho0LsxVpkOPWcF5dt70Cgja3JWf4z9GjlbTCfar+TxjhKWZh4ao
	eOQYmbsh7elT8P7HIqSFtX+3MAW9Gz4rWBwgSg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C04A045C5C
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 14:25:06 -0500 (EST)
Date: Mon, 10 Feb 2025 11:25:06 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: expose all windows volume mount points.
In-Reply-To: <dfab3625-f04f-0554-2379-44f86fcd0c53@jdrake.com>
Message-ID: <8fb75e04-610f-d6b7-3df8-950970c9187b@jdrake.com>
References: <be64d541-a24d-b5ff-5a50-9aae577a48ae@jdrake.com> <Z6nkSf7l7MOuQdBb@calimero.vinschen.de> <dfab3625-f04f-0554-2379-44f86fcd0c53@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Used wrong from address... :(

On Mon, 10 Feb 2025, Jeremy Drake wrote:

> On Mon, 10 Feb 2025, Corinna Vinschen wrote:
>
> > Yes, dos_drive_mappings() is what I really meant, thanks for pointing
> > it out.
> >
> > So I wonder why not include your additional requirements into the
> > dos_drive_mappings class and just use it to iterate over the mount
> > points.  AFAICS there are only two things missing in dos_drive_mappings:
> >
> > - looking for all mount points, not just the first one, and
> > - bookkeeping over getmntent calls
> >
> > If you add a state pointer (pointing to the current mapping) to
> > dos_drive_mappings, you only need a single slot in the TLS, holding a
> > pointer to your dos_drive_mappings instance.
>
> This would be much cleaner, I think.  I'll look at this.
>
> > [...time passes...]
> >
> > Hang on, there might be a bug here...
> >
> > [...time passes...]
> >
> > Why do we keep the cygdrive state in cygtls anyway?  From history I see
> > that this has been the case since at least 2003.
> >
> > Per definition, getmntent isn't thread-safe at all, and getmntent_r is
> > only thread-safe in that it keeps the data in a buffer provided by the
> > caller.
> > However, the state information is process-wide: if you call getmntent
> > alternating in two different threads, they don't see the same set of
> > drives, but only every second drive.
> >
> > At least this is the case on Linux.  Don't we subvert expectations
> > by handling getmentent thread-local?
> >
> > If I'm thinking to much outside the box, feel free to kick me.
>
> That's well outside my scope ;).  I think 1) getmentent is pretty well
> deprecated, and 2) if something isn't defined to be thread-safe, pretty
> much anything it happens to do in the face of multiple threads using it is
> fine (to me, we're in the realms of UB here).
>

