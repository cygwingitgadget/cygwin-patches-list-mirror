Return-Path: <SRS0=qRO6=WN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 7D334385AC1D
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 23:45:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7D334385AC1D
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7D334385AC1D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743032712; cv=none;
	b=CJIXC5ysmUEjbWNFGsR4mWlLuUneiZCCWDK7uCcdn3uL1zyLTQoTVGEZbPONQ7XPry6bkG3hALBoFDrA2b4MUGbY+f6J1ML0qJUzqWX4SqG9Lbo3J9D5Ooux4RD3hLH3it4qqXb9S36EJUo9q39hDHRkoOmx0GG8yd/1Ehluqas=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743032712; c=relaxed/simple;
	bh=9H+8ot3en22yPobvNRluVrNMj6+AEMIpwU7vqO9mfVk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=bysI8RjFn+wCmFPjangnahWcXnKDTQ2zEh1PbK7W9IF863KrKKFRUVhJG5M0MH3Fy396SFk9meM089KFnuov29eXJBjpnIZhXUR7dZ+UDJ7TbhwMSAPfryeBiyNzqWiFiErEGZlow5YUGuTsYWkK3HnatJPMHJsjXYaOvwU9En8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7D334385AC1D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=D4A7SsrC
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id DE8BB45CB6
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 19:45:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=wiW+IZ2Wfb6nZyFzpFMcBjzqcIg=; b=D4A7S
	srC+qoXTjqdRXzeDtVPH3loeJEgSeszhMb9LX9gN2SokzY1bcQXDQtcyZ8MANCBe
	jSSYnUCx8avXs9VPa7Li5VEqbo3lN8oRVlFXmBOt3XLPBJBwtfB9QNyddwP9Caxd
	hxsj4tZi0s0oh1LA3weqIhL82aBc50pAmACrQI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D784345CB2
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 19:45:11 -0400 (EDT)
Date: Wed, 26 Mar 2025 16:45:11 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <dd2918ee-0f21-a2e9-5427-e78be076bc5e@jdrake.com>
Message-ID: <3e7c52d1-01ef-4843-23a4-18f69da1ecea@jdrake.com>
References: <dd2918ee-0f21-a2e9-5427-e78be076bc5e@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_ASCII_DIVIDERS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2 splits the vendoring of libudis86 into importing the original files and
then patching them (and adding them to Makefile.am at that point).  It
also has both x86_64 and aarch64 implementations exit loops on rets or
unconditional jumps.

Jeremy Drake (5):
  Cygwin: factor out find_fast_cwd_pointer to arch-specific file.
  Cygwin: vendor libudis86 1.7.2/libudis86
  Cygwin: patch libudis86 to build as part of Cygwin
  Cygwin: use udis86 to find fast cwd pointer on x64
  Cygwin: add find_fast_cwd_pointer_aarch64.

 winsup/cygwin/Makefile.am              |   14 +-
 winsup/cygwin/fastcwd_aarch64.cc       |  203 +
 winsup/cygwin/path.cc                  |  145 +-
 winsup/cygwin/udis86/decode.c          | 1113 ++++
 winsup/cygwin/udis86/decode.h          |  195 +
 winsup/cygwin/udis86/extern.h          |  109 +
 winsup/cygwin/udis86/itab.c            | 8404 ++++++++++++++++++++++++
 winsup/cygwin/udis86/itab.h            |  680 ++
 winsup/cygwin/udis86/types.h           |  260 +
 winsup/cygwin/udis86/udint.h           |   91 +
 winsup/cygwin/udis86/udis86.c          |  464 ++
 winsup/cygwin/x86_64/fastcwd_x86_64.cc |  172 +
 12 files changed, 11727 insertions(+), 123 deletions(-)
 create mode 100644 winsup/cygwin/fastcwd_aarch64.cc
 create mode 100644 winsup/cygwin/udis86/decode.c
 create mode 100644 winsup/cygwin/udis86/decode.h
 create mode 100644 winsup/cygwin/udis86/extern.h
 create mode 100644 winsup/cygwin/udis86/itab.c
 create mode 100644 winsup/cygwin/udis86/itab.h
 create mode 100644 winsup/cygwin/udis86/types.h
 create mode 100644 winsup/cygwin/udis86/udint.h
 create mode 100644 winsup/cygwin/udis86/udis86.c
 create mode 100644 winsup/cygwin/x86_64/fastcwd_x86_64.cc

Range-diff against v1:
1:  fc59147412 = 1:  25a8b233f5 Cygwin: factor out find_fast_cwd_pointer to arch-specific file.
2:  5b5bccfc81 ! 2:  faa2688d1f Cygwin: vendor libudis86 1.7.2
    @@ Metadata
     Author: Jeremy Drake <cygwin@jdrake.com>

      ## Commit message ##
    -    Cygwin: vendor libudis86 1.7.2
    +    Cygwin: vendor libudis86 1.7.2/libudis86

         This does not include the source files responsible for generating AT&T-
    -    or Intel-syntax assembly output, and ifdefs out the large table of
    -    opcode strings since we're only interested in walking machine code, not
    -    generating disassembly.
    -
    -    Also included is a diff from the original libudis86 sources.
    +    or Intel-syntax assembly output, or upstream's Makefile.{am,in}.

         Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

    - ## winsup/cygwin/Makefile.am ##
    -@@ winsup/cygwin/Makefile.am: LIB_NAME=libcygwin.a
    - # sources
    - #
    -
    --# These objects are included directly into the import library
    - if TARGET_X86_64
    - TARGET_FILES= \
    - 	x86_64/bcopy.S \
    -@@ winsup/cygwin/Makefile.am: TARGET_FILES= \
    - 	x86_64/wmempcpy.S
    - endif
    -
    -+# These objects are included directly into the import library
    - LIB_FILES= \
    - 	lib/_cygwin_crt0_common.cc \
    - 	lib/atexit.c \
    -@@ winsup/cygwin/Makefile.am: SEC_FILES= \
    - TZCODE_FILES= \
    - 	tzcode/localtime_wrapper.c
    -
    -+if TARGET_X86_64
    -+UDIS86_FILES= \
    -+	udis86/decode.c \
    -+	udis86/itab.c \
    -+	udis86/udis86.c
    -+endif
    -+
    - DLL_FILES= \
    - 	advapi32.cc \
    - 	aio.cc \
    -@@ winsup/cygwin/Makefile.am: libdll_a_SOURCES= \
    - 	$(MM_FILES) \
    - 	$(SEC_FILES) \
    - 	$(TZCODE_FILES) \
    -+	$(UDIS86_FILES) \
    - 	$(GENERATED_FILES)
    -
    - #
    -@@ winsup/cygwin/Makefile.am: BUILT_SOURCES = \
    -
    - # Every time we touch a source file, the version info has to be rebuilt
    - # to maintain a correct build date, especially in uname release output
    --dirs = $(srcdir) $(srcdir)/fhandler $(srcdir)/lib $(srcdir)/libc $(srcdir)/math $(srcdir)/mm $(srcdir)/regex $(srcdir)/sec $(srcdir)/tzcode
    -+dirs = $(srcdir) $(srcdir)/fhandler $(srcdir)/lib $(srcdir)/libc $(srcdir)/math $(srcdir)/mm $(srcdir)/regex $(srcdir)/sec $(srcdir)/tzcode $(srcdir)/udis86
    - find_src_files = $(wildcard $(dir)/*.[chS]) $(wildcard $(dir)/*.cc)
    - src_files := $(foreach dir,$(dirs),$(find_src_files))
    -
    -
      ## winsup/cygwin/udis86/decode.c (new) ##
     @@
     +/* udis86 - libudis86/decode.c
    @@ winsup/cygwin/udis86/decode.c (new)
     + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
     + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     + */
    -+#include "winsup.h"
    -+#include "types.h"
     +#include "udint.h"
    ++#include "types.h"
     +#include "decode.h"
     +
     +#ifndef __UD_STANDALONE__
    @@ winsup/cygwin/udis86/decode.c (new)
     +decode_prefixes(struct ud *u)
     +{
     +  int done = 0;
    -+  uint8_t curr = 0, last = 0;
    ++  uint8_t curr, last = 0;
     +  UD_RETURN_ON_ERROR(u);
     +
     +  do {
    @@ winsup/cygwin/udis86/decode.c (new)
     +      break;
     +    case OP_F:
     +      u->br_far  = 1;
    -+      fallthrough;
    ++      /* intended fall through */
     +    case OP_M:
     +      if (MODRM_MOD(modrm(u)) == 3) {
     +        UDERR(u, "expected modrm.mod != 3\n");
     +      }
    -+      fallthrough;
    ++      /* intended fall through */
     +    case OP_E:
     +      decode_modrm_rm(u, operand, REGCLASS_GPR, size);
     +      break;
    @@ winsup/cygwin/udis86/decode.c (new)
     +      if (MODRM_MOD(modrm(u)) != 3) {
     +        UDERR(u, "expected modrm.mod == 3\n");
     +      }
    -+      fallthrough;
    ++      /* intended fall through */
     +    case OP_Q:
     +      decode_modrm_rm(u, operand, REGCLASS_MMX, size);
     +      break;
    @@ winsup/cygwin/udis86/decode.c (new)
     +      if (MODRM_MOD(modrm(u)) != 3) {
     +        UDERR(u, "expected modrm.mod == 3\n");
     +      }
    -+      fallthrough;
    ++      /* intended fall through */
     +    case OP_W:
     +      decode_modrm_rm(u, operand, REGCLASS_XMM, size);
     +      break;
    @@ winsup/cygwin/udis86/decode.h (new)
     +  return (primary_opcode & 0x02) != 0;
     +}
     +
    -+extern const struct ud_itab_entry ud_itab[];
    -+extern const struct ud_lookup_table_list_entry ud_lookup_table_list[];
    ++extern struct ud_itab_entry ud_itab[];
    ++extern struct ud_lookup_table_list_entry ud_lookup_table_list[];
     +
     +#endif /* UD_DECODE_H */
     +
    @@ winsup/cygwin/udis86/extern.h (new)
     +
     +extern unsigned int ud_disassemble(struct ud*);
     +
    -+#ifndef __INSIDE_CYGWIN__
     +extern void ud_translate_intel(struct ud*);
     +
     +extern void ud_translate_att(struct ud*);
    -+#endif /* __INSIDE_CYGWIN__ */
     +
     +extern const char* ud_insn_asm(const struct ud* u);
     +
    @@ winsup/cygwin/udis86/extern.h (new)
     +
     +extern enum ud_mnemonic_code ud_insn_mnemonic(const struct ud *u);
     +
    -+#ifndef __INSIDE_CYGWIN__
     +extern const char* ud_lookup_mnemonic(enum ud_mnemonic_code c);
    -+#endif /* __INSIDE_CYGWIN__ */
     +
     +extern void ud_set_user_opaque_data(struct ud*, void*);
     +
    @@ winsup/cygwin/udis86/extern.h (new)
      ## winsup/cygwin/udis86/itab.c (new) ##
     @@
     +/* itab.c -- generated by udis86:scripts/ud_itab.py, do no edit */
    -+#include "winsup.h"
     +#include "decode.h"
     +
     +#define GROUP(n) (0x8000 | (n))
    @@ winsup/cygwin/udis86/itab.c (new)
     +};
     +
     +
    -+const struct ud_lookup_table_list_entry ud_lookup_table_list[] = {
    ++struct ud_lookup_table_list_entry ud_lookup_table_list[] = {
     +    /* 000 */ { ud_itab__0, UD_TAB__OPC_TABLE, "table0" },
     +    /* 001 */ { ud_itab__1, UD_TAB__OPC_MODE, "/m" },
     +    /* 002 */ { ud_itab__2, UD_TAB__OPC_MODE, "/m" },
    @@ winsup/cygwin/udis86/itab.c (new)
     +#define O_sIv     { OP_sI,       SZ_V     }
     +#define O_sIz     { OP_sI,       SZ_Z     }
     +
    -+const struct ud_itab_entry ud_itab[] = {
    ++struct ud_itab_entry ud_itab[] = {
     +  /* 0000 */ { UD_Iinvalid, O_NONE, O_NONE, O_NONE, P_none },
     +  /* 0001 */ { UD_Iadd, O_Eb, O_Gb, O_NONE, P_aso|P_rexr|P_rexx|P_rexb },
     +  /* 0002 */ { UD_Iadd, O_Ev, O_Gv, O_NONE, P_aso|P_oso|P_rexw|P_rexr|P_rexx|P_rexb },
    @@ winsup/cygwin/udis86/itab.c (new)
     +};
     +
     +
    -+#ifndef __INSIDE_CYGWIN__
     +const char * ud_mnemonics_str[] = {
     +"invalid",
     +    "3dnow",
    @@ winsup/cygwin/udis86/itab.c (new)
     +    "movbe",
     +    "crc32"
     +};
    -+#endif /* __INSIDE_CYGWIN__ */

      ## winsup/cygwin/udis86/itab.h (new) ##
     @@
    @@ winsup/cygwin/udis86/itab.h (new)
     +    UD_MAX_MNEMONIC_CODE
     +} UD_ATTR_PACKED;
     +
    -+#ifndef __INSIDE_CYGWIN__
     +extern const char * ud_mnemonics_str[];
    -+#endif /* __INSIDE_CYGWIN__ */
     +
     +#endif /* UD_ITAB_H */

    @@ winsup/cygwin/udis86/types.h (new)
     +#endif
     +#endif /* __KERNEL__ */
     +
    -+#ifdef __INSIDE_CYGWIN__
    -+# include <inttypes.h>
    -+# ifndef __UD_STANDALONE__
    -+#  define __UD_STANDALONE__ 1
    -+# endif
    -+#endif /* __INSIDE_CYGWIN__ */
    -+
    -+
     +#if defined(_MSC_VER) || defined(__BORLANDC__)
     +# include <stdint.h>
     +# include <stdio.h>
    @@ winsup/cygwin/udis86/types.h (new)
     +  uint8_t   modrm;
     +  uint8_t   primary_opcode;
     +  void *    user_opaque_data;
    -+  const struct ud_itab_entry * itab_entry;
    -+  const struct ud_lookup_table_list_entry *le;
    ++  struct ud_itab_entry * itab_entry;
    ++  struct ud_lookup_table_list_entry *le;
     +};
     +
     +/* -----------------------------------------------------------------------------
    @@ winsup/cygwin/udis86/types.h (new)
     +typedef struct ud             ud_t;
     +typedef struct ud_operand     ud_operand_t;
     +
    -+#ifndef __INSIDE_CYGWIN__
     +#define UD_SYN_INTEL          ud_translate_intel
     +#define UD_SYN_ATT            ud_translate_att
    -+#endif /* __INSIDE_CYGWIN__ */
     +#define UD_EOI                (-1)
     +#define UD_INP_CACHE_SZ       32
     +#define UD_VENDOR_AMD         0
    @@ winsup/cygwin/udis86/udint.h (new)
     +#ifndef _UDINT_H_
     +#define _UDINT_H_
     +
    -+#ifndef __INSIDE_CYGWIN__
    -+# ifdef HAVE_CONFIG_H
    -+#  include <config.h>
    -+# endif /* HAVE_CONFIG_H */
    -+#endif /* __INSIDE_CYGWIN__ */
    ++#ifdef HAVE_CONFIG_H
    ++# include <config.h>
    ++#endif /* HAVE_CONFIG_H */
     +
     +#if defined(UD_DEBUG) && HAVE_ASSERT_H
     +# include <assert.h>
    @@ winsup/cygwin/udis86/udint.h (new)
     +
     +#endif /* _UDINT_H_ */

    - ## winsup/cygwin/udis86/udis86-modifications.diff (new) ##
    -@@
    -+diff -ur udis86-1.7.2/libudis86/decode.c udis86/decode.c
    -+--- udis86-1.7.2/libudis86/decode.c
    -++++ udis86/decode.c
    -+@@ -23,8 +23,9 @@
    -+  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    -+  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    -+  */
    -+-#include "udint.h"
    -++#include "winsup.h"
    -+ #include "types.h"
    -++#include "udint.h"
    -+ #include "decode.h"
    -+
    -+ #ifndef __UD_STANDALONE__
    -+@@ -204,7 +205,7 @@
    -+ decode_prefixes(struct ud *u)
    -+ {
    -+   int done = 0;
    -+-  uint8_t curr, last = 0;
    -++  uint8_t curr = 0, last = 0;
    -+   UD_RETURN_ON_ERROR(u);
    -+
    -+   do {
    -+@@ -653,12 +654,12 @@
    -+       break;
    -+     case OP_F:
    -+       u->br_far  = 1;
    -+-      /* intended fall through */
    -++      fallthrough;
    -+     case OP_M:
    -+       if (MODRM_MOD(modrm(u)) == 3) {
    -+         UDERR(u, "expected modrm.mod != 3\n");
    -+       }
    -+-      /* intended fall through */
    -++      fallthrough;
    -+     case OP_E:
    -+       decode_modrm_rm(u, operand, REGCLASS_GPR, size);
    -+       break;
    -+@@ -677,7 +678,7 @@
    -+       if (MODRM_MOD(modrm(u)) != 3) {
    -+         UDERR(u, "expected modrm.mod == 3\n");
    -+       }
    -+-      /* intended fall through */
    -++      fallthrough;
    -+     case OP_Q:
    -+       decode_modrm_rm(u, operand, REGCLASS_MMX, size);
    -+       break;
    -+@@ -688,7 +689,7 @@
    -+       if (MODRM_MOD(modrm(u)) != 3) {
    -+         UDERR(u, "expected modrm.mod == 3\n");
    -+       }
    -+-      /* intended fall through */
    -++      fallthrough;
    -+     case OP_W:
    -+       decode_modrm_rm(u, operand, REGCLASS_XMM, size);
    -+       break;
    -+diff -ur udis86-1.7.2/libudis86/decode.h udis86/decode.h
    -+--- udis86-1.7.2/libudis86/decode.h
    -++++ udis86/decode.h
    -+@@ -183,8 +183,8 @@
    -+   return (primary_opcode & 0x02) != 0;
    -+ }
    -+
    -+-extern struct ud_itab_entry ud_itab[];
    -+-extern struct ud_lookup_table_list_entry ud_lookup_table_list[];
    -++extern const struct ud_itab_entry ud_itab[];
    -++extern const struct ud_lookup_table_list_entry ud_lookup_table_list[];
    -+
    -+ #endif /* UD_DECODE_H */
    -+
    -+diff -ur udis86-1.7.2/libudis86/extern.h udis86/extern.h
    -+--- udis86-1.7.2/libudis86/extern.h
    -++++ udis86/extern.h
    -+@@ -60,9 +60,11 @@
    -+
    -+ extern unsigned int ud_disassemble(struct ud*);
    -+
    -++#ifndef __INSIDE_CYGWIN__
    -+ extern void ud_translate_intel(struct ud*);
    -+
    -+ extern void ud_translate_att(struct ud*);
    -++#endif /* __INSIDE_CYGWIN__ */
    -+
    -+ extern const char* ud_insn_asm(const struct ud* u);
    -+
    -+@@ -82,7 +84,9 @@
    -+
    -+ extern enum ud_mnemonic_code ud_insn_mnemonic(const struct ud *u);
    -+
    -++#ifndef __INSIDE_CYGWIN__
    -+ extern const char* ud_lookup_mnemonic(enum ud_mnemonic_code c);
    -++#endif /* __INSIDE_CYGWIN__ */
    -+
    -+ extern void ud_set_user_opaque_data(struct ud*, void*);
    -+
    -+diff -ur udis86-1.7.2/libudis86/itab.c udis86/itab.c
    -+--- udis86-1.7.2/libudis86/itab.c
    -++++ udis86/itab.c
    -+@@ -1,4 +1,5 @@
    -+ /* itab.c -- generated by udis86:scripts/ud_itab.py, do no edit */
    -++#include "winsup.h"
    -+ #include "decode.h"
    -+
    -+ #define GROUP(n) (0x8000 | (n))
    -+@@ -5028,7 +5029,7 @@
    -+ };
    -+
    -+
    -+-struct ud_lookup_table_list_entry ud_lookup_table_list[] = {
    -++const struct ud_lookup_table_list_entry ud_lookup_table_list[] = {
    -+     /* 000 */ { ud_itab__0, UD_TAB__OPC_TABLE, "table0" },
    -+     /* 001 */ { ud_itab__1, UD_TAB__OPC_MODE, "/m" },
    -+     /* 002 */ { ud_itab__2, UD_TAB__OPC_MODE, "/m" },
    -+@@ -6294,7 +6295,7 @@
    -+ #define O_sIv     { OP_sI,       SZ_V     }
    -+ #define O_sIz     { OP_sI,       SZ_Z     }
    -+
    -+-struct ud_itab_entry ud_itab[] = {
    -++const struct ud_itab_entry ud_itab[] = {
    -+   /* 0000 */ { UD_Iinvalid, O_NONE, O_NONE, O_NONE, P_none },
    -+   /* 0001 */ { UD_Iadd, O_Eb, O_Gb, O_NONE, P_aso|P_rexr|P_rexx|P_rexb },
    -+   /* 0002 */ { UD_Iadd, O_Ev, O_Gv, O_NONE, P_aso|P_oso|P_rexw|P_rexr|P_rexx|P_rexb },
    -+@@ -7749,6 +7750,7 @@
    -+ };
    -+
    -+
    -++#ifndef __INSIDE_CYGWIN__
    -+ const char * ud_mnemonics_str[] = {
    -+ "invalid",
    -+     "3dnow",
    -+@@ -8399,3 +8401,4 @@
    -+     "movbe",
    -+     "crc32"
    -+ };
    -++#endif /* __INSIDE_CYGWIN__ */
    -+diff -ur udis86-1.7.2/libudis86/itab.h udis86/itab.h
    -+--- udis86-1.7.2/libudis86/itab.h
    -++++ udis86/itab.h
    -+@@ -673,6 +673,8 @@
    -+     UD_MAX_MNEMONIC_CODE
    -+ } UD_ATTR_PACKED;
    -+
    -++#ifndef __INSIDE_CYGWIN__
    -+ extern const char * ud_mnemonics_str[];
    -++#endif /* __INSIDE_CYGWIN__ */
    -+
    -+ #endif /* UD_ITAB_H */
    -+Only in udis86-1.7.2/libudis86/: Makefile.am
    -+Only in udis86-1.7.2/libudis86/: Makefile.in
    -+Only in udis86-1.7.2/libudis86/: syn.c
    -+Only in udis86-1.7.2/libudis86/: syn.h
    -+Only in udis86-1.7.2/libudis86/: syn-att.c
    -+Only in udis86-1.7.2/libudis86/: syn-intel.c
    -+diff -ur udis86-1.7.2/libudis86/types.h udis86/types.h
    -+--- udis86-1.7.2/libudis86/types.h
    -++++ udis86/types.h
    -+@@ -36,6 +36,14 @@
    -+ #endif
    -+ #endif /* __KERNEL__ */
    -+
    -++#ifdef __INSIDE_CYGWIN__
    -++# include <inttypes.h>
    -++# ifndef __UD_STANDALONE__
    -++#  define __UD_STANDALONE__ 1
    -++# endif
    -++#endif /* __INSIDE_CYGWIN__ */
    -++
    -++
    -+ #if defined(_MSC_VER) || defined(__BORLANDC__)
    -+ # include <stdint.h>
    -+ # include <stdio.h>
    -+@@ -221,8 +229,8 @@
    -+   uint8_t   modrm;
    -+   uint8_t   primary_opcode;
    -+   void *    user_opaque_data;
    -+-  struct ud_itab_entry * itab_entry;
    -+-  struct ud_lookup_table_list_entry *le;
    -++  const struct ud_itab_entry * itab_entry;
    -++  const struct ud_lookup_table_list_entry *le;
    -+ };
    -+
    -+ /* -----------------------------------------------------------------------------
    -+@@ -235,8 +243,10 @@
    -+ typedef struct ud             ud_t;
    -+ typedef struct ud_operand     ud_operand_t;
    -+
    -++#ifndef __INSIDE_CYGWIN__
    -+ #define UD_SYN_INTEL          ud_translate_intel
    -+ #define UD_SYN_ATT            ud_translate_att
    -++#endif /* __INSIDE_CYGWIN__ */
    -+ #define UD_EOI                (-1)
    -+ #define UD_INP_CACHE_SZ       32
    -+ #define UD_VENDOR_AMD         0
    -+diff -ur udis86-1.7.2/libudis86/udint.h udis86/udint.h
    -+--- udis86-1.7.2/libudis86/udint.h
    -++++ udis86/udint.h
    -+@@ -26,9 +26,11 @@
    -+ #ifndef _UDINT_H_
    -+ #define _UDINT_H_
    -+
    -+-#ifdef HAVE_CONFIG_H
    -+-# include <config.h>
    -+-#endif /* HAVE_CONFIG_H */
    -++#ifndef __INSIDE_CYGWIN__
    -++# ifdef HAVE_CONFIG_H
    -++#  include <config.h>
    -++# endif /* HAVE_CONFIG_H */
    -++#endif /* __INSIDE_CYGWIN__ */
    -+
    -+ #if defined(UD_DEBUG) && HAVE_ASSERT_H
    -+ # include <assert.h>
    -+diff -ur udis86-1.7.2/libudis86/udis86.c udis86/udis86.c
    -+--- udis86-1.7.2/libudis86/udis86.c
    -++++ udis86/udis86.c
    -+@@ -24,8 +24,9 @@
    -+  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    -+  */
    -+
    -+-#include "udint.h"
    -++#include "winsup.h"
    -+ #include "extern.h"
    -++#include "udint.h"
    -+ #include "decode.h"
    -+
    -+ #if !defined(__UD_STANDALONE__)
    -+@@ -34,6 +35,10 @@
    -+ # endif
    -+ #endif /* !__UD_STANDALONE__ */
    -+
    -++#ifdef __INSIDE_CYGWIN__
    -++#define sprintf __small_sprintf
    -++#endif /* __INSIDE_CYGWIN__ */
    -++
    -+ static void ud_inp_init(struct ud *u);
    -+
    -+ /* =============================================================================
    -+@@ -324,6 +329,7 @@
    -+ }
    -+
    -+
    -++#ifndef __INSIDE_CYGWIN__
    -+ /* =============================================================================
    -+  * ud_lookup_mnemonic
    -+  *    Looks up mnemonic code in the mnemonic string table.
    -+@@ -339,6 +345,7 @@
    -+     return NULL;
    -+   }
    -+ }
    -++#endif /* __INSIDE_CYGWIN__ */
    -+
    -+
    -+ /*
    -
      ## winsup/cygwin/udis86/udis86.c (new) ##
     @@
     +/* udis86 - libudis86/udis86.c
    @@ winsup/cygwin/udis86/udis86.c (new)
     + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     + */
     +
    -+#include "winsup.h"
    -+#include "extern.h"
     +#include "udint.h"
    ++#include "extern.h"
     +#include "decode.h"
     +
     +#if !defined(__UD_STANDALONE__)
    @@ winsup/cygwin/udis86/udis86.c (new)
     +# endif
     +#endif /* !__UD_STANDALONE__ */
     +
    -+#ifdef __INSIDE_CYGWIN__
    -+#define sprintf __small_sprintf
    -+#endif /* __INSIDE_CYGWIN__ */
    -+
     +static void ud_inp_init(struct ud *u);
     +
     +/* =============================================================================
    @@ winsup/cygwin/udis86/udis86.c (new)
     +}
     +
     +
    -+#ifndef __INSIDE_CYGWIN__
     +/* =============================================================================
     + * ud_lookup_mnemonic
     + *    Looks up mnemonic code in the mnemonic string table.
    @@ winsup/cygwin/udis86/udis86.c (new)
     +    return NULL;
     +  }
     +}
    -+#endif /* __INSIDE_CYGWIN__ */
     +
     +
     +/*
-:  ---------- > 3:  04f7a44f59 Cygwin: patch libudis86 to build as part of Cygwin
3:  1c712acab4 ! 4:  0f06e96562 Cygwin: use udis86 to find fast cwd pointer on x64
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc

     -#define peek32(x)	(*(int32_t *)(x))
     +static inline const void *
    -+rip_rel_offset (const ud_t *ud_obj, const ud_operand_t *opr, int additional=0)
    ++rip_rel_offset (const ud_t *ud_obj, const ud_operand_t *opr, int sub_off=0)
     +{
     +  return (const void *) (ud_insn_off (ud_obj) + ud_insn_len (ud_obj) +
    -+			 opr->lval.sdword + additional);
    ++			 opr->lval.sdword - sub_off);
     +}

      /* This function scans the code in ntdll.dll to find the address of the
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     +  ud_set_input_buffer (&ud_obj, get_dir, 80);
     +  ud_set_pc (&ud_obj, (const uint64_t) get_dir);
     +  const ud_operand_t *opr;
    ++  ud_mnemonic_code_t insn;
        /* Search first relative call instruction in RtlGetCurrentDirectory_U. */
     -  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 80);
     -  if (!rcall)
     +  const uint8_t *use_cwd = NULL;
    -+  while (ud_disassemble (&ud_obj))
    ++  while (ud_disassemble (&ud_obj) &&
    ++      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
    ++      insn != UD_Ijmp)
     +    {
    -+      if (ud_insn_mnemonic (&ud_obj) == UD_Icall)
    ++      if (insn == UD_Icall)
     +	{
     +	  opr = ud_insn_opr (&ud_obj, 0);
     +	  if (opr->type == UD_OP_JIMM && opr->size == 32)
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     +  PRTL_CRITICAL_SECTION lockaddr = NULL;
     +
     +  /* both cases have an `lea rel(%rip)` on the lock */
    -+  while (ud_disassemble (&ud_obj))
    ++  while (ud_disassemble (&ud_obj) &&
    ++      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
    ++      insn != UD_Ijmp)
          {
     -      /* The lock instruction tweaks the LockCount member, which is not at
     -	 the start of the PRTL_CRITICAL_SECTION structure.  So we have to
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     -	 near to the locking stuff. */
     -      movrbx = (const uint8_t *) memmem ((const char *) lock, 40,
     -                                         "\x48\x8b\x1d", 3);
    -+      if (ud_insn_mnemonic (&ud_obj) == UD_Ilea)
    ++      if (insn == UD_Ilea)
     +	{
     +	  /* this seems to follow intel syntax, in that operand 0 is the
     +	     dest and 1 is the src */
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     +
     +  /* Next is either the `callq RtlEnterCriticalSection', or on Windows 8,
     +     a `lock btr` */
    -+  while (ud_disassemble (&ud_obj))
    ++  bool found = false;
    ++  while (ud_disassemble (&ud_obj) &&
    ++      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
    ++      insn != UD_Ijmp)
          {
     -      /* Usually the callq RtlEnterCriticalSection follows right after
     -	 fetching the lock address. */
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     -      lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
     -                                       "\x48\x8d\x0d", 3);
     -      if (!lock)
    -+      ud_mnemonic_code_t insn = ud_insn_mnemonic (&ud_obj);
     +      if (insn == UD_Icall)
      	{
     -	  /* Windows 8.1 Preview calls `lea rel(rip),%r12' then some unrelated
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     +	    {
     +	      if (ent_crit != rip_rel_offset (&ud_obj, opr))
     +		return NULL;
    ++	      found = true;
     +	      break;
     +	    }
      	}
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     +	      opr->size == 32)
     +	    {
     +	      if (lockaddr != rip_rel_offset (&ud_obj, opr,
    -+			    -(int) offsetof (RTL_CRITICAL_SECTION, LockCount)))
    ++				  offsetof (RTL_CRITICAL_SECTION, LockCount)))
     +		return NULL;
    -+
    ++	      found = true;
     +	      break;
     +	    }
      	}
     +    }
    ++  if (!found)
    ++    return NULL;

     -      if (!lock)
     +  fcwd_access_t **f_cwd_ptr = NULL;
     +  ud_type_t reg = UD_NONE;
     +  /* now we're looking for a movq rel(%rip) */
    -+  while (ud_disassemble (&ud_obj))
    ++  while (ud_disassemble (&ud_obj) &&
    ++      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
    ++      insn != UD_Ijmp)
     +    {
    -+      if (ud_insn_mnemonic (&ud_obj) == UD_Imov)
    ++      if (insn == UD_Imov)
      	{
     -	  return NULL;
     +	  const ud_operand_t *opr0 = ud_insn_opr (&ud_obj, 0);
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     -  const uint8_t *testrbx = (const uint8_t *)
     -			   memmem (movrbx + 7, 3, "\x48\x85\xdb", 3);
     -  if (!testrbx)
    -+  if (!ud_disassemble (&ud_obj) || ud_insn_mnemonic (&ud_obj) != UD_Itest)
    ++  if (!f_cwd_ptr || !ud_disassemble (&ud_obj) ||
    ++      ud_insn_mnemonic (&ud_obj) != UD_Itest)
     +    return NULL;
     +
     +  opr = ud_insn_opr (&ud_obj, 0);
4:  56d9b81dea ! 5:  e3adc20c9f Cygwin: add find_fast_cwd_pointer_aarch64.
    @@ winsup/cygwin/fastcwd_aarch64.cc (new)
     +#endif
     +}
     +
    ++/* these ids and masks, as well as the names of the various other parts of
    ++   instructions used in this file, came from
    ++   https://developer.arm.com/documentation/ddi0602/2024-09/Index-by-Encoding
    ++   (Arm A-profile A64 Instruction Set Architecture)
    ++*/
     +#define IS_INSN(pc, name) ((*(pc) & name##_mask) == name##_id)
     +static const uint32_t add_id = 0x11000000;
     +static const uint32_t add_mask = 0x7fc00000;
     +static const uint32_t adrp_id = 0x90000000;
     +static const uint32_t adrp_mask = 0x9f000000;
    ++static const uint32_t b_id = 0x14000000;
    ++static const uint32_t b_mask = 0xfc000000;
     +static const uint32_t bl_id = 0x94000000;
     +static const uint32_t bl_mask = 0xfc000000;
     +/* matches both cbz and cbnz */
    @@ winsup/cygwin/fastcwd_aarch64.cc (new)
     +static const uint32_t cbz_mask = 0x7e000000;
     +static const uint32_t ldr_id = 0xb9400000;
     +static const uint32_t ldr_mask = 0xbfc00000;
    ++/* matches both ret and br (which are the same except ret is a 'hint' that
    ++   it's  a subroutine return */
    ++static const uint32_t ret_id = 0xd61f0000;
    ++static const uint32_t ret_mask = 0xffbffc1f;
     +
    ++/* this would work for either bl or b, but we only use it for bl */
     +static inline LPCVOID
     +extract_bl_target (const uint32_t * pc)
     +{
    -+  assert (IS_INSN (pc, bl));
    ++  assert (IS_INSN (pc, bl) || IS_INSN (pc, b));
     +  int32_t offset = *pc & ~bl_mask;
     +  /* sign extend */
     +  if (offset & (1 << 25))
    @@ winsup/cygwin/fastcwd_aarch64.cc (new)
     +fcwd_access_t **
     +find_fast_cwd_pointer_aarch64 ()
     +{
    -+  LPCVOID proc = GetArm64ProcAddress (GetModuleHandle ("ntdll"),
    -+				      "RtlGetCurrentDirectory_U");
    -+  const uint32_t *start = (uint32_t *) proc;
    ++  /* Fetch entry points of relevant functions in ntdll.dll. */
    ++  HMODULE ntdll = GetModuleHandle ("ntdll.dll");
    ++  if (!ntdll)
    ++    return NULL;
    ++  LPCVOID get_dir = GetArm64ProcAddress (ntdll, "RtlGetCurrentDirectory_U");
    ++  LPCVOID ent_crit = GetArm64ProcAddress (ntdll, "RtlEnterCriticalSection");
    ++  if (!get_dir || !ent_crit)
    ++    return NULL;
    ++
    ++  LPCVOID use_cwd = NULL;
    ++  const uint32_t *start = (const uint32_t *) get_dir;
     +  const uint32_t *pc = start;
     +  /* find the call to RtlpReferenceCurrentDirectory, and get its address */
    -+  for (; pc < start + 20; pc++)
    ++  for (; pc < start + 20 && !IS_INSN (pc, ret) && !IS_INSN (pc, b); pc++)
     +    {
     +      if (IS_INSN (pc, bl))
     +	{
    -+	  proc = extract_bl_target (pc);
    ++	  use_cwd = extract_bl_target (pc);
     +	  break;
     +	}
     +    }
    -+  if (proc == start)
    ++  if (!use_cwd)
     +    return NULL;
     +
    -+  start = pc = (uint32_t *) proc;
    ++  start = pc = (const uint32_t *) use_cwd;
     +
     +  const uint32_t *ldrpc = NULL;
     +  uint32_t ldroffset, ldrsz;
     +  uint32_t ldrrn, ldrrd;
     +
     +  /* find the ldr (immediate unsigned offset) for RtlpCurDirRef */
    -+  for (; pc < start + 20; pc++)
    ++  for (; pc < start + 20 && !IS_INSN (pc, ret) && !IS_INSN (pc, b); pc++)
     +    {
     +      if (IS_INSN (pc, ldr))
     +	{
    @@ winsup/cygwin/fastcwd_aarch64.cc (new)
     +  /* work backwards, find a bl to RtlEnterCriticalSection whose argument
     +     is the fast peb lock */
     +
    -+  proc = GetArm64ProcAddress (GetModuleHandle ("ntdll"),
    -+			      "RtlEnterCriticalSection");
     +  for (pc = ldrpc; pc >= start; pc--)
     +    {
    -+      if (IS_INSN (pc, bl) && extract_bl_target (pc) == proc)
    ++      if (IS_INSN (pc, bl) && extract_bl_target (pc) == ent_crit)
     +	break;
     +    }
     +  uint32_t addoffset;
-- 
2.48.1.windows.1

