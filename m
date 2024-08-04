Return-Path: <SRS0=dFmi=PD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 30332385B508
	for <cygwin-patches@cygwin.com>; Sun,  4 Aug 2024 21:49:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 30332385B508
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 30332385B508
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1722808152; cv=none;
	b=IjenRkyNvG5AhYgUMwISgUHxvIrwkCKosW09Vsxl6BHltoAlRsyCiZfkoJnpbW4Wkhvlkaew1Fy/CLHW7bbwT1H9/rYjcnNjDNTEpf2gcsACrQu4hQjT1xljmBCHwuWsCVwKkgI3zn6kOj7oYztnDb+uEXhA6rDxUUEgkcC2Rw4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1722808152; c=relaxed/simple;
	bh=DT6jLOMJpzDIn3706s5lwPPYBM3tQSBo5VCNsMVfz1Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OCfuKbRA/ZWTXea2nedAxBE9gKTGeBFVN4f4F4g0RfGmC1ID3GPBQoRZWCwsFnVir+6REYogP2PqdNwKp5LkHIQP+2Prs+0l0mmHCj6/zPaD5NBpP5E5D1mY/6pCNu90p4aSWaaoofqHOQ2tNsvFV6pxHJNUKWnGxCS3f+Da0FY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 66944170026F1E04
X-Originating-IP: [86.140.193.104]
X-OWM-Source-IP: 86.140.193.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvdffueduteekhffhgfekgfdvteetgffhheevuefhkeegudevveeuleegudfftedunecukfhppeekiedrudegtddrudelfedruddtgeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedtrdduleefrddutdegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqddutdegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.193.104) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 66944170026F1E04; Sun, 4 Aug 2024 22:49:09 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/6] Cygwin: Fix warnings about narrowing conversions of socket ioctls
Date: Sun,  4 Aug 2024 22:48:26 +0100
Message-ID: <20240804214829.43085-6-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fix gcc 12 warnings about narrowing conversions of socket ioctl constants
when used as case labels, e.g:

> ../../../../src/winsup/cygwin/net.cc: In function ‘int get_ifconf(ifconf*, int)’:
> ../../../../src/winsup/cygwin/net.cc:1940:18: error: narrowing conversion of ‘2152756069’ from ‘long int’ to ‘int’ [-Wnarrowing]
---
 winsup/cygwin/net.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index 08c584fe5..b76af2d19 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -1935,7 +1935,7 @@ get_ifconf (struct ifconf *ifc, int what)
 	{
 	  ++cnt;
 	  strcpy (ifr->ifr_name, ifp->ifa_name);
-	  switch (what)
+	  switch ((long int)what)
 	    {
 	    case SIOCGIFFLAGS:
 	      ifr->ifr_flags = ifp->ifa_ifa.ifa_flags;
-- 
2.45.1

