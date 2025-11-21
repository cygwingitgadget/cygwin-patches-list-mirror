Return-Path: <SRS0=K2UI=55=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.146])
	by sourceware.org (Postfix) with ESMTP id 0C8E8385DC05
	for <cygwin-patches@cygwin.com>; Fri, 21 Nov 2025 13:25:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0C8E8385DC05
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0C8E8385DC05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.146
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763731509; cv=none;
	b=rtlP6YcZGgNGAfPOBsWBddsJ2CU+9RQTAJ3o5zuchKNuxRJ9icY9PqMCL47Wnw3dh2IGSXVeICZl0pvTzihAkSAHUKtK0ogBlQCL31+d6akS7rbL/1kR2bSngqCHkik3XMV/FzLDNiAag8pifntP86ubSJI7ysslCI9n9zA3H5E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763731509; c=relaxed/simple;
	bh=cGMuTnZ5WJr1iqAQ3bo1iLFooX9ff6c0bFEA0orfr00=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jVG1Cb6O+X9gPxG5JECIfMEdOVkiTX/MOJJpqbDhKXXZRkt5BJSzZZtkG/Y7bBwIIEugkPDxQn6QqQjq2jtXUrNDWxktIWs0QwUhflc4AweQ5yV+7GC66aSHMhMeZ4CanJA9owkHQwlCl5iUqq38l9hjUyC2TUB+nAkH2w74m14=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0C8E8385DC05
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1AB8067A3550
X-Originating-IP: [81.158.20.254]
X-OWM-Source-IP: 81.158.20.254
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedttdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekuddrudehkedrvddtrddvheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepthgrmhgsohhrrgdpihhnvghtpeekuddrudehkedrvddtrddvheegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduheekqddvtddqvdehgedrrhgrnhhgvgekuddqudehkedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtvddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhho
	nhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (81.158.20.254) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1AB8067A3550; Fri, 21 Nov 2025 13:25:04 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH v2] Cygwin: Add a configure-time check for minimum w32api headers version
Date: Fri, 21 Nov 2025 13:24:55 +0000
Message-ID: <20251121132455.8864-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Since we now require w32api-headers >= 13 for the
AllocConsoleWithOptions() prototype and flags, add a configure-time
check for that, as I've mused about a couple of times before.

This maybe gives a more obvious diagnosis of the problem than 'not
declared' errors, and is perhaps more self-documenting about our
expectations here.

After this, most of the other conditionals on __MINGW64_VERSION_MAJOR
can probably be removed.
---
 winsup/configure.ac | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index e7ac814b1..05b5a9897 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -57,6 +57,23 @@ AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
 AC_CHECK_TOOL(STRIP, strip, strip)
 AC_CHECK_TOOL(WINDRES, windres, windres)
 
+required_w32api_version=13
+AC_MSG_CHECKING([w32api-headers version])
+AC_COMPILE_IFELSE([
+  AC_LANG_SOURCE([[
+    #include <_mingw.h>
+
+    #if __MINGW64_VERSION_MAJOR < $required_w32api_version
+    #error "w32api-headers version >= $required_w32api_version required"
+    #endif
+ ]])
+],[
+  AC_MSG_RESULT([yes])
+],[
+  AC_MSG_RESULT([no, >= $required_w32api_version required])
+  AC_MSG_ERROR([required w32api-headers version not met])
+])
+
 AC_ARG_ENABLE(debugging,
 [AS_HELP_STRING([--enable-debugging],[Build a cygwin DLL which has more consistency checking for debugging])],
 [case "${enableval}" in
-- 
2.51.0

