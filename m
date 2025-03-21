Return-Path: <SRS0=oe3F=WI=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 670E83858D20
	for <cygwin-patches@cygwin.com>; Fri, 21 Mar 2025 23:41:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 670E83858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 670E83858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742600488; cv=none;
	b=dJApGFGS3YpxW0cTRBBeQ4qv2NkNnnJluh0g+BmMZNMBMRdJaYVDwHfx3xrt4eOr1XG1IRfxVjOT5oAhImlDJL3XO1MKxV7hBCk8aYzp0mUxhKPOYciZ7YCZbk23WlEwRvSfc66EOcDYmO0N+XaGzla19a2KAEuwCb4OGFeFGfQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742600488; c=relaxed/simple;
	bh=HOlleLZC8CGP9orT0xkdd3Df6vOA699Jb4GUYALSzSY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=rlUMG/uxCbYYNJJQcZ8FHo7WoKi6uWtnE2vIsB7RIpPVUOna+VkRyQ5l0doBW21apeApT6dDOxF99JIa10N4EZyT2A1yIS4UGPacJXr36aXlwXn1Ql944Dg6x8upS1lGSRtXdlHWuJU1Q9fZkXFUt5WAIh19FYTslkvOUivZgQE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 670E83858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=MxuKsqxb
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B9E9845CAB
	for <cygwin-patches@cygwin.com>; Fri, 21 Mar 2025 19:41:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=VHQUT
	U3nfGdfTcaSzwYqtywXoec=; b=MxuKsqxb/w3sbwdl6wO24szo2xfGw7EuLPmiV
	UepSeI7z4anPw161M60Iwy5sVxmLN24GD8BQARyN76bgqZUStp0Gd/2kpD+cn3p5
	ZQxM6ohiZNqiiIcLQwYyOG9+xUcZKmgAGvtutfgUgTpQ/K6YNrWZWQdU2YrtOe/Q
	5STpDs=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B437545CA9
	for <cygwin-patches@cygwin.com>; Fri, 21 Mar 2025 19:41:27 -0400 (EDT)
Date: Fri, 21 Mar 2025 16:41:27 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/4] find_fast_cwd_pointer rewrite
Message-ID: <dd2918ee-0f21-a2e9-5427-e78be076bc5e@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_ASCII_DIVIDERS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The second patch of this series might be a little difficult to deal
with, but I included a diff of the changes from the upstream
udis86-1.7.2 tarball (retrieved from
https://downloads.sourceforge.net/udis86/udis86-1.7.2.tar.gz),
and I'm copying it again here.

diff -ur udis86-1.7.2/libudis86/decode.c udis86/decode.c
--- udis86-1.7.2/libudis86/decode.c
+++ udis86/decode.c
@@ -23,8 +23,9 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
-#include "udint.h"
+#include "winsup.h"
 #include "types.h"
+#include "udint.h"
 #include "decode.h"

 #ifndef __UD_STANDALONE__
@@ -204,7 +205,7 @@
 decode_prefixes(struct ud *u)
 {
   int done = 0;
-  uint8_t curr, last = 0;
+  uint8_t curr = 0, last = 0;
   UD_RETURN_ON_ERROR(u);

   do {
@@ -653,12 +654,12 @@
       break;
     case OP_F:
       u->br_far  = 1;
-      /* intended fall through */
+      fallthrough;
     case OP_M:
       if (MODRM_MOD(modrm(u)) == 3) {
         UDERR(u, "expected modrm.mod != 3\n");
       }
-      /* intended fall through */
+      fallthrough;
     case OP_E:
       decode_modrm_rm(u, operand, REGCLASS_GPR, size);
       break;
@@ -677,7 +678,7 @@
       if (MODRM_MOD(modrm(u)) != 3) {
         UDERR(u, "expected modrm.mod == 3\n");
       }
-      /* intended fall through */
+      fallthrough;
     case OP_Q:
       decode_modrm_rm(u, operand, REGCLASS_MMX, size);
       break;
@@ -688,7 +689,7 @@
       if (MODRM_MOD(modrm(u)) != 3) {
         UDERR(u, "expected modrm.mod == 3\n");
       }
-      /* intended fall through */
+      fallthrough;
     case OP_W:
       decode_modrm_rm(u, operand, REGCLASS_XMM, size);
       break;
diff -ur udis86-1.7.2/libudis86/decode.h udis86/decode.h
--- udis86-1.7.2/libudis86/decode.h
+++ udis86/decode.h
@@ -183,8 +183,8 @@
   return (primary_opcode & 0x02) != 0;
 }

-extern struct ud_itab_entry ud_itab[];
-extern struct ud_lookup_table_list_entry ud_lookup_table_list[];
+extern const struct ud_itab_entry ud_itab[];
+extern const struct ud_lookup_table_list_entry ud_lookup_table_list[];

 #endif /* UD_DECODE_H */

diff -ur udis86-1.7.2/libudis86/extern.h udis86/extern.h
--- udis86-1.7.2/libudis86/extern.h
+++ udis86/extern.h
@@ -60,9 +60,11 @@

 extern unsigned int ud_disassemble(struct ud*);

+#ifndef __INSIDE_CYGWIN__
 extern void ud_translate_intel(struct ud*);

 extern void ud_translate_att(struct ud*);
+#endif /* __INSIDE_CYGWIN__ */

 extern const char* ud_insn_asm(const struct ud* u);

@@ -82,7 +84,9 @@

 extern enum ud_mnemonic_code ud_insn_mnemonic(const struct ud *u);

+#ifndef __INSIDE_CYGWIN__
 extern const char* ud_lookup_mnemonic(enum ud_mnemonic_code c);
+#endif /* __INSIDE_CYGWIN__ */

 extern void ud_set_user_opaque_data(struct ud*, void*);

diff -ur udis86-1.7.2/libudis86/itab.c udis86/itab.c
--- udis86-1.7.2/libudis86/itab.c
+++ udis86/itab.c
@@ -1,4 +1,5 @@
 /* itab.c -- generated by udis86:scripts/ud_itab.py, do no edit */
+#include "winsup.h"
 #include "decode.h"

 #define GROUP(n) (0x8000 | (n))
@@ -5028,7 +5029,7 @@
 };


-struct ud_lookup_table_list_entry ud_lookup_table_list[] = {
+const struct ud_lookup_table_list_entry ud_lookup_table_list[] = {
     /* 000 */ { ud_itab__0, UD_TAB__OPC_TABLE, "table0" },
     /* 001 */ { ud_itab__1, UD_TAB__OPC_MODE, "/m" },
     /* 002 */ { ud_itab__2, UD_TAB__OPC_MODE, "/m" },
@@ -6294,7 +6295,7 @@
 #define O_sIv     { OP_sI,       SZ_V     }
 #define O_sIz     { OP_sI,       SZ_Z     }

-struct ud_itab_entry ud_itab[] = {
+const struct ud_itab_entry ud_itab[] = {
   /* 0000 */ { UD_Iinvalid, O_NONE, O_NONE, O_NONE, P_none },
   /* 0001 */ { UD_Iadd, O_Eb, O_Gb, O_NONE, P_aso|P_rexr|P_rexx|P_rexb },
   /* 0002 */ { UD_Iadd, O_Ev, O_Gv, O_NONE, P_aso|P_oso|P_rexw|P_rexr|P_rexx|P_rexb },
@@ -7749,6 +7750,7 @@
 };


+#ifndef __INSIDE_CYGWIN__
 const char * ud_mnemonics_str[] = {
 "invalid",
     "3dnow",
@@ -8399,3 +8401,4 @@
     "movbe",
     "crc32"
 };
+#endif /* __INSIDE_CYGWIN__ */
diff -ur udis86-1.7.2/libudis86/itab.h udis86/itab.h
--- udis86-1.7.2/libudis86/itab.h
+++ udis86/itab.h
@@ -673,6 +673,8 @@
     UD_MAX_MNEMONIC_CODE
 } UD_ATTR_PACKED;

+#ifndef __INSIDE_CYGWIN__
 extern const char * ud_mnemonics_str[];
+#endif /* __INSIDE_CYGWIN__ */

 #endif /* UD_ITAB_H */
Only in udis86-1.7.2/libudis86/: Makefile.am
Only in udis86-1.7.2/libudis86/: Makefile.in
Only in udis86-1.7.2/libudis86/: syn.c
Only in udis86-1.7.2/libudis86/: syn.h
Only in udis86-1.7.2/libudis86/: syn-att.c
Only in udis86-1.7.2/libudis86/: syn-intel.c
diff -ur udis86-1.7.2/libudis86/types.h udis86/types.h
--- udis86-1.7.2/libudis86/types.h
+++ udis86/types.h
@@ -36,6 +36,14 @@
 #endif
 #endif /* __KERNEL__ */

+#ifdef __INSIDE_CYGWIN__
+# include <inttypes.h>
+# ifndef __UD_STANDALONE__
+#  define __UD_STANDALONE__ 1
+# endif
+#endif /* __INSIDE_CYGWIN__ */
+
+
 #if defined(_MSC_VER) || defined(__BORLANDC__)
 # include <stdint.h>
 # include <stdio.h>
@@ -221,8 +229,8 @@
   uint8_t   modrm;
   uint8_t   primary_opcode;
   void *    user_opaque_data;
-  struct ud_itab_entry * itab_entry;
-  struct ud_lookup_table_list_entry *le;
+  const struct ud_itab_entry * itab_entry;
+  const struct ud_lookup_table_list_entry *le;
 };

 /* -----------------------------------------------------------------------------
@@ -235,8 +243,10 @@
 typedef struct ud             ud_t;
 typedef struct ud_operand     ud_operand_t;

+#ifndef __INSIDE_CYGWIN__
 #define UD_SYN_INTEL          ud_translate_intel
 #define UD_SYN_ATT            ud_translate_att
+#endif /* __INSIDE_CYGWIN__ */
 #define UD_EOI                (-1)
 #define UD_INP_CACHE_SZ       32
 #define UD_VENDOR_AMD         0
diff -ur udis86-1.7.2/libudis86/udint.h udis86/udint.h
--- udis86-1.7.2/libudis86/udint.h
+++ udis86/udint.h
@@ -26,9 +26,11 @@
 #ifndef _UDINT_H_
 #define _UDINT_H_

-#ifdef HAVE_CONFIG_H
-# include <config.h>
-#endif /* HAVE_CONFIG_H */
+#ifndef __INSIDE_CYGWIN__
+# ifdef HAVE_CONFIG_H
+#  include <config.h>
+# endif /* HAVE_CONFIG_H */
+#endif /* __INSIDE_CYGWIN__ */

 #if defined(UD_DEBUG) && HAVE_ASSERT_H
 # include <assert.h>
diff -ur udis86-1.7.2/libudis86/udis86.c udis86/udis86.c
--- udis86-1.7.2/libudis86/udis86.c
+++ udis86/udis86.c
@@ -24,8 +24,9 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */

-#include "udint.h"
+#include "winsup.h"
 #include "extern.h"
+#include "udint.h"
 #include "decode.h"

 #if !defined(__UD_STANDALONE__)
@@ -34,6 +35,10 @@
 # endif
 #endif /* !__UD_STANDALONE__ */

+#ifdef __INSIDE_CYGWIN__
+#define sprintf __small_sprintf
+#endif /* __INSIDE_CYGWIN__ */
+
 static void ud_inp_init(struct ud *u);

 /* =============================================================================
@@ -324,6 +329,7 @@
 }


+#ifndef __INSIDE_CYGWIN__
 /* =============================================================================
  * ud_lookup_mnemonic
  *    Looks up mnemonic code in the mnemonic string table.
@@ -339,6 +345,7 @@
     return NULL;
   }
 }
+#endif /* __INSIDE_CYGWIN__ */


 /*

Jeremy Drake (4):
  Cygwin: factor out find_fast_cwd_pointer to arch-specific file.
  Cygwin: vendor libudis86 1.7.2
  Cygwin: use udis86 to find fast cwd pointer on x64
  Cygwin: add find_fast_cwd_pointer_aarch64.

 winsup/cygwin/Makefile.am                     |   14 +-
 winsup/cygwin/fastcwd_aarch64.cc              |  185 +
 winsup/cygwin/path.cc                         |  145 +-
 winsup/cygwin/udis86/decode.c                 | 1113 +++
 winsup/cygwin/udis86/decode.h                 |  195 +
 winsup/cygwin/udis86/extern.h                 |  109 +
 winsup/cygwin/udis86/itab.c                   | 8404 +++++++++++++++++
 winsup/cygwin/udis86/itab.h                   |  680 ++
 winsup/cygwin/udis86/types.h                  |  260 +
 winsup/cygwin/udis86/udint.h                  |   91 +
 .../cygwin/udis86/udis86-modifications.diff   |  252 +
 winsup/cygwin/udis86/udis86.c                 |  464 +
 winsup/cygwin/x86_64/fastcwd_x86_64.cc        |  159 +
 13 files changed, 11948 insertions(+), 123 deletions(-)
 create mode 100644 winsup/cygwin/fastcwd_aarch64.cc
 create mode 100644 winsup/cygwin/udis86/decode.c
 create mode 100644 winsup/cygwin/udis86/decode.h
 create mode 100644 winsup/cygwin/udis86/extern.h
 create mode 100644 winsup/cygwin/udis86/itab.c
 create mode 100644 winsup/cygwin/udis86/itab.h
 create mode 100644 winsup/cygwin/udis86/types.h
 create mode 100644 winsup/cygwin/udis86/udint.h
 create mode 100644 winsup/cygwin/udis86/udis86-modifications.diff
 create mode 100644 winsup/cygwin/udis86/udis86.c
 create mode 100644 winsup/cygwin/x86_64/fastcwd_x86_64.cc

-- 
2.48.1.windows.1

