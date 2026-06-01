Return-Path: <SRS0=/1rB=D5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.6])
	by sourceware.org (Postfix) with ESMTP id 0506F4BA2E11
	for <cygwin-patches@cygwin.com>; Mon,  1 Jun 2026 12:51:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0506F4BA2E11
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0506F4BA2E11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.6
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780318266; cv=none;
	b=WM5dlgHDm+WAijpkv05P3PCKdNVukDODg+gwvuME+UHBchLWBTgAf3/YgOZ61arQo6fFA1RiRw50WlHfELvbmULIgdzf//Ooou19fkvUZcqD33HslRWTs9/TkyWUg5CcwBaGLwunOCJ6XIAj5kfyfOZj3HIObAErCLyhl7OQh2A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780318266; c=relaxed/simple;
	bh=ATN9VAmG+ewP4jBi9yAKI+WdoJMiFrZIDjlKGb9s7iQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hty4J6yZVN5gl+DNLx+ElbBa4gJs2tDlW5WKY2Ja96Nu4f4gjvVELcW9SfBDZa0UIvvEMPsS4zOyJiJ0R0W0aVfvWsvwRaVdpUfxu13eVn+V3321vO+9wjbltKkX1FK+PO7EbNwo4hLvL2reNFuYLqoZpyIyQQGweIkIOYigG1c=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0506F4BA2E11
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 69E784C5035B42EB
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFyX/6wWdUuDItGvmucOgVYAh+4DpsDoNv2Ov4+3ShJ2E2B4XwcO7KjNLYwmJuT3YNbF655c6QGAjykQsis4b1zaP6GFveOkPh9mOrQrTXFiTwZ6nzH0kCkqqbuF82kRr997jg+Cv2bODK+riKxSq505lmECM7j/YgbMe3fejRWAV35gtNVVWSF5+U7790W0emzXkXXDvLQhiR55XWTY+JTyuoBkKoYm5QISF//OviOuvQNtApYPOVBGOTZd5b1TKv0wdeYr9d90vdwHCWFyPI3qty3vMSpgfbVsvzqrLmKCOpRH9Kh0RwOTWvyXgE0bvO9B1HSQ6vcCLMdSueUjmeQcDsKOoxtlF7vxisDOpYJO5NqXybxCoRZw4xD329n7W9oASpbNI1t0afQTf7zOg/U0nvZC2nnNho7Giol6XS4HT2oftLouwQAH9ZCeahMiI8A9UJcfA/tle6s1srC22Fdwm9RT2DNKvb/zgprTMNr9f+UHGkG3a2voewKYweWiqxttbWRIgLS8lB3jAarSgSKYRgY9wT1XT45eOm818FjCd5yUpV0moWb48opNm+ZI7Kngm8U2W39hVhSKFa3F8KPlTA8Ts14vs+aF17kAgpHeSgPZJfNJ6n/X4cuZ/1ueFZg1YEZy8NrQfcmKpM0jP5me9iTbbdsDYxLuQVRrdwaMw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (83.105.142.8) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E784C5035B42EB; Mon, 1 Jun 2026 13:51:04 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Cygwin: Use bool return type for comparison operators in class pinfo
Date: Mon,  1 Jun 2026 13:50:53 +0100
Message-ID: <20260601125055.1341979-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601125055.1341979-1-jon.turney@dronecode.org.uk>
References: <20260601125055.1341979-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes an error when compiling with gcc 16:

> ../../../../src/winsup/cygwin/signal.cc: In function ‘int kill_pgrp(pid_t, siginfo_t&)’:
> ../../../../src/winsup/cygwin/signal.cc:373:13: error: return type of ‘int pinfo::operator==(_pinfo*) const’ is not ‘bool’
> ../../../../src/winsup/cygwin/signal.cc:373:13: note: used as rewritten candidate for comparison of ‘_pinfo*’ and ‘pinfo’

etc.
---
 winsup/cygwin/local_includes/pinfo.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/local_includes/pinfo.h b/winsup/cygwin/local_includes/pinfo.h
index 6f817de6b..fe8203fbc 100644
--- a/winsup/cygwin/local_includes/pinfo.h
+++ b/winsup/cygwin/local_includes/pinfo.h
@@ -227,10 +227,10 @@ public:
   void maybe_set_exit_code_from_windows ();
   void set_exit_code (DWORD n);
   _pinfo *operator -> () const {return procinfo;}
-  int operator == (pinfo *x) const {return x->procinfo == procinfo;}
-  int operator == (pinfo &x) const {return x.procinfo == procinfo;}
-  int operator == (_pinfo *x) const {return x == procinfo;}
-  int operator == (void *x) const {return procinfo == x;}
+  bool operator == (pinfo *x) const {return x->procinfo == procinfo;}
+  bool operator == (pinfo &x) const {return x.procinfo == procinfo;}
+  bool operator == (_pinfo *x) const {return x == procinfo;}
+  bool operator == (void *x) const {return procinfo == x;}
   _pinfo *operator * () const {return procinfo;}
   operator _pinfo * () const {return procinfo;}
   int operator !() const {return !procinfo;}
-- 
2.51.0

