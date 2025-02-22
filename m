Return-Path: <SRS0=Yd2F=VN=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 364733858D34
	for <cygwin-patches@cygwin.com>; Sat, 22 Feb 2025 17:49:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 364733858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 364733858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740246560; cv=none;
	b=VtabZkuoxzLiMZQWabsmQyPdaW/ehxrNTpwG1zzw/+k1v2Ely2roknzdbmZaLnhR3DjGYoNQ7cr8YcCt04sy3qJrm0RRawTXZATpt1OCP9cxOAuANAjTEmwsfRsnjiuqHKINd4WU8JGFJKu85gn0Vb65shOOCrTiyK9IvYtNlUM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740246560; c=relaxed/simple;
	bh=wpjZ7GCB+14K88edRz+MKT8B31zFQ+xun+WQkxbslzs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=VfpJtBZDVv3pUQ922MbOgONCFGcbrrm93ugNgPQU+avX6yrGxoZRFYC2qGoWsTtj8gM7qO+J8p+BEQN7IKdGwttrsL0asLGiVAEnV27+wVN6lnnI4heBMQ8xzY6lNNY5ZxBtdFQYEZfYcJbl+dXmyluUvUwaSGRK6olomX5znL4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 364733858D34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=bJmSVtZ8
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 6C09AA3CE3;
	Sat, 22 Feb 2025 17:49:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id 0A1D320019;
	Sat, 22 Feb 2025 17:49:05 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v8 5/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
Date: Sat, 22 Feb 2025 10:48:22 -0700
Message-ID: <c6654d9a0db06e3e3402119d3a37d838590bccb4.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A1D320019
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: s3qzqj8b1yo5jwnkfworh661hnmyokfh
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/GqZjxFJUNNcaebHk0KRT/TiyYZUHj63A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=+hLxpeKnc/7M1ifzNSAZDb+5S6HqbrwGk/IciAZxv9A=; b=bJmSVtZ8Q/ZbNIvvRBBPtHCVZOK5uqwbwrmTVOa8DgegDXtVz+6lJeZkmmTFAbadOSGO9IsVgkt4bLNav8wRBS504Ig5WhBmqJeZqs3Aiu37W0ubuIK3U71ZFKLQvASuK+T6hZW9kjl0dU3N1VWMG7lzshIMhtiuam7n4iVI7Ez/TXN9KDoenvG6tVWbnTFruHx8MY3ifzfaqKZAjbwUTAHnPMK1zNqnDEJQrIf8Hy14JEKAnEB/thC0Rb2eL5N8yYByphDfiVr/xd+KOXp/YO0zYunL65d2Nhm/8P1Yn26ML8jC3rDqqFM6xblzhxz1SJ+GshrKqX2TB8fCGfWnWw==
X-HE-Tag: 1740246545-971205
X-HE-Meta: U2FsdGVkX18Z9N1Ji0RqYyEvhFSpru/xPqJcXjVGfaPOaRKtEHghAbD5Hv6EOFSdpwnk55ZH2dIMqg8ULDYprW++B2dau1oi/2DXBN+nlKTbXzY+a6y6Q1Lqi3ebb94l+/lhx0Q3H9PaT9gWfdIhoQpjo9TsT4OaUSRQBoS2s6qZ/zW9T/jpdUGKqRjjPhvbSBH+XLcSiXLVNBus6NAEM+MXs9fy0xNVKXQAslTS+Fi2ngmAxi6bTlTG5e4RKNdGCF0xXilQK+NP7os9e1CmiSsLnXVTSBThH8gXM59ogsuu9usPNlvKe+O4b14X1QgMJGvA58jVx68WkbxC03H/8C2/mlGCnWP8eOggk6es28McrMFaX0RhUBJCupyfkJeOY0e1uSrDBb3G4f464c2Cgg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Combine multiple notes after an entry separated by hyphen ") (" -> " - "

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 27c6593b2c44..25e0a2f78764 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1604,7 +1604,7 @@ ISO®/IEC DIS 9945 Information technology
 
 </sect1>
 
-<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
+<sect1 id="std-deprec"><title>Other UNIX® system interfaces, not in POSIX.1-2024, or deprecated:</title>
 
 <screen>
     _longjmp			(SUSv4)
@@ -1615,8 +1615,8 @@ ISO®/IEC DIS 9945 Information technology
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
@@ -1681,7 +1681,7 @@ ISO®/IEC DIS 9945 Information technology
     usleep			(SUSv3)
     utime			(SUSv4)
     utmpname			(XPG2)
-    vfork			(SUSv3)		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    vfork			(SUSv3 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
 </screen>
 
 </sect1>
-- 
2.45.1

