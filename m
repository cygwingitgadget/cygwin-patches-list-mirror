Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst06.hub.nih.gov (nihsmtpxwayst06.hub.nih.gov
 [165.112.13.57])
 by sourceware.org (Postfix) with ESMTPS id 0D9533858C39
 for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022 22:10:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0D9533858C39
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,289,1635220800"; d="scan'208";a="90608938"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail1.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 17:10:52 -0500
Received: from mail2.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail1.ncbi.nlm.nih.gov (Postfix) with ESMTP id 55F03340002
 for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022 17:10:52 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: Cygwin: A few fixes for local resolver
Date: Fri, 14 Jan 2022 17:10:11 -0500
Message-Id: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
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
X-List-Received-Date: Fri, 14 Jan 2022 22:10:54 -0000

I am sending this patch that has fallen through the cracks almost a year ago, because I switched to a different
project and it was forgotten.  I just discovered it now, and I also added the AAAA record processing as discussed
back on Feb 1, 2021.

- Use %S (instead of %s) when a wide-character output is due;
- Use native byte order for host and add port when doing I/O with DNS server;
- Use forward way for resolv.conf's "options" processing, so listing "debug" as a
  first option, will show all following option(s) as they are read;
- Re-evaluate debug output flag after each "options" processing as it may chance.
- Added processing of AAAA records


