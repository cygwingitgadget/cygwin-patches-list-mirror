Return-Path: <SRS0=rmGi=WF=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 1595A3858CDA
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 00:39:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1595A3858CDA
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1595A3858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742258377; cv=none;
	b=ZGEOLqkxNKT6q1GuHnsMXul3sDOwY0lGH9zVH+lBYXoUBGeoU8sz+ZkduPnRCJHDlypo6uv8TsMTUEvgsUFiQp2uZlbXs6EHaWzVl8QPo2pIzu+5dppBeY7Kp0iVxCoXGns5gPnFEICZGR87JML3/gAojllZY0dW/3rLuqfG02Q=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742258377; c=relaxed/simple;
	bh=rHXRaq6ZGYqR2yljQFoyjbVhT9DDmG80lu1hz9H96Vk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Tv6/SMr2IhG8Ar1wsWfsKP75kJ2f0v2nrQinY8ozh9qbdUHp7wBaxZKZb6J02o+snj6EdIPb8Fbxr62SH8rRcVrEZQMV7v9Jklk3UyOwPidk6ZUpSyPCEhoNbMfek2tcIkmgnHhDbZdDHqS2pBRb//n1jB9USyCcdKqfWNgbcRM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1595A3858CDA
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=aHyPGufA
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4848145C8C;
	Mon, 17 Mar 2025 20:39:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=nxrpw6VsuqiFlfLM+HK1/bhMLrQ=; b=aHyPG
	ufAwKNPKYUtjcMeiy5i1ph9RUFP1shhHBYERO66N5OXmDuJe5/xwuL18ynTN5PSR
	QJQMIfxuEkEVxVd+6IrGt1tXGk+WLY4Oo4hF3tYxRUx37WaYDnfugp1R3iCn7/Hy
	hpoW+Ryj0bzUJmLaI7C6s7yakN4+B5LNMrc2eM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 40FE345C7B;
	Mon, 17 Mar 2025 20:39:36 -0400 (EDT)
Date: Mon, 17 Mar 2025 17:39:36 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Adjust CWD magic to accommodate for the latest
 Windows previews
In-Reply-To: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
Message-ID: <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com>
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 1 Mar 2025, Johannes Schindelin wrote:

> Note: In the long run, we may very well want to follow the insightful
> suggestion by a helpful Windows kernel engineer who pointed out that it
> may be less fragile to implement kind of a disassembler that has a
> better chance to adapt to the ever-changing code of
> `ntdll!RtlpReferenceCurrentDirectory` by skipping uninteresting
> instructions such as `mov %rsp,%rax`, `mov %rbx,0x20(%rax)`, `push %rsi`
> `sub $0x70,%rsp`, etc, and focuses on finding the `lea`, `call
> ntdll!RtlEnterCriticalSection` and `mov ..., rbx` instructions, much
> like it was prototyped out for ARM64 at
> https://gist.github.com/jeremyd2019/aa167df0a0ae422fa6ebaea5b60c80c9

Since you kind of asked, here's a proof-of-concept that uses udis86 (I
left a whole bunch of pointer<->integer warnings since this is a PoC).
Tested on windows 11 and 8:

LPVOID find_fast_cwd_pointer_on_x64 ()
{
  ud_t ud_obj;
  ud_init (&ud_obj);
  ud_set_mode (&ud_obj, 64);
  LPCVOID proc = GetProcAddress(GetModuleHandle("ntdll"), "RtlGetCurrentDirectory_U");
  LPCVOID start = proc;
  printf("%p\n", proc);
  /* no idea for size */
  ud_set_input_buffer (&ud_obj, proc, 80);
  ud_set_pc (&ud_obj, proc);

  /* find the call to RtlpReferenceCurrentDirectory, and get its address */
  while (ud_disassemble (&ud_obj))
    {
      if (ud_insn_mnemonic (&ud_obj) == UD_Icall)
	{
	  const ud_operand_t * operand = ud_insn_opr (&ud_obj, 0);
	  if (operand->type == UD_OP_JIMM && operand->size == 32)
	    {
	      proc = ud_insn_off (&ud_obj) + ud_insn_len (&ud_obj) +
		      operand->lval.sdword;
	      break;
	    }
	}
    }
  printf("%p\n", proc);
  if (proc == start)
    return NULL;

  start = proc;
  /* no idea for size */
  ud_set_input_buffer (&ud_obj, proc, 160);
  ud_set_pc (&ud_obj, proc);

  LPVOID critsec = NULL;

  while (ud_disassemble (&ud_obj))
    {
      if (ud_insn_mnemonic (&ud_obj) == UD_Ilea)
	{
	  /* this seems to follow intel syntax, in that operand 0 is the
	     register and 1 is the memory refernece */
	  const ud_operand_t * operand = ud_insn_opr (&ud_obj, 1);
	  if (operand->type == UD_OP_MEM && operand->base == UD_R_RIP &&
	      operand->index == UD_NONE && operand->scale == 0 &&
	      operand->offset == 32)
	    {
	      critsec = ud_insn_off (&ud_obj) + ud_insn_len (&ud_obj) +
		operand->lval.sdword;
	      break;
	    }
	}
    }
  if (critsec != NtCurrentTeb ()->Peb->FastPebLock)
    return NULL;

  /* find the call to RtlEnterCriticalSection */
  proc = GetProcAddress(GetModuleHandle("ntdll"), "RtlEnterCriticalSection");
  while (ud_disassemble (&ud_obj))
    {
      enum ud_mnemonic_code insn = ud_insn_mnemonic (&ud_obj);
      if (insn == UD_Icall)
	{
	  const ud_operand_t * operand = ud_insn_opr (&ud_obj, 0);
	  if (operand->type == UD_OP_JIMM && operand->size == 32)
	    {
	      if (proc != ud_insn_off (&ud_obj) + ud_insn_len (&ud_obj) +
			    operand->lval.sdword)
		return NULL;
	      break;
	    }
	}
      else if (insn == UD_Ibtr && ud_obj.pfx_lock)
	{
	  /* for Windows 8 */
	  const ud_operand_t * operand = ud_insn_opr (&ud_obj, 0);
	  if (operand->type == UD_OP_MEM && operand->base == UD_R_RIP &&
	      operand->index == UD_NONE && operand->scale == 0 &&
	      operand->offset == 32 && critsec == ud_insn_off (&ud_obj) +
		ud_insn_len (&ud_obj) + operand->lval.sdword -
		offsetof (RTL_CRITICAL_SECTION, LockCount))
	    break;
	}
    }
  LPVOID RtlpCurDirRef = NULL;
  /* probably the next instruction is the mov qword ptr */
  while (ud_disassemble (&ud_obj))
    {
      if (ud_insn_mnemonic (&ud_obj) == UD_Imov)
	{
	  const ud_operand_t * operand = ud_insn_opr (&ud_obj, 1);
	  if (operand->type == UD_OP_MEM && operand->base == UD_R_RIP &&
	      operand->index == UD_NONE && operand->scale == 0 &&
	      operand->offset == 32 && operand->size == 64)
	    {
	      RtlpCurDirRef = ud_insn_off (&ud_obj) + ud_insn_len (&ud_obj) +
			      operand->lval.sdword;
	      break;
	    }
	}
    }

  printf("%p -> %p\n", ud_insn_off (&ud_obj), RtlpCurDirRef);

  return RtlpCurDirRef;
}
