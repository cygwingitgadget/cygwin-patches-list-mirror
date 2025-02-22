Return-Path: <SRS0=Yd2F=VN=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 0DC213858D39
	for <cygwin-patches@cygwin.com>; Sat, 22 Feb 2025 17:49:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0DC213858D39
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0DC213858D39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740246545; cv=none;
	b=nr4pwOowaBzxC/qbEDAEFc2M+R6VoFZ9HogEROJ7A11eElj3o20l7s168T8CxPb4mP0qE8wZU7PoKC4LqQ3AdfnXudtT38NeuAEGI4/N/ZnFelLnPK4hsgaQmfp7gOfZQL0UMq7KGGOdl+cwZLHZ71kRwLftk0vuzYk2jIg1NlI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740246545; c=relaxed/simple;
	bh=/raV0o/3mgW1gFtaUqE2HzmfoToqzOgir2LDzBwlQAY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Vr9LefzvKumMJdAVwjDobcQG9Cz+awIpiPxzr9jcpL6zFv+Y8thNC0LDEGJ6e9PqxckkYMbaQSYzb1k+aB7cBpybdsPq6cy1rpmZf4Osd7HUdKV77IsQvslvq24FT2BQbGSFwnDUNESKvSpBUXXmKL7xM8qiLAOdiH0w6rRSzRg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0DC213858D39
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=miwxjpwp
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6CCB11218F1;
	Sat, 22 Feb 2025 17:49:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id D88102000E;
	Sat, 22 Feb 2025 17:49:02 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v8 3/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
Date: Sat, 22 Feb 2025 10:48:20 -0700
Message-ID: <e69ee4fbd7901cf8e41568ddc88163f4b396c0b7.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D88102000E
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 934my7nkb5d7ewktsd1a1xgt641zshi6
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18rnMspHqhkaOHU1KQs9/htBtF2yGqMBUM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=PPn7tScnKEKwitAPfCvT//R1Euz0BsFz04cVOzIZPLg=; b=miwxjpwpANgek5LsRfHxWwh02sxLIu248q8b6MLyj/geXUULL6Sh4aCjVlbJyvTL7397svPKIWFX+Bw3Wfi8eWajp19X8hco4XIyF0aIq6r9HPB5nuehRidLlOWc1ZQ6itvdaMFb9LFgxvd+0eaE9u9HfH/v6IvZchumyT5PyqnFwp/asSIrwggL3eF19H9LWxX8SwsP9iN7JtHLZCmNj80oaHUnt4Q/sCsbPy9XDjrPz/R3A6IUu3tGTec5ZhhFpGjih2NQ9udr9lxFNb/7ee+asgpQ4NSaOuaytw5z/3btA26y9Argrq/fAlpOnLzUIcPrRVbgZ05Ap8/Iw6c0ug==
X-HE-Tag: 1740246542-171987
X-HE-Meta: U2FsdGVkX183185bO/mJjxFEJEMtiby1lC2l5muB+0z4OEtwOV5UBLtRCoaldkqiMI7474Yc7EaNhRelRmP0b2kany3wN8lJUiBLc8l6pRFHDvdsWvrEDtScn54UPKAwSrhhH+22JQpReAzK8swzrwsHGVDlPl1c90EMT06Vh5ovaTf8/A00Lybt5D1oSy34/1f8cX/V0xN0kqbiImSXmB+ptCLVMCBU0XD/RHFe7ihcy7tvjZHdLbCqjT9aGFPUEP+SB/nEFm8mN0aET0Dc1mdLZFpUjV5esi2gaBc12q/W3KXcY1QoWU/n1kgWxQvhqxM6lnJSKHttapZUnl2JshnnfcefTNdS29kAJmZau9HEduLD7N3cYIJYEgzi0/eiZ3nZADVPaAxLjJjvVyzY6A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add unavailable POSIX additions to Not Implemented section.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 31dbefd1fc48..20d73120f5d6 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1686,9 +1686,14 @@ ISO®/IEC DIS 9945 Information technology
 
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
@@ -1700,17 +1705,26 @@ ISO®/IEC DIS 9945 Information technology
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
     posix_mem_offset
     posix_trace[...]
     posix_typed_[...]
+    posix_typed_mem_get_info
+    posix_typed_mem_open
+    pthread_mutex_consistent
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
-    pthread_mutex_consistent
     putmsg
     setnetent
+    setresgid
+    setresuid
     ulimit
     waitid
 </screen>
-- 
2.45.1

