Return-Path: <SRS0=rgYs=WQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C49AF3858D1E
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 18:57:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C49AF3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C49AF3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743274663; cv=none;
	b=uqzcZ1W6q2seygrpWRHXvoXwgW9VJ6K8a1Dr5PsY4xOiroL3txgGkYG+ZvImpNn/Okdte2WzJ2ONS9iFHFUA6+v+9D/crXen7QTdHj8Y/TqiJzpkUFxcJuHeiuX4Q2e0yppfaCCh4cAZslAYQUa0wLXJomDzRnGKNTW3rQviVHw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743274663; c=relaxed/simple;
	bh=9KN43qlIeSptf7w7BhWttbJToIe63S7GNuTYbWt8/ck=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=rimfM4uhfFXISPZuIloqYWAoWOlU9mtHtlfKaVBP8c+Y/YNMyZpz2sHMFtsKWzdp33s8twEgMG5+HKBW9R5B3zkpu6JwXcTAN96sSrIo6mHlqimZpibbMUtdXC12spVZm8n2fe6S9c9pXGftUKJGpFigIDMJsN/men9Vmg+neiA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C49AF3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=h7vuiXCj
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7E88145CD7
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 14:57:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=8oe02
	SmmZBGraZu3uOmABjKsbTk=; b=h7vuiXCjaP+QZ3J4ETNDE6glaoFJcSNvx+nmB
	vgokCQZ1oH8f7UmpQynovwHBY7V7UyzqjptQVtEGvtxDSIsgeuvf4cixmk9OdTos
	sInxAcRkUYYibgWa5PZsbBsJm2hFu/6cpxwVFNR85KEDSwB3U6/LIikQupX8szNm
	shtB0c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7913045CD6
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 14:57:43 -0400 (EDT)
Date: Sat, 29 Mar 2025 11:57:43 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 4/5] Cygwin: use udis86 to find fast cwd pointer on x64
Message-ID: <07bdad3b-0193-f6d3-905a-98c6c65c9046@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeremy Drake <cygwin@jdrake.com>

This makes find_fast_cwd_pointer more resiliant in the face of changes
to the generated code in ntdll.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/x86_64/fastcwd.cc | 230 +++++++++++++++++++++-----------
 1 file changed, 151 insertions(+), 79 deletions(-)

diff --git a/winsup/cygwin/x86_64/fastcwd.cc b/winsup/cygwin/x86_64/fastcwd.cc
index 6bb8c2265e..f5a8755a28 100644
--- a/winsup/cygwin/x86_64/fastcwd.cc
+++ b/winsup/cygwin/x86_64/fastcwd.cc
@@ -7,10 +7,29 @@
   details. */

 #include "winsup.h"
+#include <assert.h>
+#include "udis86/types.h"
+#include "udis86/extern.h"

 class fcwd_access_t;

-#define peek32(x)	(*(int32_t *)(x))
+/* Helper function to get the absolute address of an rip-relative instruction
+   by summing the current instruction's pc (rip), the current instruction's
+   length, and the signed 32-bit displacement in the operand.  Optionally, an
+   additional offset is subtracted to deal with the case where a member of a
+   struct is being referenced by the instruction but the address of the struct
+   is desired.
+*/
+static inline const void *
+rip_rel_offset (const ud_t *ud_obj, const ud_operand_t *opr, int sub_off=0)
+{
+  assert ((opr->type == UD_OP_JIMM && opr->size == 32) ||
+	  (opr->type == UD_OP_MEM && opr->base == UD_R_RIP &&
+	   opr->index == UD_NONE && opr->scale == 0 && opr->offset == 32));
+
+  return (const void *) (ud_insn_off (ud_obj) + ud_insn_len (ud_obj) +
+			 opr->lval.sdword - sub_off);
+}

 /* This function scans the code in ntdll.dll to find the address of the
    global variable used to access the CWD.  While the pointer is global,
@@ -30,99 +49,152 @@ find_fast_cwd_pointer_x86_64 ()
 			    GetProcAddress (ntdll, "RtlEnterCriticalSection");
   if (!get_dir || !ent_crit)
     return NULL;
+  /* Initialize udis86 */
+  ud_t ud_obj;
+  ud_init (&ud_obj);
+  /* Set 64-bit mode */
+  ud_set_mode (&ud_obj, 64);
+  ud_set_input_buffer (&ud_obj, get_dir, 80);
+  /* Set pc (rip) so that subsequent calls to ud_insn_off will return the pc of
+     the instruction, saving us the hassle of tracking it ourselves */
+  ud_set_pc (&ud_obj, (uint64_t) get_dir);
+  const ud_operand_t *opr, *opr0;
+  ud_mnemonic_code_t insn;
+  ud_type_t reg = UD_NONE;
   /* Search first relative call instruction in RtlGetCurrentDirectory_U. */
-  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 80);
-  if (!rcall)
+  const uint8_t *use_cwd = NULL;
+  while (ud_disassemble (&ud_obj) &&
+      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
+      insn != UD_Ijmp)
+    {
+      if (insn == UD_Icall)
+	{
+	  opr = ud_insn_opr (&ud_obj, 0);
+	  if (opr->type == UD_OP_JIMM && opr->size == 32)
+	    {
+	      /* Fetch offset from instruction and compute address of called
+		 function.  This function actually fetches the current FAST_CWD
+		 instance and performs some other actions, not important to us.
+	       */
+	      use_cwd = (const uint8_t *) rip_rel_offset (&ud_obj, opr);
+	      break;
+	    }
+	}
+    }
+  if (!use_cwd)
     return NULL;
-  /* Fetch offset from instruction and compute address of called function.
-     This function actually fetches the current FAST_CWD instance and
-     performs some other actions, not important to us. */
-  const uint8_t *use_cwd = rcall + 5 + peek32 (rcall + 1);
+  ud_set_input_buffer (&ud_obj, use_cwd, 120);
+  ud_set_pc (&ud_obj, (uint64_t) use_cwd);
+
   /* Next we search for the locking mechanism and perform a sanity check.
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
+     we basically look for the RtlEnterCriticalSection call and test if the
+     code uses the FastPebLock. */
+  PRTL_CRITICAL_SECTION lockaddr = NULL;
+
+  while (ud_disassemble (&ud_obj) &&
+      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
+      insn != UD_Ijmp)
     {
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
+      if (insn == UD_Ilea)
+	{
+	  /* udis86 seems to follow intel syntax, in that operand 0 is the
+	     dest and 1 is the src */
+	  opr0 = ud_insn_opr (&ud_obj, 0);
+	  opr = ud_insn_opr (&ud_obj, 1);
+	  if (opr->type == UD_OP_MEM && opr->base == UD_R_RIP &&
+	      opr->index == UD_NONE && opr->scale == 0 && opr->offset == 32 &&
+	      opr0->type == UD_OP_REG && opr0->size == 64)
+	    {
+	      lockaddr = (PRTL_CRITICAL_SECTION) rip_rel_offset (&ud_obj, opr);
+	      reg = opr0->base;
+	      break;
+	    }
+	}
     }
-  else
+
+  /* Test if lock address is FastPebLock. */
+  if (lockaddr != NtCurrentTeb ()->Peb->FastPebLock)
+    return NULL;
+
+  /* Find where the lock address is loaded into rcx as the first parameter of
+     a function call */
+  bool found = false;
+  if (reg != UD_R_RCX)
     {
-      /* Usually the callq RtlEnterCriticalSection follows right after
-	 fetching the lock address. */
-      int call_rtl_offset = 7;
-      /* Search `lea rel(%rip),%rcx'.  This loads the address of the lock into
-         %rcx for the subsequent RtlEnterCriticalSection call. */
-      lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
-                                       "\x48\x8d\x0d", 3);
-      if (!lock)
+      while (ud_disassemble (&ud_obj) &&
+	  (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
+	  insn != UD_Ijmp)
 	{
-	  /* Windows 8.1 Preview calls `lea rel(rip),%r12' then some unrelated
-	     ops, then `mov %r12,%rcx', then `callq RtlEnterCriticalSection'. */
-	  lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
-					   "\x4c\x8d\x25", 3);
-	  call_rtl_offset = 14;
+	  if (insn == UD_Imov)
+	    {
+	      opr0 = ud_insn_opr (&ud_obj, 0);
+	      opr = ud_insn_opr (&ud_obj, 1);
+	      if (opr->type == UD_OP_REG && opr->size == 64 &&
+		  opr->base == reg && opr0->type == UD_OP_REG &&
+		  opr0->size == 64 && opr0->base == UD_R_RCX)
+		{
+		  found = true;
+		  break;
+		}
+	    }
 	}
+      if (!found)
+	return NULL;
+    }

-      if (!lock)
+  /* Next is the `callq RtlEnterCriticalSection' */
+  found = false;
+  while (ud_disassemble (&ud_obj) &&
+      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
+      insn != UD_Ijmp)
+    {
+      if (insn == UD_Icall)
 	{
-	  /* A recent Windows 11 Preview calls `lea rel(rip),%r13' then
-	     some unrelated instructions, then `callq RtlEnterCriticalSection'.
-	     */
-	  lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
-					   "\x4c\x8d\x2d", 3);
-	  call_rtl_offset = 24;
+	  opr = ud_insn_opr (&ud_obj, 0);
+	  if (opr->type == UD_OP_JIMM && opr->size == 32)
+	    {
+	      if (ent_crit != rip_rel_offset (&ud_obj, opr))
+		return NULL;
+	      found = true;
+	      break;
+	    }
 	}
+    }
+  if (!found)
+    return NULL;

-      if (!lock)
+  fcwd_access_t **f_cwd_ptr = NULL;
+  /* now we're looking for a mov rel(%rip), %<reg64> */
+  while (ud_disassemble (&ud_obj) &&
+      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
+      insn != UD_Ijmp)
+    {
+      if (insn == UD_Imov)
 	{
-	  return NULL;
+	  opr0 = ud_insn_opr (&ud_obj, 0);
+	  opr = ud_insn_opr (&ud_obj, 1);
+	  if (opr->type == UD_OP_MEM && opr->size == 64 &&
+	      opr->base == UD_R_RIP && opr->index == UD_NONE &&
+	      opr->scale == 0 && opr->offset == 32 &&
+	      opr0->type == UD_OP_REG && opr0->size == 64)
+	    {
+	      f_cwd_ptr = (fcwd_access_t **) rip_rel_offset (&ud_obj, opr);
+	      reg = opr0->base;
+	      break;
+	    }
 	}
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
     }
-  if (!movrbx)
+  /* Check that the next instruction is a test. */
+  if (!f_cwd_ptr || !ud_disassemble (&ud_obj) ||
+      ud_insn_mnemonic (&ud_obj) != UD_Itest)
     return NULL;
-  /* Check that the next instruction tests if the fetched value is NULL. */
-  const uint8_t *testrbx = (const uint8_t *)
-			   memmem (movrbx + 7, 3, "\x48\x85\xdb", 3);
-  if (!testrbx)
+
+  /* ... and that it's testing the same register that the mov above loaded the
+     f_cwd_ptr into against itself */
+  opr0 = ud_insn_opr (&ud_obj, 0);
+  opr = ud_insn_opr (&ud_obj, 1);
+  if (opr->type != UD_OP_REG || opr->size != 64 || opr->base != reg ||
+      opr0->type != opr->type || opr0->size != 64 || opr0->base != opr->base)
     return NULL;
-  /* Compute address of the fcwd_access_t ** pointer. */
-  return (fcwd_access_t **) (testrbx + peek32 (movrbx + 3));
+  return f_cwd_ptr;
 }
-- 
2.48.1.windows.1

