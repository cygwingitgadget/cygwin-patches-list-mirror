Return-Path: <SRS0=06VY=HM=disroot.org=omikorin@sourceware.org>
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	by sourceware.org (Postfix) with ESMTPS id A12584B9DB48
	for <cygwin-patches@cygwin.com>; Sun, 20 Sep 2026 04:26:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A12584B9DB48
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=disroot.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A12584B9DB48
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789878369; cv=none;
	b=CGzjRQkfupfyB4Vr5gAosfHTfjLJFHMYkLC+xCKMBKD1d4VtfHlObvar+yoc+3i299xgySVuXZ5w6H96M6ddCMO5OShuqTmAAse7O47RbAUdgKG8wMgT91U9/GS5LAJggh8tKMxgcYvvPjE+xzVxMcCqgZnhWVEXPec5hRK1dMY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789878369; c=relaxed/simple;
	bh=rtOZseOUDXpV8tRhG5yFqj8YofC4eI/Y4/IktmPYhLQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=RP8gWD7+EeW+p5JrORs7jmBRsKdBRLwu+7eDba8Bmt0Ie1cXsefYuxlkLHU9vZIkzHyLM4cSX1wOrkn8IWKI5crOReogCxpQfwKfDFlzC2ociVkmzys7wrNJjIisNWjnxtKe7VdhQ2vXYwE1/0BvVAR0VuL+pRprcR2DbML4sSc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=brwEHB38
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A12584B9DB48
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=brwEHB38
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B53928110D;
	Sun, 20 Sep 2026 06:26:08 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zvDamSypH4y4; Sun, 20 Sep 2026 06:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1789878368; bh=rtOZseOUDXpV8tRhG5yFqj8YofC4eI/Y4/IktmPYhLQ=;
	h=From:To:Cc:Subject:Date;
	b=brwEHB38KF5QpG6aiFsa1YUfrbgQ7lyhDMPNDZrHam8laeQM+bC5r6o45BKTkxh8h
	 +6ix5yrKEPGI4dPeSYRIN1PGXGA3NTKRr0u7lqKraBuPH56Ky/FLAkOjoQhaC2nU2n
	 GGRKemcPLghR9OuAIoquL7PmlsQF3bDxmTkR9+BMKjVeWVBFVIyeGxqT5ATfVvKsU/
	 jkYvI/1jU6sVbk31JxzakHBj22fq3PqsjD25DQ7v5DERNOiFlL2bOUKvaU9dhM7XKD
	 ouc8VkRbhpx215ghPpaRj+NYlLk/h/1pJs2xblAyHfHnJi3kolTNK/H074GOuwhSW/
	 N+lj8h1hVvjWw==
From: =?UTF-8?q?Micha=C5=82=20Korczak?= <omikorin@disroot.org>
To: cygwin-patches@cygwin.com
Cc: =?UTF-8?q?Micha=C5=82=20Korczak?= <omikorin@disroot.org>
Subject: [PATCH] cygwin: define IPTOS_DSCP_VA in netinet/ip.h
Date: Sun, 20 Sep 2026 06:25:24 +0200
Message-ID: <20260920042524.4566-1-omikorin@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Define IPTOS_DSCP_VA (0xb0) according to RFC 5865 to complete the DSCP
code point definitions in <netinet/ip.h>. This fixes compilation for
utilities like openbsd-netcat.

I provide this patch to the Cygwin sources under the 2-clause BSD license.

Signed-off-by: Michał Korczak <omikorin@disroot.org>
---
 winsup/cygwin/include/netinet/ip.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/include/netinet/ip.h b/winsup/cygwin/include/netinet/ip.h
index 5db1bd9ce..9ce752870 100644
--- a/winsup/cygwin/include/netinet/ip.h
+++ b/winsup/cygwin/include/netinet/ip.h
@@ -83,7 +83,7 @@ struct ip {
 #define IP_MAXPACKET	65535	/* maximum packet size */
 
 /*
- * Definitions for DiffServ Codepoints as per RFC2474
+ * Definitions for DiffServ Codepoints as per RFC2474 and RFC5865.
  */
 #define IPTOS_DSCP_CS0		0x00
 #define IPTOS_DSCP_CS1		0x20
@@ -103,6 +103,7 @@ struct ip {
 #define IPTOS_DSCP_AF42		0x90
 #define IPTOS_DSCP_AF43		0x98
 #define IPTOS_DSCP_CS5		0xa0
+#define	IPTOS_DSCP_VA		0xb0
 #define IPTOS_DSCP_EF		0xb8
 #define IPTOS_DSCP_CS6		0xc0
 #define IPTOS_DSCP_CS7		0xe0
-- 
2.55.0.windows.5

