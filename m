Return-Path: <SRS0=qRO6=WN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3982E3AA88AD
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 23:51:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3982E3AA88AD
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3982E3AA88AD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743033094; cv=none;
	b=NKs6GLlMIpEe4J/LiuOtFo0GfBnQl+XvGNpngmxQHDwr3c00+i3U1zG58rP7uwaacJzxgqhncQ5KZ5oKJTMte1INQ91r+dBfied4ICN7QnlO8K870jBjg5YPf5P8d5ZX0ffEDdNjpSqwmK1SoBSXkXfEXmwOBDc3Y0sFSG++XoU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743033094; c=relaxed/simple;
	bh=5vzqIybOxeYRZgOXkuuoZZXO+UvcnO0lg8Wu3tDwLxE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=hkHLsLLiJ6s3aIYbrQnxFJXXAtMQSMGbn4Xcu0uy2M1GdWaD5kRSxGd5q6L0v3/U0aMawaALu+/Gux9nEFq83BaXm6Fzb7TC3ENdS23+At/POZqCVjvEIjZxd7eIZhxda55g9+JVb5BfPaxv1fwj7ix0pYhLXYUhhPqJ8nB7AKM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3982E3AA88AD
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=gL4vXjac
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id E3F0745CB6
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 19:51:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=zPpns
	fkP8CUwuHFa5Fo1ZQkeOqw=; b=gL4vXjacU6nMH9ZCU4XKiOX6RLOpIuOms/hQP
	XChAgBPRuj18rqlC0pbKIAvWFKlXRMCd5nwnlbXpAbYtqRKOE9AyuJ1IxZBZ+7t8
	1+uR74zqJrkeGCUReAhczbxOYpZU6QfhYJwRlQCkATGKY18OrnRqduH2jYUMZEsB
	D7shZA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C7BF645CB2
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 19:51:33 -0400 (EDT)
Date: Wed, 26 Mar 2025 16:51:33 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/5] Cygwin: patch libudis86 to build as part of Cygwin
Message-ID: <cef26de9-2a63-643a-db42-8b890dfe5161@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_ASCII_DIVIDERS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeremy Drake <cygwin@jdrake.com>

This ifdefs out the large table of
opcode strings (and the function that references it) since we're only
interested in walking machine code, not generating disassembly, and
makes a couple of other tables "const" so that they end up in .rdata
instead of .data.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/Makefile.am     | 12 ++++++++++--
 winsup/cygwin/udis86/decode.c | 13 +++++++------
 winsup/cygwin/udis86/decode.h |  4 ++--
 winsup/cygwin/udis86/extern.h |  4 ++++
 winsup/cygwin/udis86/itab.c   |  7 +++++--
 winsup/cygwin/udis86/itab.h   |  2 ++
 winsup/cygwin/udis86/types.h  | 14 ++++++++++++--
 winsup/cygwin/udis86/udint.h  |  8 +++++---
 winsup/cygwin/udis86/udis86.c |  9 ++++++++-
 9 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 9ede4249e3..8ecf25d343 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -48,7 +48,6 @@ LIB_NAME=libcygwin.a
 # sources
 #

-# These objects are included directly into the import library
 if TARGET_X86_64
 TARGET_FILES= \
 	x86_64/bcopy.S \
@@ -64,6 +63,7 @@ TARGET_FILES= \
 	x86_64/wmempcpy.S
 endif

+# These objects are included directly into the import library
 LIB_FILES= \
 	lib/_cygwin_crt0_common.cc \
 	lib/atexit.c \
@@ -267,6 +267,13 @@ SEC_FILES= \
 TZCODE_FILES= \
 	tzcode/localtime_wrapper.c

+if TARGET_X86_64
+UDIS86_FILES= \
+	udis86/decode.c \
+	udis86/itab.c \
+	udis86/udis86.c
+endif
+
 DLL_FILES= \
 	advapi32.cc \
 	aio.cc \
@@ -389,6 +396,7 @@ libdll_a_SOURCES= \
 	$(MM_FILES) \
 	$(SEC_FILES) \
 	$(TZCODE_FILES) \
+	$(UDIS86_FILES) \
 	$(GENERATED_FILES)

 #
@@ -423,7 +431,7 @@ BUILT_SOURCES = \

 # Every time we touch a source file, the version info has to be rebuilt
 # to maintain a correct build date, especially in uname release output
-dirs = $(srcdir) $(srcdir)/fhandler $(srcdir)/lib $(srcdir)/libc $(srcdir)/math $(srcdir)/mm $(srcdir)/regex $(srcdir)/sec $(srcdir)/tzcode
+dirs = $(srcdir) $(srcdir)/fhandler $(srcdir)/lib $(srcdir)/libc $(srcdir)/math $(srcdir)/mm $(srcdir)/regex $(srcdir)/sec $(srcdir)/tzcode $(srcdir)/udis86
 find_src_files = $(wildcard $(dir)/*.[chS]) $(wildcard $(dir)/*.cc)
 src_files := $(foreach dir,$(dirs),$(find_src_files))

diff --git a/winsup/cygwin/udis86/decode.c b/winsup/cygwin/udis86/decode.c
index b4efa778ca..1fe50e19f6 100644
--- a/winsup/cygwin/udis86/decode.c
+++ b/winsup/cygwin/udis86/decode.c
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
@@ -204,7 +205,7 @@ static int
 decode_prefixes(struct ud *u)
 {
   int done = 0;
-  uint8_t curr, last = 0;
+  uint8_t curr = 0, last = 0;
   UD_RETURN_ON_ERROR(u);

   do {
@@ -653,12 +654,12 @@ decode_operand(struct ud           *u,
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
@@ -677,7 +678,7 @@ decode_operand(struct ud           *u,
       if (MODRM_MOD(modrm(u)) != 3) {
         UDERR(u, "expected modrm.mod == 3\n");
       }
-      /* intended fall through */
+      fallthrough;
     case OP_Q:
       decode_modrm_rm(u, operand, REGCLASS_MMX, size);
       break;
@@ -688,7 +689,7 @@ decode_operand(struct ud           *u,
       if (MODRM_MOD(modrm(u)) != 3) {
         UDERR(u, "expected modrm.mod == 3\n");
       }
-      /* intended fall through */
+      fallthrough;
     case OP_W:
       decode_modrm_rm(u, operand, REGCLASS_XMM, size);
       break;
diff --git a/winsup/cygwin/udis86/decode.h b/winsup/cygwin/udis86/decode.h
index a7362c84a4..8d1af5705c 100644
--- a/winsup/cygwin/udis86/decode.h
+++ b/winsup/cygwin/udis86/decode.h
@@ -183,8 +183,8 @@ ud_opcode_field_sext(uint8_t primary_opcode)
   return (primary_opcode & 0x02) != 0;
 }

-extern struct ud_itab_entry ud_itab[];
-extern struct ud_lookup_table_list_entry ud_lookup_table_list[];
+extern const struct ud_itab_entry ud_itab[];
+extern const struct ud_lookup_table_list_entry ud_lookup_table_list[];

 #endif /* UD_DECODE_H */

diff --git a/winsup/cygwin/udis86/extern.h b/winsup/cygwin/udis86/extern.h
index ae9f82f225..0a5e892237 100644
--- a/winsup/cygwin/udis86/extern.h
+++ b/winsup/cygwin/udis86/extern.h
@@ -60,9 +60,11 @@ extern unsigned int ud_decode(struct ud*);

 extern unsigned int ud_disassemble(struct ud*);

+#ifndef __INSIDE_CYGWIN__
 extern void ud_translate_intel(struct ud*);

 extern void ud_translate_att(struct ud*);
+#endif /* __INSIDE_CYGWIN__ */

 extern const char* ud_insn_asm(const struct ud* u);

@@ -82,7 +84,9 @@ extern int ud_opr_is_gpr(const struct ud_operand *opr);

 extern enum ud_mnemonic_code ud_insn_mnemonic(const struct ud *u);

+#ifndef __INSIDE_CYGWIN__
 extern const char* ud_lookup_mnemonic(enum ud_mnemonic_code c);
+#endif /* __INSIDE_CYGWIN__ */

 extern void ud_set_user_opaque_data(struct ud*, void*);

diff --git a/winsup/cygwin/udis86/itab.c b/winsup/cygwin/udis86/itab.c
index a3d0634b86..11c350b78e 100644
--- a/winsup/cygwin/udis86/itab.c
+++ b/winsup/cygwin/udis86/itab.c
@@ -1,4 +1,5 @@
 /* itab.c -- generated by udis86:scripts/ud_itab.py, do no edit */
+#include "winsup.h"
 #include "decode.h"

 #define GROUP(n) (0x8000 | (n))
@@ -5028,7 +5029,7 @@ const uint16_t ud_itab__0[] = {
 };


-struct ud_lookup_table_list_entry ud_lookup_table_list[] = {
+const struct ud_lookup_table_list_entry ud_lookup_table_list[] = {
     /* 000 */ { ud_itab__0, UD_TAB__OPC_TABLE, "table0" },
     /* 001 */ { ud_itab__1, UD_TAB__OPC_MODE, "/m" },
     /* 002 */ { ud_itab__2, UD_TAB__OPC_MODE, "/m" },
@@ -6294,7 +6295,7 @@ struct ud_lookup_table_list_entry ud_lookup_table_list[] = {
 #define O_sIv     { OP_sI,       SZ_V     }
 #define O_sIz     { OP_sI,       SZ_Z     }

-struct ud_itab_entry ud_itab[] = {
+const struct ud_itab_entry ud_itab[] = {
   /* 0000 */ { UD_Iinvalid, O_NONE, O_NONE, O_NONE, P_none },
   /* 0001 */ { UD_Iadd, O_Eb, O_Gb, O_NONE, P_aso|P_rexr|P_rexx|P_rexb },
   /* 0002 */ { UD_Iadd, O_Ev, O_Gv, O_NONE, P_aso|P_oso|P_rexw|P_rexr|P_rexx|P_rexb },
@@ -7749,6 +7750,7 @@ struct ud_itab_entry ud_itab[] = {
 };


+#ifndef __INSIDE_CYGWIN__
 const char * ud_mnemonics_str[] = {
 "invalid",
     "3dnow",
@@ -8399,3 +8401,4 @@ const char * ud_mnemonics_str[] = {
     "movbe",
     "crc32"
 };
+#endif /* __INSIDE_CYGWIN__ */
diff --git a/winsup/cygwin/udis86/itab.h b/winsup/cygwin/udis86/itab.h
index 778a76d610..b6924b747a 100644
--- a/winsup/cygwin/udis86/itab.h
+++ b/winsup/cygwin/udis86/itab.h
@@ -673,6 +673,8 @@ enum ud_mnemonic_code {
     UD_MAX_MNEMONIC_CODE
 } UD_ATTR_PACKED;

+#ifndef __INSIDE_CYGWIN__
 extern const char * ud_mnemonics_str[];
+#endif /* __INSIDE_CYGWIN__ */

 #endif /* UD_ITAB_H */
diff --git a/winsup/cygwin/udis86/types.h b/winsup/cygwin/udis86/types.h
index 8b012a98e6..2d2dc683c1 100644
--- a/winsup/cygwin/udis86/types.h
+++ b/winsup/cygwin/udis86/types.h
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
@@ -221,8 +229,8 @@ struct ud
   uint8_t   modrm;
   uint8_t   primary_opcode;
   void *    user_opaque_data;
-  struct ud_itab_entry * itab_entry;
-  struct ud_lookup_table_list_entry *le;
+  const struct ud_itab_entry * itab_entry;
+  const struct ud_lookup_table_list_entry *le;
 };

 /* -----------------------------------------------------------------------------
@@ -235,8 +243,10 @@ typedef enum ud_mnemonic_code ud_mnemonic_code_t;
 typedef struct ud             ud_t;
 typedef struct ud_operand     ud_operand_t;

+#ifndef __INSIDE_CYGWIN__
 #define UD_SYN_INTEL          ud_translate_intel
 #define UD_SYN_ATT            ud_translate_att
+#endif /* __INSIDE_CYGWIN__ */
 #define UD_EOI                (-1)
 #define UD_INP_CACHE_SZ       32
 #define UD_VENDOR_AMD         0
diff --git a/winsup/cygwin/udis86/udint.h b/winsup/cygwin/udis86/udint.h
index 2908b613b6..29695476ec 100644
--- a/winsup/cygwin/udis86/udint.h
+++ b/winsup/cygwin/udis86/udint.h
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
diff --git a/winsup/cygwin/udis86/udis86.c b/winsup/cygwin/udis86/udis86.c
index d62af1f3df..53db032b90 100644
--- a/winsup/cygwin/udis86/udis86.c
+++ b/winsup/cygwin/udis86/udis86.c
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
@@ -324,6 +329,7 @@ ud_insn_mnemonic(const struct ud *u)
 }


+#ifndef __INSIDE_CYGWIN__
 /* =============================================================================
  * ud_lookup_mnemonic
  *    Looks up mnemonic code in the mnemonic string table.
@@ -339,6 +345,7 @@ ud_lookup_mnemonic(enum ud_mnemonic_code c)
     return NULL;
   }
 }
+#endif /* __INSIDE_CYGWIN__ */


 /*
-- 
2.48.1.windows.1

