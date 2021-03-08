Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 5DE863951878
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 16:17:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5DE863951878
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([68.147.0.90])
 by shaw.ca with ESMTP
 id JIZIlHyUyHmS3JIZKla4e4; Mon, 08 Mar 2021 09:17:18 -0700
X-Authority-Analysis: v=2.4 cv=MaypB7zf c=1 sm=1 tr=0 ts=60464e0e
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=nz-5sxVJmLUA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=l_tzzKMxq7DTUOKwP8oA:9
 a=QEXdDO2ut3YA:10 a=Oo_AWuyYNfLdekRdCgwA:9 a=B2y7HmGcmWMA:10
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] cygwin-htdocs/packaging-hint-files.html: update categories
Date: Mon,  8 Mar 2021 09:17:12 -0700
Message-Id: <20210308161712.11280-3-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308161712.11280-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20210308161712.11280-1-Brian.Inglis@SystematicSW.ab.ca>
Reply-To: patches
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.30.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIWWkaYxVayM+BnQwCs1dyQVVcHOKtlemuOrjWsMSWFMZBP60Txfj9gRsGvTP75ZZBQBP68NrEX7PchcoxTm0QcNFLA23TdWtZsg75OgorXhtIYjNqjr
 WPliAHFruZ2iBYfW1FMPHmE5ujZ0nzGVa/hP9hS1hKWiNS0yQ6b//K1dUqIAm8baaANoi40ZRn8m2srylNJ3sLyZwmKMLSWJtkBayHzZPW/4elHfMHMLRbR0
 XjaW/KXQvNCCS7tid9Ml0gLuonq5XRLJi9rG+hyvjVE=
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP, T_HTML_ATTACH autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 08 Mar 2021 16:17:20 -0000

This is a multi-part message in MIME format.
--------------2.30.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

---
 packaging-hint-files.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


--------------2.30.1
Content-Type: text/x-patch; name="0002-cygwin-htdocs-packaging-hint-files.html-update-categories.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0002-cygwin-htdocs-packaging-hint-files.html-update-categories.patch"

diff --git a/packaging-hint-files.html b/packaging-hint-files.html
index 025bbb4e5830..ceecd206737e 100755
--- a/packaging-hint-files.html
+++ b/packaging-hint-files.html
@@ -130,8 +130,8 @@ No actual moles will be harmed during execution of this game."
       <p>Archive</p>
       <p>Audio</p>
       <p>Base</p>
-      <p>Comm</p>
       <p>Database</p>
+      <p>Debug</p>
       <p>Devel</p>
       <p>Doc</p>
       <p>Editors</p>
@@ -146,7 +146,6 @@ No actual moles will be harmed during execution of this game."
       <p>Mail</p>
       <p>MATE</p>
       <p>Math</p>
-      <p>Mingw</p>
       <p>Net</p>
       <p>Ocaml</p>
       <p>Office</p>
@@ -157,6 +156,7 @@ No actual moles will be harmed during execution of this game."
       <p>Ruby</p>
       <p>Scheme</p>
       <p>Science</p>
+      <p>Security</p>
       <p>Shells</p>
       <p>Sugar</p>
       <p>System</p>

--------------2.30.1--


