Return-Path: <SRS0=acew=VR=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id D49263858D28
	for <cygwin-patches@cygwin.com>; Wed, 26 Feb 2025 06:38:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D49263858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D49263858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740551904; cv=none;
	b=AQVtPrBWafAhYjcXUn6tTo+RLoO6PCfcS+CGs/HrYGbOMX4HnjTzbmudrf8EbW5swPE7mv0za4m5fJCm69l7dQmQq0E0hLSiAm4T4e88QlCFeaGFsK+giksdDXv2iTwh2gsq6n3SW9X6qmsI5ocnwKRcfZSwH7Sqw4Ll96khEiI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740551904; c=relaxed/simple;
	bh=tMan2sNxlJOtPIFrT2UqLBiuOK2IELuZ1DEqLybRDyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UGLyQf569opVFDFDvuAg4TINFMCxhTVkd//yrGTZ9kUX/y7Fsyb9sBWSkGV+i5+F5AC7zPwWJ/RN6/lrYcbDpsLEm/UNqq64iGorFBxXJP1kH+PqClh77ZSnkoVQe6H5z+sxhSmu1ElbVvKB8sVXZdF2cKsitnM06McmMlJLEzI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D49263858D28
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 51Q6i0VS031939;
	Tue, 25 Feb 2025 22:44:00 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdN3RJ3C; Tue Feb 25 22:43:56 2025
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2] Cygwin: Add spawn family of functions to docs
Date: Tue, 25 Feb 2025 22:37:30 -0800
Message-ID: <20250226063815.52755-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013423.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013423.html>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In the doc tree, add a new section "Other system interfaces[...]" that
lists the spawn family of functions, most of the exposed cygwin internal
functions that a user might have use for, and some other functions
duplicating Windows or DOS interfaces that might have some utility.

---
 winsup/doc/posix.xml | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 43e860b0d..b9443eaae 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1762,6 +1762,41 @@ ISO®/IEC DIS 9945 Information technology
 
 </sect1>
 
+<sect1 id="std-other"><title>Other system interfaces, some from Windows:</title>
+
+<screen>
+    _alloca			(Windows)
+    _feinitialise
+    _get_osfhandle		(Windows)
+    _pipe			(Windows)
+    _setmode			(Windows)
+    cwait			(Windows)
+    cygwin_attach_handle_to_fd
+    cygwin_conv_path
+    cygwin_conv_path_list
+    cygwin_create_path
+    cygwin_detach_dll
+    cygwin_dll_init
+    cygwin_internal
+    cygwin_logon_user
+    cygwin_posix_path_list_p
+    cygwin_set_impersonation_token
+    cygwin_split_path
+    cygwin_stackdump
+    cygwin_umount
+    cygwin_winpid_to_pid
+    spawnl			(Windows)
+    spawnle			(Windows)
+    spawnlp			(Windows)
+    spawnlpe			(Windows)
+    spawnv			(Windows)
+    spawnve			(Windows)
+    spawnvp			(Windows)
+    spawnvpe			(Windows)
+</screen>
+
+</sect1>
+
 <sect1 id="std-notes"><title>Implementation Notes</title>
 
 <para><function>chroot</function> only emulates a chroot function call
-- 
2.45.1

