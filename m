Return-Path: <SRS0=Hj8f=ZP=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id D0308385DC1F
	for <cygwin-patches@cygwin.com>; Wed,  2 Jul 2025 00:00:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D0308385DC1F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D0308385DC1F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751414407; cv=none;
	b=O2Ml9r8MzWyMR5tP9jFC5yB+g++PREHbBmIAP/pFZFaiXreZMCQCEFUxvtt9EPvMhMn8ZbGhrLGRSx7cKW/DndNzvseMoWTuFF8V91gskU0KwCmlfAn8OzKw51ecExwU7qjZMlgywpR2WgeS4/z9kGG40s+iVXp9UqLzn6SyZXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751414407; c=relaxed/simple;
	bh=1LL1FZ9r5bjAkmkou3P6VV8043YsBz5hQfCmfzkP83k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=GXUS7nnGLyUK9gCTQN+D/OpFWCoF+XOYaUg9SG28MjTiVCv8FEnZnz1AI5zYbTcJwOffb/wv5hCIztO8GTi2rGaDTGlgaH0fyFzfWnBZuZsXfXdBR+HCqdNmySVFIxIcmx5gEFnTFRFRc6HS0Y0yk3JGawx3nvJYFIYjXWrtNiw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D0308385DC1F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ftiY+Vjc
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9C9E945CA9
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 20:00:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=CeeG8QorHavyfY6cFxnbHVN2abc=; b=ftiY+
	VjcyMA/wIpz0MQGefVu+osTf03qY5srwTiUEhP3txI0KMU5+ZnNcks19IfaIMz8b
	tNGmEJUJt+fAAlLmkSB+c7PNUYBbLXAR5z0miZL8JGDyUJzNl6Go1OpN7GIZt5xQ
	DlTFGWELOZUrvHeFtv0MVoUALrC7p6iDvK0Ny8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 83D4145CA7
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 20:00:07 -0400 (EDT)
Date: Tue, 1 Jul 2025 17:00:07 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
Message-ID: <5fc133f2-8c78-8a94-79e2-4fa17892055a@jdrake.com>
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com> <aF6N5Ds7jmadgewV@calimero.vinschen.de> <7b118296-1d56-0b42-3557-992338335189@jdrake.com> <aGJl0crH02tjTIZs@calimero.vinschen.de> <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 30 Jun 2025, Jeremy Drake via Cygwin-patches wrote:

> I probably won't be able to get back to really working on this for at
> least a week, but I'm hoping to at least get some comments written today.

Well, I did manage to get a new revision out before my mini-vacation,
improving commit messages, adding comments, and moving additional
parameters to child_info_spawn::worker to a const struct & parameter (this
allows most callers to construct the struct in the parameter list since
they only care about the mode, and only popen and posix_spawn need a named
local for the struct to set more members from their defaults).
