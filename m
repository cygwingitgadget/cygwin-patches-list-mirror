Return-Path: <SRS0=8byy=UD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 7C72D3857B9F
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 00:03:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7C72D3857B9F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7C72D3857B9F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736553797; cv=none;
	b=WZYsYve0F8B9yDzZT/d7JWdwCvcmpF4r9hrf5sgNKgtc+41iMOw8mZP/BSZeN/zKqAN7UyHEaIFPWgXXeQW/Z2XYosd7FcQuRWQTFwCSI1mkL1FbX8cr1JzY14FkH4/opE9Fgx1m5wspro7U0QcmKLCK9XFi2HkNPNE+bS2XGaE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736553797; c=relaxed/simple;
	bh=LkrGnjNwhwbN+M1PMIbxiA9BogVPhjG3sWH2iffZTtU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=p1lC6/Ph+Qu+LJmJlqaNpmG/0lGWArI3hZIZ3c+WkG4kg42plYLcTDO01bwRiw/LeEkT5uiiJV2GOX5a2sqirY1Z/Y9h2qbWcqqWhONr17A6tZaXr3pMZz9XPjJ5XWL6gPAD6sDjIkzmRGNbrXwYGqBbTdeWCmBFlcPcER3a780=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C72D3857B9F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=DpcBc6Ib
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1939CB03C9;
	Sat, 11 Jan 2025 00:03:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id AB30B20025;
	Sat, 11 Jan 2025 00:03:15 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
Date: Fri, 10 Jan 2025 17:01:04 -0700
Message-ID: <b02f73ea85c1a9e6cd1a7ebc116fde12f5f6ccc4.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Stat-Signature: it74d9gqw8kbgiey3dbq36wcqhp1jgoc
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: AB30B20025
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19RUaFoRdlio7+QHwxyOYW6UhqU4grCtvU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=P75LgM+HS8gBNwl3NJJ8G0gGOj1zhK4fMxx1RtU4lk0=; b=DpcBc6IbGX9oMkbNGM4mo5LopfMeX/F68hOgxY1+9Adq+g4zqRfLgVHmqA2lj1+ZHVQGSx4weX6GLABeFhsWHlCeYJ1CbauQDBRU4FchVPUaAilHA8+tdxQlGCjTieAmxCoa7wYM0V8OsN1t7tLe8VZ5kE4GOrQZUAkeB8k4zyZ/pYbk8+1vwiaP09rEDWtAbs8TrOtLZq3pbFIQsdvVeUYTelEW9SzofrbGjcsaKo5xGqSDxV12+Ghnddfdk6lqWKMmX7T0wf05BjCI+5KyvqCHvVY37BkSxn0hWSEGkpTgBFY/RVQBArgBtEhxbLrjAvh6Flv2HRzOJRJTeldxPg==
X-HE-Tag: 1736553795-733099
X-HE-Meta: U2FsdGVkX1/FjKmCWk1vdJiGFe0Llq74G8XEkvsCTfpkWHpDChSacU/4t8Lnxxew4eNhqfEkuxTuz27xvOZ8NHo70+qLl97MqHW+LpbGnh+2Ps6ly3X6q/Q7HVpP1sHw0WgrTfHRTigEFpyH6RqlxA0GO7HZlpqjAqdczxXPGKgybkB+3r/GQGCBySXkqyUUc/SVJBrl7EEL97kmcEROofdwDbsZMQ85NO9hupSk1RwTUyAnI4fx2EPOq1DLvG8ngT/ZV5VFeJiMcoGycTqfUy5tdIwJk7/6c3e/nDkkqFxEl1f4xYCEYMJpxpjpN1aiMhT0tdzFTypgqYwE7qn/pOT+79Zg/Bepahb0L68JfrFit3W8pwpEfxXMMIxJsIawGVzwBqnGkOSofAhahHjPlg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add unavailable POSIX additions to Not Implemented section,
with mentions of headers and packages where they are expected.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 17c9ebf6f73f..2e14861802bf 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1678,9 +1678,17 @@ ISO/IEC DIS 9945 Information technology
 
 </sect1>
 
-<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
+<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
 
 <screen>
+    CMPLX			(not available in "complex.h" header)
+    CMPLXF			(not available in "complex.h" header)
+    CMPLXL			(not available in "complex.h" header)
+    _Fork			(not available in "(sys/)unistd.h" header)
+    dcgettext_l			(not available in external gettext "libintl" library)
+    dcngettext_l		(not available in external gettext "libintl" library)
+    dgettext_l			(not available in external gettext "libintl" library)
+    dngettext_l			(not available in external gettext "libintl" library)
     endnetent
     fattach
     fmtmsg
@@ -1692,17 +1700,29 @@ ISO/IEC DIS 9945 Information technology
     getnetbyname
     getnetent
     getpmsg
+    getresgid			(not available in "(sys/)unistd.h" header)
+    getresuid			(not available in "(sys/)unistd.h" header)
+    gettext_l			(not available in external gettext "libintl" library)
     isastream
+    kill_dependency		(not available in "stdatomic.h" header)
     mlockall
     munlockall
+    ngettext_l			(not available in external gettext "libintl" library)
+    posix_close			(not available in "(sys/)unistd.h" header)
+    posix_devctl		(prototyped in cygwin-devel "devctl.h" header)
     posix_mem_offset
     posix_trace[...]
-    posix_typed_[...]
+    posix_typed_mem_get_info	(not available in "(sys/)mman.h" header)
+    posix_typed_mem_open	(not available in "(sys/)mman.h" header)
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
     pthread_mutex_consistent
     putmsg
     setnetent
+    setresgid			(not available in "(sys/)unistd.h" header)
+    setresuid			(not available in "(sys/)unistd.h" header)
+    tcgetwinsize		(not available in "(sys/)termios.h" header)
+    tcsetwinsize		(not available in "(sys/)termios.h" header)
     ulimit
     waitid
 </screen>
-- 
2.45.1

