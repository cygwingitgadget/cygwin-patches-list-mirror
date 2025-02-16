Return-Path: <SRS0=xgCx=VH=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id BBE483858D1E
	for <cygwin-patches@cygwin.com>; Sun, 16 Feb 2025 21:47:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BBE483858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BBE483858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739742430; cv=none;
	b=iT43JXaKlX3vfxSH1bFy3b5D+WMU5OUIUwUqlwsXRA3VZzhR4blnpK/hsfSQ/mNtGItb5CSbePfbil4fRlERBEL91NG5iHOgOUq7W93SoiHVq4gIz/pBFCDYFvb1jQf+KpWgYj2sZi1WQiCHV8qn2YMeyrO2P1515OQL/3WG1wQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739742430; c=relaxed/simple;
	bh=A1JNkmL42Tsd2mpuqM3BaGDVBLCyLzPuh2z1zrsFxLY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ubyxOw5SOwf4vVhQELwLAoN6T/mqeH1gUZWLMhz2bPr1ndSXp+ITDshYoxYQIxFdwf41+8JxXHEqGEVp5m/n4i83Ml7LLgjPOEqRCkh/mv2hqA5tT3mmyFTVogaOh8CWQHYT7LE1K4GSMByKM+klQnnkqWcQat3y5uahbE3lpJE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BBE483858D1E
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 51GLqsXl037629;
	Sun, 16 Feb 2025 13:52:54 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdVXBgQp; Sun Feb 16 13:52:47 2025
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Add spawn family of functions to docs
Date: Sun, 16 Feb 2025 13:46:49 -0800
Message-ID: <20250216214657.2303-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In the doc tree, change the title of section "Other UNIX system
interfaces..." to "Other system interfaces...".  Add the spawn family of
functions noting their origin as Windows.

The title change seems warranted as neither the spawn family of
functions nor the listed clock_setres() function originated from UNIX
systems.

---
 winsup/doc/posix.xml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 26d4fcfa4..3d2dac086 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1559,7 +1559,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
 
 </sect1>
 
-<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
+<sect1 id="std-deprec"><title>Other system interfaces, not in POSIX.1-2008 or deprecated:</title>
 
 <screen>
     bcmp			(POSIX.1-2001, SUSv3)
@@ -1568,6 +1568,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     chroot			(SUSv2)		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     clock_setres		(QNX, VxWorks)	(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     cuserid			(POSIX.1-1988, SUSv2)
+    cwait			(Windows)
     ecvt			(SUSv3)
     endutent			(XPG2)
     fcvt			(SUSv3)
@@ -1602,6 +1603,14 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     scalb			(SUSv3)
     setcontext			(SUSv3)
     setutent			(XPG2)
+    spawnl			(Windows)
+    spawnle			(Windows)
+    spawnlp			(Windows)
+    spawnlpe			(Windows)
+    spawnv			(Windows)
+    spawnve			(Windows)
+    spawnvp			(Windows)
+    spawnvpe			(Windows)
     stime			(SVID)
     swapcontext			(SUSv3)
     sys_errlist			(BSD)
-- 
2.45.1

