Return-Path: <SRS0=moaP=MZ=scientia.org=calestyo@sourceware.org>
Received: from donkey.ash.relay.mailchannels.net (donkey.ash.relay.mailchannels.net [23.83.222.49])
	by sourceware.org (Postfix) with ESMTPS id 894643858C41
	for <cygwin-patches@cygwin.com>; Wed, 22 May 2024 00:36:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 894643858C41
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=scientia.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 894643858C41
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=23.83.222.49
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1716338199; cv=pass;
	b=m5i6r6MCEfJPbrl+6FybkSTEq340l8gvTQT+JWQ7ivF764J1ntQbybg1+vHb5mWC5FPuiRN9JrA7tPB6qvZcuOEjubTK0enchUJbRB+OYpMxOaLpC1/URCn4/ediaUIw0vkJvdOTJYKMxp9xoGKuk7tWHCi0X+X54ryMDR97QA4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716338199; c=relaxed/simple;
	bh=GNN8ivbMj4LcGEnZlzAuj/Ow2qNSHIR84drGIQDP41c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bkD1Wrlz0oxaaYQuk6dr2bGOZx/5t+a4q/ink6WJfyJArZYcXgO7j5bnoeCtkOHWCVF3/fyRHiZ4m3yQaWUgsPoWBM0eebQJsevMQZy7Zfns1iBP5TIbDRONoHHBt4zhVOmCcbF55PmvNf4agixRz6yvJHDxyXBYbTABuNysuIQ=
ARC-Authentication-Results: i=2; server2.sourceware.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8FB074C2205
	for <cygwin-patches@cygwin.com>; Wed, 22 May 2024 00:36:36 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id F22214C2300
	for <cygwin-patches@cygwin.com>; Wed, 22 May 2024 00:36:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1716338196; a=rsa-sha256;
	cv=none;
	b=qolJT2OVjjiMpIFmm+ZC+WW85uoXSW3iLJ/ZeA3L1TJD8/gerVahckaOIlxeGHJHHFcz/J
	VRSafI5JI88HIgdWE7IYu5OpCxBX/GgQkeoxwnPO/Ai3QD6gKl+LIjfPeFBTGoASS8S2C6
	cT+yuCV35k9knB9pN/HkW/PROqnEHPis1c52xMSo01iDTd52W+H4julcQ72gKyV7djVuVq
	ouVrgOFihOEj6u66MYth/4Vzn/RLqqn8LJWfqWHXRtMLLPzGMsynJKKDVtqds12CPSW4XC
	0R6Rf7CLUoQkBxFPN2azxm7bHgkd1kZPXpL1H1cSWDthq6gqvPyhVpdJaErypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1716338196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jBzHN2V/4C3vKnmJRkmVBobU3Vw48xiIHqtGe5Mk10=;
	b=S2cF4AXKxftXQEQoQsVKG8Om53IuWw4U4KODDTUW+i5uBZy005D3lOIiG5aSgqH+/hBQ3N
	aaIaAjg4mlzCDFefeR909wCu+zZP38NzYCLwMr1FoiuKvO82Vf/le4nAPYVfaW9EIRPPWZ
	4zheBCC+FhFyyZxD3eyP4icvzveJVFqkoSqH/ZFgC4Zet3Mx0oeOwMWWINanRoE/uOeFwc
	As/mDiCNkzcyymLr8Z3mMmsdv7Z8n/E3Tu5RfUAHayeBa0sPACgB4GW0ZNIy8JeGl1hfhj
	Ky/vqsbxHRMBVlMt6WdjcFUzUgTp607Kh+b14WgMjuESdQzJOWm8dxXXsHoj+Q==
ARC-Authentication-Results: i=1;
	rspamd-68bbddc7f5-5tcd8;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Shade-Troubled: 296029321b6bc6e0_1716338196474_1531817607
X-MC-Loop-Signature: 1716338196474:2466622876
X-MC-Ingress-Time: 1716338196474
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.1.237 (trex/6.9.2);
	Wed, 22 May 2024 00:36:36 +0000
Received: from p5090f664.dip0.t-ipconnect.de ([80.144.246.100]:55654 helo=heisenberg.scientia.org)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1s9Zy4-00000008Ph7-2OPo;
	Wed, 22 May 2024 00:36:34 +0000
Received: by heisenberg.scientia.org (Postfix, from userid 1000)
	id F249020C7598; Wed, 22 May 2024 02:36:29 +0200 (CEST)
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: cygwin-patches@cygwin.com
Cc: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
Subject: [PATCH 1/1] make `cygcheck --find-package` output parseable
Date: Wed, 22 May 2024 02:35:38 +0200
Message-ID: <20240522003627.486983-2-calestyo@scientia.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522003627.486983-1-calestyo@scientia.org>
References: <20240522003627.486983-1-calestyo@scientia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>

Both, package names and version numbers, are allowed to contain `-`, which makes
the output of `cygcheck --find-package` not parseable.

This changes the separator between package name and version to be a space, which
is not allowed in package names.

Signed-off-by: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
---
 winsup/utils/mingw/dump_setup.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/utils/mingw/dump_setup.cc b/winsup/utils/mingw/dump_setup.cc
index 050679a0d..e30f0f8ed 100644
--- a/winsup/utils/mingw/dump_setup.cc
+++ b/winsup/utils/mingw/dump_setup.cc
@@ -590,7 +590,7 @@ package_find (int verbose, char **argv)
 		{
 		  if (verbose)
 		    printf ("%s: found in package ", filename);
-		  printf ("%s-%s\n", packages[i].name, packages[i].ver);
+		  printf ("%s %s\n", packages[i].name, packages[i].ver);
 		}
 	    }
 	}
-- 
2.45.1

