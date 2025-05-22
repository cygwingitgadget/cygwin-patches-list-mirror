Return-Path: <SRS0=d5ak=YG=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3B5EC3857833
	for <cygwin-patches@cygwin.com>; Thu, 22 May 2025 20:26:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3B5EC3857833
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3B5EC3857833
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747945563; cv=none;
	b=Wh18DnkB18wgBUWauNguz6fMaTs/mxTon7Lhvk7sFqaF8pltNDfprPTVPSR/842a2Nj+0VZUBilsBrWq4l2u4lpoTO4BljVhf7zxc2FetNdPYlwcboNfvL5ySoW8TdHlQ8z1n0T7/uhvjVJubqx4j3c2iwOjbXBcyJmFGuX09VE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747945563; c=relaxed/simple;
	bh=OHxlATgVkHHQhm3geEU8/bCAyfu7vRqj4Qqav399Y5U=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ZW6oJFC/DwJ1IzZja0CePro28p0z2zZvyDLjZfq0OQ/qzrtM9B3TqpjzP9wLS4wnZRoinc90iuMQyn+V98ChGXwzcmm5hYyacoulOAJSQFdC4i43C21HOIU4HYJwSYx2/HRs0D0D+BR4/G51hgn6PaYwxm5m5Qr+anwnkzagFwk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3B5EC3857833
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=MGyHYq0n
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id E7E0A45CBB;
	Thu, 22 May 2025 16:26:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Bte0x3wudJdI7wiJTcC20Z/WcsM=; b=MGyHY
	q0n1BCtqzS2dHNeLsvymaoys/4HRn5fnyolR7sEY226NMrB36sxvlWw/sEviwKq8
	hxvc4or5a64FrH1oDWSHkmzprzM1KLJLG1WUcfR9If5jQEuPdoEWkx6tAYVSA2j0
	HuAARVLXCjsmsymxoy41Nr4NQvWLxQmm97d+qY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CEE6645C8C;
	Thu, 22 May 2025 16:26:02 -0400 (EDT)
Date: Thu, 22 May 2025 13:26:02 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dll_init: use size_t instead of DWORD for size
In-Reply-To: <20250523044636.0e1aa3327c0501875bcf9068@nifty.ne.jp>
Message-ID: <da9db121-5693-5128-e2a4-9c66d9782cb8@jdrake.com>
References: <61ee55a2-9aed-187b-a748-a3c653255177@jdrake.com> <20250523044636.0e1aa3327c0501875bcf9068@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 23 May 2025, Takashi Yano wrote:

> Nice cache!
> Question is: Isn't it better to declare size as SIZE_T rather
> than size_t because the 2nd arg (size) of VirtualAlloc() is
> declared as SIZE_T?
>
> Other than that LGTM. If you think size_t is better, please push
> as is.

I was on the fence, I didn't see any other usages of SIZE_T nearby.  I
will change to SIZE_T (since that matches both VirtualAlloc and
MEMORY_BASIC_INFORMATION) and push.
