Return-Path: <SRS0=IVSM=UJ=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id 5F5AC383FB93
	for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2025 17:03:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F5AC383FB93
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F5AC383FB93
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737133426; cv=none;
	b=POnHfCkSkyDUOeoPuFLd2MuhGYxrt5RqXgzKWi8fGrm/yQUfvUYrbmcnFPOJ4szPTRMVbu9E8icZpazsL5EBTAEzxsxVgOkT/9t8VhSWiGrxA4MrcpCnFEdBlbmPS/D8OFueyil+m+uWfIojIsEDweHvoUyhn4W6H+X0/yowugQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737133426; c=relaxed/simple;
	bh=puKz4dZxwjORraCWDnPsOFCEOjnQoS5NmzH9t8dJ3VI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=KiRAMjkj+OOBLLcfJzF4I48wDcu7+WvjTWgJCqZFzNgDnhJabiAV+Y3JDSFXnme8l8PUd8WGCFnse/AiMgEmsU/IjMGNT9aFy1zvNVUkrvftaDKaQCxct1LD/f8dOTsRApltjvg3e4kt4Ck9AepZHxzUh0YU00XU/CyF588fVuU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F5AC383FB93
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=o3NOvo+R
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 030FB1C794E;
	Fri, 17 Jan 2025 17:03:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf17.hostedemail.com (Postfix) with ESMTPA id 9E68817;
	Fri, 17 Jan 2025 17:03:44 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v7 5/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
Date: Fri, 17 Jan 2025 10:01:08 -0700
Message-ID: <f4c420cce26d744920e89ab7b4f48a77b5053fa6.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E68817
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: y8qep8edc373t8gc84jiwdaozb5qt9uo
X-Rspamd-Server: rspamout03
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18q/k6meFepHvvJDWAaquokv9sOqB/V8dQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=/og05biSxpOyU7FAxTE7bUXzb/4fLPgStvGze6a6S90=; b=o3NOvo+R1PiWlkg7+ZEUxgAUNZ1rxyn/7fVWkbXukkbTxAXUMxHSyDi+21oAAerLc6HW4wo9BENZDkFVSEiuYK1ulLpIn5dhp5rJTJWQ5RkK4KArWXrXI1CO0F2XXNHOG+HpIY2VW+LASKqv67cTvs8THZZ1O87k6K0ryPso+yY9jhw2ZuyU5FfUK+99edg93dTuLU6OsCBiE4t1mKTh1J+S6xmdwORu56wKOex0/gmKKSZbUMZAYF+6MRHiVl+UKVKx2fYHI939bMnpYQgd/r7Z2cs91WdLOiY+JaDaVGXt9/Na+Fo61uMgULfydPgJaHXwyO4Wtyal0f20waOrtA==
X-HE-Tag: 1737133424-116551
X-HE-Meta: U2FsdGVkX19Ok7/tF55jM8ohF/YOjQJr0rDtl8YtG0onTQsKmUfjxgl7YO1ZUOpT3a5xWho2oLU5Ealr3Pt0r+MLXRSfWb69L6+MYK/4cYdASUkUCaB55xnpdYbCds46kAWnxX0hs4bOqS+LeeJgmLwLXdyEaMiUD4EVqq01KYoEn2dq1OA9FpEFUtlt8/nMG7gK6PdU+/5Dl2+PzXZphKk3SfnPZCskr4QH1UsrlHpLoEwL4MCajHjp4Q3xHm0olLS3dy1pvR+Zel3g/dmhojCKC3jcvTw7sENZY0trzoXbkC0LgTnozTPIjFR4Uxk3GBSuR7slb+g=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Combine multiple notes after an entry separated by hyphen ") (" -> " - "

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index b0ef2bc37698..ca6ff2c902b1 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1292,6 +1292,7 @@ ISO/IEC DIS 9945 Information technology
     gamma_r
     gammaf
     gammaf_r
+    getdomainname
     getdtablesize
     getgrouplist
     getifaddrs
@@ -1537,7 +1538,6 @@ ISO/IEC DIS 9945 Information technology
     fegetprec
     fesetprec
     futimesat
-    getdomainname		(NIS)
     getmntent
     memalign
     setmntent
@@ -1614,8 +1614,8 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1680,7 +1680,7 @@ ISO/IEC DIS 9945 Information technology
     usleep			(SUSv3)
     utime			(SUSv4)
     utmpname			(XPG2)
-    vfork			(SUSv3)		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    vfork			(SUSv3 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
 </screen>
 
 </sect1>
-- 
2.45.1

