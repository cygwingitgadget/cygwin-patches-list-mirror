Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id C80523840C24
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 17:35:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C80523840C24
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id twvejQJ3jYYpxtwvfjDF4k; Fri, 10 Jul 2020 11:35:20 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17 a=w_pzkKWiAAAA:8
 a=UB0UgkEmhwAVqxie5Z0A:9 a=cTIoticSJXVV-ev_:21 a=7c-70XkDUcg6bGs9:21
 a=c9-Lal56WJz_DM2L:21 a=FhXMovWKs60A:10 a=ylEQVlorgLYA:10 a=WK-i71OpKu4A:10
 a=uvLZkzHzGa8A:10 a=sRI3_1zDfAgwuvI8zelB:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3] Clarify FAQ 1.5 What version of Cygwin is this, anyway?
Date: Fri, 10 Jul 2020 11:34:51 -0600
Message-Id: <20200710173450.46857-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGaFXJtVXZ0/sDa4bNLfYVvM6LNS3vBxQz8X3hlAAMlqznYwhk8lfs/t3hbnlSXshfhCMlyZa14fKcI4pztQi7zyUu9eWodZibdXubK7xzb8U/v1r4hH
 StAdofRxTK412YL4/cQ+dTsrPAU5jRmj8ggoec9Fo9i4REMRIObMTFMgnGBzO5vn82RFEShz7sGqBB+32vTW7GR4nAy+jiSfLBZqHZuUmLH/JaWBVFx9TEQa
 g6dbTHo0FIr2D4kF5SvyfQ==
X-Spam-Status: No, score=-14.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 10 Jul 2020 17:35:24 -0000

Patch to:
	https://cygwin.com/git/?p=cygwin-htdocs.git;f=faq/faq.html;hb=HEAD
as a result of thread:
	https://cygwin.com/pipermail/cygwin/2020-July/245442.html
and comments:
	https://cygwin.com/pipermail/cygwin-patches/2020q3/010331.html

Relate Cygwin DLL to Unix kernel,
add required options to command examples,
differentiate Unix and Cygwin commands;
mention that the cygwin package contains the DLL.
---
 faq/faq.html | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/faq/faq.html b/faq/faq.html
index 1f2686c6..8659db5d 100644
--- a/faq/faq.html
+++ b/faq/faq.html
@@ -53,22 +53,39 @@ such freedom is that the people who use a given piece of software
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
+    <p>To find the version of the Cygwin DLL installed,
+	you can use:
+	<code class="command"><strong>uname&nbsp;-a</strong></code>;
+        as you would for a Unix kernel.
+        As the Cygwin DLL takes the place of a Unix kernel,
+	you can also use any of the Unix compatible commands:
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
+	<code class="package">cygwin</code> package containing the Cygwin DLL
+	and Cygwin system specific utilities is just another (but very
+	important!) package.
+	The packages in Cygwin are continually improving, thanks to
+	the efforts of net volunteers who maintain the Cygwin binary ports.
+	Each package has its own version numbers and its own release process.
 </p><p>So, how do you get the most up-to-date version of Cygwin?  Easy.  Just
 download the Cygwin Setup program by following the instructions
 <a class="ulink" href="https://cygwin.com/install.html" target="_top">here</a>.
-The setup program will handle the task of updating the packages on your system
-to the latest version. For more information about using Cygwin's
-<code class="filename">setup.exe</code>, see 
+The Setup program will handle the task of updating the packages on your system
+to the latest version. For more information about using Cygwin's Setup program,
+see 
 <a class="ulink" href="https://cygwin.com/cygwin-ug-net/setup-net.html" target="_top">Setting Up Cygwin</a>
 in the Cygwin User's Guide. 
 </p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.what.who"></a><p><b>1.6.</b></p></td><td align="left" valign="top"><p>Who's behind the project?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p><span class="bold"><strong>(Please note that if you have cygwin-specific
@@ -692,7 +709,8 @@ user with <code class="literal">cygrunsrv -u</code> (see
 information).
 </p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.using.path"></a><p><b>4.5.</b></p></td><td align="left" valign="top"><p>How should I set my PATH?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p>This is done for you in the file /etc/profile, which is sourced by bash
 when you start it from the Desktop or Start Menu shortcut, created by
-<code class="literal">setup.exe</code>.  The line is
+the Cygwin Setup program.
+The line is
 </p><pre class="screen">
 	PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
 </pre><p>Effectively, this <span class="bold"><strong>prepends</strong></span> /usr/local/bin and /usr/bin to your
@@ -889,8 +907,7 @@ services like sshd) beforehand.</p><p>The only DLL that is sanctioned by the Cyg
 you get by running <a class="ulink" href="https://cygwin.com/install.html" target="_top">setup-x86.exe or setup-x86_64.exe</a>,
 installed in a directory controlled by this program.  If you have other
 versions on your system and desire help from the cygwin project, you should
-delete or rename all DLLs that are not installed by
-<code class="filename">setup.exe</code>.
+delete or rename all DLLs that are not installed by the Cygwin Setup program.
 </p><p>If you're trying to find multiple versions of the DLL that are causing
 this problem, reboot first, in case DLLs still loaded in memory are the
 cause.  Then use the Windows System find utility to search your whole
-- 
2.27.0

