Return-Path: <SRS0=Pspn=2F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id C17A53858D33
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 11:57:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C17A53858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C17A53858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753358255; cv=none;
	b=D/7PwaUqalooJPt8o+4l2SBrRjlUHJD+Zj3iV8/zHY5iGwUvJafakQkn6L9oAB6405jyR/3lWxlK3wzx3UQZ6JZ8g9sk2ZGOEDzzcYrJ8SbZ9Uq2M/egNL6asMzw/sMvdlxLdHnBOwNFL7AWWpk5mxvjk9k2G8GhKYmIXZJ9S48=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753358255; c=relaxed/simple;
	bh=ESnmuE+gW6rX3+55J7D/KGPzZuUuG91RY6uyPZKhIuM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=v0oLiz895ostQ2NOeCGMgweMbFcKmCnz0DELFhciAyKNn9lRt3N1ifrTOAWcCtGLvLl9FGIqyOHQfPmR2n8WAb3Voy+GGdnb1ISaC6CtRmDt6lZJ9OQ7EVwqofxVBQavbaCaIPYcbshCoKMV2C+60a0MNBe1fnQC8DDhAsuYw+E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C17A53858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PYvddA8t
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20250724115731824.SGRK.98325.localhost.localdomain@nifty.com>;
          Thu, 24 Jul 2025 20:57:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: Fix handling of archetype fhandler in process_fd
Date: Thu, 24 Jul 2025 20:57:01 +0900
Message-ID: <20250724115713.1669-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753358251;
 bh=l4iDZVCnELNtG5jZS6bUv4V+inANdQXwgP/6EJpaeA8=;
 h=From:To:Cc:Subject:Date;
 b=PYvddA8tB4c037t59uuwVxqpMFYPVouGvw16hlQTls+OK1SDOhAPUzTOLy/1Ep590BvLd3rW
 vtBoH20SoZN5VHrYH8r2+4oCW0JtNR/RPgxf4f/U1+aNf++xMmtxonMxLGTFWBMeX4Re6flfVu
 TnxufQ/7L4LhwRIIoYrD6EJTwMSlhoj/wxoV43yD9VSD/7ArJflfFnoAuWvSR8dr5rAihpJ8lB
 lTA3BUp96A+9PcWJfxA8hupGKqmW6FN+GxICvSylgYVpUEe/w2gZ98yPUk823efMAxqW+jEmqA
 1kvBch5W4Ep2/nt06gLukr3v2/j4zhgTrhCJCqlG6xcxvUxg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, process_fd failed to correctly handle fhandlers using an
archetype. This was due to the missing PATH_OPEN flag in path_conv,
which caused build_fh_pc() to skip archetype initialization. The
root cause was a bug where open() did not set the PATH_OPEN flag
for fhandlers using an archetype.

This patch introduces a new method, path_conv::set_isopen(), to
explicitly set the PATH_OPEN flag in path_flags in fhandler_base::
open_with_arch().

Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258167.html
Fixes: 92ddb7429065 ("(build_pc_pc): Use fh_alloc to create. Set name from fh->dev if appropriate. Generate an archetype or point to one here.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/base.cc      | 3 +++
 winsup/cygwin/local_includes/path.h | 1 +
 winsup/cygwin/release/3.6.5         | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
index 64a5f6aea..beebd710c 100644
--- a/winsup/cygwin/fhandler/base.cc
+++ b/winsup/cygwin/fhandler/base.cc
@@ -474,6 +474,9 @@ fhandler_base::open_with_arch (int flags, mode_t mode)
       if (!open_setup (flags))
 	api_fatal ("open_setup failed, %E");
     }
+  /* For pty and console, PATH_OPEN flag has not been set in open().
+     So set it here unconditionally. */
+  pc.set_isopen ();
 
   close_on_exec (flags & O_CLOEXEC);
   /* A unique ID is necessary to recognize fhandler entries which are
diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
index 1fd542c96..a9ce2c7e4 100644
--- a/winsup/cygwin/local_includes/path.h
+++ b/winsup/cygwin/local_includes/path.h
@@ -244,6 +244,7 @@ class path_conv
   int isopen () const {return path_flags & PATH_OPEN;}
   int isctty_capable () const {return path_flags & PATH_CTTY;}
   int follow_fd_symlink () const {return path_flags & PATH_RESOLVE_PROCFD;}
+  void set_isopen () {path_flags |= PATH_OPEN;}
   void set_cygexec (bool isset)
   {
     if (isset)
diff --git a/winsup/cygwin/release/3.6.5 b/winsup/cygwin/release/3.6.5
index 97bb39792..f14fbe6e1 100644
--- a/winsup/cygwin/release/3.6.5
+++ b/winsup/cygwin/release/3.6.5
@@ -19,3 +19,6 @@ Fixes:
 - Instead, fix internal conversion of filenames in case of an invalid
   4 byte UTF-8 sequence.
   Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258358.html
+
+- Make process_fd correctly handle pty and console.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258167.html
-- 
2.45.1

