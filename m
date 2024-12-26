Return-Path: <SRS0=UkoZ=TT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 88C773858D20
	for <cygwin-patches@cygwin.com>; Thu, 26 Dec 2024 12:34:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 88C773858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 88C773858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1735216469; cv=none;
	b=LSfbL6KfZQ1U9xb537FAUGKf5s3o9WCd+Zqes1d5ArKBRF75aB/5VoNOpkNEbWUv3Kh8Xmip6jjrYQ9GNjkFe5x2n+Yt9WL34SVs+/QbRBzWRtpMWEbnuFAbnxPXkbRa54Rx6v4DK/tMNtX5y65By7lm5hw0zQkGsIasF9mtVWY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1735216469; c=relaxed/simple;
	bh=Xr1GMSCWelfVxNbFQo95b0OV+RuChMCy2bLS/ueU1uw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=k2jHU/H9KVq8s1v5PctswbezttNwz8A4Lo0UPm4lgqtXHHjuq25J9f0uEYqwpdjq+sHriwWxFjmkAa4TRQs65y++x5daOCfXjTW/1Ha2brsO5v2jqr8R4+LpKHlCqtQZXBKY1kPb539Ek8Pd5NvQBMwPyAqefTpjTWCrOtRui/8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 88C773858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PcJdwUeD
Received: from localhost.localdomain by mta-snd-e05.mail.nifty.com
          with ESMTP
          id <20241226123426290.NTJS.81160.localhost.localdomain@nifty.com>;
          Thu, 26 Dec 2024 21:34:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruno Haible <bruno@clisp.org>
Subject: [PATCH] Cygwin: access: Fix X_OK behaviour for administrator
Date: Thu, 26 Dec 2024 21:34:01 +0900
Message-ID: <20241226123410.126087-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1735216466;
 bh=myO2cVK+xIbT4W52Bz+3WfplpIsIQpPi99+OHTKsiqA=;
 h=From:To:Cc:Subject:Date;
 b=PcJdwUeD7UD6gEudo4slpdg0Yp5K7lwYH69RUEJFYk24vZY1tWi3nBIgVt4mZPczIFG60Srd
 rgcs9aiXPxIQvZShS/LAfyC9kccY/VSxm/ifWvHN5o/Ik4hMTxlToaV8nE0MPah9naU61LnNl8
 mD5QQ09SjWzzwF4lxfDKaut2OscAS9aslMqtgWz7GFEmdaJJs6uF1H3qRhHoScph44lGgz2vWm
 ALM+Fv6pO4zLECMdT/W8sYCXfOUjQI2JEYb+4fuGr4rOOz2VCjccC82vP2yJsQaJF8N11QakqT
 odaDvDXvT+rY887PHMaFYO97smyzR3uNSVesijQ9qbxIzXsw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit a0933cd17d19, access(_, X_OK) returns 0 for the
file without execution permission if the account is administrator
while it should return -1. The Administrator has full access
permission regardless of ACL, however, access() should return -1
if execution permission is set for neither user, group nor others,
even though NtOpenFile() succeeds. This patch checks result of
stat() before calling NtOpenFile() when the X_OK permissions is
specified for access().

Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256972.html
Fixes: a0933cd17d19 ("Correction for samba/SMB share")
Reported-by: Bruno Haible <bruno@clisp.org>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sec/base.cc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/winsup/cygwin/sec/base.cc b/winsup/cygwin/sec/base.cc
index 647c27ec6..666d257e3 100644
--- a/winsup/cygwin/sec/base.cc
+++ b/winsup/cygwin/sec/base.cc
@@ -613,6 +613,22 @@ check_file_access (path_conv &pc, int flags, bool effective)
   if (flags & X_OK)
     desired |= FILE_EXECUTE;
 
+  /* The Administrator has full access permission regardless of ACL,
+     however, access() should return -1 if 'x' permission is set
+     for neither user, group nor others, even though NtOpenFile()
+     succeeds. */
+  if ((flags & X_OK) && !pc.isdir ())
+    {
+      struct stat st;
+      if (stat (pc.get_posix (), &st))
+	goto out;
+      else if ((st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH)) == 0)
+	{
+	  set_errno (EACCES);
+	  goto out;
+	}
+    }
+
   if (!effective)
     cygheap->user.deimpersonate ();
 
@@ -634,6 +650,7 @@ check_file_access (path_conv &pc, int flags, bool effective)
   if (!effective)
     cygheap->user.reimpersonate ();
 
+out:
   debug_printf ("flags %y, ret %d", flags, ret);
   return ret;
 }
-- 
2.45.1

