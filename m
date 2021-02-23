Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id A9D70384A01D
 for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021 20:48:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A9D70384A01D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([68.147.0.90])
 by shaw.ca with ESMTP
 id Eebflhj29nRGtEebglOhok; Tue, 23 Feb 2021 13:48:32 -0700
X-Authority-Analysis: v=2.4 cv=cagXElPM c=1 sm=1 tr=0 ts=60356a20
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=FQIUaudScV-YmkUJqO8A:9 a=QEXdDO2ut3YA:10
 a=w_pzkKWiAAAA:8 a=S1M8JrWu_8AMCfADIGQA:9 a=IYBem0ozU_IA:10 a=4ME_40Uw-3UA:10
 a=IZNN6_d4PyIA:10 a=l4lHiSdNQNsA:10 a=B2y7HmGcmWMA:10
 a=sRI3_1zDfAgwuvI8zelB:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] index.html: update Cygwin home page to show version 3.1.7
Date: Tue, 23 Feb 2021 13:48:23 -0700
Message-Id: <20210223204823.48389-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.30.0"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIvI4bCQO34veU0Wzn1JuOYrZd+mwnmMY4dDAzIY7NIjGj5uSVrFqvqQEBUY7eWi2DTNFLgTTtYjyZ6V4WnZShuvHNllEo7fjaCroyFMaf/+IbXOD8s3
 LsaTIU6Sv4IzqYs99wwykcM9vzHkG9Y3HsZuQXJZWI0/ZcSiuugUvZTHpSXCLIixUW0H81E2H5GaH/cPQZ3mosb1eEtnbxfdn39weH8JBLPd+7xbbn091d4l
 OUD1h2l84zwouO+gpzKLv1HE/LL2Y/godrFPaGfa1OQ=
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_HTML_ATTACH autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 23 Feb 2021 20:48:35 -0000

This is a multi-part message in MIME format.
--------------2.30.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

---
 index.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


--------------2.30.0
Content-Type: text/x-patch; name="0001-index.html-update-Cygwin-home-page-to-show-version-3.1.7.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-index.html-update-Cygwin-home-page-to-show-version-3.1.7.patch"

diff --git a/index.html b/index.html
index 037a9d87c968..7aafecea8c2e 100755
--- a/index.html
+++ b/index.html
@@ -50,7 +50,7 @@
 
   <p>
     The most recent version of the Cygwin DLL is
-    <b><a href="https://cygwin.com/pipermail/cygwin-announce/2020-July/009605.html">3.1.6</a></b>.
+    <b><a href="https://cygwin.com/pipermail/cygwin-announce/2020-August/009678.html">3.1.7</a></b>.
   </p>
 
   <h2 class="cartouche">Installing Cygwin</h2>

--------------2.30.0--


