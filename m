Return-Path: <crd@acm.org>
Received: from resqmta-c1p-023465.sys.comcast.net (resqmta-c1p-023465.sys.comcast.net [IPv6:2001:558:fd00:56::5])
	by sourceware.org (Postfix) with ESMTPS id F248E3858D28
	for <cygwin-patches@cygwin.com>; Fri,  7 Oct 2022 17:26:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F248E3858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=acm.org
Received: from resomta-c1p-023266.sys.comcast.net ([96.102.18.234])
	by resqmta-c1p-023465.sys.comcast.net with ESMTP
	id gmFlo7rvWf0y0gr7Qo8AZS; Fri, 07 Oct 2022 17:26:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1665163600;
	bh=b6H3q0MDMA+67M3Usxqh53gR7JAaO0uNrcG4BQjqpCQ=;
	h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
	b=JKRAA0sT+7DRH/7WmnE+kNO9HdwthJr7+quhraBM7RuqDksidOCrDL0v9p8fOZ/FX
	 A//Kpj31+3v8t542aMbLPg+YYRiY/KD8Jf8cjeo6LYSBeO1Rf7GQh+HnTsB2OXZp/a
	 bojoRdrEqa+1jC1YBhP9RDJYBcpcpS7eQHOXSn1LfMikzWrhTAXDv/t/62KM01rQlH
	 V9fRYGF5ofdmluykaFW1T8OwWrhBFsEXXsLSVGxfAP3VOmDxgPF4gKncn54rye3CkT
	 2Rkm7wTDcYDlTZgKy2CDzqji87h6UGxdHurTKEfrihL6Q7Mg/z9EiRt0QNSyouwjSB
	 SDW9wNto04AKg==
Received: from localhost.localdomain
 ([IPv6:2601:547:c500:dbe:1951:24e:458f:9dd])
	by resomta-c1p-023266.sys.comcast.net with ESMTPA
	id gr6voOYV5R8NVgr72oV4X6; Fri, 07 Oct 2022 17:26:17 +0000
X-Xfinity-VMeta: sc=49.00;st=legit
From: Chad Dougherty <crd@acm.org>
To: cygwin-patches@cygwin.com
Cc: Chad Dougherty <crd@acm.org>
Subject: [PATCH] add a reference to the official SPDX License List
Date: Fri,  7 Oct 2022 13:25:56 -0400
Message-Id: <20221007172556.15154-1-crd@acm.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,GIT_PATCH_0,KAM_DMARC_NONE,KAM_SHORT,SPF_HELO_PASS,SPF_SOFTFAIL,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

this page contains the concrete license identifiers that packagers are
likely to want to include in their cygport files

I found this list quite useful and had several slightly incorrect
variations in my first attempt at creating a cygport before discovering
it.

Signed-off-by: Chad Dougherty <crd@acm.org>
---
 packaging-hint-files.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packaging-hint-files.html b/packaging-hint-files.html
index 38ea2c8e..8c299ba3 100755
--- a/packaging-hint-files.html
+++ b/packaging-hint-files.html
@@ -406,7 +406,7 @@ version: <i>version</i>
     <p>
       <code>license</code> is
       a <a href="https://spdx.github.io/spdx-spec/SPDX-license-expressions/">SPDX
-      license expression</a> for the open source license(s) of the package
+      license expression</a> for the <a href="https://spdx.org/licenses/">open source license(s)</a> of the package
       source code.
     </p>
   </li>
-- 
2.38.0

