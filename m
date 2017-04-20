Return-Path: <cygwin-patches-return-8750-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68804 invoked by alias); 20 Apr 2017 14:29:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68774 invoked by uid 89); 20 Apr 2017 14:29:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=volunteers, archives, HX-Junkmail-Premium-Raw:sk:2017.4., Intent
X-HELO: rgout01.bt.lon5.cpcloud.co.uk
Received: from rgout0107.bt.lon5.cpcloud.co.uk (HELO rgout01.bt.lon5.cpcloud.co.uk) (65.20.0.127) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Apr 2017 14:29:04 +0000
X-OWM-Source-IP: 86.141.129.28 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=8/50,refid=2.7.2:2017.4.19.110016:17:8.707,ip=,rules=NO_URI_FOUND, NO_CTA_URI_FOUND, NO_MESSAGE_ID, NO_URI_HTTPS, TO_MALFORMED
Received: from localhost.localdomain (86.141.129.28) by rgout01.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58F62BE30049DD01; Thu, 20 Apr 2017 15:29:03 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Update URLs for Cygwin packaging information
Date: Thu, 20 Apr 2017 14:29:00 -0000
Message-Id: <20170420142831.329304-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q2/txt/msg00021.txt.bz2

Also:
Remove obsolete reference to g-b-s
Remove mention of ancient pre-invisiconsole behaviour of setup scripts

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/faq-programming.xml | 11 ++++-------
 winsup/doc/faq-using.xml       |  2 +-
 winsup/doc/setup-net.xml       |  6 +-----
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 5234414..c0ddd79 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -15,18 +15,15 @@ volunteers to prepare and maintain packages, because the priority of the
 Cygwin Team is Cygwin itself.
 </para>
 <para>The Cygwin Package Contributor's Guide at
-<ulink url="https://cygwin.com/setup.html"/> details everything you need to know
-about being a package maintainer. The quickest way to get started is to
-read the <emphasis>Initial packaging procedure, script-based</emphasis> section on
-that page.  The <literal>generic-build-script</literal> found there works well for
-most packages. 
+<ulink url="https://cygwin.com/packages.html"/> details everything you need to know
+about Cygwin packaging.
 </para>
 <para>For questions about package maintenance, use the cygwin-apps mailing
 list (start at <ulink url="https://cygwin.com/lists.html"/>) <emphasis>after</emphasis>
 searching and browsing the cygwin-apps list archives, of course.  Be
 sure to look at the <emphasis>Submitting a package</emphasis> checklist at
-<ulink url="https://cygwin.com/setup.html"/> before sending an ITP (Intent To
-Package) email to cygwin-apps.
+<ulink url="https://cygwin.com/packaging-contributors-guide.html#submitting"/>
+before sending an ITP (Intent To Package) email to cygwin-apps.
 </para>
 <para>You should also announce your intentions to the general cygwin list, in
 case others were thinking the same thing.
diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index bb26b83..c62e039 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -610,7 +610,7 @@ installed distribution.
 <para>Probably because there is nobody willing or able to maintain it.  It
 takes time, and the priority for the Cygwin Team is the Cygwin package.
 The rest is a volunteer effort.  Want to contribute?  See
-<ulink url="https://cygwin.com/setup.html"/>.
+<ulink url="https://cygwin.com/packaging.html"/>.
 </para>
 </answer></qandaentry>
 
diff --git a/winsup/doc/setup-net.xml b/winsup/doc/setup-net.xml
index c66fe1f..211bbed 100644
--- a/winsup/doc/setup-net.xml
+++ b/winsup/doc/setup-net.xml
@@ -254,11 +254,7 @@ in <filename>/etc/passwd</filename>.
 <sect2 id="setup-postinstall"><title>Post-Install Scripts</title>
 <para>
 Last of all, <command>setup.exe</command> will run any post-install
-scripts to finish correctly setting up installed packages. Since each
-script is run separately, several windows may pop up. If you are 
-interested in what is being done, see the Cygwin Package Contributor's
-Guide at <ulink 
-url="https://cygwin.com/setup.html"/>
+scripts to finish correctly setting up installed packages.
 When the last post-install script is completed, <command>setup.exe</command> 
 will display a box announcing the completion. A few packages, such as
 the OpenSSH server, require some manual site-specific configuration. 
-- 
2.8.3
