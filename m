Return-Path: <SRS0=dFmi=PD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 2B21D385DDDC
	for <cygwin-patches@cygwin.com>; Sun,  4 Aug 2024 21:49:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2B21D385DDDC
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2B21D385DDDC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1722808147; cv=none;
	b=UcBAepgXW5NS9GjohBHmNQV/xig0ewVqy0dweLTVb0WaRQvGxqkGDRxEa03VnsuiWEsGSKazzYrSVswlvnir56POk0XDdL3vroWiXyXBi+3W8PDJDgWOJYOWUZIyJucXoipEttQcpTvi/BIXCLSJ3Mh9R4NrcqYXAvqGJHOPnrc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1722808147; c=relaxed/simple;
	bh=0c6ykD+nyDuqfaEnwWaYEI4iXD9UbKSXyLGm02Hh4kI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pRJLbBGyOVVN2e0RUtV2g3ZSLKJfZh7nyYu9CVXdFOLKOueR8JWajLA+vHAWAnHxVCfa49UuGOhEnIlNv7wUuNGm7uI6QA+oSxH7YwXEUefyYHB/JgK5CfaoZ1NkhXRtgW4JTHobghOFZHgk7Qz9fyTyw/siudY9b21mDmuITZc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 66944170026F1DB4
X-Originating-IP: [86.140.193.104]
X-OWM-Source-IP: 86.140.193.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvdffueduteekhffhgfekgfdvteetgffhheevuefhkeegudevveeuleegudfftedunecukfhppeekiedrudegtddrudelfedruddtgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedtrdduleefrddutdegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqddutdegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.193.104) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 66944170026F1DB4; Sun, 4 Aug 2024 22:49:05 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/6] Cygwin: Fix warning about narrowing conversions in tape options
Date: Sun,  4 Aug 2024 22:48:25 +0100
Message-ID: <20240804214829.43085-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fix a gcc 12 warning about a narrowing conversion in case labels for
tape options.

> In file included from /wip/cygwin/src/winsup/cygwin/include/sys/mtio.h:14,
>                  from ../../../../src/winsup/cygwin/fhandler/tape.cc:13:
> ../../../../src/winsup/cygwin/fhandler/tape.cc: In member function ‘int mtinfo_drive::set_options(HANDLE, int32_t)’:
> ../../../../src/winsup/cygwin/fhandler/tape.cc:965:12: error: narrowing conversion of ‘4026531840’ from ‘unsigned int’ to ‘int’ [-Wnarrowing]
---
 winsup/cygwin/fhandler/tape.cc        | 4 ++--
 winsup/cygwin/local_includes/mtinfo.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/tape.cc b/winsup/cygwin/fhandler/tape.cc
index 0e235f16c..732fd1bb7 100644
--- a/winsup/cygwin/fhandler/tape.cc
+++ b/winsup/cygwin/fhandler/tape.cc
@@ -894,9 +894,9 @@ mtinfo_drive::get_status (HANDLE mt, struct mtget *get)
 }
 
 int
-mtinfo_drive::set_options (HANDLE mt, int32_t options)
+mtinfo_drive::set_options (HANDLE mt, uint32_t options)
 {
-  int32_t what = (options & MT_ST_OPTIONS);
+  uint32_t what = (options & MT_ST_OPTIONS);
   bool call_setparams = false;
   bool set;
   TAPE_SET_DRIVE_PARAMETERS sdp =
diff --git a/winsup/cygwin/local_includes/mtinfo.h b/winsup/cygwin/local_includes/mtinfo.h
index 03aabbfd0..46f8b1be9 100644
--- a/winsup/cygwin/local_includes/mtinfo.h
+++ b/winsup/cygwin/local_includes/mtinfo.h
@@ -101,7 +101,7 @@ class mtinfo_drive
   int set_compression (HANDLE mt, int32_t count);
   int set_blocksize (HANDLE mt, DWORD count);
   int get_status (HANDLE mt, struct mtget *get);
-  int set_options (HANDLE mt, int32_t options);
+  int set_options (HANDLE mt, uint32_t options);
   int async_wait (HANDLE mt, DWORD *bytes_written);
 
 public:
-- 
2.45.1

