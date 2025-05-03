Return-Path: <SRS0=bpPz=XT=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C47933858D21
	for <cygwin-patches@cygwin.com>; Sat,  3 May 2025 17:27:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C47933858D21
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C47933858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746293263; cv=none;
	b=ddS6nlNgGBx0sSYtk3/SQBpwm9DYtJ5Sud2upG7kpLutGKlTUETnd9keAXkRn5/FuaQcbBCex1w0pp7gmLF63HLsSfOBDmXlNxoHqRbq83nzrCIa7nrYZyC1BEnDKmN/tPmHioYr6ND5u+RGPYUpclxSB2vf1Ar+YpHfea/8wYA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746293263; c=relaxed/simple;
	bh=uuw0qKURzwZorSdKRDTmW43V1i6vPEiuzxaYv2BFQbQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ZtGk38alJj/LR2sU07ibb3z+El22X1xfaZ61gqsDqu7UEUuxxHhIRKt8LtOg9XBZnlHGhEe+Jp2L4NvNbEx0SIymn//AZoeFWM3C7OhZud1lwS6sdfsOZ/u+Qj6sR0nh8iEKCcj+JYsUSKKiyBGkYIv5OaRXf/AUGMS+t0cfC8s=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C47933858D21
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=bNcKtEse
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 6F23845C94;
	Sat, 03 May 2025 13:27:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=YtJ+GVSe434wifDpf3tKAYbJiDU=; b=bNcKt
	Eseotl7sc43pFJD4ZRpmJimKcb1IKuWwmE0dAwwEXobtvqsbYI2U5eefW00ahtWX
	/7NsiejjoGipu59Ap+1JkqXIR64N409dno7OIqZDxZpMthIqemUy510NaDGxLXw6
	Wfo8POmvv4cPyQiZP3PRNErlgsDAlzC0BcuFvE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4C1D345C8D;
	Sat, 03 May 2025 13:27:43 -0400 (EDT)
Date: Sat, 3 May 2025 10:27:43 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: docs: flesh out docs for cygwin_conv_path.
In-Reply-To: <c0eedde1-50b2-7a4c-ab3b-2747ed91a4b8@jdrake.com>
Message-ID: <b54d1b48-f63d-e6fc-1940-e4f3f346fc0b@jdrake.com>
References: <cb20f137-46cb-eab9-27e9-ca098d1364e5@jdrake.com> <4c633aaa-eb33-42ed-a1e5-f75f58af85be@dronecode.org.uk> <c0eedde1-50b2-7a4c-ab3b-2747ed91a4b8@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 3 May 2025, Jeremy Drake via Cygwin-patches wrote:

> On Sat, 3 May 2025, Jon Turney wrote:
>
> > On 01/05/2025 20:28, Jeremy Drake via Cygwin-patches wrote:
> > > Explicitly specify that `from` and `to` are NUL-terminated strings, that
> > > NULL is permitted in `to` when `size` is 0, and that `to` is not
> > > written to in the event of an error (unless it was a fault while writing
> > > to `to`).
> >
> > That's great, thanks.
> >
> > Please apply.
> >
>
> Done.  I'm not sure if I should apply to the cygwin-3_6-branch too though.
> It is just a doc update...

I went ahead and cherry-picked those commits to cygwin-3_6-branch and
pushed.  I saw the GHA would update the stable docs on the website when a
release tag is pushed, and figured it was worthwhile to have them updated
with 3.6.2 rather than waiting for 3.7.0.
