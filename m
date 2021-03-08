Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 5A549395185F
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 16:17:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5A549395185F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([68.147.0.90])
 by shaw.ca with ESMTP
 id JIZIlHyUyHmS3JIZKla4e2; Mon, 08 Mar 2021 09:17:18 -0700
X-Authority-Analysis: v=2.4 cv=MaypB7zf c=1 sm=1 tr=0 ts=60464e0e
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17 a=LF2dOfbMAAAA:8
 a=nz-5sxVJmLUA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=8WpNhovB5sBz0rFBwpsA:9
 a=QEXdDO2ut3YA:10 a=YJYmlWn9AAAA:8 a=9KdCY6IqqAMPIkOccvMA:9 a=dwsXynWkEd4A:10
 a=eLdUWIf9s_IA:10 a=B2y7HmGcmWMA:10 a=TmiWL2DCWjWbbQwbIu5r:22
 a=1jzlMsT2ksTeFbNwC4-K:22 a=yLDStRjdRdRizzv_QTJ6:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] cygwin-htdocs/links.html: update MinGW.org reference
Date: Mon,  8 Mar 2021 09:17:11 -0700
Message-Id: <20210308161712.11280-2-Brian.Inglis@SystematicSW.ab.ca>
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
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT,
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
X-List-Received-Date: Mon, 08 Mar 2021 16:17:20 -0000

This is a multi-part message in MIME format.
--------------2.30.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

---
 links.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


--------------2.30.1
Content-Type: text/x-patch; name="0001-cygwin-htdocs-links.html-update-MinGW.org-reference.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-cygwin-htdocs-links.html-update-MinGW.org-reference.patch"

diff --git a/links.html b/links.html
index ab2bb6e5d7d5..705e60c023a8 100755
--- a/links.html
+++ b/links.html
@@ -22,10 +22,10 @@ as well.  These binaries do not use the Cygwin DLL and only support the
 Windows APIs.
 </p>
 
-<h2>MinGW.org</h2>
+<h2>MinGW</h2>
 
 <p class="indent">
-<a href="http://www.mingw.org/">MinGW.org</a> is like Mingw-w64, but only
+<a href="https://osdn.net/projects/mingw/">MinGW</a> is like Mingw-w64, but only
 supports 32 bit Windows.
 </p>
 

--------------2.30.1--


