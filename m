Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 197E1385C6F5
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 23:55:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 197E1385C6F5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 197E1385C6F5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750982125; cv=none;
	b=XOYOdbVf7K3fLMz54v5aWMNBV4eBReaxVGTbVBfLRWyLPbQQD7AIT5VGHy+lgox7XDJtClnv0UtYVWpXqIhPCwsL+4ViBvLwHpnDqYMjI4rAwroC4DstLR0OprsJfuO3li4WjrOSLPYMKicYROhi3CN7Q4wI39rGkSK4QoD/6Ik=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750982125; c=relaxed/simple;
	bh=sHtcTaNZNlEvnWF4NOWGArnYTJ/931hMtVT/KlmvVes=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=H9KYPBWb1gcItZNqpUJqFym3zWtKF3T2tEVI26Owm3MU6lhBO/szSIpsR88eYd7tBdqIfwMTTPvl3lHzUOfeEkU5iKpG1GONOI7w6Ps2TecHWSunARMf0fm3c8cZGJP7rX8+pnYTXxlch8o1b2njQukvdtsh4PqSitKYOJT+oe4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 197E1385C6F5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=C4m3rox6
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id EAB5A45D31
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=yV86W
	fGWYNJTH3VlteXAeapv4zw=; b=C4m3rox6vp3oxfOB75aE+lV8lNCIpyNqlk+10
	is98ooKCCqGYfPNK8iSfkrH8UL5QaAco1cAJ/xzknyoLQfV6isxP9bxWFkHwlGpy
	48wYHViHunnoPABmbfmNGTB0EGb03Nw54Y6jxfRbKfVfvSKZSFKCaLWARzTNTVge
	Cvn+N8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id E584045D30
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:55:24 -0400 (EDT)
Date: Thu, 26 Jun 2025 16:55:24 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/5] Cygwin: allow redirecting stderr in ch_spawn
Message-ID: <cb938c47-80dd-78c6-876f-7a36112960af@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

stdin and stdout were alreadly allowed for popen, but implementing
posix_spawn in terms of spawn would require stderr as well.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/dcrt0.cc                    | 2 ++
 winsup/cygwin/local_includes/child_info.h | 6 +++---
 winsup/cygwin/spawn.cc                    | 5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 69c233c247..b0fb5c9c1e 100644
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

