Return-Path: <SRS0=tiif=M7=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 5F15D3858C78
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 05:36:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F15D3858C78
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F15D3858C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1716874573; cv=none;
	b=Jdt50XlnKXF6zMUKKKYYiBQNr6B0ID//ziozbvHnsbYQrYxShm3EyC3seEHSM8iimgSoxLptoOBdz3eaeFPawgehUhFheMTpx7cmMzEkL3TfIkwSgVmMbuzgTU6JmEf7iFUwMRLWhOVDNEFFdhg1TEJdqT6EIWkvsl3kOGpsXns=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716874573; c=relaxed/simple;
	bh=bsRmHXNvqNPbzhKgHD5RZd9UFvttw6Zb9aoqdjbvmzI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mQzQjfaGYxl7ZXi2QUt1XCfPEUikcAOYqqY2+r6Cof6gRCmpU5NKzpbKMoKYj/lfMzaTdAH2GYWJxvwhWnpC3yxqLuUIYHkUYO2DW9APlJaoCb8zzx4cYgToQZXaAO/PKAWrnGZxxEoCIOxSXOhenEzBlXlJwnEXXJSapqrwwpg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id BD6FF45B09
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 01:36:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=A0cg2
	RYSluHJYuGqfkit2YVCV3E=; b=peFgY415ofU79Ki4CeodyWPaHNvzN91hFPqWY
	PTw0gekyY7dHbSIXf5GIkfKfpEcFzcbw+fJPQ9fCxBavqyH+iehRMkeMl9avHuB7
	OVvuTdYCPht8jXdVOE0VxjXFw9DwyrOtQr+GyghNvd7anibMadU8+nIePoY5VqNP
	woZ8J8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 699AB45A98
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 01:36:07 -0400 (EDT)
Date: Mon, 27 May 2024 22:36:07 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: disable high-entropy VA for ldh
Message-ID: <719ef5af-7945-6ffd-d217-6a9cec1540fb@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If ldd is run against a DLL or EXE which links to the Cygwin DLL, ldh
will end up loading the Cygwin DLL dynamically, much like cygcheck or
strace.

Addresses: https://cygwin.com/pipermail/cygwin/2024-May/255991.html
Fixes: 60675f1a7eb2 ("Cygwin: decouple shared mem regions from Cygwin DLL")
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/utils/mingw/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/utils/mingw/Makefile.am b/winsup/utils/mingw/Makefile.am
index d9557d8b50..7f7317ae15 100644
--- a/winsup/utils/mingw/Makefile.am
+++ b/winsup/utils/mingw/Makefile.am
@@ -38,6 +38,7 @@ cygcheck_LDADD = -lz -lwininet -lshlwapi -lpsapi -lntdll
 cygwin_console_helper_SOURCES = cygwin-console-helper.cc

 ldh_SOURCES = ldh.cc
+ldh_LDFLAGS = ${AM_LDFLAGS} -Wl,--disable-high-entropy-va

 strace_SOURCES = \
 	path.cc \
-- 
2.45.1.windows.1

