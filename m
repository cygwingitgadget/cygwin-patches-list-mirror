Return-Path: <SRS0=DBc0=5F=kmaps.co=evgeny@sourceware.org>
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by sourceware.org (Postfix) with ESMTPS id F392F3858D20
	for <cygwin-patches@cygwin.com>; Tue, 28 Oct 2025 13:46:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F392F3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F392F3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::d2c
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761659191; cv=none;
	b=m4Jo8HBS/sMi9jWmH2sc83RpUoF1K0X4cSYnSJwHoYvK2BDOieS2CzDcoPHM2T09N9wuZ/d2VEFyyrnTm2daEPfLFbyzdCucHm9cMaTO8vWE+cnSayYJ1010+WNp4dPeu688qwu5N0/GGXp0xX/Mb/wJFcCz99VK/D7GMUgDGgM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761659191; c=relaxed/simple;
	bh=zrawf6JREI6saaltO8LkUWkFW26TOpx8vI0a8ZjO1dk=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=L+SyM0+INbBmZnC7fwbIQBr1rqbyF7udEylzPslJiLqns89lvuiPMq0CDvqfx6NYu181T9OK1CjjChlbVcfWhMp+GjJCFVFtEKUozTFlnJLQgKXuO4V7ZHVJxim3xAa6SA6SFv/OkV/Br7QDWHo6KbbQRbb7fNnzZz3v2LmeNYs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F392F3858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=rgsIDLmx
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-88703c873d5so214868139f.3
        for <cygwin-patches@cygwin.com>; Tue, 28 Oct 2025 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1761659190; x=1762263990; darn=cygwin.com;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aeabgaZ2DZuhrRIol+dG63Lmz5z/amkwWluLFzFoKrA=;
        b=rgsIDLmxDTv2cRwTJuYOZzcJOAS1kEaVDzK4zv+fClhMl+LchnP6SKy4oFp5/2PdQx
         Y4d6a+ufHr4Nfa0DXC3UQbOH4FBwnOvBkoWnlHWTsskNvmxgReMz6jJrrRB73jpZsg8/
         gBCIZslK+ZycbTQxuOAIfkhOw/d8RJaXiv1iE7F1OsYNkXD7InjYaZVA/BJ231W8rwQL
         h/CPYp+nf7md5yL4+N4Upl9d/NcJqCAgbd7Yo2K1XWSuYL7Xh/EOPNz0pbPmnRJIUhIc
         fbCQ4tavcwJwelXZGiu2hOPhATbbZlv2sfkC8xo0sGvxgRvwLE0TnjtM87BaXrl7gzbh
         /99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659190; x=1762263990;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aeabgaZ2DZuhrRIol+dG63Lmz5z/amkwWluLFzFoKrA=;
        b=LakO/nwLphkHNIo8NfaWOgDDqkeqldvd47VpOQvplONBpTIlW89ps60jehWjagAiFa
         oNF7ODRHqGQu4KXaohX6sWhFqeF2Pgx91FSy3pq4W5RtuyKgiK3HIDWy8C57xTubEIpE
         qwQ2QwG4MnroF7QZ9CcwGsyGGcxdY4+mRYl7vaFvHcRpuOA4vZi1V32Yh0MT7d06KQ2x
         45BeIEHp1NS76fvBlcXrnOA2aeBRc23h155OEaMl0QPSeGWGji8PH3ZpgCu78OA7Wkpl
         zjNX4wQ7KTyG2leLqS8FrcA5MA2TpHv8JOo/p3lh93DwPeBztSrLG1j6/oPAB9XH0wAE
         5LVg==
X-Gm-Message-State: AOJu0Yxa0mjQMQjNmSXEtfr6ELLGgZZurIAF40i4BS1OrejmGSLxkGU9
	BPBkVrB0uGwC6W/d1GQHg4wrZkv8hY72nvOzx4mLiKMvS0t4WXquXIUu4EvkvZA7VhlJb+C4IZV
	4EyZ1AhjIyG1Ytvm1KDK06Ie88ELMZr2Uq0Vqo4kTSsHotxGlR0e39VY=
X-Gm-Gg: ASbGncsQWdihX0fS3G2Gel2Mox3P0+7pKd99t4pZambgg3ukD1f/YQBdoF/tzKtOxHu
	mDAVtbiltwtCwfAqwFMw9wDyFGx/QCeasCfNJomqDlxGwOIkF/LlAQW2liLM3xL7HGScLCHHt/h
	uYlSLjcd2lp0HvM54FlQYMTNz3r6pQydeZGDLCw3aIfPZckVuNTdK4LJhuphP+g5GnvwmaYI3GC
	Yk+GzwF7kmJMLnv+LcJtL3oBQovXKs13HNWua/JgOE5tMt7/5c2XoIdXxIKUQ==
X-Google-Smtp-Source: AGHT+IETiZBf4GbDWlfjJ9mcJzyo3+oE0fXCMprpkCH4RreCCmu889jndWlOfTJCCggvcH9QfhXbEl761EhXqQe7nDU=
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f11:b0:430:c38f:fb82 with SMTP id
 e9e14a558f8ab-4320f7b75dfmr42902315ab.8.1761659190033; Tue, 28 Oct 2025
 06:46:30 -0700 (PDT)
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 09:46:29 -0400
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 09:46:29 -0400
From: Evgeny Karpov <evgeny@kmaps.co>
Date: Tue, 28 Oct 2025 09:46:29 -0400
X-Gm-Features: AWmQ_bmJBwPWlw7IHaRvKuLpz1fLcBs_A5IA-t8Tp9FRZ-ceKVtVYutTB11MFtQ
Message-ID: <CABd5JDC_=LLjR8_nRHxBzLCxMgEqMwJP+jf-E_CPvFxOYWR2nw@mail.gmail.com>
Subject: [PATCH] Cygwin: aarch64: Add runtime pseudo relocation
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The patch adds runtime pseudo relocation handling for 12-bit and 21-bit
relocations. The 26-bit relocation is handled using a jump stub generated by
the linker.

---
 winsup/cygwin/pseudo-reloc.cc | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/winsup/cygwin/pseudo-reloc.cc b/winsup/cygwin/pseudo-reloc.cc
index 5a0eab936..fdc2a5d1b 100644
--- a/winsup/cygwin/pseudo-reloc.cc
+++ b/winsup/cygwin/pseudo-reloc.cc
@@ -199,6 +199,9 @@ do_pseudo_reloc (void * start, void * end, void * base)
   ptrdiff_t reloc_target = (ptrdiff_t) ((char *)end - (char*)start);
   runtime_pseudo_reloc_v2 *v2_hdr = (runtime_pseudo_reloc_v2 *) start;
   runtime_pseudo_reloc_item_v2 *r;
+#ifdef __aarch64__
+  uint32_t opcode;
+#endif

   /* A valid relocation list will contain at least one entry, and
    * one v1 data structure (the smallest one) requires two DWORDs.
@@ -307,6 +310,13 @@ do_pseudo_reloc (void * start, void * end, void * base)
 	  if ((reldata & 0x8000) != 0)
 	    reldata |= ~((ptrdiff_t) 0xffff);
 	  break;
+#ifdef __aarch64__
+	case 12:
+	case 21:
+	  opcode = (*((unsigned int *) reloc_target));
+	  reldata = 0;
+	  break;
+#endif
 	case 32:
 	  reldata = (ptrdiff_t) (*((unsigned int *)reloc_target));
 #if defined (__x86_64__) || defined (_WIN64)
@@ -339,6 +349,31 @@ do_pseudo_reloc (void * start, void * end, void * base)
 	case 16:
 	  __write_memory ((void *) reloc_target, &reldata, 2);
 	  break;
+#ifdef __aarch64__
+	case 12:
+	  /* Replace add Xn, Xn, :lo12:label with ldr Xn, [Xn, :lo12:__imp__func].
+	     That loads the address of _func into Xn.  */
+	  opcode = 0xf9400000 | (opcode & 0x3ff); // ldr
+	  reldata = ((ptrdiff_t) base + r->sym) & ((1 &lt;&lt; 12) - 1);
+	  reldata >>= 3;
+	  opcode |= reldata &lt;&lt; 10;
+	  __write_memory ((void *) reloc_target, &opcode, 4);
+	  break;
+	case 21:
+	  /* Replace adrp Xn, label with adrp Xn, __imp__func.  */
+	  opcode &= 0x9f00001f;
+	  reldata = (((ptrdiff_t) base + r->sym) >> 12)
+		    - (((ptrdiff_t) base + r->target) >> 12);
+	  reldata &= (1 &lt;&lt; 21) - 1;
+	  opcode |= (reldata & 3) &lt;&lt; 29;
+	  reldata >>= 2;
+	  opcode |= reldata &lt;&lt; 5;
+	  __write_memory ((void *) reloc_target, &opcode, 4);
+	  break;
+	/* A note regarding 26 bits relocation.
+	   A single opcode is not sufficient for 26 bits relocation in
dynamic linking.
+	   The linker generates a jump stub instead.  */
+#endif
 	case 32:
 #if defined (__CYGWIN__) && defined (__x86_64__)
 	  if (reldata > (ptrdiff_t) __INT32_MAX__
-- 
2.39.5
