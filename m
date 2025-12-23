Return-Path: <SRS0=CjPM=65=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id 37DD84BA2E04
	for <cygwin-patches@cygwin.com>; Tue, 23 Dec 2025 18:41:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 37DD84BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 37DD84BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766515320; cv=none;
	b=OZVeTqBJ++uuW6t1qYKD5nQP6goxSND7fcXBNUzD24GNc9fQGHZGw50XqQDH1HXsa8WumFLuiCK2vLTsoukvMJ1lxxQ6B3HOPpB961satv82WRU095o3aGkbfUT6HlNu8hN4vCVD7AQveNrgaEIF/1hgPGGOfenxODLuk9woGQA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766515320; c=relaxed/simple;
	bh=+/Psmxi3BcJmFes3HScMEAlX1fSJEuoSCpMOPDbileA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ZmEoUoP/q6CChTiGN8/OtYtU6bQlOkfk0GD5plM/KV8noF+5i4LoSmbtZoNrBYQy214RIEk++zEhewgZdUGv20ozrVEFF3Hl7l0hJp6sjgH2u5+RkUFpfSRH1l2w0nrxW9fH4alEOTYKlpEy9AxQ3RBHL6iTxGQdOnX2r1hginM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 37DD84BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pxGg7q1m
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251223184157142.ZKDI.36235.HP-Z230@nifty.com>;
          Wed, 24 Dec 2025 03:41:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Takashi Yano <takashi.yano@nity.ne.jp>
Subject: [PATCH] Cygwin: thread: Fix stack alignment for PTHREAD_CANCEL_ASYNCHRONOUS
Date: Wed, 24 Dec 2025 03:41:41 +0900
Message-ID: <20251223184150.1415-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766515317;
 bh=hz+xpmHbLj91SDqpszbWnirvniFu6kYGx8qwW4JjXOk=;
 h=From:To:Cc:Subject:Date;
 b=pxGg7q1mTMktwHiBRMt2XzizAaCgHysLT89GI9XusTb2mNlYFiktTP9fGXqXvX/K9EmVxbHl
 WefnqaYEDTQbJ9g5M+FGWgRv5ZByIX8mbSAQyxnv89BNenCQY2I3XyLoXVPoMXnE2GciCuUP0U
 bGKteEH6jwQntlWHw2mXQ0KbSDQsESDF9LJoAGj1iKx0aahYKxyriyzvcnsyKIZkGYYbgIxj3e
 Z+FxJFO4R+8B3NiST+6G3aV+XozWW0lx0XnrF6NtEVvfzYvJpEuzAuzKh7nYjTeh10cupxlYOR
 Rn6OGQuWe/MWH+zTR0Qq9HZuM+IT8GAyi5JpixEzPYLq4jAw==
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED,URI_TRY_3LD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The test case winsup/testsuites/winsup.api/pthread/cancel2 fails
on Windows 11 and Windows Server 2025, while it works on Windows 10
and Windows Server 2022. PTHREAD_CANCEL_ASYNCHRONOUS is implemented
using [GS]etThreadContext() on the target thread and forcibly
overrides instruction pointer to pthread::static_cancel_self().
Previously, the stack pointer was not trimmed to 16-byte alignment,
even though this is required by 64-bit Windows ABI. This appears to
have been overlooked when cygwin first added x86_64 support.

This patch fixes this issue by aligning the stack pointer as well as
the instruction pointer in the PTHREAD_CANCEL_ASYNCHRONOUS handling.

Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259117.html
Fixes: 61522196c715 ("* Merge in cygwin-64bit-branch.")
Reported-by: Takashi Yano <takashi.yano@nity.ne.jp>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nity.ne.jp>
---
 winsup/cygwin/thread.cc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 86a00e76e..2270a248b 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -630,6 +630,25 @@ pthread::cancel ()
       threadlist_t *tl_entry = cygheap->find_tls (cygtls);
       if (!cygtls->inside_kernel (&context))
 	{
+#if defined(__x86_64__)
+	  /* Need to trim alignment of stack pointer.
+	     https://learn.microsoft.com/en-us/cpp/build/stack-usage?view=msvc-170
+	     states,
+	       "The stack will always be maintained 16-byte aligned,
+	        except within the prolog (for example, after the return
+		address is pushed),",
+	     that is, we need 16n + 8 byte alignment here. */
+	  context._CX_stackPtr &= 0xfffffffffffffff8UL;
+	  if ((context._CX_stackPtr & 8) == 0)
+	    context._CX_stackPtr -= 8;
+#elif defined(__aarch64__)
+	  /* 16 bytes alignment required. Trim stack pointer just in case.
+	  https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?view=msvc-170
+	  */
+	  context._CX_stackPtr &= 0xfffffffffffffff0UL;
+#else
+#error unimplemented for this target
+#endif
 	  context._CX_instPtr = (ULONG_PTR) pthread::static_cancel_self;
 	  SetThreadContext (win32_obj_id, &context);
 	}
-- 
2.51.0

