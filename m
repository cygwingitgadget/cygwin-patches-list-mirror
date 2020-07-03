Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.12])
 by sourceware.org (Postfix) with ESMTPS id C6B853851C09
 for <cygwin-patches@cygwin.com>; Fri,  3 Jul 2020 23:18:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C6B853851C09
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44]) by shaw.ca with ESMTP
 id rUwcj1xv462brrUwdjaQhc; Fri, 03 Jul 2020 17:18:11 -0600
X-Authority-Analysis: v=2.3 cv=LKf9vKe9 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=BqgCfznX7MUA:10 a=UsIZ3BRvCboA:10 a=w_pzkKWiAAAA:8 a=51kjSXn8rxP2_lg2150A:9
 a=fxnx5gAmH_237FX_:21 a=dM2mh-vyZaXv8Wvn:21 a=gRcj7Hltp7ieFsb-:21
 a=WK-i71OpKu4A:10 a=sRI3_1zDfAgwuvI8zelB:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Clarify FAQ 1.5 What version of Cygwin is this, anyway?
Date: Fri,  3 Jul 2020 17:17:17 -0600
Message-Id: <20200703231716.24076-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAXTTxjeojRBgRL4kJYVmQ1MqowRVnFnihinMtSC42yZCD3gzwIQK1MaMjHmjeWB1R20ve6EeX/VCffi2G09+N9QzI+zOvufETAiVwArYgqW3CTo0hA2
 mqAzpX6kboFF8IWNO2PyBCJIkI4yrKI1ySqtKaJ0Hpse8fn9bi3I/RyfC4B2IWWQldr3Cz/yqPk94aD1LLkp0f7cBDDq0fTso9e8TDBxnfqJ+7OAVeLrh8N0
 JbA5oZ1Ej9E67jgXsHalaQ==
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 03 Jul 2020 23:18:14 -0000

Relate Cygwin DLL to Unix kernel,
add required options to command examples,
differentiate Unix and Cygwin commands;
mention that the cygwin package contains the DLL.

---
 faq/faq.html | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/faq/faq.html b/faq/faq.html
index 1f2686c6..846e087e 100644
--- a/faq/faq.html
+++ b/faq/faq.html
@@ -53,16 +53,30 @@ such freedom is that the people who use a given piece of software
 should be able to change it to fit their needs, learn from it, share
 it with their friends, etc.  The GPL or LGPL licenses allows you those
 freedoms, so it is free software.
-</p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.what.version"></a><p><b>1.5.</b></p></td><td align="left" valign="top"><p>What version of Cygwin <span class="emphasis"><em>is</em></span> this, anyway?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p>To find the version of the Cygwin DLL installed, you can use
-<code class="filename">uname</code> as on Linux or <code class="filename">cygcheck</code>. Refer to each command's
-<code class="literal">--help</code> output and the
-<a class="ulink" href="https://cygwin.com/cygwin-ug-net/" target="_top">Cygwin User's Guide</a>
-for more information.
-</p><p>If you are looking for the version number for the whole Cygwin
-release, there is none. Each package in the Cygwin release has its own
-version.  The packages in Cygwin are continually improving, thanks to
-the efforts of net volunteers who maintain the Cygwin binary ports.
-Each package has its own version numbers and its own release process.
+</p></td></tr>
+<tr class="question"><td align="left" valign="top"><a name="faq.what.version"></a><p><b>1.5.</b></p></td>
+    <td align="left" valign="top"><p>What version of Cygwin <span class="emphasis"><em>is</em></span> this, anyway?</p></td></tr>
+<tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top">
+    <p>As the Cygwin DLL takes the place of a Unix kernel,
+	to find the version of the Cygwin DLL installed,
+	you can use any of the Unix compatible commands:
+	<code class="command"><strong>uname&nbsp;-a</strong></code>;
+	<code class="command"><strong>uname&nbsp;-srvm</strong></code>;
+	<code class="command"><strong>head&nbsp;/proc/version</strong></code>;
+	or the Cygwin command:
+	<code class="command"><strong>cygcheck&nbsp;-V</strong></code>.
+	Refer to each command's
+	<code class="option">--help</code> output or the
+	<a class="ulink" href="https://cygwin.com/cygwin-ug-net/" target="_top">Cygwin User's Guide</a>
+	for more information.</p>
+    <p>If you are looking for the version number for the whole Cygwin release,
+	there is none.
+	Each package in the Cygwin release has its own version, and the
+	<code class="package">cygwin</code> package containing the Cygwin DLL and
+	Cygwin system specific utilities is just another (but very important!) package.
+	The packages in Cygwin are continually improving, thanks to
+	the efforts of net volunteers who maintain the Cygwin binary ports.
+	Each package has its own version numbers and its own release process.
 </p><p>So, how do you get the most up-to-date version of Cygwin?  Easy.  Just
 download the Cygwin Setup program by following the instructions
 <a class="ulink" href="https://cygwin.com/install.html" target="_top">here</a>.
-- 
2.27.0

