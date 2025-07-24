Return-Path: <SRS0=sZqY=2F=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 09E553856080
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 20:25:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 09E553856080
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 09E553856080
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753388711; cv=none;
	b=UiAaY+LydwdOcl84c+w4GLjYvonpdECeu7khF9UrBlvniVNv8f0A+E+8k8p1YYvgGnFqU8mlghj6JavbV/SfhnCNpcRnRN7auUC4bdTW8/sAsum7NFbQp0Xb2towZMCDxRZg4/j7CrLlW6S0rWZvk9gpbNBBx0UK7hPQtMLmby0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753388711; c=relaxed/simple;
	bh=Pfhg7hr2LheRnD7AzlfVEQdkqWUU9E57gXDih3YLMk0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vqdBy8fdTMtv8lzQR00SGjTMP3HJiquM/A+MLExw6YZfFKlC3qQaZRlIVbicCdi6ltgBqh17wMSCMDhEORPLOJRwAZnNkxcIyml+UHsagP2PYQzhGGqqn35zKerherbO/vR/ThT6w0fQgxOyYg84N5x1AEL4QbhmarJNEspT7eo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 09E553856080
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Q7vDT0Wn
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B4D0345CD2;
	Thu, 24 Jul 2025 16:25:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=M3uA1jF78fyPUy7qnhsAUeFCC0k=; b=Q7vDT
	0Wn7SWjbMl88wu7gmXGtsnwzkzpBuxxr9erUftlXlmIRJul5EUbvbeg6zrHGVT0i
	N83c+elbHAt5uYrAeoLoQX0Prm4FhAIVi707X6vN3Ie3kDSktLfXZKxQ5EmPcNDt
	1Nf3FGS0t3TwWGJUylYnGYUddbIro9/31YoZkg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id ADECF45CC6;
	Thu, 24 Jul 2025 16:25:10 -0400 (EDT)
Date: Thu, 24 Jul 2025 13:25:10 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
In-Reply-To:  <GV4PR83MB0941BC79A50B76470922FE38925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
Message-ID: <039ff598-6a8d-3a16-c544-be7dae5b2a78@jdrake.com>
References: <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com> <aH4NM_WJNC2KHpHT@calimero.vinschen.de> <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com> <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de> <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com> <aH9jZCS92AGUaP-o@calimero.vinschen.de> <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com> <aICZuCg3tKXOj_mR@calimero.vinschen.de>
 <GV4PR83MB0941AA5AD0E67B89787B1FE0925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com> <aIIM-ZOEUZDsq-og@calimero.vinschen.de>  <GV4PR83MB0941BC79A50B76470922FE38925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="12017318494208-805787166-1753388710=:74162"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPAM_BODY,SPF_HELO_PASS,SPF_PASS,TXREP,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--12017318494208-805787166-1753388710=:74162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Jul 2025, Radek Barton wrote:

> Hello.
>
> Thank you for noticing. Here's the fixed version.
>
> Radek
>
> ---
> From 353e7120b660a5bf5abdff7afbd652c666c66bf8 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft=
.com>
> Date: Sat, 19 Jul 2025 19:17:12 +0200
> Subject: [PATCH v3] Cygwin: mkimport: implement AArch64 +/-4GB relocati=
ons
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Based on https://sourceware.org/pipermail/cygwin-patches/2025q3/014154.=
html
> suggestion, this patch implements +/-4GB relocations for AArch64 in the=
 mkimport
> script by using adrp and ldr instructions. This change required update
> in winsup/cygwin/mm/malloc_wrapper.cc where those instructions are
> decoded to get target import address.
>
> Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/mm/malloc_wrapper.cc | 26 +++++++++++++++++---------
>  winsup/cygwin/scripts/mkimport     |  7 +++++--
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/mall=
oc_wrapper.cc
> index 863d3089c..20d933bf5 100644
> --- a/winsup/cygwin/mm/malloc_wrapper.cc
> +++ b/winsup/cygwin/mm/malloc_wrapper.cc
> @@ -51,16 +51,24 @@ import_address (void *imp)
>    __try
>      {
>  #if defined(__aarch64__)
> -      // If opcode is an adr instruction.
> -      uint32_t opcode =3D *(uint32_t *) imp;
> -      if ((opcode & 0x9f000000) =3D=3D 0x10000000)
> +      /* If opcode1 is an adrp and opcode2 is ldr instruction:
> +           - https://www.scs.stanford.edu/~zyedidia/arm64/adrp.html
> +           - https://www.scs.stanford.edu/~zyedidia/arm64/ldr_imm_gen.=
html
> +         NOTE: This implementation assumes that the relocation table i=
s made of
> +         those specific AArch64 instructions as generated by the
> +         winsup/cygwin/scripts/mkimport script. Please, keep it in syn=
c. */
> +      uint32_t opcode1 =3D *((uint32_t *) imp);
> +      uint32_t opcode2 =3D *(((uint32_t *) imp) + 1);
> +      if (((opcode1 & 0x9f000000) =3D=3D 0x90000000) && ((opcode2 & 0x=
bfc00000) =3D=3D 0xb9400000))

These checks could be tightened up a bit given the extremely limited
instructions that are used.
+      uint32_t opcode3 =3D *(((uint32_t *) imp) + 2);
+      if (((opcode1 & 0x9f00001f) =3D=3D 0x90000010) &&
           ((opcode2 & 0xffc003ff) =3D=3D 0xf9400210) &&
           (opcode3 =3D=3D 0xd61f0200))

This ensures:
* xip0 aka x16 is the register used
* the ldr is 64-bit (you already were assuming that by the "64 bit scale"
  comment below, but this checks that that bit is set)
* the next instruction after the ldr is a br x16

If you wanted to cover the binutils case, something like:

       if (((opcode1 & 0x9f00001f) =3D=3D 0x90000010) &&
          (((opcode2 & 0xffc003ff) =3D=3D 0xf9400210) &&
           (opcode3 =3D=3D 0xd61f0200)) ||
          (((opcode2 & 0xffc003ff) =3D=3D 0x91000210) &&
           (opcode3 =3D=3D 0xf9400210) &&
           (*(((uint32_t *) imp) + 3) =3D=3D 0xd61f0200))

The 12 bits in the ldr correspond to the same 12 bits in the add, just no=
t
64 bit scaled so that would have to be checked in the below code.



>  	{
> -	  uint32_t immhi =3D (opcode >> 5) & 0x7ffff;
> -	  uint32_t immlo =3D (opcode >> 29) & 0x3;
> -	  int64_t sign_extend =3D (0l - (immhi >> 18)) << 21;
> -	  int64_t imm =3D sign_extend | (immhi << 2) | immlo;
> -	  uintptr_t jmpto =3D *(uintptr_t *) ((uint8_t *) imp + imm);
> -	  return (void *) jmpto;
> +	  uint32_t immhi =3D (opcode1 >> 5) & 0x7ffff;
> +	  uint32_t immlo =3D (opcode1 >> 29) & 0x3;
> +	  uint32_t imm12 =3D ((opcode2 >> 10) & 0xfff) * 8; // 64 bit scale
> +	  int64_t sign_extend =3D (0l - ((int64_t) immhi >> 32)) << 33; // si=
gn extend from 33 to 64 bits
> +	  int64_t imm =3D sign_extend | (((immhi << 2) | immlo) << 12);
> +	  int64_t base =3D (int64_t) imp & ~0xfff;
> +	  uintptr_t* jmpto =3D (uintptr_t *) (base + imm + imm12);
> +	  return (void *) *jmpto;
>  	}
>  #else
>        if (*((uint16_t *) imp) =3D=3D 0x25ff)
> diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mki=
mport
> index 0c1bcafbf..33d8b08fb 100755
> --- a/winsup/cygwin/scripts/mkimport
> +++ b/winsup/cygwin/scripts/mkimport
> @@ -73,8 +73,11 @@ EOF
>  	.extern	$imp_sym
>  	.global	$glob_sym
>  $glob_sym:
> -	adr x16, $imp_sym
> -	ldr x16, [x16]
> +	# NOTE: Using instructions that are used by MSVC and LLVM. Binutils a=
re
> +	# using adrp/add/ldr-0-offset though. Please, keep it in sync with
> +  # import_address implementation in winsup/cygwin/mm/malloc_wrapper.c=
c.
> +	adrp x16, $imp_sym
> +	ldr x16, [x16, #:lo12:$imp_sym]
>  	br x16
>  EOF
>  	} else {
> --
> 2.50.1.vfs.0.0
>

--=20
When more and more people are thrown out of work, unemployment
results.
		-- Calvin Coolidge
--12017318494208-805787166-1753388710=:74162--
