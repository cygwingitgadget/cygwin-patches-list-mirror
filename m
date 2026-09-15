Return-Path: <SRS0=YFSk=HH=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id 17E5E4BA9020
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 12:27:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 17E5E4BA9020
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 17E5E4BA9020
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789475230; cv=none;
	b=DbzvEt3TmjhUo9E1/MKb7gAgP4h3s3vjUsClSRw0iN/V80qIFfC+EBw1C03eBEF9y4lOGZNfdkzQLVdQsaVDCKHgg39BxvR74xAvE4S9EtVlrczHuqBhXwHXIOFpEO+lPQU/Ws2Lp/34qR17S4PvDIdS8/M+pmuXo/OodkSxYbw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789475230; c=relaxed/simple;
	bh=jAaRRAuhxq3QbM/TOPbNnmvtKJB7ySnJodQDKpH/ZIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NC0fGWseXOKs+NPSt4InYrUoaGE8jApHECGZ2itXrapPsyTIakiAYIDG7DAWkHOWPIvuDb7NUCt9hQRrFP9iHD1jEGHRGkCyzZOgixcE/1Gl0bHfc6bJBridRWPaPMkCn0lQaXgLZ9di63nZQ0lNDXXLci3eFcRXL9cfLjmSmRM=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 17E5E4BA9020
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A71593507EF59BF
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGLik/id6LMt6I2prWlEDdVOsD8uZ91HsoF3bQpMnQ0XIzfq0phqEu5RzDN0SiKWt6p1hR6bs7SSv7PBE4RqfVSFKF6fwjeeiyEyzEI7drl9qLxnI29dX7pgpCFKUyiykR2OVLyZhx6xuikP3WodPlm2zhrbYOk7SP1lL9xlCSOQqISyrpH+3wvkR+CQd5zzHAHxM4IelJGscbb8ngtbhb5eFRja76SuH5+z62IV0PYIBsb8gp4EElUa6HO2QbTfkqO7Jm10DsmYym8kk1IhZyI1BvP6QDvTNU20JivuY6XE6liTMweEEjOJr6+04rMxdX6UPbOGA6wfzi14s8FE0LSOZ5S7iIpXQL3goW4yH0NvOcQVg9zGd1a3wEz3X73QyP/KwU9zY2lMhY0Lrt0O532uUfYAjCls/riLn++7LKjMVQRwQRB+A0OeVy3lWdxIOxkrs5i3RKYO4Wr18Urtnx6VRs+Hq73syIu88G44858rdI8HZaWj0mSdaZsCrEi43HPp8TaEwjIJ8lEzNVmG8ff1T7xH8T8B/TRIBhJfxb/Jnpl+wv7em/ym5VdIbO5mi2ZhdsSP5cTEQ3IfAf21Y9pmv8OdBrDomU19WFWJ539pHivo4NVa9tmdzharLz6o7pR6ucWBmePqHIlEl1XUFm1uD0bPIEJousDICBdfN0ZSQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (62.56.83.178) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A71593507EF59BF; Tue, 15 Sep 2026 13:27:06 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Explicitly pass include directory to winres
Date: Tue, 15 Sep 2026 13:26:53 +0100
Message-ID: <20260915122654.443226-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

(This is needed for a bootstrap build, where an installed
cygwin/version.h doesn't exist yet.)
---
 winsup/cygwin/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 06ae3b7de..22b7b14bd 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -465,7 +465,7 @@ uname_version.c: .FORCE
 version.cc: scripts/mkvers.sh include/cygwin/version.h winver.rc $(src_files)
 	@echo "Making version.cc and winver.o";\
 	export CC="$(CC)";\
-	/bin/sh $(word 1,$^) $(word 2,$^) $(word 3,$^) $(WINDRES) $(CFLAGS)
+	/bin/sh $(word 1,$^) $(word 2,$^) $(word 3,$^) $(WINDRES) -I${winsup_srcdir}/cygwin/include $(CFLAGS)
 
 winver.o: version.cc
 
-- 
2.51.0

