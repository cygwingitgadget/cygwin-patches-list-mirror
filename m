Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 2519038515F6
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 19:43:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2519038515F6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2519038515F6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736970214; cv=none;
	b=tFtlSaZUN2/fupWNJnse2iX1fY2OweJozn40o8D2P17SsSiK8VAhl8F2ewzDfWe4G+ysI2os01dtBvWqnHc9rVkhzKwKKE+i6HI8jgWDfV20gsSspbC+oSv1dDc+Gggi4RxdH/zvP0y58UwhTWWuZf7KAuhjna2iW+VghVMnjZM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736970214; c=relaxed/simple;
	bh=F+my2qesOGjtXCx1TlJREjLR6IP42ZERxjUf0b/pThg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=pxzpoZak9avKOqEU+QAKA5A+dMlOknjQhl+wV2qMlgO6QTJDuSNuaKVXVwcrc5niSOu1FS2aiD8luOzikVSVR0jeZIK8Y09lFUXZBzm6eeFVNWVFv93fiNKUaRHjXZ/TlTJzHbB1/n7v1oNBevriTvP5hBsbcCdPo7Vgz3MkVWM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2519038515F6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=PrI2ZkY0
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A8FBF120135;
	Wed, 15 Jan 2025 19:43:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 5552C20030;
	Wed, 15 Jan 2025 19:43:32 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v6 5/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
Date: Wed, 15 Jan 2025 12:39:22 -0700
Message-ID: <f6784ba01723e392f2ab777adf27329923a82b84.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5552C20030
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: h8j9aimcwpidm7e9q98esrutn9a49dan
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+8Dp5PufWHXgzStrpdQ2AnDGa6hBepGZc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=ThK8NKt/WjcYNBcEtVyQkXHaKyhvd4ilu9BLJD9bssk=; b=PrI2ZkY0lyQYe+RhoMgtX4mgU/Nhw0IuUKHFxD6X4zJ+KEIJTdGpKJwI2DoAwfGqFh3izK1eqc2ghuU8pZeWPfFPIWXFgZ1i5l6oMFA/mGCeYadf7mvXbQV761Smwb4y4uKnDGSzP1FmQDsdNZEg2kby9HxHOqQwKszFVWzj0oNRNu0UxX7YAAky9bLpzlKHP5fUUDMkgld55iStrnXNwkENPSpHmkwL+l5/rkAVxGL6+whMwfvKAP6R6CGEnUPY6XBQ+8OLWnXCam7XfIq7b+sI2SEjR8F9ZV0IbDdDwnAqgprRokVMnfTi+VsOQJ7JLItwmyKHs9+kic9OsOEI2g==
X-HE-Tag: 1736970212-405791
X-HE-Meta: U2FsdGVkX1/gUkgSKIHOlr/oMORbIl+6CXQq7kBNRdqv/mdDoCfWxUL21q9z7xuuSfwgCGRj+RVYwyUsptQivctyxUfjSrvAZy2RAsEw1o2iAXi62AcAxH/BfTLmE6+yeVZB8ucbd5wuDTqeN+an7wusuGNDI9eES0+HlIYQaJ8qOOaHjQorNQ5I0R9IK3RNVJSckRBsllVacfnm6Y11z6/mVkYSW5JNqNhID/U+xkaakBLsTcHMzpgowIu+vi7Wwr/Vs8pdvfjukzSlicjfG2qLlJO3hVUw0JMtMlwHxq2NUTYTZvpFnof+jV5u4tCVLbCxWP6EPz8=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Combine multiple notes after an entry separated by hyphen ") (" -> " - "

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index ac05f6972ee7..0c9e492d62ad 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1610,8 +1610,8 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1676,7 +1676,7 @@ ISO/IEC DIS 9945 Information technology
     usleep			(SUSv3)
     utime			(SUSv4)
     utmpname			(XPG2)
-    vfork			(SUSv3)		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    vfork			(SUSv3 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
 </screen>
 
 </sect1>
@@ -1700,11 +1700,6 @@ ISO/IEC DIS 9945 Information technology
     getresgid			(not available in "(sys/)unistd.h" header)
     getresuid			(not available in "(sys/)unistd.h" header)
     gettext_l			(not available in external gettext "libintl" library)
-<<<<<<< HEAD
-    isastream
-=======
-    kill_dependency		(not available in "stdatomic.h" header)
->>>>>>> 5888275d7f48 (Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries)
     mlockall
     munlockall
     ngettext_l			(not available in external gettext "libintl" library)
-- 
2.45.1

