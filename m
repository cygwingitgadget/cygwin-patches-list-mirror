Return-Path: <SRS0=WO2z=WR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E0ABC3858D29
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 01:56:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E0ABC3858D29
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E0ABC3858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743299776; cv=none;
	b=htoMaMz2eT04oeQ+0jha0jHPnwR9FZ8Uaak7RSqTKDngSjwOQx0aoKQ3elUJncDpEtnoAUcuGt2jTNckGTmzU/ws3AmVkX5sO4GRTPxGA4GqUUfiJR8OB4ljLcPFELpJ7uxHMQwC+d5PnNuoU38RH83NUxO2KiLviPQ298Htlms=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743299776; c=relaxed/simple;
	bh=TJJHJnIdVvNX3jvnLyEKDP4/ox5v5f0c0Qb6B07z8Ug=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=AYubDJVGNc5bVj515VtI1m8W9gM9wbllV37c8T2xw0n068eJafUD4/7+PSyTb6fougR1hc4e+QhRJzDKi3OnBfyfby6um7jMxHQAa31Y2OvnDYZfeitaNMrcmmXxubbSckWBiwnF23kzp4O9gzL3K0L7o+vM/o88pTAqyxf5Uyc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E0ABC3858D29
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=CjiKZe/U
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 983EB45C92
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 21:56:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=mftO7
	MEynBGpBDdRbNKGQoSJ9fQ=; b=CjiKZe/UvQfGBAXrNdJHqwx76Qu3CsX7r34/N
	h3A96KczfrNuymn05uwqNCCOB1PmIhxMFHUtjhqoe7Q+ij8nI9FfsoTNE/ySNS6P
	wk1WHg8TZa8ar1YsioEDHGuu3b2bR7I5R+8f4bFEjPzKya9XIDXiZRF1RQgteSNB
	07vwOo=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7EFB145C8D
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 21:56:15 -0400 (EDT)
Date: Sat, 29 Mar 2025 18:56:15 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 5/5] Cygwin: add find_fast_cwd_pointer_aarch64.
Message-ID: <6a08e0b0-b1ee-09b5-b7e6-e4489e25b850@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,URI_TRY_3LD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeremy Drake <cygwin@jdrake.com>

This works for aarch64 hosts when the target is aarch64, x86_64, or i686,
with only a small #if block in one function that needs to care.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/Makefile.am        |   1 +
 winsup/cygwin/aarch64/fastcwd.cc | 207 +++++++++++++++++++++++++++++++
 winsup/cygwin/path.cc            |  27 +++-
 3 files changed, 229 insertions(+), 6 deletions(-)
 create mode 100644 winsup/cygwin/aarch64/fastcwd.cc

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index fdd026a525..6438a41487 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -52,6 +52,7 @@ if TARGET_X86_64
 TARGET_FILES= \
 	x86_64/bcopy.S \
 	x86_64/fastcwd.cc \
+	aarch64/fastcwd.cc \
 	x86_64/memchr.S \
 	x86_64/memcpy.S \
 	x86_64/memmove.S \
diff --git a/winsup/cygwin/aarch64/fastcwd.cc b/winsup/cygwin/aarch64/fastcwd.cc
new file mode 100644
index 0000000000..a85c539817
--- /dev/null
+++ b/winsup/cygwin/aarch64/fastcwd.cc
@@ -0,0 +1,207 @@
+/* aarch64/fastcwd.cc: find the fast cwd pointer on aarch64 hosts.
+
+  This file is part of Cygwin.
+
+  This software is a copyrighted work licensed under the terms of the
+  Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+  details. */
+
+/* You might well wonder why this file is included in x86_64 target files
+   in Makefile.am.  It turns out that this code works when built for i686,
+   x86_64, or aarch64 with just the small #if/#elif block in
+   GetArm64ProcAddress below caring which. */
+
+#include "winsup.h"
+#include <assert.h>
+
+class fcwd_access_t;
+
+static LPCVOID
+GetArm64ProcAddress (HMODULE hModule, LPCSTR procname)
+{
+  const BYTE *proc = (const BYTE *) GetProcAddress (hModule, procname);
+#if defined (__aarch64__)
+  return proc;
+#else
+#if defined (__i386__)
+  static const BYTE thunk[] = "\x8b\xff\x55\x8b\xec\x5d\x90\xe9";
+  static const BYTE thunk2[0];
+#elif defined (__x86_64__)
+  /* see
+     https://learn.microsoft.com/en-us/windows/arm/arm64ec-abi#fast-forward-sequences */
+  static const BYTE thunk[] = "\x48\x8b\xc4\x48\x89\x58\x20\x55\x5d\xe9";
+  /* on windows 11 22000 the thunk is different than documented on that page */
+  static const BYTE thunk2[] = "\x48\x8b\xff\x55\x48\x8b\xec\x5d\x90\xe9";
+#else
+#error "Unhandled architecture for thunk detection"
+#endif
+  if (memcmp (proc, thunk, sizeof (thunk) - 1) == 0 ||
+     (sizeof(thunk2) && memcmp (proc, thunk2, sizeof (thunk2) - 1) == 0))
+    {
+      proc += sizeof (thunk) - 1;
+      proc += 4 + *(const int32_t *) proc;
+    }
+  return proc;
+#endif
+}
+
+/* these ids and masks, as well as the names of the various other parts of
+   instructions used in this file, came from
+   https://developer.arm.com/documentation/ddi0602/2024-09/Index-by-Encoding
+   (Arm A-profile A64 Instruction Set Architecture)
+*/
+#define IS_INSN(pc, name) ((*(pc) & name##_mask) == name##_id)
+static const uint32_t add_id = 0x11000000;
+static const uint32_t add_mask = 0x7fc00000;
+static const uint32_t adrp_id = 0x90000000;
+static const uint32_t adrp_mask = 0x9f000000;
+static const uint32_t b_id = 0x14000000;
+static const uint32_t b_mask = 0xfc000000;
+static const uint32_t bl_id = 0x94000000;
+static const uint32_t bl_mask = 0xfc000000;
+/* matches both cbz and cbnz */
+static const uint32_t cbz_id = 0x34000000;
+static const uint32_t cbz_mask = 0x7e000000;
+static const uint32_t ldr_id = 0xb9400000;
+static const uint32_t ldr_mask = 0xbfc00000;
+/* matches both ret and br (which are the same except ret is a 'hint' that
+   it's  a subroutine return */
+static const uint32_t ret_id = 0xd61f0000;
+static const uint32_t ret_mask = 0xffbffc1f;
+
+/* this would work for either bl or b, but we only use it for bl */
+static inline LPCVOID
+extract_bl_target (const uint32_t *pc)
+{
+  assert (IS_INSN (pc, bl) || IS_INSN (pc, b));
+  int32_t offset = *pc & ~bl_mask;
+  /* sign extend */
+  if (offset & (1 << 25))
+    offset |= bl_mask;
+  /* Note uint32_t * artithmatic will implicitly multiply the offset by 4 */
+  return pc + offset;
+}
+
+static inline uint64_t
+extract_adrp_address (const uint32_t *pc)
+{
+  assert (IS_INSN (pc, adrp));
+  uint64_t adrp_base = (uint64_t) pc & ~0xFFF;
+  int64_t  adrp_imm = (*pc >> (5+19+5)) & 0x3;
+  adrp_imm |= ((*pc >> 5) & 0x7FFFF) << 2;
+  /* sign extend */
+  if (adrp_imm & (1 << 20))
+    adrp_imm |= ~((1 << 21) - 1);
+  adrp_imm <<= 12;
+  return adrp_base + adrp_imm;
+}
+
+/* This function scans the code in ntdll.dll to find the address of the
+   global variable used to access the CWD.  While the pointer is global,
+   it's not exported from the DLL, unfortunately.  Therefore we have to
+   use some knowledge to figure out the address. */
+
+fcwd_access_t **
+find_fast_cwd_pointer_aarch64 ()
+{
+  /* Fetch entry points of relevant functions in ntdll.dll. */
+  HMODULE ntdll = GetModuleHandle ("ntdll.dll");
+  if (!ntdll)
+    return NULL;
+  LPCVOID get_dir = GetArm64ProcAddress (ntdll, "RtlGetCurrentDirectory_U");
+  LPCVOID ent_crit = GetArm64ProcAddress (ntdll, "RtlEnterCriticalSection");
+  if (!get_dir || !ent_crit)
+    return NULL;
+
+  LPCVOID use_cwd = NULL;
+  const uint32_t *start = (const uint32_t *) get_dir;
+  const uint32_t *pc = start;
+  /* find the call to RtlpReferenceCurrentDirectory, and get its address */
+  for (; pc < start + 20 && !IS_INSN (pc, ret) && !IS_INSN (pc, b); pc++)
+    {
+      if (IS_INSN (pc, bl))
+	{
+	  use_cwd = extract_bl_target (pc);
+	  break;
+	}
+    }
+  if (!use_cwd)
+    return NULL;
+
+  start = pc = (const uint32_t *) use_cwd;
+
+  const uint32_t *ldrpc = NULL;
+  uint32_t ldroffset, ldrsz;
+  uint32_t ldrrn, ldrrd;
+
+  /* find the ldr (immediate unsigned offset) for RtlpCurDirRef */
+  for (; pc < start + 20 && !IS_INSN (pc, ret) && !IS_INSN (pc, b); pc++)
+    {
+      if (IS_INSN (pc, ldr))
+	{
+	  ldrpc = pc;
+	  ldrsz = (*pc & 0x40000000);
+	  ldroffset = (*pc >> (5+5)) & 0xFFF;
+	  ldroffset <<= ldrsz ? 3 : 2;
+	  ldrrn = (*pc >> 5) & 0x1F;
+	  ldrrd = *pc & 0x1F;
+	  break;
+	}
+    }
+  if (ldrpc == NULL)
+    return NULL;
+
+  /* the next instruction after the ldr should be checking if it was NULL:
+     either a compare and branch if zero or not zero (hence why cbz_mask is 7e
+     instead of 7f) */
+  if (!IS_INSN (pc + 1, cbz) || (*(pc + 1) & 0x1F) != ldrrd
+      || (*(pc + 1) & 0x80000000) != (ldrsz << 1))
+    return NULL;
+
+  /* work backwards, find a bl to RtlEnterCriticalSection whose argument
+     is the fast peb lock */
+
+  for (pc = ldrpc; pc >= start; pc--)
+    {
+      if (IS_INSN (pc, bl) && extract_bl_target (pc) == ent_crit)
+	break;
+    }
+  uint32_t addoffset;
+  uint32_t addrn;
+  for (; pc >= start; pc--)
+    {
+      if (IS_INSN (pc, add) && (*pc & 0x1F) == 0)
+	{
+	  addoffset = (*pc >> (5+5)) & 0xFFF;
+	  addrn = (*pc >> 5) & 0x1F;
+	  break;
+	}
+    }
+  PRTL_CRITICAL_SECTION lockaddr = NULL;
+  for (; pc >= start; pc--)
+    {
+      if (IS_INSN (pc, adrp) && (*pc & 0x1F) == addrn)
+	{
+	  lockaddr = (PRTL_CRITICAL_SECTION) (extract_adrp_address (pc) +
+					      addoffset);
+	  break;
+	}
+    }
+  if (lockaddr != NtCurrentTeb ()->Peb->FastPebLock)
+    return NULL;
+
+  /* work backwards from the ldr to find the corresponding adrp */
+  fcwd_access_t **RtlpCurDirRef = NULL;
+  for (pc = ldrpc; pc >= start; pc--)
+    {
+      if (IS_INSN (pc, adrp) && (*pc & 0x1F) == ldrrn)
+	{
+	  RtlpCurDirRef = (fcwd_access_t **) (extract_adrp_address (pc) +
+					      ldroffset);
+	  break;
+	}
+    }
+
+  return RtlpCurDirRef;
+}
+
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 3a5e2ee07e..7a08e978ad 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -4495,21 +4495,36 @@ fcwd_access_t **
 find_fast_cwd_pointer_x86_64 ();
 #endif

+fcwd_access_t **
+find_fast_cwd_pointer_aarch64 ();
+
 static fcwd_access_t **
 find_fast_cwd ()
 {
   fcwd_access_t **f_cwd_ptr;

-  /* First check if we're running on an ARM64 system.  Skip
-     fetching FAST_CWD pointer as long as there's no solution for finding
-     it on that system. */
-  if (wincap.host_machine () == IMAGE_FILE_MACHINE_ARM64)
-    return NULL;
+  switch (wincap.host_machine ())
+    {
+    case IMAGE_FILE_MACHINE_ARM64:
+      f_cwd_ptr = find_fast_cwd_pointer_aarch64 ();
+      break;
+#ifdef __x86_64__
+    case IMAGE_FILE_MACHINE_AMD64:
+      f_cwd_ptr = find_fast_cwd_pointer_x86_64 ();
+      break;
+#endif
+    default:
+      small_printf ("Cygwin WARNING:\n"
+"  Couldn't compute FAST_CWD pointer for an unknown architecture (%04y)\n"
+"  Please update to the latest available Cygwin version from\n"
+"  https://cygwin.com/.  If the problem persists, please see\n"
+"  https://cygwin.com/problems.html\n\n", (int) wincap.host_machine ());
+      return NULL;
+    }

   /* Fetch the pointer but don't set the global fast_cwd_ptr yet.  First
      we have to make sure we know the version of the FAST_CWD structure
      used on the system. */
-  f_cwd_ptr = find_fast_cwd_pointer_x86_64 ();
   if (!f_cwd_ptr)
     small_printf ("Cygwin WARNING:\n"
 "  Couldn't compute FAST_CWD pointer.  This typically occurs if you're using\n"
-- 
2.48.1.windows.1

