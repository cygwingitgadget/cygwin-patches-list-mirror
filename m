Return-Path: <SRS0=9m/t=NM=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 786523858D28
	for <cygwin-patches@cygwin.com>; Mon, 10 Jun 2024 04:47:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 786523858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 786523858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717994855; cv=none;
	b=iX0zmZpM0X+u/1gjRMWOFbttESx4FHJHvi7V8VkUkuED/NcOP0TsTfwlQIaYZASkiEJg0HeLcdd+PRUSnLTod6XX1GpvD4Gi5hVNqffy4sO+h0n+KtomifMiwrEM2D7Z0Tb0U/SFZdHyzjEdeNzc2UWINtG5JANnHxHFpWuzeuE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717994855; c=relaxed/simple;
	bh=mB7o+Nt2FPMnQZhoMzsJ1MXgoh51cCgx7mcmA/Yc7BE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JmxmmAnOHMMT8xYaLRj2+DuS6/5M9fJ2E4W8zjW1p0Zv4lmrusUejUWVuCQgRPWOFwW+QG9uG2zDFjz3cegaNsaOtut2XWZrjXe9kIA+V8Kf0Q+STgndfLUpVCVoTeRxKHgixYCH8J7DrzDoNt5Ff2AWC7QDWR0VgBKRbbtFrQo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 45A4qbgf088700;
	Sun, 9 Jun 2024 21:52:37 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdHvuSvJ; Sun Jun  9 21:52:27 2024
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] cygwin-htdocs: Upgrade 32-bit note to Q and A
Date: Sun,  9 Jun 2024 21:47:09 -0700
Message-ID: <20240610044718.8237-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Upgrade the note about 32-bit Cygwin to a full question and answer(s).
Also close a couple of HTML tags that need it.

---
 install.html | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/install.html b/install.html
index cdb9948b..c948e647 100755
--- a/install.html
+++ b/install.html
@@ -201,7 +201,7 @@ version for an old, unsupported Windows?</h2>
       </p>
       <p>
         Also use <code>--no-verify</code> with this URL.
-      </p
+      </p>
     </td>
   </tr>
   <tr>
@@ -242,7 +242,7 @@ version for an old, unsupported Windows?</h2>
       64-bit: http://ctm.crouchingtigerhiddenfruitbat.org/pub/cygwin/circa/64bit/2016/08/30/104235
       <p>
         Also use <code>--no-verify</code> with these URLs.
-      </p
+      </p>
     </td>
   </tr>
   <tr>
@@ -273,15 +273,23 @@ version for an old, unsupported Windows?</h2>
   Time Machine</a> for providing this archive.
 </p>
 
-  <h4>A note about 32-bit Cygwin</h4>
+<h2 class="cartouche" id="unsup32bit">Q: Can I still run unsupported 32-bit Cygwin?</h2>
+
+  <p>
+    A1: You can, but why would you?  32-bit Cygwin was frozen at version
+    3.3.6, around August 2022.  There have been and there will be no bug
+    fixes or security updates, and no new functionality added.  No longer
+    supported on the mailing lists; it has joined the choir invisible.
+  </p>
 
   <p>
-    The limited address space of 32-bit Windows means that
+    A2: If you're on 32-bit Windows as well,
+    the limited address space there means that
     <a href="/faq.html#faq.using.fixing-fork-failures">random
     failures in the fork(2) system call</a> are more likely.  Therefore, we
-    recommend using 32-bit Cygwin only in limited scenarios, with only a minimum
-    of necessary packages installed, and only if there's no way to run 64-bit
-    Cygwin instead.
+    recommend using 32-bit Cygwin only in limited scenarios, with only a
+    minimum of necessary packages installed, and only if there's no way
+    to run 64-bit Cygwin instead.
   </p>
 
   <p>
-- 
2.43.0

