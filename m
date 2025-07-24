Return-Path: <SRS0=Pspn=2F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 8C7F93858D1E
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 08:36:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C7F93858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C7F93858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753346196; cv=none;
	b=Zz9wN+cvn4/soYZafMsTRTI0AGuQ/PaVeq4qV8BHiVotRLCiOYTEEytHki8vc/mx75UIl+Rsocq68NsHgMGO6H+SrfwEmj1zMVT9rfwbZ0upIXfWXvluDR0TogUHqdx/L8g0KWATJCdV5LENm5OjQCdu8gEsVd3N5n1w9dTyHFE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753346196; c=relaxed/simple;
	bh=tEuXnW4TTXTBGp+H0AzprTMiz+RAI4wQe7Mha3x2PcQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=dlSPXCf9l4Kell+XR2kFa+1EM9VmCTK5kZ5ruoN57p9kBNptbzYGfAQd2bFdJ3bM/GK8ASDtzE8KDjZIB7falKOH/BciPthzZak0G35y/BmF/qT+oL7EugeGNlivQcguSUkHh8KTJ5vvO7GIKQhGbT2tNzB6LHMecvXgvj/IFlU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C7F93858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MduEXnqN
Received: from localhost.localdomain by mta-snd-w06.mail.nifty.com
          with ESMTP
          id <20250724083633603.LWJI.116286.localhost.localdomain@nifty.com>;
          Thu, 24 Jul 2025 17:36:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH] Cygwin: dtable: Fix handling of archetype fhandler in process_fd
Date: Thu, 24 Jul 2025 17:36:07 +0900
Message-ID: <20250724083616.1084-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753346193;
 bh=0pbU/FLJQ//XYM4LcHx/lqqdnNckACDMHqzBgf1Y5NA=;
 h=From:To:Cc:Subject:Date;
 b=MduEXnqNyNR0RRgD9okxYjBa1b6WWSGWBecwi3JAhOXGy4GMrdLd20OJzJgjEMlVFbwp2oNR
 E519dkFAd/MOenpBJJjhwBB1hcswurFVMBDoqKgLEBRXscjihh3M+5LiwbPko1Ln0i7drf9c77
 ujWMx6wl6/E3Yf3bvxMH0f48M57dQK9AkZy7Ue4DK/wgI1XWPRAxQ3lcVFO4YTvKOrZGfB/+na
 lHSfvQ2GN0hn+C/2kFJSmsx3R9ys8dclTj+igNcDP1jlYDMgHK5Uslpcp7JOQtXainft6FEJIq
 em+nnQvz6BThvJlTTYQ139gSyYGRm1OZfw2WbnmRbZ3paCBQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, process_fd failed to correctly handle fhandlers using an
archetype. This was due to the missing PATH_OPEN flag in path_conv,
which caused build_fh_pc() to skip archetype initialization. The
root cause was a bug where open() did not set the PATH_OPEN flag
for fhandlers using an archetype.

This patch introduces a new method, path_conv::set_isopen(), to
explicitly set the PATH_OPEN flag in path_flags when opening a
fhandler that uses an archetype.

Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258167.html
Fixes: 92ddb7429065 ("(build_pc_pc): Use fh_alloc to create. Set name from fh->dev if appropriate. Generate an archetype or point to one here.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc             | 4 ++++
 winsup/cygwin/local_includes/path.h | 1 +
 winsup/cygwin/release/3.6.5         | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index f1832a169..6a99c99f9 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -674,6 +674,8 @@ build_fh_pc (path_conv& pc)
 		    fh->archetype->get_handle ());
       if (!fh->get_name ())
 	fh->set_name (fh->archetype->dev ().name ());
+      if (pc.isopen ())
+	fh->pc.set_isopen ();
     }
   else if (cygwin_finished_initializing && !pc.isopen ())
     fh->set_name (pc);
@@ -681,6 +683,8 @@ build_fh_pc (path_conv& pc)
     {
       if (!fh->get_name ())
 	fh->set_name (fh->dev ().native ());
+      if (pc.isopen ())
+	fh->pc.set_isopen ();
       fh->archetype = fh->clone ();
       debug_printf ("created an archetype (%p) for %s(%d/%d)", fh->archetype, fh->get_name (), fh->dev ().get_major (), fh->dev ().get_minor ());
       fh->archetype->archetype = NULL;
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
index 3fbaa0c3a..b4d8b44d9 100644
--- a/winsup/cygwin/release/3.6.5
+++ b/winsup/cygwin/release/3.6.5
@@ -12,3 +12,6 @@ Fixes:
 
 - Fix multi-thread safety of system().
   Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258324.html
+
+- Make process_fd correctly handle pty and console.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258167.html
-- 
2.45.1

