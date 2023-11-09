Return-Path: <SRS0=DcfC=GW=upm.es=pedroluis.castedo@sourceware.org>
Received: from neon-v2.ccupm.upm.es (neon-v2.ccupm.upm.es [138.100.198.70])
	by sourceware.org (Postfix) with ESMTPS id D62EB3858D33
	for <cygwin-patches@cygwin.com>; Thu,  9 Nov 2023 19:05:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D62EB3858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=upm.es
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=upm.es
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D62EB3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=138.100.198.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699556722; cv=none;
	b=FvPtx5qpIYu9tKhhHwpVfCU48xWgvKBhntUyfc2viFKtI88QH+JxyzdDyDwig8NGlMtuaHrgWz22dCQS/OL4xlRcpms5d90Vka4DdWy0gif1FduGEEiPtH/k1NlwXg6LCZHNQ9S4Ghi1ZJ1DbfcO4/2D4D4SgzLkwKH86kbJg+E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699556722; c=relaxed/simple;
	bh=UK/64rao2aF0b9kFzkra9rtj+7BPUrG5k1imDCbf51c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=taj4pIbXVjQ1gDj3XjDvZyNr9N2PT3S21Axvrauct0EC8yBkS+dSHuZKON0xtJKX2hbx1g40ualLRgg7oN5GvIBSt9X3iBZgA0YmMIDjFhtetXAGx2UCGY3uxx6VvCroZOCgErN1OCdcLnUCUUXUqhHk1kJKNJeSRcgCGw3cTMM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain (unn-84-17-62-139.cdn77.com [84.17.62.139] (may be forged))
        (user=pedroluis.castedo@upm.es mech=LOGIN bits=0)
        by neon-v2.ccupm.upm.es (8.15.2/8.15.2/neon-v2-001) with ESMTPSA id 3A9J57bm029150
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Nov 2023 19:05:18 GMT
From: Pedro Luis Castedo Cepeda <pedroluis.castedo@upm.es>
To: cygwin-patches@cygwin.com
Cc: Pedro Luis Castedo Cepeda <pedroluis.castedo@upm.es>
Subject: [PATCH] fix(libc): Fix handle of %E & %O modifiers at end of format string
Date: Thu,  9 Nov 2023 20:04:41 +0100
Message-ID: <20231109190441.2826-1-pedroluis.castedo@upm.es>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_40,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

- Prevent strftime to parsing format string beyond its end when
  it finish with "%E" or "%O".
---
 newlib/libc/time/strftime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/newlib/libc/time/strftime.c b/newlib/libc/time/strftime.c
index 56f227c5f..c4e9e45a9 100644
--- a/newlib/libc/time/strftime.c
+++ b/newlib/libc/time/strftime.c
@@ -754,6 +754,8 @@ __strftime (CHAR *s, size_t maxsize, const CHAR *format,
 
       switch (*format)
 	{
+	case CQ('\0'):
+	  break;
 	case CQ('a'):
 	  _ctloc (wday[tim_p->tm_wday]);
 	  for (i = 0; i < ctloclen; i++)
-- 
2.42.1

