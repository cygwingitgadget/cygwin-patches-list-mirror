Return-Path: <SRS0=rgYs=WQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E56F43858D1E
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 18:54:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E56F43858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E56F43858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743274463; cv=none;
	b=GUMVQCaaGkI39ln9ZnlVnDTBK/pDX21vEDk6R9ROEcNH5uT7cyXn1jZ83pH7Djy2PiqM6niujbrrlaPfDo6s9wBZJS6UkjmIwv/Px/RmPoKVrX1Ok4+L5gGPRPEgYYPdvnBRdHRezLME+ZwLc7yBx8jhGzoBlfL3MKdvH8pM42U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743274463; c=relaxed/simple;
	bh=Fi9xh8bT62vzdQ9+wiaDikYsXb5w/9JYUZAP9lO3JDY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=FbC/u6d6+0PxxXV97BdTS3lSJwJRJLQyXTlHzzCGl/pF8uLjjdF+KZWxy6oEd0knurV4v91viWUCT4fLlqbltRvuX/vnWWmZKomNwjwMDYbBQU9zOmyEENefxQDX7tmhS/FrKbgX1fMzNMQ5ZUFlsR3tZVA2tJNs82j3OK25Ubo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E56F43858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=JNLeZSKO
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9FF2F45CD7
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 14:54:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=R9xYX
	RB450OgRMPEr1pRl7kQxPY=; b=JNLeZSKOMj0JA4bRsW0powCJq2jGKdpoJwspM
	OaKMaY3zErADQ9Qp7Owa3pVVl7v20/3l9YG+u/qosErQKmQmoKCsk2/MN+ECdtHa
	LdWODrZnBTrslJqAQqfWVjq9dOafvBTOAsev67+/cx5fWRYkf8AwmN2pOKOZrynX
	TEOMNM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9AC8B45CD6
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 14:54:22 -0400 (EDT)
Date: Sat, 29 Mar 2025 11:54:22 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 1/5] Cygwin: factor out find_fast_cwd_pointer to arch-specific
 file.
Message-ID: <8f9eb94b-b47f-1f7d-8046-d37e855af252@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeremy Drake <cygwin@jdrake.com>

This is in preparation for rewriting it using udis86, and adding an
implementation for aarch64 hosts.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/Makefile.am       |   1 +
 winsup/cygwin/path.cc           | 122 ++----------------------------
 winsup/cygwin/x86_64/fastcwd.cc | 128 ++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 117 deletions(-)
 create mode 100644 winsup/cygwin/x86_64/fastcwd.cc

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index d47a1a2d11..a0e839701a 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -52,6 +52,7 @@ LIB_NAME=libcygwin.a
 if TARGET_X86_64
 TARGET_FILES= \
 	x86_64/bcopy.S \
+	x86_64/fastcwd.cc \
 	x86_64/memchr.S \
 	x86_64/memcpy.S \
 	x86_64/memmove.S \
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index d2aaed3143..3a5e2ee07e 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -4490,122 +4490,10 @@ fcwd_access_t::SetDirHandleFromBufferPointer (PWCHAR buf_p, HANDLE dir)
   f_cwd->DirectoryHandle = dir;
 }

-/* This function scans the code in ntdll.dll to find the address of the
-   global variable used to access the CWD.  While the pointer is global,
-   it's not exported from the DLL, unfortunately.  Therefore we have to
-   use some knowledge to figure out the address. */
-
-#define peek32(x)	(*(int32_t *)(x))
-
-static fcwd_access_t **
-find_fast_cwd_pointer ()
-{
-  /* Fetch entry points of relevant functions in ntdll.dll. */
-  HMODULE ntdll = GetModuleHandle ("ntdll.dll");
-  if (!ntdll)
-    return NULL;
-  const uint8_t *get_dir = (const uint8_t *)
-			   GetProcAddress (ntdll, "RtlGetCurrentDirectory_U");
-  const uint8_t *ent_crit = (const uint8_t *)
-			    GetProcAddress (ntdll, "RtlEnterCriticalSection");
-  if (!get_dir || !ent_crit)
-    return NULL;
-  /* Search first relative call instruction in RtlGetCurrentDirectory_U. */
-  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 80);
-  if (!rcall)
-    return NULL;
-  /* Fetch offset from instruction and compute address of called function.
-     This function actually fetches the current FAST_CWD instance and
-     performs some other actions, not important to us. */
-  const uint8_t *use_cwd = rcall + 5 + peek32 (rcall + 1);
-  /* Next we search for the locking mechanism and perform a sanity check.
-     On Pre-Windows 8 we basically look for the RtlEnterCriticalSection call.
-     Windows 8 does not call RtlEnterCriticalSection.  The code manipulates
-     the FastPebLock manually, probably because RtlEnterCriticalSection has
-     been converted to an inline function.  Either way, we test if the code
-     uses the FastPebLock. */
-  const uint8_t *movrbx;
-  const uint8_t *lock = (const uint8_t *)
-                        memmem ((const char *) use_cwd, 80,
-                                "\xf0\x0f\xba\x35", 4);
-  if (lock)
-    {
-      /* The lock instruction tweaks the LockCount member, which is not at
-	 the start of the PRTL_CRITICAL_SECTION structure.  So we have to
-	 subtract the offset of LockCount to get the real address. */
-      PRTL_CRITICAL_SECTION lockaddr =
-        (PRTL_CRITICAL_SECTION) (lock + 9 + peek32 (lock + 4)
-                                 - offsetof (RTL_CRITICAL_SECTION, LockCount));
-      /* Test if lock address is FastPebLock. */
-      if (lockaddr != NtCurrentTeb ()->Peb->FastPebLock)
-        return NULL;
-      /* Search `mov rel(%rip),%rbx'.  This is the instruction fetching the
-         address of the current fcwd_access_t pointer, and it should be pretty
-	 near to the locking stuff. */
-      movrbx = (const uint8_t *) memmem ((const char *) lock, 40,
-                                         "\x48\x8b\x1d", 3);
-    }
-  else
-    {
-      /* Usually the callq RtlEnterCriticalSection follows right after
-	 fetching the lock address. */
-      int call_rtl_offset = 7;
-      /* Search `lea rel(%rip),%rcx'.  This loads the address of the lock into
-         %rcx for the subsequent RtlEnterCriticalSection call. */
-      lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
-                                       "\x48\x8d\x0d", 3);
-      if (!lock)
-	{
-	  /* Windows 8.1 Preview calls `lea rel(rip),%r12' then some unrelated
-	     ops, then `mov %r12,%rcx', then `callq RtlEnterCriticalSection'. */
-	  lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
-					   "\x4c\x8d\x25", 3);
-	  call_rtl_offset = 14;
-	}
-
-      if (!lock)
-	{
-	  /* A recent Windows 11 Preview calls `lea rel(rip),%r13' then
-	     some unrelated instructions, then `callq RtlEnterCriticalSection'.
-	     */
-	  lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
-					   "\x4c\x8d\x2d", 3);
-	  call_rtl_offset = 24;
-	}
-
-      if (!lock)
-	{
-	  return NULL;
-	}
-
-      PRTL_CRITICAL_SECTION lockaddr =
-        (PRTL_CRITICAL_SECTION) (lock + 7 + peek32 (lock + 3));
-      /* Test if lock address is FastPebLock. */
-      if (lockaddr != NtCurrentTeb ()->Peb->FastPebLock)
-        return NULL;
-      /* Next is the `callq RtlEnterCriticalSection'. */
-      lock += call_rtl_offset;
-      if (lock[0] != 0xe8)
-        return NULL;
-      const uint8_t *call_addr = (const uint8_t *)
-                                 (lock + 5 + peek32 (lock + 1));
-      if (call_addr != ent_crit)
-        return NULL;
-      /* In contrast to the above Windows 8 code, we don't have to search
-	 for the `mov rel(%rip),%rbx' instruction.  It follows right after
-	 the call to RtlEnterCriticalSection. */
-      movrbx = lock + 5;
-    }
-  if (!movrbx)
-    return NULL;
-  /* Check that the next instruction tests if the fetched value is NULL. */
-  const uint8_t *testrbx = (const uint8_t *)
-			   memmem (movrbx + 7, 3, "\x48\x85\xdb", 3);
-  if (!testrbx)
-    return NULL;
-  /* Compute address of the fcwd_access_t ** pointer. */
-  return (fcwd_access_t **) (testrbx + peek32 (movrbx + 3));
-}
+#ifdef __x86_64__
+fcwd_access_t **
+find_fast_cwd_pointer_x86_64 ();
+#endif

 static fcwd_access_t **
 find_fast_cwd ()
@@ -4621,7 +4509,7 @@ find_fast_cwd ()
   /* Fetch the pointer but don't set the global fast_cwd_ptr yet.  First
      we have to make sure we know the version of the FAST_CWD structure
      used on the system. */
-  f_cwd_ptr = find_fast_cwd_pointer ();
+  f_cwd_ptr = find_fast_cwd_pointer_x86_64 ();
   if (!f_cwd_ptr)
     small_printf ("Cygwin WARNING:\n"
 "  Couldn't compute FAST_CWD pointer.  This typically occurs if you're using\n"
diff --git a/winsup/cygwin/x86_64/fastcwd.cc b/winsup/cygwin/x86_64/fastcwd.cc
new file mode 100644
index 0000000000..6bb8c2265e
--- /dev/null
+++ b/winsup/cygwin/x86_64/fastcwd.cc
@@ -0,0 +1,128 @@
+/* x86_64/fastcwd.cc: find fast cwd pointer on x86_64 hosts.
+
+  This file is part of Cygwin.
+
+  This software is a copyrighted work licensed under the terms of the
+  Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+  details. */
+
+#include "winsup.h"
+
+class fcwd_access_t;
+
+#define peek32(x)	(*(int32_t *)(x))
+
+/* This function scans the code in ntdll.dll to find the address of the
+   global variable used to access the CWD.  While the pointer is global,
+   it's not exported from the DLL, unfortunately.  Therefore we have to
+   use some knowledge to figure out the address. */
+
+fcwd_access_t **
+find_fast_cwd_pointer_x86_64 ()
+{
+  /* Fetch entry points of relevant functions in ntdll.dll. */
+  HMODULE ntdll = GetModuleHandle ("ntdll.dll");
+  if (!ntdll)
+    return NULL;
+  const uint8_t *get_dir = (const uint8_t *)
+			   GetProcAddress (ntdll, "RtlGetCurrentDirectory_U");
+  const uint8_t *ent_crit = (const uint8_t *)
+			    GetProcAddress (ntdll, "RtlEnterCriticalSection");
+  if (!get_dir || !ent_crit)
+    return NULL;
+  /* Search first relative call instruction in RtlGetCurrentDirectory_U. */
+  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 80);
+  if (!rcall)
+    return NULL;
+  /* Fetch offset from instruction and compute address of called function.
+     This function actually fetches the current FAST_CWD instance and
+     performs some other actions, not important to us. */
+  const uint8_t *use_cwd = rcall + 5 + peek32 (rcall + 1);
+  /* Next we search for the locking mechanism and perform a sanity check.
+     On Pre-Windows 8 we basically look for the RtlEnterCriticalSection call.
+     Windows 8 does not call RtlEnterCriticalSection.  The code manipulates
+     the FastPebLock manually, probably because RtlEnterCriticalSection has
+     been converted to an inline function.  Either way, we test if the code
+     uses the FastPebLock. */
+  const uint8_t *movrbx;
+  const uint8_t *lock = (const uint8_t *)
+                        memmem ((const char *) use_cwd, 80,
+                                "\xf0\x0f\xba\x35", 4);
+  if (lock)
+    {
+      /* The lock instruction tweaks the LockCount member, which is not at
+	 the start of the PRTL_CRITICAL_SECTION structure.  So we have to
+	 subtract the offset of LockCount to get the real address. */
+      PRTL_CRITICAL_SECTION lockaddr =
+        (PRTL_CRITICAL_SECTION) (lock + 9 + peek32 (lock + 4)
+                                 - offsetof (RTL_CRITICAL_SECTION, LockCount));
+      /* Test if lock address is FastPebLock. */
+      if (lockaddr != NtCurrentTeb ()->Peb->FastPebLock)
+        return NULL;
+      /* Search `mov rel(%rip),%rbx'.  This is the instruction fetching the
+         address of the current fcwd_access_t pointer, and it should be pretty
+	 near to the locking stuff. */
+      movrbx = (const uint8_t *) memmem ((const char *) lock, 40,
+                                         "\x48\x8b\x1d", 3);
+    }
+  else
+    {
+      /* Usually the callq RtlEnterCriticalSection follows right after
+	 fetching the lock address. */
+      int call_rtl_offset = 7;
+      /* Search `lea rel(%rip),%rcx'.  This loads the address of the lock into
+         %rcx for the subsequent RtlEnterCriticalSection call. */
+      lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
+                                       "\x48\x8d\x0d", 3);
+      if (!lock)
+	{
+	  /* Windows 8.1 Preview calls `lea rel(rip),%r12' then some unrelated
+	     ops, then `mov %r12,%rcx', then `callq RtlEnterCriticalSection'. */
+	  lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
+					   "\x4c\x8d\x25", 3);
+	  call_rtl_offset = 14;
+	}
+
+      if (!lock)
+	{
+	  /* A recent Windows 11 Preview calls `lea rel(rip),%r13' then
+	     some unrelated instructions, then `callq RtlEnterCriticalSection'.
+	     */
+	  lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
+					   "\x4c\x8d\x2d", 3);
+	  call_rtl_offset = 24;
+	}
+
+      if (!lock)
+	{
+	  return NULL;
+	}
+
+      PRTL_CRITICAL_SECTION lockaddr =
+        (PRTL_CRITICAL_SECTION) (lock + 7 + peek32 (lock + 3));
+      /* Test if lock address is FastPebLock. */
+      if (lockaddr != NtCurrentTeb ()->Peb->FastPebLock)
+        return NULL;
+      /* Next is the `callq RtlEnterCriticalSection'. */
+      lock += call_rtl_offset;
+      if (lock[0] != 0xe8)
+        return NULL;
+      const uint8_t *call_addr = (const uint8_t *)
+                                 (lock + 5 + peek32 (lock + 1));
+      if (call_addr != ent_crit)
+        return NULL;
+      /* In contrast to the above Windows 8 code, we don't have to search
+	 for the `mov rel(%rip),%rbx' instruction.  It follows right after
+	 the call to RtlEnterCriticalSection. */
+      movrbx = lock + 5;
+    }
+  if (!movrbx)
+    return NULL;
+  /* Check that the next instruction tests if the fetched value is NULL. */
+  const uint8_t *testrbx = (const uint8_t *)
+			   memmem (movrbx + 7, 3, "\x48\x85\xdb", 3);
+  if (!testrbx)
+    return NULL;
+  /* Compute address of the fcwd_access_t ** pointer. */
+  return (fcwd_access_t **) (testrbx + peek32 (movrbx + 3));
+}
-- 
2.48.1.windows.1

