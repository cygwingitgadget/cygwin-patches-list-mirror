Return-Path: <SRS0=2n0R=CE=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id D4B30385771A
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 00:16:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D4B30385771A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id 9qVRq57EKLAoI9x8cq7ctn; Fri, 16 Jun 2023 00:16:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686874586; bh=RsM7GzhovfVg2dixt4aKk4PRGehOjDc0g/rS5c8GOwE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=HGGccqHXefzpvuRNzOTBnCR6vC8w2RJpNS+HyHXIVOEdsHNoi9it53kSm5D9xOND4
	 6cMuXr5uAK78bAN70H5hl5fYJB85m5LLMuuxlJ1LXwKgTQegp+sdD/QvzTkAjvooPL
	 vFiKOttVMO4zi6k1Qa0qWIm/q0KRpjt3k7Q/ae07zLt7VjhInGjWSe1NavkviiZR8d
	 zZuYh2WCQV0+Ufw/Wr80CRd1F7dGWhV8uC94I9rk47NXbkjfXyFlCkCp1e620YstQM
	 nvQBPJ/JCSDTJMazbOZZs5JijHJqBfPDP59gLbqe9L44azkgJDez5MtuIctqexL4jM
	 S5MST+3uqdckQ==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id 9x8bqYYoZcyvu9x8cqO5Th; Fri, 16 Jun 2023 00:16:26 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=648ba9da
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=SFGEnkTAR_NGIzSk_2gA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 3/3] fhandler/proc.cc: use wincap.has_user_shstk
Date: Thu, 15 Jun 2023 18:16:24 -0600
Message-ID: <0afbace57b9ee469eb12fba773ef1347f24a8802.1686095734.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
References: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfB4ngQyAhLYZNhEs7lji38JrJqXj4915CFUD2UL99PNllRenMf8u5LnsK38dvgxx5e5XptqlccB7FYCT6uDe80SzFxGb8hFmfXg/+iIy5czKnHy2ewGi
 XEq9EDQA6yNDuL5n1sRQv0rrFKmQtoK9eEhB+HtTmjdYNpL7JH2FcPxD1ExNaU6SBzenwjHtRcLoxQpd6NrMDByrc3y3qlgXYXvcIrD+LXaM5uDVFobCqwqR
 0PLraPx4b2I5YvlB/6D3ZOBE4cHegLy9pWLhmQpI+E0=
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>
Message-ID: <20230616001624.lBhOf6LIa0cxRR9gUzNo76fT7OQNs2vJP8s-4tnNbV4@z>

---
 winsup/cygwin/fhandler/proc.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index 3c79762e0fbd..2eaf436dc122 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1486,12 +1486,12 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 /*	  ftcprint (features1,  6, "split_lock_detect");*//* MSR_TEST_CTRL split lock */
 
-      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
-      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
-					 && wincap.build_number () >= 19041)
+      /* Windows [20]20H1/[20]2004/19041 user shadow stack */
+      if (maxf >= 0x00000007 && wincap.has_user_shstk ())
         {
+	  /* cpuid 0x00000007 ecx CET shadow stack */
 	  cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
-	  ftcprint (features1,  7, "user_shstk");	/* "user shadow stack" */
+	  ftcprint (features1,  7, "user_shstk");	/* user shadow stack */
 	}
 
       /* cpuid 0x00000007:1 eax */
-- 
2.39.0

