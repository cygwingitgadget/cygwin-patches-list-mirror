Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id 1DC363861899
 for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020 13:31:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1DC363861899
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id uyXwjHfnsFXePuyXxjc5We; Mon, 13 Jul 2020 07:31:05 -0600
X-Authority-Analysis: v=2.3 cv=ePaIcEh1 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17 a=w_pzkKWiAAAA:8
 a=Maegdg8Ow6QiC2z6ULYA:9 a=sRI3_1zDfAgwuvI8zelB:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] FAQ 1.6 Update Who's behind the project?
Date: Mon, 13 Jul 2020 07:30:07 -0600
Message-Id: <20200713133006.18422-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfB7qYIwUMNnrA7I72nVzaRC31IXBW9LDVnhVP+TT8DKpkWA2gcEKANeBkk1avgdc8N0UerY/WrrWG/OWFgtaBlgOtgNmVPWJHz5Ye6CmZHkpN5e0vtfm
 Y/OrM3S0cz6bBi0AvWI5xoif/IFx98K+4ZRAYR529pESCQGwQhFX4EOp5hWNqpKMVbXuhWWe4aFxykNE0cKqyF7AMxu2HV8f87oV8ZP15mZKkg04eN67ETO6
 AV/owbmBeeZFDr+lSGQNKQ==
X-Spam-Status: No, score=-13.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 13 Jul 2020 13:31:07 -0000

winsup/doc/faq-what.xml: remove Red Hat, Net, Win32 references and clean up
---
 winsup/doc/faq-what.xml | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
index 772fc04645..ea8496ccbc 100644
--- a/winsup/doc/faq-what.xml
+++ b/winsup/doc/faq-what.xml
@@ -124,29 +124,28 @@ questions, all of these people will appreciate it if you use the cygwin
 mailing lists rather than sending personal email.)</emphasis>
 </para>
 <para>
-Corinna Vinschen is the current project lead. Corinna is a senior Red Hat
-engineer. Corinna is responsible for the Cygwin library and maintains a couple
-of packages, for instance OpenSSH, OpenSSL, and a lot more.
+Corinna Vinschen is the current project lead,
+responsible for the Cygwin library and a lot more.
 </para>
 <para>
-Yaakov Selkowitz is another Red Hat engineer working on the Cygwin project.
-He's the guy behind the current build and packaging system and maintains by
-far the most packages in the Cygwin distribution.
+Yaakov Selkowitz is the guy behind the current build and packaging system
+and maintained by far the most packages in the Cygwin distribution.
 </para>
 <para>
-Jon Turney is developer and maintainer of the Cygwin X server and a couple
-of related packages.
+Jon Turney is maintainer of the Cygwin X server and related packages.
 </para>
 <para>
-The packages in the Net release are maintained by a large group of people;
-a complete list can be found
-<ulink url='https://cygwin.com/cygwin-pkg-maint'>here</ulink>.
-</para>
-<para>Please note that all of us working on Cygwin try to be as responsive as
-possible and deal with patches and questions as we get them, but realistically
-we don't have time to answer all of the email that is sent to the main mailing
-list.  Making Net releases of the Win32 tools and helping people on the Net out
-is not our primary job function, so some email will have to go unanswered.
+The packages are maintained by a large group of
+<ulink url='https://cygwin.com/cygwin-pkg-maint'>volunteers</ulink>.
+</para>
+<para>
+Please note that all of us volunteering on Cygwin try to be as responsive as
+possible and deal with patches and questions as we get them, but
+realistically we don't have time to answer all of the email that is sent to
+the main mailing list.
+Making releases of the tools and packages is an activity in our spare time,
+helping people out is not our primary focus, so some email will have to go
+unanswered.
 </para>
 <para>Many thanks to everyone using the tools for their many contributions in
 the form of advice, bug reports, and code fixes.  Keep them coming!
-- 
2.27.0

