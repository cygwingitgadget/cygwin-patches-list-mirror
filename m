Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 2C579385C6DE
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 20:27:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2C579385C6DE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2C579385C6DE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750969666; cv=none;
	b=jCXPZADaDMJW2FuI+sxXcW9qdtvuOBrjVDjdCin9G9PbnFqMdnx0rXtlAAzPgDmIC6FBBo8kwJZ8Sx9E6DuV95x0QVZ0eeO+GB7iXchcvH0OVWe2CaohBIgf31x5FAUC5f3PmGJ2q+5ozDzo2XwECC2pmtNJr/8EYcMj0GEN/Zw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750969666; c=relaxed/simple;
	bh=B5rfuJ54DULSJfwXanrBDEI0Mha18m26CHgw3/HGqhA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ajJuMoKHKSHLjcNh55eAEVc+mY1NN5nDCBBexk1xp6hpiRq+O+DQ8XzlcMQTku9csfRCoPCUWuLflgmpmz6yVZQcX7/C1KIgNDmXIHo7AdCjfNCZTGZosKU1MiAFIWjVMoygoKTfHGea6WUA6u02t1+qRqCrmKe1Ns6AIUMGAZQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2C579385C6DE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ITGRWbZ7
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 0A9D445D3B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:27:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=j1jVe
	mLgmidcmy+mjUaZDfCls4U=; b=ITGRWbZ7zsz3jmyqukXfBHoWnrOV3ZoTue+jW
	cXXZcoUR/wCZqA5cih9YFN4FhnbQGvDnv5g056nzogGtUkaq+FIEPwh8EKrRIg0K
	Bw2JSkxMdEBn7W2Ly+m9p6WVuRpx4NZWzXUGqchdnrBe1RrWtdkkS0nrhVmi3hQm
	YG0IHo=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 05DD345D37
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:27:46 -0400 (EDT)
Date: Thu, 26 Jun 2025 13:27:45 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: testsuite: include sys/stat.h for chmod in
 posix_spawn/errors.c
Message-ID: <dd7c309e-69a6-b15b-ecaa-8c2faea74f58@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is required on Linux.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/winsup.api/posix_spawn/errors.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/testsuite/winsup.api/posix_spawn/errors.c b/winsup/testsuite/winsup.api/posix_spawn/errors.c
index 2fc3217bc0..3fbc2cbf99 100644
--- a/winsup/testsuite/winsup.api/posix_spawn/errors.c
+++ b/winsup/testsuite/winsup.api/posix_spawn/errors.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/stat.h>
 #include <unistd.h>

 static char tmppath[] = "pspawn.XXXXXX";
-- 
2.49.0.windows.1

