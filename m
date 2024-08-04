Return-Path: <SRS0=dFmi=PD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 3206E385842A
	for <cygwin-patches@cygwin.com>; Sun,  4 Aug 2024 21:48:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3206E385842A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3206E385842A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1722808135; cv=none;
	b=MLnKPkWOJ5EJk3A5bB5pQR2xdcGGQnCZO5wj+bPRT8V4WmUyfcCJG/3uwYULD+I7yLk+zfLBWwn5vGskkBGI2rvVmBBKWGFTOGcBODveXqf7dS6NL1H/CAMqUYVhiItXbQf1/beLLWdKNyfDwT0Cd6f9VsAqvdK4+kF3dzA44Mw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1722808135; c=relaxed/simple;
	bh=YtXj1P3F4Y75BL02hikay0GaM4b8dUrGGl1u8MD0FrQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=wDvS05pMdYsQIpnzmc2wJFE9GKaJ09OEAJeVO2MTnYdA0B8VdjvFRGvp060stBIy1wErmrz/2mJ9Cm/YY/dTtTMxhjLtztaVAalk73kdCudU9f3q1cwe+FxW4mN6gvyOLAdz6sjUsrcSRDRpNvUL1pd+5rpewJ3NSHs2/HdPm+c=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 66944170026F1CE1
X-Originating-IP: [86.140.193.104]
X-OWM-Source-IP: 86.140.193.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeffvddukeetudeljeefgfdvlefgteevueekleevieefueeileduvdehhfehiefgnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppeekiedrudegtddrudelfedruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedtrdduleefrddutdegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqddutdegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhn
	vgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.193.104) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 66944170026F1CE1; Sun, 4 Aug 2024 22:48:53 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/6] Cygwin: Suppress array-bounds warning from NtCurrentTeb()
Date: Sun,  4 Aug 2024 22:48:22 +0100
Message-ID: <20240804214829.43085-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This disables a warning seen with gcc 12 caused by intrinsics used by
the inline implementation of NtCurrentTeb() inside w32api headers.

> In function ‘long long unsigned int __readgsqword(unsigned int)’,
>     inlined from ‘_TEB* NtCurrentTeb()’ at /usr/include/w32api/winnt.h:10020:86,
> [...]
> /usr/include/w32api/psdk_inc/intrin-impl.h:838:1: error: array subscript 0 is outside array bounds of ‘long long unsigned int [0]’ [-Werror=array-bounds]

See also: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105523#c6
---
 winsup/cygwin/local_includes/winlean.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/local_includes/winlean.h b/winsup/cygwin/local_includes/winlean.h
index 5bf1be262..62b651be6 100644
--- a/winsup/cygwin/local_includes/winlean.h
+++ b/winsup/cygwin/local_includes/winlean.h
@@ -53,7 +53,10 @@ details. */
 #define __undef_CRITICAL
 #endif
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Warray-bounds"
 #include <windows.h>
+#pragma GCC diagnostic pop
 #include <wincrypt.h>
 #include <lmcons.h>
 #include <ntdef.h>
-- 
2.45.1

