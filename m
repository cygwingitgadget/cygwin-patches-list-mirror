Return-Path: <SRS0=kA/S=4F=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.131])
	by sourceware.org (Postfix) with ESMTP id 0357B3858D37
	for <cygwin-patches@cygwin.com>; Fri, 26 Sep 2025 13:23:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0357B3858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0357B3858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758893036; cv=none;
	b=V6p4lTjTADfrWqThjzrzG9quL/NhXU/bmVU6sMNakHYq85/CJPhrg/VSspr9GTIk2tRffbjX5Uh42ij5UhRxUx2h0HehGyoFnhWG8n6NWfBG3xfGbb560Z1thQ2J/KDB/NuOlGmhLTOITccWs8yqVSM8C1ecaaPIAGDPgF4VKlU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758893036; c=relaxed/simple;
	bh=gatXIFQni9gDBZITQsBcJHEN9WQ+vdSJXgkQRD1UtOU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VezjB7H5hyX1cSoClQ4KNBDPsFkMhlgXmRNDytVADC1PGtSz3FxexmXlgCX9CVKcprnATZOjwkvKWtjB1rLVPwLK0M9hPFUf52nWllVVNWBtoGdJzUmfvmpds/jhHLSIOYKbF4w4GvaAnHQSdN2iFbx4BgG2VQlXpCz+Tglga8s=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0357B3858D37
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68C798FD012133E8
X-Originating-IP: [86.144.41.51]
X-OWM-Source-IP: 86.144.41.51
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefftdelkeeuheektefgtdekhfegieetkedtkeefhfehffetfffhjedtjefggeenucffohhmrghinhepshgrmhgsrgdrohhrghdpghhnuhdrohhrghdptgihghifihhnrdgtohhmnecukfhppeekiedrudeggedrgedurdehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeegrdeguddrhedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugeegqdeguddqhedurdhrrghnghgvkeeiqddugeegrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttddupdhnsggprhgtphhtthhopedvpdhrtghpthhtohep
	tgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.144.41.51) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68C798FD012133E8; Fri, 26 Sep 2025 14:23:54 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: doc: Fix doubled .html typo in package server link
Date: Fri, 26 Sep 2025 14:23:39 +0100
Message-ID: <20250926132339.6503-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/doc/faq-setup.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
index 17b11c9fb..2d138020b 100644
--- a/winsup/doc/faq-setup.xml
+++ b/winsup/doc/faq-setup.xml
@@ -668,7 +668,7 @@ That's all there is to it.
 this purpose.  See <ulink url="http://rsync.samba.org/"/>,
 <ulink url="http://www.gnu.org/software/wget/"/> for utilities that can do this for you.
 For more information on setting up a custom Cygwin package server, see
-the <ulink url="https://cygwin.com/package-server.html.html">Cygwin Package Server page</ulink>.
+the <ulink url="https://cygwin.com/package-server.html">Cygwin Package Server page</ulink>.
 
 </para>
 </answer></qandaentry>
-- 
2.45.1

