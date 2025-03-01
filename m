Return-Path: <SRS0=Gbfl=VU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E6C283858D1E
	for <cygwin-patches@cygwin.com>; Sat,  1 Mar 2025 22:08:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E6C283858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E6C283858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740866923; cv=none;
	b=uUMuMmLQEkWZn+7nZ62EaD+WCeTG5J+o56qXRNO8M81lAZ7cehGQJtMNtLkFEeroGyYOF+fMLUwx0RyNHbujF7jzySSvu0Uqi9fEVzwndM80SvuxByZxqYFIJ0fXlAAN98acXoaQrkLmoLNfwad8GF63oR84e+QqubJhVTqSqts=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740866923; c=relaxed/simple;
	bh=gYvuUNDlbwWMuBgrczpQrlN/O64XJSfkO0h0AQs7chU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ujzOnKP61W8WjkIpyOZQeNW9psH7DLcxq8tX6bMCh4hvB251Mny59OyhfDOPDFjReoPUCDG4wnW78FJeq2K11S9+qgG0PY6OtfRCdSnGmM8q81Nhh9Bcl7e7ojrnSuJa61hybKzw8sde9c1W3HAu+N3PFLzjV9AEBNpq1xZPDDg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E6C283858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=CZX1wiHk
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7FC3545C0C;
	Sat,  1 Mar 2025 17:08:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=OyTawtT9war/gLzaRdk34fLqAYw=; b=CZX1w
	iHkT2r0xvpImVs9G6JnFdrO0HdOLvrWkQM/lcsjdVS6beKDCi9erTgls9nS16Sy6
	Uj2+vg4OucVnQNBXPhq8IYWZVY85vE1EgrEY+lITHeMkv5H56+AZm0GOTAGTqsjS
	YtqPMAItHhKl7GWduSgQutEm8zPIRDDK9yvGXA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4FA7D45B8A;
	Sat,  1 Mar 2025 17:08:42 -0500 (EST)
Date: Sat, 1 Mar 2025 14:08:42 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Adjust CWD magic to accommodate for the latest
 Windows previews
In-Reply-To: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
Message-ID: <f9d3372c-77d2-e093-c5c3-8f496c2bc6b7@jdrake.com>
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 1 Mar 2025, Johannes Schindelin wrote:

> Note: In the long run, we may very well want to follow the insightful
> suggestion by a helpful Windows kernel engineer who pointed out that it
> may be less fragile to implement kind of a disassembler that has a
> better chance to adapt to the ever-changing code much
> like it was prototyped out for ARM64 at
> https://gist.github.com/jeremyd2019/aa167df0a0ae422fa6ebaea5b60c80c9

Luckily, ARM64 is in "ARM mode", where instructions are 32-bits long, so
you don't have to code how to decode every instruction to successfully
skip them.
