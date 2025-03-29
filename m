Return-Path: <SRS0=rgYs=WQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id BA94E3858D1E
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 18:51:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BA94E3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BA94E3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743274283; cv=none;
	b=sgjMIYoqO0IxVIidYug05SZpSp93r/2UzCY6jkQq+xQpiVLuCibMpOezwA8/H6Q40BbBz9tXODssEkfOuLi3VBzJSjw9w4URw8342/PPocQFSE3/MOOwGQroo+EHRyg+ovuEVSnkLwth8qe8j8jUbCnA4E9Hnu1TwtXmigmeGJE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743274283; c=relaxed/simple;
	bh=PEfBtmUXQmP2mERHu5oQRO1EXVFF27cMn28iaEOPue8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=FoTbu0rBFv4WcrA97GFlKthvqEsMvFplZ1cMm0X3zV/XOl+gLKM6+UwMw/Z4LZQWCienEM6s6eFsBc0PVCf590QU7kg4ZbaTMkS36+2TMcVWQwQ48YGMWz0FX+ZQuuVRuul7a2G3L4frAnIYk7DFDVkjGweN/V7pEcGSsbF+5yw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA94E3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Xpqt3+O3
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3BD8B45CD7
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 14:51:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=aopa6319HfTock8LT4bzblJdYFo=; b=Xpqt3
	+O3n6vUaoUJ3cT70N2BV6Kg6UI+FKBfdExZmuxJpXrS/K+dVWTRqykLimKCdmHar
	JeVI7pFfLbB5S71ZSX6iLFEMNrxghtaueKniDuw5slhpSKMLwW+AMV0pWIDzgnxG
	uh6LopKPIbZylWZS8SaBBvEGufnImZDvrZzaxA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 20D7745CD6
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 14:51:23 -0400 (EDT)
Date: Sat, 29 Mar 2025 11:51:23 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <3e7c52d1-01ef-4843-23a4-18f69da1ecea@jdrake.com>
Message-ID: <20da32b5-3d5d-b5ef-1b6a-9ef181285b1a@jdrake.com>
References: <dd2918ee-0f21-a2e9-5427-e78be076bc5e@jdrake.com> <3e7c52d1-01ef-4843-23a4-18f69da1ecea@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v3:
* moves files to x86_64/fastcwd.cc and aarch64/fastcwd.cc
* reflows commit message in patch 3
* adds comments & assert to x86_64/fastcwd.cc
* removes Windows 8.0 case (I didn't realize Windows 8 was no longer supported)
* adds tracking of lea destination register to rcx for call to RtlEnterCriticalSection
* switches from memcmp to comparing the members of opr that are relevant.
* minor formatting tweaks to aarch64/fastcwd.cc

I tested x86_64 code on every released Windows version from 9600 to 26100.
Interestingly, the machine code of the "use_cwd" function
(RtlpReferenceCurrentDirectory) didn't seem to change until 26100.

(I previously tested the prototype aarch64 code on 16299, 19045, 22631,
and 26100, but only 22000+ supports x86_64 emulation).

Jeremy Drake (5):
  Cygwin: factor out find_fast_cwd_pointer to arch-specific file.
  Cygwin: vendor libudis86 1.7.2/libudis86
  Cygwin: patch libudis86 to build as part of Cygwin
  Cygwin: use udis86 to find fast cwd pointer on x64
  Cygwin: add find_fast_cwd_pointer_aarch64.

 winsup/cygwin/Makefile.am        |   14 +-
 winsup/cygwin/aarch64/fastcwd.cc |  203 +
 winsup/cygwin/path.cc            |  145 +-
 winsup/cygwin/udis86/decode.c    | 1113 ++++
 winsup/cygwin/udis86/decode.h    |  195 +
 winsup/cygwin/udis86/extern.h    |  109 +
 winsup/cygwin/udis86/itab.c      | 8404 ++++++++++++++++++++++++++++++
 winsup/cygwin/udis86/itab.h      |  680 +++
 winsup/cygwin/udis86/types.h     |  260 +
 winsup/cygwin/udis86/udint.h     |   91 +
 winsup/cygwin/udis86/udis86.c    |  464 ++
 winsup/cygwin/x86_64/fastcwd.cc  |  200 +
 12 files changed, 11755 insertions(+), 123 deletions(-)
 create mode 100644 winsup/cygwin/aarch64/fastcwd.cc
 create mode 100644 winsup/cygwin/udis86/decode.c
 create mode 100644 winsup/cygwin/udis86/decode.h
 create mode 100644 winsup/cygwin/udis86/extern.h
 create mode 100644 winsup/cygwin/udis86/itab.c
 create mode 100644 winsup/cygwin/udis86/itab.h
 create mode 100644 winsup/cygwin/udis86/types.h
 create mode 100644 winsup/cygwin/udis86/udint.h
 create mode 100644 winsup/cygwin/udis86/udis86.c
 create mode 100644 winsup/cygwin/x86_64/fastcwd.cc

Range-diff against v2:
1:  25a8b233f5 ! 1:  a1c9f722d7 Cygwin: factor out find_fast_cwd_pointer to arch-specific file.
    @@ winsup/cygwin/Makefile.am: LIB_NAME=libcygwin.a
      if TARGET_X86_64
      TARGET_FILES= \
      	x86_64/bcopy.S \
    -+	x86_64/fastcwd_x86_64.cc \
    ++	x86_64/fastcwd.cc \
      	x86_64/memchr.S \
      	x86_64/memcpy.S \
      	x86_64/memmove.S \
    @@ winsup/cygwin/path.cc: find_fast_cwd ()
          small_printf ("Cygwin WARNING:\n"
      "  Couldn't compute FAST_CWD pointer.  This typically occurs if you're using\n"

    - ## winsup/cygwin/x86_64/fastcwd_x86_64.cc (new) ##
    + ## winsup/cygwin/x86_64/fastcwd.cc (new) ##
     @@
    -+/* fastcwd_x86_64.cc: find fast cwd pointer on x86_64 hosts.
    ++/* x86_64/fastcwd.cc: find fast cwd pointer on x86_64 hosts.
     +
     +  This file is part of Cygwin.
     +
2:  faa2688d1f = 2:  1c290dbc53 Cygwin: vendor libudis86 1.7.2/libudis86
3:  04f7a44f59 ! 3:  bd2dca35eb Cygwin: patch libudis86 to build as part of Cygwin
    @@ Metadata
      ## Commit message ##
         Cygwin: patch libudis86 to build as part of Cygwin

    -    This ifdefs out the large table of
    -    opcode strings (and the function that references it) since we're only
    -    interested in walking machine code, not generating disassembly, and
    -    makes a couple of other tables "const" so that they end up in .rdata
    -    instead of .data.
    +    This ifdefs out the large table of opcode strings (and the function that
    +    references it) since we're only interested in walking machine code, not
    +    generating disassembly, and makes a couple of other tables "const" so
    +    that they end up in .rdata instead of .data.

         Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

4:  0f06e96562 ! 4:  140a61c9e1 Cygwin: use udis86 to find fast cwd pointer on x64
    @@ Commit message

         Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

    - ## winsup/cygwin/x86_64/fastcwd_x86_64.cc ##
    + ## winsup/cygwin/x86_64/fastcwd.cc ##
     @@
        details. */

      #include "winsup.h"
    ++#include <assert.h>
     +#include "udis86/types.h"
     +#include "udis86/extern.h"

      class fcwd_access_t;

     -#define peek32(x)	(*(int32_t *)(x))
    ++/* Helper function to get the absolute address of an rip-relative instruction
    ++   by summing the current instruction's pc (rip), the current instruction's
    ++   length, and the signed 32-bit displacement in the operand.  Optionally, an
    ++   additional offset is subtracted to deal with the case where a member of a
    ++   struct is being referenced by the instruction but the address of the struct
    ++   is desired.
    ++*/
     +static inline const void *
     +rip_rel_offset (const ud_t *ud_obj, const ud_operand_t *opr, int sub_off=0)
     +{
    ++  assert ((opr->type == UD_OP_JIMM && opr->size == 32) ||
    ++	  (opr->type == UD_OP_MEM && opr->base == UD_R_RIP &&
    ++	   opr->index == UD_NONE && opr->scale == 0 && opr->offset == 32));
    ++
     +  return (const void *) (ud_insn_off (ud_obj) + ud_insn_len (ud_obj) +
     +			 opr->lval.sdword - sub_off);
     +}

      /* This function scans the code in ntdll.dll to find the address of the
         global variable used to access the CWD.  While the pointer is global,
    -@@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
    +@@ winsup/cygwin/x86_64/fastcwd.cc: find_fast_cwd_pointer_x86_64 ()
      			    GetProcAddress (ntdll, "RtlEnterCriticalSection");
        if (!get_dir || !ent_crit)
          return NULL;
    ++  /* Initialize udis86 */
     +  ud_t ud_obj;
     +  ud_init (&ud_obj);
    ++  /* Set 64-bit mode */
     +  ud_set_mode (&ud_obj, 64);
     +  ud_set_input_buffer (&ud_obj, get_dir, 80);
    -+  ud_set_pc (&ud_obj, (const uint64_t) get_dir);
    -+  const ud_operand_t *opr;
    ++  /* Set pc (rip) so that subsequent calls to ud_insn_off will return the pc of
    ++     the instruction, saving us the hassle of tracking it ourselves */
    ++  ud_set_pc (&ud_obj, (uint64_t) get_dir);
    ++  const ud_operand_t *opr, *opr0;
     +  ud_mnemonic_code_t insn;
    ++  ud_type_t reg = UD_NONE;
        /* Search first relative call instruction in RtlGetCurrentDirectory_U. */
     -  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 80);
     -  if (!rcall)
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     -     performs some other actions, not important to us. */
     -  const uint8_t *use_cwd = rcall + 5 + peek32 (rcall + 1);
     +  ud_set_input_buffer (&ud_obj, use_cwd, 120);
    -+  ud_set_pc (&ud_obj, (const uint64_t) use_cwd);
    ++  ud_set_pc (&ud_obj, (uint64_t) use_cwd);
     +
        /* Next we search for the locking mechanism and perform a sanity check.
     -     On Pre-Windows 8 we basically look for the RtlEnterCriticalSection call.
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     -                        memmem ((const char *) use_cwd, 80,
     -                                "\xf0\x0f\xba\x35", 4);
     -  if (lock)
    -+     On Pre- (or Post-) Windows 8 we basically look for the
    -+     RtlEnterCriticalSection call.  Windows 8 does not call
    -+     RtlEnterCriticalSection.  The code manipulates the FastPebLock manually,
    -+     probably because RtlEnterCriticalSection has been converted to an inline
    -+     function.  Either way, we test if the code uses the FastPebLock. */
    ++     we basically look for the RtlEnterCriticalSection call and test if the
    ++     code uses the FastPebLock. */
     +  PRTL_CRITICAL_SECTION lockaddr = NULL;
     +
    -+  /* both cases have an `lea rel(%rip)` on the lock */
     +  while (ud_disassemble (&ud_obj) &&
     +      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
     +      insn != UD_Ijmp)
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     -                                         "\x48\x8b\x1d", 3);
     +      if (insn == UD_Ilea)
     +	{
    -+	  /* this seems to follow intel syntax, in that operand 0 is the
    ++	  /* udis86 seems to follow intel syntax, in that operand 0 is the
     +	     dest and 1 is the src */
    ++	  opr0 = ud_insn_opr (&ud_obj, 0);
     +	  opr = ud_insn_opr (&ud_obj, 1);
     +	  if (opr->type == UD_OP_MEM && opr->base == UD_R_RIP &&
    -+	      opr->index == UD_NONE && opr->scale == 0 && opr->offset == 32)
    ++	      opr->index == UD_NONE && opr->scale == 0 && opr->offset == 32 &&
    ++	      opr0->type == UD_OP_REG && opr0->size == 64)
     +	    {
     +	      lockaddr = (PRTL_CRITICAL_SECTION) rip_rel_offset (&ud_obj, opr);
    ++	      reg = opr0->base;
     +	      break;
     +	    }
     +	}
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     +  if (lockaddr != NtCurrentTeb ()->Peb->FastPebLock)
     +    return NULL;
     +
    -+  /* Next is either the `callq RtlEnterCriticalSection', or on Windows 8,
    -+     a `lock btr` */
    ++  /* Find where the lock address is loaded into rcx as the first parameter of
    ++     a function call */
     +  bool found = false;
    -+  while (ud_disassemble (&ud_obj) &&
    -+      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
    -+      insn != UD_Ijmp)
    ++  if (reg != UD_R_RCX)
          {
     -      /* Usually the callq RtlEnterCriticalSection follows right after
     -	 fetching the lock address. */
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     -      lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
     -                                       "\x48\x8d\x0d", 3);
     -      if (!lock)
    -+      if (insn == UD_Icall)
    ++      while (ud_disassemble (&ud_obj) &&
    ++	  (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
    ++	  insn != UD_Ijmp)
      	{
     -	  /* Windows 8.1 Preview calls `lea rel(rip),%r12' then some unrelated
     -	     ops, then `mov %r12,%rcx', then `callq RtlEnterCriticalSection'. */
     -	  lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
     -					   "\x4c\x8d\x25", 3);
     -	  call_rtl_offset = 14;
    -+	  opr = ud_insn_opr (&ud_obj, 0);
    -+	  if (opr->type == UD_OP_JIMM && opr->size == 32)
    ++	  if (insn == UD_Imov)
     +	    {
    -+	      if (ent_crit != rip_rel_offset (&ud_obj, opr))
    -+		return NULL;
    -+	      found = true;
    -+	      break;
    ++	      opr0 = ud_insn_opr (&ud_obj, 0);
    ++	      opr = ud_insn_opr (&ud_obj, 1);
    ++	      if (opr->type == UD_OP_REG && opr->size == 64 &&
    ++		  opr->base == reg && opr0->type == UD_OP_REG &&
    ++		  opr0->size == 64 && opr0->base == UD_R_RCX)
    ++		{
    ++		  found = true;
    ++		  break;
    ++		}
     +	    }
      	}
    --
    ++      if (!found)
    ++	return NULL;
    ++    }
    +
     -      if (!lock)
    -+      else if (insn == UD_Ibtr && ud_obj.pfx_lock)
    ++  /* Next is the `callq RtlEnterCriticalSection' */
    ++  found = false;
    ++  while (ud_disassemble (&ud_obj) &&
    ++      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
    ++      insn != UD_Ijmp)
    ++    {
    ++      if (insn == UD_Icall)
      	{
     -	  /* A recent Windows 11 Preview calls `lea rel(rip),%r13' then
     -	     some unrelated instructions, then `callq RtlEnterCriticalSection'.
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     -	  lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
     -					   "\x4c\x8d\x2d", 3);
     -	  call_rtl_offset = 24;
    -+	  /* for Windows 8 */
     +	  opr = ud_insn_opr (&ud_obj, 0);
    -+	  if (opr->type == UD_OP_MEM && opr->base == UD_R_RIP &&
    -+	      opr->index == UD_NONE && opr->scale == 0 && opr->offset == 32 &&
    -+	      opr->size == 32)
    ++	  if (opr->type == UD_OP_JIMM && opr->size == 32)
     +	    {
    -+	      if (lockaddr != rip_rel_offset (&ud_obj, opr,
    -+				  offsetof (RTL_CRITICAL_SECTION, LockCount)))
    ++	      if (ent_crit != rip_rel_offset (&ud_obj, opr))
     +		return NULL;
     +	      found = true;
     +	      break;
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()

     -      if (!lock)
     +  fcwd_access_t **f_cwd_ptr = NULL;
    -+  ud_type_t reg = UD_NONE;
    -+  /* now we're looking for a movq rel(%rip) */
    ++  /* now we're looking for a mov rel(%rip), %<reg64> */
     +  while (ud_disassemble (&ud_obj) &&
     +      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
     +      insn != UD_Ijmp)
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     +      if (insn == UD_Imov)
      	{
     -	  return NULL;
    -+	  const ud_operand_t *opr0 = ud_insn_opr (&ud_obj, 0);
    ++	  opr0 = ud_insn_opr (&ud_obj, 0);
     +	  opr = ud_insn_opr (&ud_obj, 1);
    -+	  if (opr->type == UD_OP_MEM && opr->base == UD_R_RIP &&
    -+	      opr->index == UD_NONE && opr->scale == 0 &&
    -+	      opr->offset == 32 && opr->size == 64 &&
    -+	      opr0->type == UD_OP_REG)
    ++	  if (opr->type == UD_OP_MEM && opr->size == 64 &&
    ++	      opr->base == UD_R_RIP && opr->index == UD_NONE &&
    ++	      opr->scale == 0 && opr->offset == 32 &&
    ++	      opr0->type == UD_OP_REG && opr0->size == 64)
     +	    {
     +	      f_cwd_ptr = (fcwd_access_t **) rip_rel_offset (&ud_obj, opr);
     +	      reg = opr0->base;
    @@ winsup/cygwin/x86_64/fastcwd_x86_64.cc: find_fast_cwd_pointer_x86_64 ()
     -      movrbx = lock + 5;
          }
     -  if (!movrbx)
    --    return NULL;
    -   /* Check that the next instruction tests if the fetched value is NULL. */
    ++  /* Check that the next instruction is a test. */
    ++  if (!f_cwd_ptr || !ud_disassemble (&ud_obj) ||
    ++      ud_insn_mnemonic (&ud_obj) != UD_Itest)
    +     return NULL;
    +-  /* Check that the next instruction tests if the fetched value is NULL. */
     -  const uint8_t *testrbx = (const uint8_t *)
     -			   memmem (movrbx + 7, 3, "\x48\x85\xdb", 3);
     -  if (!testrbx)
    -+  if (!f_cwd_ptr || !ud_disassemble (&ud_obj) ||
    -+      ud_insn_mnemonic (&ud_obj) != UD_Itest)
    -+    return NULL;
     +
    -+  opr = ud_insn_opr (&ud_obj, 0);
    -+  if (opr->type != UD_OP_REG || opr->base != reg ||
    -+      memcmp (opr, ud_insn_opr (&ud_obj, 1), offsetof (ud_operand_t, _legacy)))
    ++  /* ... and that it's testing the same register that the mov above loaded the
    ++     f_cwd_ptr into against itself */
    ++  opr0 = ud_insn_opr (&ud_obj, 0);
    ++  opr = ud_insn_opr (&ud_obj, 1);
    ++  if (opr->type != UD_OP_REG || opr->size != 64 || opr->base != reg ||
    ++      opr0->type != opr->type || opr0->size != 64 || opr0->base != opr->base)
          return NULL;
     -  /* Compute address of the fcwd_access_t ** pointer. */
     -  return (fcwd_access_t **) (testrbx + peek32 (movrbx + 3));
5:  e3adc20c9f ! 5:  87f2bcf895 Cygwin: add find_fast_cwd_pointer_aarch64.
    @@ Commit message
         Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

      ## winsup/cygwin/Makefile.am ##
    -@@ winsup/cygwin/Makefile.am: DLL_FILES= \
    - 	exceptions.cc \
    - 	exec.cc \
    - 	external.cc \
    -+	fastcwd_aarch64.cc \
    - 	fcntl.cc \
    - 	fenv.c \
    - 	flock.cc \
    +@@ winsup/cygwin/Makefile.am: if TARGET_X86_64
    + TARGET_FILES= \
    + 	x86_64/bcopy.S \
    + 	x86_64/fastcwd.cc \
    ++	aarch64/fastcwd.cc \
    + 	x86_64/memchr.S \
    + 	x86_64/memcpy.S \
    + 	x86_64/memmove.S \

    - ## winsup/cygwin/fastcwd_aarch64.cc (new) ##
    + ## winsup/cygwin/aarch64/fastcwd.cc (new) ##
     @@
    -+/* fastcwd_aarch64.cc: find the fast cwd pointer on aarch64 hosts.
    ++/* aarch64/fastcwd.cc: find the fast cwd pointer on aarch64 hosts.
     +
     +  This file is part of Cygwin.
     +
    @@ winsup/cygwin/fastcwd_aarch64.cc (new)
     +  Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
     +  details. */
     +
    -+/* You might well wonder why this file is not in an aarch64 target-specific
    -+   directory, like fastcwd_x86_64.cc.  It turns out that this code works when
    -+   built for i686, x86_64, or aarch64 with just the small #if/#elif block in
    ++/* You might well wonder why this file is included in x86_64 target files
    ++   in Makefile.am.  It turns out that this code works when built for i686,
    ++   x86_64, or aarch64 with just the small #if/#elif block in
     +   GetArm64ProcAddress below caring which. */
     +
     +#include "winsup.h"
    -+#include "assert.h"
    ++#include <assert.h>
     +
     +class fcwd_access_t;
     +
     +static LPCVOID
     +GetArm64ProcAddress (HMODULE hModule, LPCSTR procname)
     +{
    -+  const BYTE * proc = (const BYTE *) GetProcAddress (hModule, procname);
    ++  const BYTE *proc = (const BYTE *) GetProcAddress (hModule, procname);
     +#if defined (__aarch64__)
     +  return proc;
     +#else
    @@ winsup/cygwin/fastcwd_aarch64.cc (new)
     +
     +/* this would work for either bl or b, but we only use it for bl */
     +static inline LPCVOID
    -+extract_bl_target (const uint32_t * pc)
    ++extract_bl_target (const uint32_t *pc)
     +{
     +  assert (IS_INSN (pc, bl) || IS_INSN (pc, b));
     +  int32_t offset = *pc & ~bl_mask;
    @@ winsup/cygwin/fastcwd_aarch64.cc (new)
     +}
     +
     +static inline uint64_t
    -+extract_adrp_address (const uint32_t * pc)
    ++extract_adrp_address (const uint32_t *pc)
     +{
     +  assert (IS_INSN (pc, adrp));
     +  uint64_t adrp_base = (uint64_t) pc & ~0xFFF;
-- 
2.48.1.windows.1

