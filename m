Return-Path: <SRS0=/1rB=D5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.131])
	by sourceware.org (Postfix) with ESMTP id 245484BA2E12
	for <cygwin-patches@cygwin.com>; Mon,  1 Jun 2026 12:51:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 245484BA2E12
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 245484BA2E12
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780318267; cv=none;
	b=wGbp+9cwghscrvcAJxpwijOB4DeLCxLsvrLi2OjZt3Nq5Sc7uqxKHq+l9iBYleLpYCdh38aAvBRqClHm1pQPAynaYOSBFuU0VMdwkRh0FF/YQXMchRzN3m9F+hu0d0Gpu6ZBXCffqsvp74zMmSxPgbGXuquOtxPmjzMP8Vv3X6w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780318267; c=relaxed/simple;
	bh=bmbWGSpPJVz5VwXBEP+EwBLhLXBaXoXhxQJh1c4qETc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YX3d/0gdPbXN63wudPplvFVLORR7VCGtqsWYwhVlM8ncC0anhAOOK736VR3h6bIu6Cj1yppEeW4cecI8Yh2AMzKtNhxwhEkohceh3bkK4J75s68oZHO8VOr/Z5arpVfiTgzF/etZ1ifxN0aWUF7RicE5Ay1ChRh4LpnIpdmRg3c=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 245484BA2E12
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 69E784C5035B433F
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFyX/6wWdUuDItGvmucOgVYAh+4DpsDoNv2Ov4+3ShJ2E2B4XwcO7KjNLYwmJuT3YNbF655c6QGAjykQsis4b1zaP6GFveOkPh9mOrQrTXFiTwZ6nzH0kCkqqbuF82kRr997jg+Cv2bODK+riKxSq505lmECM7j/YgbMe3fejRWAV35gtNVVWSF5+U7790W0emzXkXXDvLQhiR55XWTY+JTyuoBkKoYm5QISF//OviOuvQNtApYPOVBGOTZd5b1TKv0wdeYr9d90vdwHCWFyPI3qty3vMSpgfbVsvzqrLmKCOpRH9Kh0RwOTWvyXgE0bvO9B1HSQ6vcCLMdSueUjmeQenjylmaketlm4GELyrnzPV2GaeV1aZ4Q9n7FozB28w9zshujgGNLAQ9vOHsKJFrdEZCGfsehdfGHdzuGLVV9KbH5AjURIZcmVIjT2/YV6hRiZBigHzbJN7tL2dHLtUGYByyVB88Pc9wlYif2NN8p3HhlyS54jv1b31/pmP3mgqjM6rRYWlLVCfIsv8hRUMdqnorKIafdInAF7Pk9/O6esZNnlzW+pYGe8CfHVJoKrKWG2x2iMlrvg/v2+r1e0uBKQwtCRbuCo8R4WFu6fkQQgkAOylAsDcm6UDFNnQ4sCPKo8y0kU/4zymcDEbDK1XQXRzoQkaatcE0AH7CtzN5Jng
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (83.105.142.8) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E784C5035B433F; Mon, 1 Jun 2026 13:51:05 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Cygwin: Fix compilation of c8rtomb with gcc 16
Date: Mon,  1 Jun 2026 13:50:54 +0100
Message-ID: <20260601125055.1341979-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601125055.1341979-1-jon.turney@dronecode.org.uk>
References: <20260601125055.1341979-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

../../../../src/winsup/cygwin/strfuncs.cc: In function ‘size_t c8rtomb(char*, char8_t, mbstate_t*)’:
../../../../src/winsup/cygwin/strfuncs.cc:214:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
../../../../src/winsup/cygwin/strfuncs.cc:215:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
../../../../src/winsup/cygwin/strfuncs.cc:216:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
---
 winsup/cygwin/strfuncs.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/strfuncs.cc b/winsup/cygwin/strfuncs.cc
index 0cf41cefc..85427a0d1 100644
--- a/winsup/cygwin/strfuncs.cc
+++ b/winsup/cygwin/strfuncs.cc
@@ -211,9 +211,9 @@ c8rtomb (char *s, char8_t c8, mbstate_t *ps)
     {
       /* We already collected something... */
       int idx = ps->__count & 0x3;
-      char8_t &c1 = ps->__value.__wchb[0];
-      char8_t &c2 = ps->__value.__wchb[1];
-      char8_t &c3 = ps->__value.__wchb[2];
+      unsigned char &c1 = ps->__value.__wchb[0];
+      unsigned char &c2 = ps->__value.__wchb[1];
+      unsigned char &c3 = ps->__value.__wchb[2];
 
       switch (idx)
 	{
-- 
2.51.0

