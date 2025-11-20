Return-Path: <SRS0=Fsgb=54=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.240])
	by sourceware.org (Postfix) with ESMTP id D6BC33858C24
	for <cygwin-patches@cygwin.com>; Thu, 20 Nov 2025 14:47:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D6BC33858C24
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D6BC33858C24
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.240
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763650046; cv=none;
	b=ZJ2a9rwVU4wdF5JRplZLZWWgYIVY/uqpvQAd2gtnEdu/i2w7/nuXCKhC94Fpogh3/LI0yBr9Hk+9RiHsoIHKVbLMxD33RnH6GpNIGljcd4SIaRzr+9T1x2xTjHS2wKmxFLp6UG0rxkqsYaKPyk4B9bQJPDsi/r5V6JO+12lAwBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763650046; c=relaxed/simple;
	bh=dX5u3zYnP104enst7fBfs/DJls2J4dN19HEcnxdde4U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oJFCplJfIhoE2lxkfmJRaUnbGiuyBzFNHARgrmp8+p4O3TRKWqqOWYmm9O9iL2sWJYr2ve5ffSP94SgRnr+2l8Uiv5hSWhpPuOeqHisTzwfHOkMn1WCYrv/RNbQdX6v3KTSLn4ZOPcnBsxjxNR9u0zYY5KQ5t6e9g2sTOBW9a0I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D6BC33858C24
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1BDB0659E0A4
X-Originating-IP: [81.158.20.254]
X-OWM-Source-IP: 81.158.20.254
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekuddrudehkedrvddtrddvheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepthgrmhgsohhrrgdpihhnvghtpeekuddrudehkedrvddtrddvheegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduheekqddvtddqvdehgedrrhgrnhhgvgekuddqudehkedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtfedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhho
	nhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (81.158.20.254) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1BDB0659E0A4; Thu, 20 Nov 2025 14:47:24 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Add a configure-time check for minimum w32api headers version
Date: Thu, 20 Nov 2025 14:47:15 +0000
Message-ID: <20251120144715.4015-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Since we now require w32api-headers >= 13 for the
AllocConsoleWithOptions() prototype, add a configure-time check for
that, as I've mused about a couple of times before.

This maybe gives a more obvious diagnosis of the problem than 'not
declared' errors, and is perhaps more self-documenting about our
expectations here.

After this, most of the other conditionals on __MINGW64_VERSION_MAJOR
can probably be removed.
---
 winsup/configure.ac | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index e7ac814b1..4137f93eb 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -57,6 +57,21 @@ AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
 AC_CHECK_TOOL(STRIP, strip, strip)
 AC_CHECK_TOOL(WINDRES, windres, windres)
 
+AC_MSG_CHECKING([for required w32api-headers version])
+AC_COMPILE_IFELSE([
+  AC_LANG_SOURCE([[
+    #include <_mingw.h>
+
+    #if __MINGW64_VERSION_MAJOR < 13
+    #error "insufficient w32api-headers version"
+    #endif
+ ]])
+],[
+  AC_MSG_RESULT([yes])
+],[
+  AC_MSG_ERROR([no])
+])
+
 AC_ARG_ENABLE(debugging,
 [AS_HELP_STRING([--enable-debugging],[Build a cygwin DLL which has more consistency checking for debugging])],
 [case "${enableval}" in
-- 
2.51.0

