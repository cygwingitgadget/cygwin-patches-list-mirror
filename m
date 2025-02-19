Return-Path: <SRS0=3P/8=VK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id D44733858D20
	for <cygwin-patches@cygwin.com>; Wed, 19 Feb 2025 01:54:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D44733858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D44733858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739930052; cv=none;
	b=xm/FD+ieO9s8vG2KCJ42UVQfjFng2m8OolSFy/cnCrD7xgDVXgci3ILJmgPSwGTRk3mB9NSt241OkhmgeI+8rupeIbDMAwn6YdtbxGmcUiKXId53z82cqDbLngury+KzXQtR6SIpkzOyJwX9YM2H1LD/Zi9NgUltjmSWXLlXolU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739930052; c=relaxed/simple;
	bh=caFxiVOssWNe0JAciWzw8roJqG/rCEq6yixIA9my7sA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=MrzRFXVmhpI0avlYpWMTwP2kuMHUR13i0jcESrMjKGvFKeBPSd6ongVukZ4KdC6RYDN2+AEIkEzy4ZdNfZ7fSVuGXhn3TNxs9gmBjB/O5Kiju8RMUtww5vu0dtMghDMnDckeKZ1pQ5ieABwZNK0y8qQHRc1HcfCXTHz34NqBK0M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D44733858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=iIn1OZ/4
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A5B3345C30;
	Tue, 18 Feb 2025 20:54:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=OB7e7F8TNrQg8nWP0EA8wDyOB68=; b=iIn1O
	Z/4m1pAYECXdIg8MGGecn1UU2ZzicQOyk1l13u5j5NR/COqaWjZp0y6+TfhjJUyj
	F79k12e7ni19kRQ0Zbk6SacJp2tl5vVOVJW6A8xcwc5SywaYoBIaB9sonnYht/oK
	KrXzJzRYVpZVnIbazuCVQY+z55OEZ0VLkR6S7w=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7AD6245BF6;
	Tue, 18 Feb 2025 20:54:12 -0500 (EST)
Date: Tue, 18 Feb 2025 17:54:12 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Lionel Cons <lionelcons1972@gmail.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: include network mounts in cygdrive_getmntent.
In-Reply-To: <CAPJSo4XGXfOPBw+1WAYYjhQDU64SXzfVfh7goSDDepUADWZrEg@mail.gmail.com>
Message-ID: <d45a6382-2df8-be02-4024-432cdb9d5d0b@jdrake.com>
References: <8dd3b5f5-004c-53ee-53ea-6428de5dd597@jdrake.com> <CAPJSo4XGXfOPBw+1WAYYjhQDU64SXzfVfh7goSDDepUADWZrEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 19 Feb 2025, Lionel Cons wrote:

> Does this patch cover global mounts, i.e. SMB mounted by user
> LocalSystem on a driver letter are visible to ALL users. Local users
> logons can override the same drive letter via per-user net use
>
> Example:
> LocalSystem mounts H: to \\homeserver\disk4\users, this is visible to
> all users in a system
> User "lionel" mounts H: to \\lionelsserver\data\homedir, this is
> visible to the current Logon session

I believe so, but it doesn't actually matter.  From the Cygwin
perspective, it would just show a mount of H: on /cygdrive/h.
