Return-Path: <SRS0=8XWn=ZA=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id DD082381976B
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 18:40:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DD082381976B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DD082381976B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750185617; cv=none;
	b=Um09tTVa9RkwqhNtvU7c5HSZnfOShPEPOiveYBf0BrGiUz8uUc16aJ78qApUP3eOfCnrTOzE8iv+CUb7hCejRhjAnQWR8DnYkRnpDJp/tH5JOqlMlkzIRJb3YbBwR49eUKLRIfcLRUS7Rt7a1KILSBg9l4wZdMtuDdeNApr6dq8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750185617; c=relaxed/simple;
	bh=SAhlOyichbp1fIIbfeYe9mTzvXPXIhG09ZNKToqlRGM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=AFH1WQ5jvxhvGphQvLn3nsh25VSWSyV0nmvwV9qXQ71XDiQmoZfcDDl6F7DWk8UqdYSUBgG2H1uviUB+HHaJllaKEmzmLzbDD7sw5zs5VqNG3tabFPy8dIm2hJtEOXbzhTHiUv0Leg6Efnn5fnCI3ZqqwspnPUNMxF0So805BV0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DD082381976B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=R9R3AJDf
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id BA67645D53
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 14:40:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=sERvcDb2FaN81WliBCFFI//hC2k=; b=R9R3A
	JDfFJ6VeCPeWrP4ZzPuL1vG0ALJeqfvbUPN0FIKudUaivFHYutIJOJpKGVUlF57Q
	QnfEeaiwaWj/Rp+UMKUpxWr9P3QXuxBAVdD96w78aXDA9HPa+uDsstMLeuW2Fd7c
	8RUkqUjOUJi114jXuvK8GOIVRoSHvSA9HRKQUs=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id A0F9045D51
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 14:40:17 -0400 (EDT)
Date: Tue, 17 Jun 2025 11:40:17 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: make pthread initializer macros constinit
 compliant
In-Reply-To: <aFG0H0f0zJj-4yOn@calimero.vinschen.de>
Message-ID: <35b8a377-bde2-e42d-35e0-ba92147ae553@jdrake.com>
References: <1277a22d-9beb-52b3-c9ea-7980f54fb84b@jdrake.com> <9f2971ca-114a-cfec-646a-a32eabfc3ac3@jdrake.com> <aFFNnpI5eBgSl805@calimero.vinschen.de> <413d1875-ed41-9ad0-3954-4df6bae666e7@jdrake.com> <aFGyoVdstMJOjEBD@calimero.vinschen.de>
 <aFG0H0f0zJj-4yOn@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 17 Jun 2025, Corinna Vinschen wrote:

> Actually Cygwin doesn't use the PTHREAD macros at all outside C++ code.

libc/msgcat.c... Also I didn't check newlib, but I don't know if that
counts (defines __INSIDE_CYGWIN__) or not.  The only usages that seemed to
trigger the "relocation truncated to fit" error were == comparisons in
thread.cc
