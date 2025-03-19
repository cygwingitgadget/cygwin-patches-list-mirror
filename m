Return-Path: <SRS0=crg5=WG=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 8D7A6385841F
	for <cygwin-patches@cygwin.com>; Wed, 19 Mar 2025 05:11:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8D7A6385841F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8D7A6385841F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742361098; cv=none;
	b=TddmzMspLH8AH0r6vlNz/B3pC09kcZG96U3zyV12tSgQOEn5drNKGK57Onv+NfLSJoM8aHLjNAsr2ORgHmZ46x0s4bp/xCjo3+G6KWzRbpZPcLhI4kecTt3s/3uTbpjSgcrLmZtINpKe7Yk63OsFMRYFcUcy691Lv3WuaXM+Km4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742361098; c=relaxed/simple;
	bh=R6LM+TvPZOBF5RyyHpR9gCL2SG76zF6A0hqCC9H/neo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=pFS1vpdokiNehm6XTM9yehbRyySbQxLKEwMilQNjk8olOsPtVnajXLZqBlDRGgk9DJTH+0AcBUeQuDfe7R82i+BazTlkdHGzkfNJJM5UUU8fc4gWrKOwKLxelpjX9Yb0Qo1//5homKzbs0Hcf1Mv6Qdy/tFeCpKRtXIzKUcGQ8E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8D7A6385841F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=t/Ob3Ly8
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id E64A445C64;
	Wed, 19 Mar 2025 01:11:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Fe+2+JHlfzivuQD9w4s/MCY5wsU=; b=t/Ob3
	Ly8YToai1D8xmBhlXBX95iEw4+2Fl/r3QBT25m0XZ8TJDcBo1Ug9zCZnW8knOESF
	GPy+EIghaczeKIpLHc3L99R18mbKVt1e6XF4blIyg7hLYPnnPRIdaxML7nH0En8W
	LMZEDJ0a6xJj7rfqJw1iyPaEG39psnrIY0E65A=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CCB4E45C63;
	Wed, 19 Mar 2025 01:11:37 -0400 (EDT)
Date: Tue, 18 Mar 2025 22:11:37 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Use udis86 to walk x64 machine code in find_fast_cwd_pointer
In-Reply-To: <Z9nIRlpIEfAbNoJ2@calimero.vinschen.de>
Message-ID: <5097ccfa-83f6-c76e-6c59-28c876cc2db8@jdrake.com>
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de> <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com> <Z9k9OcYu5Y47VsjU@calimero.vinschen.de> <e63f40de-faf7-2187-9f13-7bce6f7d7238@jdrake.com>
 <Z9nIRlpIEfAbNoJ2@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 18 Mar 2025, Corinna Vinschen wrote:

> Subdir of winsup/cygwin, probably.  What I'm most curious about is the
> size it adds to the DLL.  I wonder if, say, an extra 32K is really
> usefully spent, given it only checks a small part of ntdll.dll, and only
> once per process tree, too.

I did this with msys-2.0.dll, but it shouldn't matter as a delta.
all are stripped msys-2.0.dll size
start:
3,246,118 bytes
with udis86 vendored, but not called:
3,247,142 bytes
with find_fast_cwd_pointer rewritten to use udis86:
3,328,550 bytes

(I know the second one isn't realistic, the linker could exclude unused
code, I was just kind of curious)

This is with all the "translate to assembly text, intel or at&t syntax"
and "table of strings for opcodes" stuff removed to try to save space,
still a net increase of 82,432 bytes.

Here's the new find_fast_cwd_pointer function:

static fcwd_access_t **
find_fast_cwd_pointer ()
{
  /* Fetch entry points of relevant functions in ntdll.dll. */
  HMODULE ntdll = GetModuleHandle ("ntdll.dll");
  if (!ntdll)
    return NULL;
  const uint8_t *get_dir = (const uint8_t *)
			   GetProcAddress (ntdll, "RtlGetCurrentDirectory_U");
  const uint8_t *ent_crit = (const uint8_t *)
			    GetProcAddress (ntdll, "RtlEnterCriticalSection");
  if (!get_dir || !ent_crit)
    return NULL;
  ud_t ud_obj;
  ud_init (&ud_obj);
  ud_set_mode (&ud_obj, 64);
  ud_set_input_buffer (&ud_obj, (const uint8_t *) get_dir, 80);
  ud_set_pc (&ud_obj, (const uint64_t) get_dir);
  const ud_operand_t *opr;
  /* Search first relative call instruction in RtlGetCurrentDirectory_U. */
  const uint8_t *use_cwd = NULL;
  while (ud_disassemble (&ud_obj))
    {
      if (ud_insn_mnemonic (&ud_obj) == UD_Icall)
	{
	  opr = ud_insn_opr (&ud_obj, 0);
	  if (opr->type == UD_OP_JIMM && opr->size == 32)
	    {
	      /* Fetch offset from instruction and compute address of called
		 function.  This function actually fetches the current FAST_CWD
		 instance and performs some other actions, not important to us.
	       */
	      use_cwd = (const uint8_t *) (ud_insn_off (&ud_obj) +
					   ud_insn_len (&ud_obj) +
					   opr->lval.sdword);
	      break;
	    }
	}
    }
  if (!use_cwd)
    return NULL;
  ud_set_input_buffer (&ud_obj, (const uint8_t *) use_cwd, 120);
  ud_set_pc (&ud_obj, (const uint64_t) use_cwd);

  /* Next we search for the locking mechanism and perform a sanity check.
     On Pre- (or Post-) Windows 8 we basically look for the
     RtlEnterCriticalSection call.  Windows 8 does not call
     RtlEnterCriticalSection.  The code manipulates the FastPebLock manually,
     probably because RtlEnterCriticalSection has been converted to an inline
     function.  Either way, we test if the code uses the FastPebLock. */
  PRTL_CRITICAL_SECTION lockaddr = NULL;

  /* both cases have an `lea rel(%rip)` on the lock */
  while (ud_disassemble (&ud_obj))
    {
      if (ud_insn_mnemonic (&ud_obj) == UD_Ilea)
	{
	  /* this seems to follow intel syntax, in that operand 0 is the
	     dest and 1 is the src */
	  opr = ud_insn_opr (&ud_obj, 1);
	  if (opr->type == UD_OP_MEM && opr->base == UD_R_RIP &&
	      opr->index == UD_NONE && opr->scale == 0 && opr->offset == 32)
	    {
	      lockaddr = (PRTL_CRITICAL_SECTION) (ud_insn_off (&ud_obj) +
						  ud_insn_len (&ud_obj) +
						  opr->lval.sdword);
	      break;
	    }
	}
    }

  /* Test if lock address is FastPebLock. */
  if (lockaddr != NtCurrentTeb ()->Peb->FastPebLock)
    return NULL;

  /* Next is either the `callq RtlEnterCriticalSection', or on Windows 8,
     a `lock btr` */
  while (ud_disassemble (&ud_obj))
    {
      ud_mnemonic_code_t insn = ud_insn_mnemonic (&ud_obj);
      if (insn == UD_Icall)
	{
	  opr = ud_insn_opr (&ud_obj, 0);
	  if (opr->type == UD_OP_JIMM && opr->size == 32)
	    {
	      if (ent_crit != (const uint8_t *) (ud_insn_off (&ud_obj) +
						 ud_insn_len (&ud_obj) +
						 opr->lval.sdword))
		return NULL;
	      break;
	    }
	}
      else if (insn == UD_Ibtr && ud_obj.pfx_lock)
	{
	  /* for Windows 8 */
	  opr = ud_insn_opr (&ud_obj, 0);
	  if (opr->type == UD_OP_MEM && opr->base == UD_R_RIP &&
	      opr->index == UD_NONE && opr->scale == 0 && opr->offset == 32 &&
	      opr->size == 32)
	    {
	      if (lockaddr != (PRTL_CRITICAL_SECTION) (ud_insn_off (&ud_obj) +
				ud_insn_len (&ud_obj) + opr->lval.sdword -
				offsetof (RTL_CRITICAL_SECTION, LockCount)))
		return NULL;

	      break;
	    }
	}
    }

  fcwd_access_t **f_cwd_ptr = NULL;
  ud_type_t reg = UD_NONE;
  /* now we're looking for a movq rel(%rip) */
  while (ud_disassemble (&ud_obj))
    {
      if (ud_insn_mnemonic (&ud_obj) == UD_Imov)
	{
	  const ud_operand_t *opr0 = ud_insn_opr (&ud_obj, 0);
	  opr = ud_insn_opr (&ud_obj, 1);
	  if (opr->type == UD_OP_MEM && opr->base == UD_R_RIP &&
	      opr->index == UD_NONE && opr->scale == 0 &&
	      opr->offset == 32 && opr->size == 64 &&
	      opr0->type == UD_OP_REG)
	    {
	      f_cwd_ptr = (fcwd_access_t **) (ud_insn_off (&ud_obj) +
					      ud_insn_len (&ud_obj) +
					      opr->lval.sdword);
	      reg = opr0->base;
	      break;
	    }
	}
    }
  /* Check that the next instruction tests if the fetched value is NULL. */
  if (!ud_disassemble (&ud_obj) || ud_insn_mnemonic (&ud_obj) != UD_Itest)
    return NULL;

  opr = ud_insn_opr (&ud_obj, 0);
  if (opr->type != UD_OP_REG || opr->base != reg ||
      memcmp (opr, ud_insn_opr (&ud_obj, 1), offsetof (ud_operand_t, _legacy)))
    return NULL;
  return f_cwd_ptr;
}
