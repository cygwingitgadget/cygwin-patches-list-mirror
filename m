Return-Path: <SRS0=tiif=M7=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E6811385B52B
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 17:19:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E6811385B52B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E6811385B52B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1716916764; cv=none;
	b=D5tS1VxsKYW3nROZk7T6HkBcBj0n09OFRtlx9p8FAIAE3XC131i7RfPGRqZIK1Z0LITJ+iPkZeis5GH8ugfdr3yK3ShUKjPk15e6QcJuDo3GrM1apGCBkPXvSj97Ow03Vd7rraAzHuGJoWggTU8rCvykU4IpdE6JIRjbQCleWIQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716916764; c=relaxed/simple;
	bh=Le6JoVbDCR9Qs8JZ37mW7TaMHbBDT/dY5K6NfOGw7O0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=xP+jcjLNX+7TUwa0UlBbg+MN3uXhF2N6wTyZYhnKynnOnHkOUMBnEqQ15cI9IDp+8i3MPOG4isYyQK7CAfK4JkGaOOhnVHA6eCs56sEaM2x/6IqV0VoAM7bJwUheQiI8ozA4tvibWGtFCBv+PkaNBWYNSY1Ty640oNK6fheUYAQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id C14D445B20
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 13:19:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=vzwXK
	C984KS4yJY4X2WVaAKQdOE=; b=A8Smc2GETfpnAZHGNNqY6Q8JZI5vEi4sjvbLR
	Jm/6bHKSSAPmJHcIeGdcxlb70aAG+Zgsl24Xauau91SNORm0IsRh8xn0x6+juT28
	plBZezQDktBs0MeBtjer886DR8/zbuX7j9SnZHBlJ7+8pYFnkGMxoww4+IS+NxYY
	ZF1nyk=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B8B9445B1E
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 13:19:22 -0400 (EDT)
Date: Tue, 28 May 2024 10:19:22 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v1] Cygwin: disable high-entropy VA for ldh
Message-ID: <651f7e9a-8f59-7874-75ff-be82153e9dd8@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If ldd is run against a DLL which links to the Cygwin DLL, ldh will end
up loading the Cygwin DLL dynamically, much like cygcheck or strace.

Addresses: https://cygwin.com/pipermail/cygwin/2024-May/255991.html
Fixes: 60675f1a7eb2 ("Cygwin: decouple shared mem regions from Cygwin DLL")
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/utils/mingw/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/utils/mingw/Makefile.am b/winsup/utils/mingw/Makefile.am
index b89d89490a..07b9f928d4 100644
--- a/winsup/utils/mingw/Makefile.am
+++ b/winsup/utils/mingw/Makefile.am
@@ -53,6 +53,7 @@ cygcheck_LDADD = -lz -lwininet -lshlwapi -lpsapi -lntdll
 cygwin_console_helper_SOURCES = cygwin-console-helper.cc

 ldh_SOURCES = ldh.cc
+ldh_LDFLAGS = ${AM_LDFLAGS} -Wl,--disable-high-entropy-va

 strace_SOURCES = \
 	path.cc \
-- 
2.45.1.windows.1


