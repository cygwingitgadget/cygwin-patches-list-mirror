Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 5D6243858416
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 12:32:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5D6243858416
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5D6243858416
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753187579; cv=none;
	b=RERlACnLLwoT3lHLpd0cBP6w292geot81f4c6tNJ3UIyM7MIKOMNRev+oC4axB4k4rOvWf0Z+UfSz45Z8bBvvTYmz+wEr+ezAcxkvPGgfFhr55t7RoScK8mV7Xlt6THL1qeI9OB7IG3ranHqeADhhmuXkvotHYaqAOwdxaM0sH0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753187579; c=relaxed/simple;
	bh=PpF6W5d95rUk95p4NKPqtRVjYmcUsoDSWVAxwhdkloo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=TlP2EURUmksbRqI5WK87znds5s8FEx6ZjToOvt8Gkcni1OOg1If0+j8Rykf5eVgiS52RYonATrgshTgzU5VVmxusfBZBjeRSF6WhGmU3mgbYCNubX2Q4PLxI9sVk+dQ6EatXwDXubOCQT85kKVPqjoVdVUaaBs+jxseeWLFIBpY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5D6243858416
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hI11IqqA
Received: from localhost.localdomain by mta-snd-w06.mail.nifty.com
          with ESMTP
          id <20250722123255747.FLLJ.116286.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 21:32:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: process_fd: Fix handling of archetype fhandler
Date: Tue, 22 Jul 2025 21:32:32 +0900
Message-ID: <20250722123240.349-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753187575;
 bh=Zz62s1wQ300fHv3B0mn7eBWTK5g+BjsNyslo7pQxKEE=;
 h=From:To:Cc:Subject:Date;
 b=hI11IqqADHH9lKtc9Rt9Y22yKdVLV6wr+IMz3KY4mStr0f5tY0HXvnrC1h1U9VJvhtqnkDpP
 8hIhCMpql4eCEdZqMvbAbqUYK+1RQjYrpBM1lf2cSjes22gEuaj7NgQGwqc1jDA2JQNujf0ylg
 Dbm4A3d7VX9CB5eJFDsVDAHgaLtIyjpaQ7AbDxm9iIhzjYs08Zr+tNX/iv7khkmkaC2NMQ+UN0
 wTOZfim9eimSMlvifAkpMO3x8d5XDe10wJFKOJhByAdv7dIKTPTJiRfwthtQoZJFqlDF4LMRn0
 9ORDqzSYyG85Zv/2uJ1tGYOURKPkWvz3h9bwIyGOpMUMIhaw==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, process_fd did not handle fhandler using archetype
correctly. Due to lack of PC_OPEN flag for path_conv, build_fh_pc()
could not initialize archetype. Because of this bug, accessing pty
or console via process_fd fails.

With this patch, use build_fh_name() with PC_OPEN flag instead of
build_fh_pc() to set PC_OPEN flag to path_conv.

Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258167.html
Fixes: 7aca27b4fe55 ("Cygwin: introduce fhandler_process_fd and add stat(2) handling")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/process_fd.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/process_fd.cc b/winsup/cygwin/fhandler/process_fd.cc
index d81495103..14ae8746a 100644
--- a/winsup/cygwin/fhandler/process_fd.cc
+++ b/winsup/cygwin/fhandler/process_fd.cc
@@ -97,7 +97,7 @@ fhandler_process_fd::fetch_fh (HANDLE &out_hdl, uint32_t flags)
 	      pc.get_posix ());
       pc.set_posix (fullpath);
     }
-  fhandler_base *fh = build_fh_pc (pc);
+  fhandler_base *fh = build_fh_name (pc.get_posix (), PC_OPEN);
   if (!fh)
     {
       CloseHandle (hdl);
-- 
2.45.1

