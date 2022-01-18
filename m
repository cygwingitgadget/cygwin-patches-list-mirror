Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst05.hub.nih.gov (nihsmtpxwayst05.hub.nih.gov
 [165.112.13.52])
 by sourceware.org (Postfix) with ESMTPS id 6C6653858D39
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 22:41:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6C6653858D39
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,298,1635220800"; d="scan'208";a="90486806"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail2.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst05.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2022 17:41:19 -0500
Received: from mail1.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail2.ncbi.nlm.nih.gov (Postfix) with ESMTP id BFF861A0002
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 17:41:18 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: Cygwin: resolver: more fixes
Date: Tue, 18 Jan 2022 17:39:14 -0500
Message-Id: <20220118223916.43814-1-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FROM_GOV_DKIM_AU,
 SPF_PASS, TXREP,
 T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 18 Jan 2022 22:41:21 -0000

Proposed are two fixes for more little bugs in the resolver.  The first
one fixes the ID field returned in the response to match the ID of the
request (even in the case when the OS-supplied native resolver is used).
The second one is about the standard compliance (when the response is
relayed from the native OS resolver):  the targets in SRV records
should never be compressed.


