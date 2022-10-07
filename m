Return-Path: <crd@acm.org>
Received: from resqmta-h1p-028596.sys.comcast.net (resqmta-h1p-028596.sys.comcast.net [IPv6:2001:558:fd02:2446::4])
	by sourceware.org (Postfix) with ESMTPS id 1F1163858D28
	for <cygwin-patches@cygwin.com>; Fri,  7 Oct 2022 17:27:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1F1163858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=acm.org
Received: from resomta-h1p-027910.sys.comcast.net ([96.102.179.196])
	by resqmta-h1p-028596.sys.comcast.net with ESMTP
	id gnsUoFFpD4RFhgr8Jo4Hqs; Fri, 07 Oct 2022 17:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1665163655;
	bh=piZKuDW7nwJG3RiHlUYoqZBeryeHNDpSx1zl1F10/Hw=;
	h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
	b=qO4EWb7f62gnY3BUS8yVSGWJ+rzcZNLhxSgh5Arei9P1PJLPYO0zC0MDQt6sGTDos
	 W7xWCSrkf/vF1u8uKu6PDlnE7Vv57F+GeWRJrw2X3lxlZetFKyCXEWyifq3LTFLqVF
	 yzp08duC+iIrKSmeExxzNH8YGw4mMNnKsHGZKYukrAM+4edob9IPesDTjODZQV/iYI
	 UTpPIlGjgmL6SSxtXHyYYHewWq841y7LJS8A5gERA7s/bszEDzHIrAQgW+3x2xU3Ht
	 yhRGs0xLiS+6v4ANScAq2qOfLDRXdKa+2hArAcu52IqxDnwRyPZErvwVS0FcWu7jlZ
	 MSn9A0NwbfYZA==
Received: from localhost.localdomain
 ([IPv6:2601:547:c500:dbe:1951:24e:458f:9dd])
	by resomta-h1p-027910.sys.comcast.net with ESMTPA
	id gr7soaB7RbHKHgr7voROsB; Fri, 07 Oct 2022 17:27:12 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
From: Chad Dougherty <crd@acm.org>
To: cygwin-patches@cygwin.com
Cc: Chad Dougherty <crd@acm.org>
Subject: [PATCH 2/2] typo: that -> than
Date: Fri,  7 Oct 2022 13:26:43 -0400
Message-Id: <20221007172644.15168-1-crd@acm.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,GIT_PATCH_0,KAM_DMARC_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Chad Dougherty <crd@acm.org>
---
 contrib.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib.html b/contrib.html
index d5024694..04dc9726 100755
--- a/contrib.html
+++ b/contrib.html
@@ -132,7 +132,7 @@ in git format-patch format.</p>
       git format-patch [--cover-letter]
 </pre>
 
-<p>This will produce files with all of your changes newer that origin,
+<p>This will produce files with all of your changes newer than origin,
 making it easy for someone to review and, if you don't have write
 access, push.  Give them a final once-over.  Ideally you include a good
 description of your change with details what it does, how it works, what
-- 
2.38.0

