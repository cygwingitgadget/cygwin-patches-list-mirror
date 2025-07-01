Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 688A7385C6FE
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 17:09:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 688A7385C6FE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 688A7385C6FE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751389789; cv=none;
	b=p5fflN1N8uIPoiT/fzTRx9koHxIi3zHBx+uijrK7eOOaLQvQFqMCgysk+11PdTgIFieFOqXYYpZ+vK2ZHkWU+V7xfDrxSCPG5d98+HrmnDtNrP7OR8khQLgbFFPuaZ6LSYRf7k+TTQa0CYpFOcC1BhK76Od5fVoFLz0Rr2AxqDY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751389789; c=relaxed/simple;
	bh=UH8ghktJb3qHvTlin1D2M3tm9+b8wvxh5/lPF2TTJv0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=cuDqQeeKU05semBlMbWbLpecHcn/zBtWWeYI2dNcrak9RnQLntFkXL/T7+BCCBIE/Fxmlq/xT27DuTl6Sl18BOCx/fMYQAtOmz0ajOaKq0wXoCUJCebwZLIHe5OtPuR6f9HeZcZlIQ2+Lxsf/0FDvlXMpENxSWgR3qM5fKT/tDY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 688A7385C6FE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=zu4QllNG
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 183F845CA8
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 13:09:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=YdKrOt65dScro8/QNNVBdGXV6ZU=; b=zu4Ql
	lNGVox8gNwZLeNZYq8FX5miMEyl1tPBgi8Ekp7PCVjhmWvaT51TgtxOxGdYpNND9
	BHldpaGFZYKmb9hwTos9Ib5+8r1BzHOpPKH65IwHYio48jZt6t5+4OAq//ZiSezh
	I3bzVMP3ggRyQVE6gLacUoIbNI9hs9SYi7qimA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 155E745C86
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 13:09:49 -0400 (EDT)
Date: Tue, 1 Jul 2025 10:09:48 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: CI: cygstress: update for stress-ng 0.19.02 and
 current Cygwin
In-Reply-To: <b5fae801-1732-99ac-1fe1-6c2552407055@t-online.de>
Message-ID: <8941f3e9-16ae-7130-0215-3c65dc3f9aaf@jdrake.com>
References: <b5fae801-1732-99ac-1fe1-6c2552407055@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 1 Jul 2025, Christian Franke wrote:
-  fp            # WORKS,CI
+  fp            # FAILS     # TODO Cygwin: "terminated on signal: 11" (x86_64 on arm64 only), please see:
+                            # https://sourceware.org/pipermail/cygwin/2025-June/258332.html

-  memcpy        # WORKS,CI  # (fixed in Cygwin 3.6.1: crash due to set DF
in signal handler)
+  memcpy        # FAILS     # TODO Cygwin: "terminated on signal: 11" (x86_64 on arm64 only), please see:
+                            # https://sourceware.org/pipermail/cygwin/2025-June/258332.html
+                            # (fixed in Cygwin 3.6.1: crash due to set DF in signal handler)

These should be fixed now, by
b0a9b628aad8dd35892b9da3511c434d9a61d37f (or
cygwin-3.7.0-dev-161-gb0a9b628aad8)
