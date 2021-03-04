Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 6982D3846077
 for <cygwin-patches@cygwin.com>; Thu,  4 Mar 2021 03:56:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6982D3846077
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([68.147.0.90])
 by shaw.ca with ESMTP
 id Hf5ileVhVHmS3Hf5jlKIPd; Wed, 03 Mar 2021 20:56:02 -0700
X-Authority-Analysis: v=2.4 cv=MaypB7zf c=1 sm=1 tr=0 ts=60405a52
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=nz-5sxVJmLUA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=_166spCgmPjDGNcvoiYA:9
 a=QEXdDO2ut3YA:10 a=CCpqsmhAAAAA:8 a=W5r6je3X3E5lmGmlb3UA:9 a=2wkYanB4cVUA:10
 a=B2y7HmGcmWMA:10 a=ul9cdbp4aOFLsgKbc677:22 a=BPzZvq435JnGatEyYwdK:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin-htdocs/lists.html: add note about attachment size
 limits
Date: Wed,  3 Mar 2021 20:55:56 -0700
Message-Id: <20210304035556.10550-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.0
Reply-To: patches
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.30.0"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJi6Uib2vVUzQ6ofHyrBl1W4jy/4s5pGm95RV3Irb1D0bqEscT0QSBzlXR9cEhAD9or7BfAMWng+O9vULC9249YiE3QHrfb99RCp+rqOucj2z2sqfC3a
 lQynVI4ZXNLdTeIGhfOq19FF7cNsPOnDQTQ2BL3J37YimzqwLD99VJh+aevK+pEPUL3FkguK8vaUbOJADRqgXVViGuMsRhdu/XV/YsRURl2ZB68by2HjnsoM
 s3woj35iE4EA2sGCU82LighXm310RR5b/yIIV1bG3tg=
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
X-List-Received-Date: Thu, 04 Mar 2021 03:56:05 -0000

This is a multi-part message in MIME format.
--------------2.30.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

committer please adjust based on actual size limits if different:
(256KB - 8KB email text)/1.37 overhead ~ 180KB
180KB * 1.37 overhead + 8KB email text ~ 256KB
---
 lists.html | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)


--------------2.30.0
Content-Type: text/x-patch; name="0001-cygwin-htdocs-lists.html-add-note-about-attachment-size.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-cygwin-htdocs-lists.html-add-note-about-attachment-size.patch"

diff --git a/lists.html b/lists.html
index fb784f8d2732..a3beda2d64e0 100755
--- a/lists.html
+++ b/lists.html
@@ -42,7 +42,14 @@ answer.</p>
 <div class="smaller">
 <ul class="spaced">
 
-<li><b>None of the below lists accept <a href="https://sourceware.org/lists.html#html-mail">html mail</a>.  Use plain text only.</b></li>
+<li><b>None of the below lists accept
+<a href="https://sourceware.org/lists.html#html-mail">html mail</a>.
+Use plain text only.</b>
+If you include attachments, please try to ensure they are in plain text,
+and limit them to about <b>180KB</b>, as with encoding and email overhead,
+any larger will exceed the size limits for emails to these lists.</li>
+<!-- 180KB * 1.37 overhead + 8KB email text ~ 256KB -->
+<!-- (256KB - 8KB email text)/1.37 overhead ~ 180KB -->
 
 <li><b>Please do not feed the spammers by <a href="acronyms/#PCYMTNQREAIYR">including raw email addresses</a> in the body of your message.</b></li>
 

--------------2.30.0--


