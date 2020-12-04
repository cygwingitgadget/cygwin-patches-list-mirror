Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst06.hub.nih.gov (nihsmtpxwayst06.hub.nih.gov
 [165.112.13.57])
 by sourceware.org (Postfix) with ESMTPS id 670C7385700A
 for <cygwin-patches@cygwin.com>; Fri,  4 Dec 2020 22:58:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 670C7385700A
IronPort-SDR: mVEFW2GwYgonHW6QzLyllQxOrueDdRmd7bOccQSokB1Q1CMpHPkKU0pNffDsOKoJhKoSWNvZC1
 yIDmsBnmcCh8wR/W7UNelYs98F0VSAp/L6tp3avKMkwvUZexgSTnOYIEmJ9fovxmc4es0fCjQI
 DacTAwuRvKdk8N5FGon+HuNVSqcEnIoQk4PYhT0nZbldziT9ByQ5RXdx83IiUxzcQFZQzMH4AT
 7riZUXMvtH76UM9KFU8+z9caDlgHlIe3+ZYlVhVvL8ixvmEyurD5DsVyVb4ZMT34XV5pcmNeHv
 phc=
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.78,393,1599537600"; d="scan'208";a="38772607"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail1.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2020 17:58:23 -0500
Received: from mail1.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail1.ncbi.nlm.nih.gov (Postfix) with ESMTP id 6F8DD340002;
 Fri,  4 Dec 2020 17:58:22 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix trace output for getdomainname()
Date: Fri,  4 Dec 2020 17:58:01 -0500
Message-Id: <20201204225801.48037-1-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FROM_GOV_DKIM_AU,
 GIT_PATCH_0, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Fri, 04 Dec 2020 22:58:25 -0000

---
 winsup/cygwin/net.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index 724e787fe..cec0a70cc 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -772,7 +772,7 @@ getdomainname (char *domain, size_t len)
 	  && GetNetworkParams(info, &size) == ERROR_SUCCESS)
 	{
 	  strncpy(domain, info->DomainName, len);
-	  debug_printf ("gethostname %s", domain);
+	  debug_printf ("getdomainname %s", domain);
 	  return 0;
 	}
       __seterrno ();
-- 
2.29.2

