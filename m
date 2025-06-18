Return-Path: <SRS0=e9kc=ZB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 669E838453A1
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 06:20:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 669E838453A1
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 669E838453A1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750227643; cv=none;
	b=ldrvilpkh7L8+JrG0k6T2TKBCISpRaShX2UZn0RVV5/+bMhvppsFpwalUC4TRi+IOhTLD7OLp4zmS+7RhC0V/OjvUVFx3iZXJY6qyIyjuTSCKCmbB3aa823ixmen8z9QgESGTIt2O7Kw5gGgsI0k+hVO4ZO9qvcpb3YqbWeKESs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750227643; c=relaxed/simple;
	bh=TxX3oVbk1oLBdap4Vh5O81BFtP+9AytdR7LlP/WUI7U=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=XjX8+N1eLbytdRx2srOerELG4nJK88ekNF6gqkBNXojqz7PbP7Z9V3Ci1CoVqtAO1a+HIwQ/EvdXRGdxqx9iZxWY0/Nz/XFuJx9M4XWb0Evl/GOMZIR40JPzqRjnzyJ5pNS/OMOV5sz9TrgsS2nC2x12dU1wJSBcE4h9+wwcTMw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 669E838453A1
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=qntXjKil
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3A02545D50
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 02:20:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=SFv50mIdyGF8tZnb2EKCAEhEcBA=; b=qntXj
	KilcHzvDSjRftJ+1vtW8e+QTyd8v3SW2xkX7qMDraDbpvdpcOhbYCb0hH/948kP1
	JNio3w6CCVFJSdZHq7NtJQRpJgqTMThatjYh7C4YBYTZaAdY5BhwycEZFqLmsxpS
	t0m+su9XRoJTZ+fLp9ouJx2aCM8bqjvjZXzyzk=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1945845CE8
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 02:20:43 -0400 (EDT)
Date: Tue, 17 Jun 2025 23:20:42 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: testsuite: add posix_spawn tests
In-Reply-To: <9ac1505a-3e36-7a3d-97cf-3dd6567cbcf4@jdrake.com>
Message-ID: <d4b58846-594b-064c-8c17-f22caea45d29@jdrake.com>
References: <555fc9f8-0ab9-6902-f59f-e57d6a74b7e2@jdrake.com> <9ac1505a-3e36-7a3d-97cf-3dd6567cbcf4@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 17 Jun 2025, Jeremy Drake via Cygwin-patches wrote:

> Currently just a couple of tests of error conditions, but I have more
> tests to add.
>
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>
> v2: wrap some lines, and add a test for ENOEXEC error (it does NOT fall
> back to invoking the shell).
>
> diff --git a/winsup/testsuite/winsup.api/posix_spawn/errors.c b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> new file mode 100644
> index 0000000000..38563441f3
> --- /dev/null
> +++ b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> @@ -0,0 +1,57 @@
> +#include "test.h"
> +#include <spawn.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>

D'oh, Linux needs <sys/stat.h> for chmod.

