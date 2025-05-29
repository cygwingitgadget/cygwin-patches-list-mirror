Return-Path: <SRS0=7LkC=YN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C085A385843F
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 17:57:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C085A385843F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C085A385843F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748541466; cv=none;
	b=RrdnWoac7QoqZCtkpqx367okyDiyzQ7drrBW1w3AIMI2wbCgYuK8/FhMKfbNXUqDknN+nvtaBXg3YeGe1Ro5Saam1H6wNY/0Tv0gaQ0IZssRWUtQPRp+oFIfco/WO2SKYF+p+jnReNN3PM/LkMSMWi9Znb2sQ2et7mqjM6Q5YWc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748541466; c=relaxed/simple;
	bh=gQaHJPMeymoYfZ+WbD7JqghMrR84CLha3bQd6pMSa/k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=xHbmY4UAfc4nzXk21AKuCpyyw7W4v/ca5d/PvJkFjK2Mtx4UeQ7aStEbvXoK5ouVSmyp7g4Rxzmqfldc7lLxDC7z6ELjaH1io33FmPSzGjExxaRZGX6drQiavZGFQPC8Ao3XI5m4SwKsdZGOzz662G4YT6XcGJyU9Kh0sY2sa5E=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9C2C345CB2
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 13:57:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=QzPww
	CK2IJizdxtCKv3JTxJABlo=; b=szXsL3OVHt4abHZqEHzlusENt0yEOG7kRn2X9
	OPD5FI3BFiQlznm9tRsi+khjs5ZIKGW0pITQRuMiXtawxFXG4bMhZnwZAtBbatgI
	c0B5DA8oaTTmnCmRuNkBm3ds8uvmyDUj9O5Ebph7a8BVAi4pHGNtcO2iXg3C2CVW
	uXgL+U=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 95E3C45CA8
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 13:57:46 -0400 (EDT)
Date: Thu, 29 May 2025 10:57:46 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [RFC PATCH 1/3] Cygwin: allow redirecting stderr in ch_spawn
Message-ID: <4b5c620c-4fd9-470f-6e94-965e73f3b6ff@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

stdin and stdout were alreadly allowed for popen, but implementing
posix_spawn in terms of spawn would require stderr as well.
---
 winsup/cygwin/dcrt0.cc                    | 2 ++
 winsup/cygwin/local_includes/child_info.h | 6 +++---
 winsup/cygwin/spawn.cc                    | 5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index f4c09befd6..9b02acf2cd 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -662,6 +662,8 @@ child_info_spawn::handle_spawn ()
     cygheap->fdtab.move_fd (__stdin, 0);
   if (__stdout >= 0)
     cygheap->fdtab.move_fd (__stdout, 1);
+  if (__stderr >= 0)
+    cygheap->fdtab.move_fd (__stderr, 2);
   cygheap->user.groups.clear_supp ();

   /* If we're execing we may have "inherited" a list of children forked by the
diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 2da62ffaa3..902be8727b 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -33,7 +33,7 @@ enum child_status
 #define EXEC_MAGIC_SIZE sizeof(child_info)

 /* Change this value if you get a message indicating that it is out-of-sync. */
-#define CURR_CHILD_INFO_MAGIC 0xacbf4682U
+#define CURR_CHILD_INFO_MAGIC 0x6ccb18aeU

 #include "pinfo.h"
 struct cchildren
@@ -145,7 +145,7 @@ public:
   cygheap_exec_info *moreinfo;
   int __stdin;
   int __stdout;
-  char filler[4];
+  int __stderr;

   void cleanup ();
   child_info_spawn () {};
@@ -190,7 +190,7 @@ public:
   bool has_execed_cygwin () const { return iscygwin () && has_execed (); }
   operator HANDLE& () {return hExeced;}
   int worker (const char *, const char *const *, const char *const [],
-		     int, int = -1, int = -1);
+		     int, int = -1, int = -1, int = -1);
 };

 extern child_info_spawn ch_spawn;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index ef175e7082..9a7f0bbf73 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -281,7 +281,7 @@ extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
 int
 child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			  const char *const envp[], int mode,
-			  int in__stdin, int in__stdout)
+			  int in__stdin, int in__stdout, int in__stderr)
 {
   bool rc;
   int res = -1;
@@ -517,6 +517,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       set (chtype, real_path.iscygexec ());
       __stdin = in__stdin;
       __stdout = in__stdout;
+      __stderr = in__stderr;
       record_children ();

       si.lpReserved2 = (LPBYTE) this;
@@ -579,7 +580,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,

       int fileno_stdin = in__stdin < 0 ? 0 : in__stdin;
       int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
-      int fileno_stderr = 2;
+      int fileno_stderr = in__stderr < 0 ? 2 : in__stderr;

       bool no_pcon = mode != _P_OVERLAY && mode != _P_WAIT;
       term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false),
-- 
2.49.0.windows.1

