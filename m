Return-Path: <SRS0=92hR=HC=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id E41B34BAE7F6
	for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2026 06:24:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E41B34BAE7F6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E41B34BAE7F6
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789021447; cv=none;
	b=uSTUwI5x3aEEUEVVeYz2lxgkZuI2lCKxUsMqMp7hdC0jei9gbsGozX7oQpG2YzxZkls7nM+rAlvGOHeoJwAhJ5kD+yJMJSpBw0rt5w9JiqXOIDvag6sUrT2FQrQ+8u0ILUTYH7u+U5lLKLOjivTT1RvMQXpwZAyMWZ+spJqX7us=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789021447; c=relaxed/simple;
	bh=VHX2aAAAfPtBSLyibCkYD+p7CDLsgaWl6QFP0S16/c0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=igIoLeuov+PZOVd+qa9PhHBfdpYRi89FQdcinHvMbmrqvyvR4beToitpujOpmd7kJ3flHkogigZUNs28B57ELkJ/WdHzgf8AWbJfuzCroOF74NwTQQmJ3x0V3Nf0FMtObPyNLec43R6x/yYb1JG4SlhcHEvzdONpmuHRfcFnYIM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=qoC2sWRl
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E41B34BAE7F6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=qoC2sWRl
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A49284042B;
	Thu, 10 Sep 2026 06:24:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf05.hostedemail.com (Postfix) with ESMTPA id 48B722001B;
	Thu, 10 Sep 2026 06:24:00 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH] Cygwin 3.6.10 release
Date: Thu, 10 Sep 2026 00:22:46 -0600
Message-ID: <c4835768b043a802c4fde5f68323005571c32567.1789021325.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 48B722001B
X-Stat-Signature: yds7nhnykimmem899p3gnn47cph8h1e6
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18G5SH7bg7JV3WO0u4N2mRVb9DLouIyVME=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=he; bh=icwOTSn9Lt4fAQOcipRFdpZK6zkVvObhI2DRaSIRRR8=; b=qoC2sWRlCV8fhnVAnjtIBwwafzOsQSuHkxmi+/xwSI8mwRHS5xtupasN+DOzib0wzec/dJ5NwMHaxCyQ/HIoObdeYivNek6/DHMUQh652m4PpgMUozfn5efBgiSyfFEqDQKLjanDHuJDLUWt6diCzZd4+DTFeuQOavUfwgBmQ/82CHEmyHvgEYq3EgUXXNH4zW7KhRHHKzTGR+MGyKlE2aXLC1yRQOnTTs9m3uzMvB/d07bRZKQv5KpHM5yum0zJPJpNUfv4wzB1aWeF0i7Q3Kxlv6wFHZX0fLM9VL6fpl1+z5QvTKIVrO0Z/plhxCJRZAeqeuPfB/Iu1niMBbx1KQ==
X-HE-Tag: 1789021440-767096
X-HE-Meta: U2FsdGVkX18ilHuoQ8lG4/wD+vFDxT9kR6pbzhOFJ9fdMUSdSYMznAxhsWPsMQnjEZBESHj++bbTLOB+KRF3Q13EYZgD/Z0r8kPdYRgIAyTD7Dw5C40RN4CcyioqTFBcLpN6AUpx8LTcwMPPSts4ps02A515RMuWWpqNTbwwOH/Cizq4atUUKKetB+xaz3afvCIIo/+Mziw2/Y8Cj6GM/2b2o7u7ZkL7iQ0AiQ1NONXnzJ3b9/QbpTTcup6I0fG758lVHV42awi57bpEwuaZmJTyuyqb2eV8DPBi61MWpDuF5naSc3Kc5ykrRvlxuquVzXSz57QnP6Zbr9vI0h1QSC66upZw83WuGf39teg2BGQVA9SgZJdRxYzK1PoLFnhY3f6lZ7g814OeI/rym13S14ZjWs0LfXsvp/5uOUXHfLF7XHD+vOmlbPTzKlD8cScGPIW4qUqwnxaWjLsa0roWjFFyied+fxJf/iOeh/5+IBnwkjXqx1lnlg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 index.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/index.html b/index.html
index 27c6fd68c289..3b81ee0eaae3 100755
--- a/index.html
+++ b/index.html
@@ -45,7 +45,7 @@
 
   <p>
     The most recent version of the Cygwin DLL is
-    <b><a href="https://sourceware.org/pipermail/cygwin-announce/2026-April/012969.html">3.6.9</a></b>.
+    <b><a href="https://cygwin.com/pipermail/cygwin-announce/2026-July/013133.html">3.6.10</a></b>.
   </p>
   <p>
     The Cygwin DLL currently works with all recent, commercially released
-- 
2.51.0

