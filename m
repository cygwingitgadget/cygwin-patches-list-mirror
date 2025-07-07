Return-Path: <SRS0=hEVR=ZU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 1B7E43857823
	for <cygwin-patches@cygwin.com>; Mon,  7 Jul 2025 20:15:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1B7E43857823
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1B7E43857823
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751919353; cv=none;
	b=fDDxQoQ0wrfZe1bb65QGxP09sUhBGRf2cGrF5DKuEyel5ixmr7couk2TQdxfwsMqd7t6eHFts9pBECOE6aFPLbCveUcU2dKfGgOarswK8OCuaCeUbKozC7ycc2yedzupcSK4J/ZfZJfJP7Vk2473a2NpCo6oKOlZKH6VvOD4294=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751919353; c=relaxed/simple;
	bh=YCJIoAyjPeIJ0ERz6vS87PAE5VScf6YMBnRL2LfYARE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=iwwtame6Y9U6rSQ66WM5+6p35BvM65JwLd+5MwzXN4+bxZ4uqfpt643R4vXWj0abhZ6aR/Yq60AaQZsVxSSnouz6ry2tApS43R9XjsYKWPVEfhRL80K6O9OarpYPmEbxrUNzXmyvcpu5DMqmlZzO75QwDlW81wRfFzAe8faXWE0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1B7E43857823
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=mojtFrwM
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B546545C1D
	for <cygwin-patches@cygwin.com>; Mon, 07 Jul 2025 16:15:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=nvVNaheZ6ekz6Onfe9njTnq61hU=; b=mojtF
	rwM1OAGe6gt93HuJsbeS5XgfhmuVueuaBGCtrGg3BhHax29q9YoblAjFpa139c/1
	TDamyJ61NW3jPb9s6mkn9uqNJxm8ERwfBpbvhXEG/BjltpY5eikbtrmU9IaMdmb2
	W6yXi5NRSYurtS5Q8SCVdsWyxa1sLWoEDNHw8Y=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9C92A45A5F
	for <cygwin-patches@cygwin.com>; Mon, 07 Jul 2025 16:15:52 -0400 (EDT)
Date: Mon, 7 Jul 2025 13:15:52 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aGwm9dRIeb_s9NAL@calimero.vinschen.de>
Message-ID: <25bf8e00-b42d-1d9e-4a1d-eff357795b76@jdrake.com>
References: <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com> <aGaZq6sSSuNCKX59@calimero.vinschen.de> <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com> <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
 <aGeQMtwhTueOa4MT@calimero.vinschen.de> <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com> <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com> <aGulX_0Azb6GI-_C@calimero.vinschen.de> <51a8dd9a-2cc4-39cd-d026-2b4b3920bfb1@jdrake.com>
 <aGwm9dRIeb_s9NAL@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 7 Jul 2025, Corinna Vinschen wrote:

> On Jul  7 12:16, Jeremy Drake via Cygwin-patches wrote:
> > On Mon, 7 Jul 2025, Corinna Vinschen wrote:
> > > All good points.  We should actually see what the Austin Group comes up
> > > with and then we can reconsider.  In the meantime we stick to your current
> > > implementation.  Would you mind to push it on top of main into a new
> > > topic branch, i.e., something like
> > >
> > >   git checkout -b topic/posix_spawn main
> > >
> > > and push it?  If you're not aware of this, the "topic/" prefix is
> > > required to allow force pushing to the branch.  It's some kind of
> > > safety net from the gerrit macros activated for a couple of projects
> > > on sware.
> >
> > Done.
> > https://www.cygwin.com/cgit/newlib-cygwin/log/?h=topic%2Fposix_spawn
> >
> > This also includes the patch I recently sent, because I had done half of
> > that while adding pgroup support.
>
> Looks good.  However, shouldn't the hunk adding InterlockedCompareExchange
> setting the pgid go into its own patch?  That looks more like a bugfix
> to me...

I don't think it's a bugfix - previously, this was where the pgid was
initialized and it was done unconditionally.  Now that I want to set the
pgid in child_info_spawn::worker, this needs to not overwrite that
already-set pgid.  (This does not fix the issue where I see a pgid of 0 in
a spawned process sometimes instead of what it should have inherited from
the parent, which I assume is a race between the child running and the
parent finishing up this initialization).
