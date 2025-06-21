Return-Path: <SRS0=Mu3T=ZE=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 69C173AEAEC1
	for <cygwin-patches@cygwin.com>; Sat, 21 Jun 2025 17:38:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 69C173AEAEC1
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 69C173AEAEC1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750527519; cv=none;
	b=nByLfz2feQ9DOJdnsfVh+SRqj+RqOM4XhzvZYez+u/Khi0YvDkg+2BKjx/NqSKv04DHjE3vXRUQR8UHPvDx4h4ELiwoFt8HxMW/p+Cz5y05tWX/pH8XGrNFJ/3+cWtgBpmwqRKeGFlclQ5Kkcmsw6hKImM6h5i1Gl1p/Y2IJask=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750527519; c=relaxed/simple;
	bh=5vYr88PNNl2ShG243yimo8mZE0DlGwIw1DWFkXjE/vw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=nFiILRV49DGwzTNfBnKeNfqrOQ0kBFpwY8tXo9PWknwoFFz2M+V6+/Q9rzt+UuFd84j8qJ8lFVqZtBCyYswLUCtyBSU1szJ7SUnwNh1TPyopB5QtVTrBRTPet7SRnohhNuui/FoLM6MQIQq2tQDg5NgzMkE2Mh0Kk3W/LRsaWYY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 69C173AEAEC1
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=K5vuCh5W
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 17FDF45CEB
	for <cygwin-patches@cygwin.com>; Sat, 21 Jun 2025 13:38:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=WTy56gZQ0A/ExeBZ6W+/ggcYOtY=; b=K5vuC
	h5WCO4rDQrlsP/kQ2qd8VgG2Sv10JS5yb4orCeyB0TnB+ZbQ92JMCrtZbr0ZxJ0X
	S8ACGhXH9LyIZWHcGeYaI+HPrPGtS3n0uBEHT+9B0r7HmPiNC5nHQVwT2gXhpeeY
	vhaRS8qDltmaBvR18H0Hk7l9l8ZVluEQrMa6uw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1499145CBB
	for <cygwin-patches@cygwin.com>; Sat, 21 Jun 2025 13:38:38 -0400 (EDT)
Date: Sat, 21 Jun 2025 10:38:37 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 1/3] Cygwin: allow redirecting stderr in ch_spawn
In-Reply-To: <aFE0VoED9dQ4QppT@calimero.vinschen.de>
Message-ID: <cf09e022-0033-e620-0af9-bda1d3c752a9@jdrake.com>
References: <4b5c620c-4fd9-470f-6e94-965e73f3b6ff@jdrake.com> <aFE0VoED9dQ4QppT@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 17 Jun 2025, Corinna Vinschen wrote:

> On May 29 10:57, Jeremy Drake via Cygwin-patches wrote:
> > stdin and stdout were alreadly allowed for popen, but implementing
> > posix_spawn in terms of spawn would require stderr as well.
> > ---
> >  winsup/cygwin/dcrt0.cc                    | 2 ++
> >  winsup/cygwin/local_includes/child_info.h | 6 +++---
> >  winsup/cygwin/spawn.cc                    | 5 +++--
> >  3 files changed, 8 insertions(+), 5 deletions(-)
>
> LGTM
>
> Thanks,
> Corinna


OK, I could push this one, since it stands alone and I'm sure that it
works because I have used it in the subsequent patch.  The reason I
haven't is that I am still trying to figure out if an additional change to
child_info.h might be needed for (f)chdir, and I am trying to avoid making
multiple changes to the CHILD_INFO_MAGIC.  Let me know if this is not
really a concern.

My current thinking is that yes, something would need to be in
child_info_spawn or cygheap_exec_info.  I'm leaning towards an int dirfd,
because I would need that anyway to deal with open actions after a chdir
(using openat).  My sticking point is considering how to deal with
spawning a non-Cygwin process.

a) I would need a wide Windows path for CreateProcessW, but fhandler
doesn't expose its path_conv or get_nt_native_path, only get_name
(get_posix) and get_win32_name (get_win32) which is narrow.  Adding
another accessor to fhandler_base probably wouldn't be too controversial.

b) I would need the same logic as in cwdstuff::set to determine whether
the dir is "legal" to use for a non-Cygwin app's cwd, and the error to
report if it's not (cwdstuff::get_error_desc).  I'm not a fan of
copy-pasting code, so it will take some consideration of how to refactor
that in a way that the code could be called by both.  Suggestions
appreciated.

Maybe next week I can get back to these patches and button up more and get
it to a point where it can be merged (especially if it's OK to leave
adding (f)chdir changes for later).
