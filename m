Return-Path: <SRS0=jqfJ=HV=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id 034CA4B9DB4F
	for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2026 13:15:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 034CA4B9DB4F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 034CA4B9DB4F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790687724; cv=none;
	b=TcHk6qOPyY2MTlzfZobDg8qyXXWu+zylF2r4LCn/DNzviLtP7JsFAVaCWx7GpNwaTohogV+15wDxTvXxMtYJSwHiSd6zXmmRzsD4k7B9aTarfP0Vni+/mKVJTZptZ6VVh91XJ/vsfPHEvCfbaWofCweFoPP/kq/Rixq4g7opxPA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790687724; c=relaxed/simple;
	bh=zkLymHP0HNTxk7yH2Ag2f36xPw/Me413/4GrpU+nIYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tpJZDXYmWFU9QXqSru8BYilDccVKbQW8j/6ktdkxyNOrb2VFLSPc4lVciB4QNlHIHtEnZQU5hK2rr1s2i5+bCpFebf5uDkXGo8XFGuGazclAe+DicydJdBhqVPM8BMoWJO+ql6EwzbErLUf1USHNGqbY3ASRv2DpWSp5ol9MhM8=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 034CA4B9DB4F
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715F5F0ACE58EA
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEAPs4JrLaC/AcolZHJKhQzbfMuWeGJ16ivKydokNFA7Eli7XAVhJRyveiRWs2pgR2wmHduU4R+w1BIe29Yh2OSsV+lOWR0kxAdgU2FH4nMwJMpsvqu0zidf+o9MfWq6AO4kmhy9oh1kTYg4JvnSSRoJa5PzM5Lx5pQr4SKhwF3Adl9PRdnAVFoWc5PBh5lhGWShDmsxcahKGUBW7BtE7NaumdKa0YhZfcyqc/nWa59wCJaa9VNmiZr6Vj8rz8ZTYEZ5hMaHgR63fbIa/mCmOpQsobrNfmlQI56cRtrbAjQ0AvKAqZXYOEzltn9PshWppGq+/WT+M8Ch/0FaNJ/yslKGnlUrCApQ7WXwnH8tMeza9HigeOBPiO2a1ocZRqbSvHBqB/ctYjmjk0tWcAzZ1WLekdacoF7LkcNjC+F1eJoJ/fsGbxDIfR6UDh7H7vggZ05e8zegatI9ny4kCFuF8jTbbSXLSSU3231KK4/Sh7B2ROp/+UXviuC0QFAWNNr+u06DVZ3LFcCsE9+VT6/xG8cW37bsGvb12+14iD09Umg45x7yXpeVX/YH3tu3cDQ6OgIkS4M8fhq9aFo9OTqEORXRj9Up1hHLw5lVJBM/R/BE2MYGdXOv0POV/ORwofxxJ8Wfu4uBAc0Hnk1pxsgIXQBFd+LmkHETcyqdEE8XxFmog
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (62.56.83.178) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715F5F0ACE58EA; Tue, 29 Sep 2026 14:15:14 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Drop _pei386_runtime_relocator stub on aarch64
Date: Tue, 29 Sep 2026 14:15:07 +0100
Message-ID: <20260929131507.239767-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On aarch64, don't emit a stub _pei386_runtime_relocator into the
libcygwin.a import library, purely for satisfying a reference which ld
no longer makes.
---

Notes:
    The specific ld version mentioned here is a "forward-looking statement".
    The actual version of ld this change appears in is not yet known.

 winsup/cygwin/Makefile.am                |  6 +++++-
 winsup/cygwin/lib/_cygwin_crt0_common.cc | 16 ++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 22b7b14bd..ba281779b 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -83,9 +83,13 @@ LIB_FILES= \
 	lib/premain1.c \
 	lib/premain2.c \
 	lib/premain3.c \
-	lib/pseudo-reloc-dummy.c \
 	lib/pthreadconst.S
 
+if TARGET_X86_64
+LIB_FILES+= \
+	lib/pseudo-reloc-dummy.c
+endif
+
 FHANDLER_FILES= \
 	fhandler/base.cc \
 	fhandler/clipboard.cc \
diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
index a22528ab4..4d4f63c7e 100644
--- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
+++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
@@ -222,11 +222,19 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
   u->pseudo_reloc_end = &__RUNTIME_PSEUDO_RELOC_LIST_END__;
   u->image_base = &_image_base__;
   /* This is actually a dummy call to force the linker to load this
-     symbol for older apps which need it. Unfortunately, ld for x86_64
-     still emits this symbol when linking against static libs which
-     require pseudo relocation, so we can't drop this call and the
-     dummy function just yet. */
+     symbol for older apps which need it.
+
+     Unfortunately, ld prior to 2.48 emits this symbol for PE+ targets when
+     linking against static libs which require pseudo-relocation (even though
+     it's unncessary for v2 pseudo-reloc, which has always been available for
+     those targets), so we can't drop this call and the dummy function just yet.
+
+     Linking for aarch64 targets is assumed to be using ld 2.48 or later, which
+     no longer emits that reference.
+  */
+#ifdef __x86_64__
   _pei386_runtime_relocator (NULL);
+#endif
   return 1;
 }
 } /* "C" */
-- 
2.51.0

