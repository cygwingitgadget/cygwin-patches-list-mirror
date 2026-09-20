Return-Path: <SRS0=06VY=HM=disroot.org=omikorin@sourceware.org>
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	by sourceware.org (Postfix) with ESMTPS id 3CCB54B9DB48
	for <cygwin-patches@cygwin.com>; Sun, 20 Sep 2026 04:33:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3CCB54B9DB48
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=disroot.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3CCB54B9DB48
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789878832; cv=none;
	b=ACwEADRzmJ/7DSUtOfi9HQtugV6RZ1L8Ro92khJWC0+NaKVDJzAcMJwmBFL9QZ/8cD8EvALUJiyFauy3Lzt5NV6D4650DTMCbMegWyyOmC9tJNlOMZZ9TLlAJvL9c8KCnq2q/jvPnplo6PtrLXDackXd5SzpIPieeWXmpEVDuic=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789878832; c=relaxed/simple;
	bh=/iOAEMZN2IerIc1rmCNGBsVPLn2mT2Puo7wLuV+Cdok=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=kXdcXwUiKgr7ydX14Nt6qCr2LIPFKjRdFjaDMJ1aQHazvhR3zBPUnOk1VRw/MV26IafAO+UXxncPm3bCxtCta8WVDNlC7E4l1jHnqJEiW4k1Xdca/4jtJnZR9Y2BReTiqey5Ihltl87LkPp9aMipK76CpmIgQs73/H7vp8+N5vo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=iHVrpH3C
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3CCB54B9DB48
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=iHVrpH3C
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1C97182C8F;
	Sun, 20 Sep 2026 06:33:51 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EvwL1ck2Rti4; Sun, 20 Sep 2026 06:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1789878830; bh=/iOAEMZN2IerIc1rmCNGBsVPLn2mT2Puo7wLuV+Cdok=;
	h=From:To:Cc:Subject:Date;
	b=iHVrpH3CXOFoW6N+BQEZth5xE/vZQrocVN3fkRrERhdrnMRaitZgcY9B5+vZu84Ox
	 QyURVjqzbP4e7eb373Xbe8mJ8gq45u6UXkAzIn2IWmyYHd7BLezXUR9fUfQh0rAIH4
	 bmupX/0BixeVtex44FmHeR4fkJ8AlNfBYEHZ26mWFHlU3xsk9qyjxYyh0qD4fOj/Fb
	 qLxsYkk+VsXpupb3HOe33lF9zHZiFvfm6K3m4pzwUcchHItBYvvst57jw4vf1+oGC3
	 jOi23hfgYnZMZRUx2XK42JJpmkjfRHQ2AQ7kwSz4C1+m0ZVR4RS18nDg9oEZzse6+c
	 vFYZbgtBFHgLQ==
From: =?UTF-8?q?Micha=C5=82=20Korczak?= <omikorin@disroot.org>
To: cygwin-patches@cygwin.com
Cc: =?UTF-8?q?Micha=C5=82=20Korczak?= <omikorin@disroot.org>
Subject: [PATCH v2] cygwin: define IPTOS_DSCP_VA in netinet/ip.h
Date: Sun, 20 Sep 2026 06:32:47 +0200
Message-ID: <20260920043247.4589-1-omikorin@disroot.org>
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
v2: Fix whitespace formatting to match surrounding code style.

 winsup/cygwin/include/netinet/ip.h | 1 +
 1 file changed, 1 insertion(+)
 
 winsup/cygwin/include/netinet/ip.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/include/netinet/ip.h b/winsup/cygwin/include/netinet/ip.h
index 5db1bd9ce..8b67a5c6e 100644
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
+#define IPTOS_DSCP_VA		0xb0
 #define IPTOS_DSCP_EF		0xb8
 #define IPTOS_DSCP_CS6		0xc0
 #define IPTOS_DSCP_CS7		0xe0
-- 
2.55.0.windows.5

