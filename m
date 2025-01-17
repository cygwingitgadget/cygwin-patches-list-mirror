Return-Path: <SRS0=IVSM=UJ=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 60E35383FB8F
	for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2025 17:03:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 60E35383FB8F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 60E35383FB8F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737133423; cv=none;
	b=DRZFwDtAagQiiyEjdvOZz9QJjNjcv8xvCwonm+9zJ//mTQwwzUNSPqRQUhcYxMyc00YSUiR5iYKxrnV3Cwx43dnNVSOxF3RMzP+tdsb1r5/Zyb3fnVqISxHKpnjC2R6cI1XHCMV3pHEu9V+auQx2eQd+M2LyrXYlWZOZhrb5XDg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737133423; c=relaxed/simple;
	bh=St/t+0MJpzWIR8bt50IVjt5kmSPlIV0irKR9Ws5BmZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=nBU311/08v4hXXkOf6uRBSEZ1xcxppsiZnW/Naxkyd6D0vWzkY1JwR0c/xjmmw1SBOPGgZ47ewEWe8CFzHxTNoIx9CL6airX8gfElUmm8pf9kfnnSOq84Guu3WPkUqYBCahAZ1yXixbMMsgXlprKxwoN6HCxEhIJDSueAJNsBCc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60E35383FB8F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=n28tOtUi
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DC20C1C78FC;
	Fri, 17 Jan 2025 17:03:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf17.hostedemail.com (Postfix) with ESMTPA id 710A51A;
	Fri, 17 Jan 2025 17:03:41 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v7 3/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
Date: Fri, 17 Jan 2025 10:01:06 -0700
Message-ID: <342fdec23f175f816177ac73945ed7fbf5538b90.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 710A51A
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: dr34gup3m64ogffxzzm8n3zx9bhnptmg
X-Rspamd-Server: rspamout03
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18P9cuzNPt2RoCD+XUZMD9GgKaj2bUKwr4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=31KcDp9XuFeli4obtobjGf7sYxJI2wmQD9HhlI4PdaM=; b=n28tOtUiveIdtDXbOGP6VYXc8lyJa0Z0L3HTHeu+gY4RaXnjM/drhUhVcqoK+GkhbepdvcKs9CEV29oxQclirzdPp1yRE4OLp7A4Sse/OXN/FaQdPC6FIV3E5CVaTOLlWUlxPCQ+TPvbYDCKZ/aafXNW1MZq48dBdcwHt41aAw7o7JZue6V07HXAysajed9Y/0Y/vwAMQpwpeAHzrF6hDP1MIyqzj7kpKXgf5/RuBfVyhQ1K0XevfHAudRQQkHPwofJEpwaw5x3HpfUkJfQQ7ZGAuNaIxTkMU3mBSDgV/R6Hhdahih+0WHngUzPtYys5bOqfCBvN0GjoKJYlsqlpxg==
X-HE-Tag: 1737133421-760476
X-HE-Meta: U2FsdGVkX19mQicdFUOBbjc8YWA0T34LSNIu8CbbC52J81ybebMki+IyqVFCzjO0G00B8lStmrIztb5WF96mlfMRD70K/I+TIfDFvQbnS2W1jRJpnjfSBxEfYt4ohV1uXneVNK67UlceL8tDVHnUngRsaBm3F+q3U3iLNYiZMfHBPa+26pXsbxJqEFmX0RvVlNMfn7N90SK066pWb2bdfREqf+jALrFtB/f2PxLBHNG8FkbKbDusqguV6XXljcWcAcnPLuZ6QwVE9uEFhZCJbmDxhneEkh8CdzAe+G35u8N6M7NUKHv8NJ7jF9hHee501JaKA3nzPaG+5VEgRookzVdagnGhYRiW6BPssNO8FlBbINdG8PmjlsHZ8EwnUFQtj7oq7yZvwdCRkeC/nVzLFQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add unavailable POSIX additions to Not Implemented section.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index ac05657d2246..7e66cb8fc1c0 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -16,6 +16,9 @@ ISO/IEC DIS 9945 Information technology
 - Issue 8.</para>
 
 <screen>
+    CMPLX			
+    CMPLXF			
+    CMPLXL			
     FD_CLR
     FD_ISSET
     FD_SET
@@ -554,6 +557,7 @@ ISO/IEC DIS 9945 Information technology
     jn
     jrand48
     kill
+    kill_dependency		
     killpg
     l64a
     labs
@@ -1466,6 +1470,8 @@ ISO/IEC DIS 9945 Information technology
     mempcpy
     memrchr
     mkostemps
+    posix_spawn_file_actions_addchdir_np
+    posix_spawn_file_actions_addfchdir_np
     pow10
     pow10f
     pow10l
@@ -1677,9 +1683,14 @@ ISO/IEC DIS 9945 Information technology
 
 </sect1>
 
-<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
+<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
 
 <screen>
+    _Fork			
+    dcgettext_l			
+    dcngettext_l		
+    dgettext_l			
+    dngettext_l			
     endnetent
     fattach
     fmtmsg
@@ -1691,17 +1702,28 @@ ISO/IEC DIS 9945 Information technology
     getnetbyname
     getnetent
     getpmsg
+    getresgid			
+    getresuid			
+    gettext_l			
     isastream
     mlockall
     munlockall
+    ngettext_l			
+    posix_close			
+    posix_devctl		(prototyped in cygwin-devel "devctl.h" header)
     posix_mem_offset
     posix_trace[...]
-    posix_typed_[...]
+    posix_typed_mem_get_info	
+    posix_typed_mem_open	
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
     pthread_mutex_consistent
     putmsg
     setnetent
+    setresgid			
+    setresuid			
+    tcgetwinsize		
+    tcsetwinsize		
     ulimit
     waitid
 </screen>
-- 
2.45.1

