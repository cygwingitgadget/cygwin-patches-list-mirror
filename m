Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 1D18B3857C7F
 for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020 12:59:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1D18B3857C7F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id uy3FjHQbjFXePuy3Gjc1nx; Mon, 13 Jul 2020 06:59:23 -0600
X-Authority-Analysis: v=2.3 cv=ePaIcEh1 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17 a=CCpqsmhAAAAA:8
 a=w_pzkKWiAAAA:8 a=51kjSXn8rxP2_lg2150A:9 a=FhXMovWKs60A:10 a=ylEQVlorgLYA:10
 a=WK-i71OpKu4A:10 a=uvLZkzHzGa8A:10 a=ul9cdbp4aOFLsgKbc677:22
 a=sRI3_1zDfAgwuvI8zelB:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/doc/faq-what.xml FAQ 1.5 Clarify What version is this
Date: Mon, 13 Jul 2020 06:58:56 -0600
Message-Id: <20200713125855.17015-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPkYHapIV2zW49jEz7YaS9y9dNwBeHDa+DMcKbffF0P0azEUNAt4KB5PIcBCJ/SASi8Qdl6Oq2nWQbsRmF/peyIWfWi4pUwaIZJhaLiz7O0pMPEFzM0l
 FKVLPO66QIOu0msj4RZWeQvn1DJ9PjWncaadI7JPstBTO7epRDwJPOneb9+43nlV7jzWIvo9laO4vdEXhP27wbBFdonhgH6zKOl/Xbb1pHA/OOcDkayJs3Z3
 RClz3vaDimF2hdYR2DRjsg==
X-Spam-Status: No, score=-13.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_BL, RCVD_IN_MSPIKE_L3, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Mon, 13 Jul 2020 12:59:25 -0000

Patch to:
https://sourceware.org/git/?p=newlib-cygwin.git;f=winsup/doc/faq-what.xml;a=blob
as a result of thread:
	https://cygwin.com/pipermail/cygwin/2020-July/245442.html
and comments:
	https://cygwin.com/pipermail/cygwin-patches/2020q3/010331.html
Relate Cygwin DLL to Unix kernel,
add required options to command examples,
differentiate Unix and Cygwin commands;
mention that the cygwin package contains the DLL,
replace setup.exe reference by Cygwin Setup program wording.
---
 winsup/doc/faq-what.xml | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
index ce3483017d..772fc04645 100644
--- a/winsup/doc/faq-what.xml
+++ b/winsup/doc/faq-what.xml
@@ -85,25 +85,34 @@ freedoms, so it is free software.
 <answer>
 
 <para>To find the version of the Cygwin DLL installed, you can use
-<filename>uname</filename> as on Linux or <filename>cygcheck</filename>. Refer to each command's
+<filename>uname</filename> <literal>-r</literal> as you would for a Unix kernel.
+As the Cygwin DLL takes the place of a Unix kernel,
+you can also use the Unix compatible command:
+<filename>head</filename> <filename>/proc/version</filename>,
+or the Cygwin specific command:
+<filename>cygcheck</filename> <literal>-V</literal>.
+Refer to each command's
 <literal>--help</literal> output and the
 <ulink url='https://cygwin.com/cygwin-ug-net/'>Cygwin User's Guide</ulink>
 for more information.
 </para>
 <para>If you are looking for the version number for the whole Cygwin
-release, there is none. Each package in the Cygwin release has its own
-version.  The packages in Cygwin are continually improving, thanks to
-the efforts of net volunteers who maintain the Cygwin binary ports.
+release, there is none.
+Each package in the Cygwin release has its own version, and the
+<literal>cygwin</literal> package containing the Cygwin DLL and Cygwin
+system specific utilities is just another (but very important!) package.
+The packages in Cygwin are continually improving, thanks to
+the efforts of volunteers who maintain the Cygwin ports.
 Each package has its own version numbers and its own release process.
 </para>
 <para>So, how do you get the most up-to-date version of Cygwin?  Easy.  Just
-download the Cygwin Setup program by following the instructions
-<ulink url='https://cygwin.com/install.html'>here</ulink>.
-The setup program will handle the task of updating the packages on your system
-to the latest version. For more information about using Cygwin's
-<filename>setup.exe</filename>, see 
+download the Cygwin Setup program by following the
+<ulink url='https://cygwin.com/install.html'>installation instructions</ulink>.
+The Setup program will handle the task of updating the packages on your system
+to the latest version.
+For more information about using Cygwin's Setup program, see
 <ulink url='https://cygwin.com/cygwin-ug-net/setup-net.html'>Setting Up Cygwin</ulink>
-in the Cygwin User's Guide. 
+in the Cygwin User's Guide.
 </para></answer></qandaentry>
 
 <qandaentry id="faq.what.who">
-- 
2.27.0

