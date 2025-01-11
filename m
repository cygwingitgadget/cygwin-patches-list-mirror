Return-Path: <SRS0=8byy=UD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 752993857C5D
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 00:03:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 752993857C5D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 752993857C5D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736553800; cv=none;
	b=isOh/p+570BRZD9jD+hqG2qK9sa9ATVWn34dhZQ0mYS78a1M4UofiCQgEcVHSrxYRKMHXdyF6Lb/Logw7L5ZwJeZEEY7Lmet9127yGTeFa6Vd6kmBI9pw5xBO9HVZb57I7POjEAnGhh694mI2e1rLvTc1hGJc8sUA4fUxtJAeX0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736553800; c=relaxed/simple;
	bh=PnNP+wjBGI9WIjSMJ+r1dZ9fU4A1r++AT9Ygg5EUYE0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=cjvYcAVB9V5Hrqjwb/OGdjDOWJTC7y72bNDs7Q6C/nEd5TXbBSuzKZSPdNgDGXTMeZBihuBf334GgCcciZSMOdYzMk+HVzhErmf+zUM0SrZ2TlB6zLMXcCWkLVv6fc/diWLX2Jy5LISJLRzxGjxAfUV6/4IV8lfWmE7osU7mQ54=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 752993857C5D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=T+0KQgoJ
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 0BC95140F6E;
	Sat, 11 Jan 2025 00:03:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id AE4C120028;
	Sat, 11 Jan 2025 00:03:18 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 5/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
Date: Fri, 10 Jan 2025 17:01:06 -0700
Message-ID: <01f1853b12130b21d35849f4ee8427efffe523a5.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 78di8xkdjasd76p4xpikdt7bqqp6yu1w
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: AE4C120028
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18MSmNZ9HGKEbHJNv+Y9lwzbc7C41MAOAg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=FgAODw5+hRO27HyCsJZeayMW9gheldm2PUiqw1e6GVI=; b=T+0KQgoJEp+B23xR2rMEP2xu/+H/L4TioQgfe/OO/VVNTw6LcfdW8aoGYcwcpQw9RDm+DudAVpXeFooNn869MfucbwLMCfrCDvHAWnTm7h12YD1WoK6MBLdvu2tI/nYAUC+o96yUGR0W5bSSMjBXgJ3kdnr9WXRmdpw2TcGHOl4hjXfNNC+CE+6xv05lfFgxRUewbgNKc28PncsCgncMuYAEI80OEhJsh12tZc7HlyISP/lgQ8GeByD6qqmDv0sSmdc4HMx/QLo1rIw4LWpuCHcKeU+3cfeapZP9KqgKS80Q53u7FB5u7L9DdBr0VzTuZmUU1TftL1fYmF1eiucYig==
X-HE-Tag: 1736553798-338448
X-HE-Meta: U2FsdGVkX19geWq2pkX9J0ocM0xf9JwcqpVcZOCBEO/Y0M8ePA+jbgBkFuYo3sVVYyiWuwpuCBZq3QTfbvOdhXLWP9Uz3dKNAv1jAPX5+RAZBN24TQ/GzcxpSLykBC0Xf5qjhzdu63poDCbxAcIUXqG/k1b0cqiem2OpxmyeMIF0gOdqpNQSdkokT1wZc3Pj0qNWMKvI/I01QPu27yIWEkYKm+LNbFu0g2yqjJ3qnmXMFoZozChctVbOMBjpjB3Fl/rmxEzAzFpKzjGxuV1TjzFDH08sZ2alKSYb1fReNqewSTyjsG2A+ESnmew1yOzojWKAarJ37ZE=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Combine multiple notes after an entry separated by hyphen ") (" -> " - "

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 9b74bcf5a79b..17a051b4461c 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1607,8 +1607,8 @@ ISO/IEC DIS 9945 Information technology
     bcmp			(POSIX.1-2001, SUSv3)
     bcopy			(SUSv3)
     bzero			(SUSv3)
-    chroot			(SUSv2)		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    clock_setres		(QNX, VxWorks)	(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    chroot			(SUSv2 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    clock_setres		(QNX, VxWorks - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     cuserid			(POSIX.1-1988, SUSv2)
     ecvt			(SUSv3)
     endutent			(XPG2)
@@ -1673,7 +1673,7 @@ ISO/IEC DIS 9945 Information technology
     usleep			(SUSv3)
     utime			(SUSv4)
     utmpname			(XPG2)
-    vfork			(SUSv3)		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    vfork			(SUSv3 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
 </screen>
 
 </sect1>
-- 
2.45.1

