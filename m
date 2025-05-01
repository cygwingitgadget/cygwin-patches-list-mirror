Return-Path: <SRS0=nMGZ=XR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 72C6B3858D20
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 18:44:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 72C6B3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 72C6B3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746125063; cv=none;
	b=Mismv/pR7Flo+a9NDDVN/7h99qEFGzwmVi8KjKEdGdFKAYTsvbZzaW+Ue4b+xiyMSYMIOLWax+8OB0VPKoXM0kQRNKWpgMNs4lr2tn3OMSN2q+oEMz+gk1DOTBEDbEekwg8roJfDGhbndM0zO4l0hhS6c5mi5ug25uKdIIJoUgw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746125063; c=relaxed/simple;
	bh=Pun49BxaQ1M9VqB2Vqkksxrd4Uk0qzaZqZKCPdI3hNo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=kDDnPHwePKYkE+f6HRH6Omy7PvVIqWkD1de8whKsYCDvbTt1XGc1ON4g8lRMUi3B52bnWxuhiUnPGBFnH+YQ6b7a6IUQFoJ0lWh6QGqY/8oP6C0gQ+3kHu1AlCsqO5K83w+rsQF9knj83loR/TUK0+smMULgW+jKnmBcJzjZB7s=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 72C6B3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=lNrbI3Ks
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2397D45C56;
	Thu, 01 May 2025 14:44:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=x5dywEb2IdFiq4rq6YVOCPUB9Ag=; b=lNrbI
	3Ks/SyGu56AOu/jAq7olHzEsaa/ZdvYQzvDUQIPk73VccYBdw+VDNeXZ1PW1B8KV
	0ZMjfvRcnR9/EmMEG3fRTk7JeVYogrsKL9gCJfLzUXJg2zsZgdSE86iHo3i3l1Sd
	uS9Hjy4FbGxte+Y3pSwNdI4Y+l/Ke3F1AJsIqc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1DF8145C1D;
	Thu, 01 May 2025 14:44:23 -0400 (EDT)
Date: Thu, 1 May 2025 11:44:23 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: dladdr: use proper max size of dli_fname.
In-Reply-To: <20250501224757.4c9d689a3b2be9028f5e865f@nifty.ne.jp>
Message-ID: <2a263b60-65a9-66b2-6d25-57f7e33b468b@jdrake.com>
References: <b4ed3ebb-2fb3-4d95-1069-017bb381ad81@jdrake.com> <20250501224757.4c9d689a3b2be9028f5e865f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 1 May 2025, Takashi Yano wrote:

> On Wed, 30 Apr 2025 12:45:56 -0700 (PDT)
> Jeremy Drake wrote:
> > The DL_info::dli_fname member is actually PATH_MAX bytes, so specify
> > that (larger) size to cygwin_conv_path rather than MAX_PATH.
> >
> > Also, use a tmp_pathbuf for the GetModuleFileNameW buffer, so that any
> > buffer size limitation will definitely be due to the size of dli_fname,
> > and add a static_assert of the size of dli_fname so we can be sure we're
> > using the right size constant here.
> >
>
> Thanks for the patch. LGTM. Pushed.

Thanks.  Sorry I didn't write anything in the release/3.6.2 file for this
one - I didn't think it necessarily needed to be backported as it was
mostly a theoretical issue.  It's not like it was a buffer overflow, it
was just that if a module was loaded from a long enough path it would
result in an error when there was actually enough space in the dli_fname
member to hold it.  (That's another reason why I didn't write something
for the release file: it's hard to explain succinctly in a way that
doesn't sound like it's a potential buffer overflow!)

Also, I do now have push-after-approval permissions, so I can push my own
patches once you, Corinna, or Jon OK them.
