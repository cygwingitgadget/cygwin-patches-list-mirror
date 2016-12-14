Return-Path: <cygwin-patches-return-8656-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128259 invoked by alias); 14 Dec 2016 18:02:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128248 invoked by uid 89); 14 Dec 2016 18:02:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.8 required=5.0 tests=AWL,BAYES_40,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=D*dronecode.org.uk, sk:jontur, U*jon.turney, sk:jon.tur
X-HELO: rgout0806.bt.lon5.cpcloud.co.uk
Received: from rgout0806.bt.lon5.cpcloud.co.uk (HELO rgout0806.bt.lon5.cpcloud.co.uk) (65.20.0.153) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 14 Dec 2016 18:02:22 +0000
X-OWM-Source-IP: 86.179.112.226 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2016.12.14.174520:17:7.944,ip=,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __FROM_DOMAIN_IN_ANY_CC1, URI_ENDS_IN_PHP, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, URI_ENDS_IN_HTML, __CP_URI_IN_BODY, __MULTIPLE_URI_TEXT, __URI_IN_BODY, BODY_SIZE_5000_5999, __MIME_TEXT_P1, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, __FROM_DOMAIN_IN_RCPT, __MIME_TEXT_P, BODY_SIZE_7000_LESS, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, LEGITIMATE_NEGATE
Received: from localhost.localdomain (86.179.112.226) by rgout08.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 584830E300993B36; Wed, 14 Dec 2016 18:02:19 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Fix some broken links in Cygwin FAQ
Date: Wed, 14 Dec 2016 18:02:00 -0000
Message-Id: <20161214180208.34760-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q4/txt/msg00014.txt.bz2

GNU no longer encourages the use of documentation mirrors, to avoid
referring to obsolete documentation.  Also www.fsf.org/manual/ is
just a redirect to www.fsf.org/manual

Links to using-utils.html #fragments are no longer correct as each utility
is now a separate page, since 646745cb.

indiana.edu seems to have moved XLiveCD information, without a redirect.

Linking to clean_setup.pl on cygwin.com doesn't work, as direct downloads
aren't allowed, so instead state where it can be found on a mirror.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/faq-resources.xml | 4 +---
 winsup/doc/faq-setup.xml     | 8 ++++----
 winsup/doc/faq-using.xml     | 2 +-
 winsup/doc/faq-what.xml      | 4 +---
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/winsup/doc/faq-resources.xml b/winsup/doc/faq-resources.xml
index c797127..35cb689 100644
--- a/winsup/doc/faq-resources.xml
+++ b/winsup/doc/faq-resources.xml
@@ -34,9 +34,7 @@ and an API Reference at
 <ulink url="https://cygwin.com/cygwin-api/cygwin-api.html"/>.
 </para>
 <para>You can find documentation for the individual GNU tools at
-<ulink url="http://www.fsf.org/manual/"/>.  (You should read GNU manuals from
-a local mirror, check
-<ulink url="http://www.fsf.org/server/list-mirrors.html"/> for a list of them.)
+<ulink url="http://www.gnu.org/manual/"/>.
 </para>
 </answer></qandaentry>
 
diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
index a790974..0fc2635 100644
--- a/winsup/doc/faq-setup.xml
+++ b/winsup/doc/faq-setup.xml
@@ -333,7 +333,7 @@ you will have to select it explicitly.  See
 <ulink url="https://cygwin.com/packages/"/> for a searchable list of available
 packages, or use <literal>cygcheck -p </literal> as described in the Cygwin
 User's Guide at
-<ulink url="https://cygwin.com/cygwin-ug-net/using-utils.html#cygcheck"/>.
+<ulink url="https://cygwin.com/cygwin-ug-net/cygcheck.html"/>.
 </para>
 <para>If you want to build programs, of course you'll need <literal>gcc</literal>,
 <literal>binutils</literal>, <literal>make</literal> and probably other packages from the
@@ -415,7 +415,7 @@ looking names, being encoded with their URLs
 <para>Of course, you can keep them around in case you want to reinstall a
 package. If you want to clean out only the outdated packages, Michael Chase
 has written a script called <literal>clean_setup.pl</literal>, available
-at <ulink url="ftp://cygwin.com/pub/cygwin/unsupported/clean_setup.pl" />.
+at <filename>unsupported/clean_setup.pl</filename> in a Cygwin mirror.
 </para>
 </answer></qandaentry>
 
@@ -576,7 +576,7 @@ installed are <literal>sshd</literal>, <literal>cron</literal>,
 that might be running in the background.  Exit the command prompt and ensure
 that no Cygwin processes remain.  Note: If you want to save your mount points for a later 
 reinstall, first save the output of <literal>mount -m</literal> as described at 
-<ulink url="https://cygwin.com/cygwin-ug-net/using-utils.html#mount"/>.
+<ulink url="https://cygwin.com/cygwin-ug-net/mount.html"/>.
 </para>
 </listitem>
 <listitem><para>If you installed <literal>cyglsa.dll</literal> by running the
@@ -704,7 +704,7 @@ the Cygwin Setup homepage at
 <answer>
 
 <para>While some users have successfully done this, for example Indiana
-University's XLiveCD <ulink url="http://xlivecd.indiana.edu/"/>, there is no
+University's XLiveCD <ulink url="http://racinfo.indiana.edu/research/xlivecd.php"/>, there is no
 easy way to do it. Full instructions for constructing a portable Cygwin
 on CD by hand can be found on the mailing list at
 <ulink url="https://www.cygwin.com/ml/cygwin/2003-07/msg01117.html"/>
diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index 415b8a5..deb7c7e 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -1160,7 +1160,7 @@ domains. For example, you might want to use the <computeroutput>Domain
 Users</computeroutput> group instead.</para>
 
 <para>For more information on <command>setfacl</command>, see
-<ulink url="https://cygwin.com/cygwin-ug-net/using-utils.html#setfacl"/></para>
+<ulink url="https://cygwin.com/cygwin-ug-net/setfacl.html"/></para>
 </answer></qandaentry>
 
 <qandaentry id="faq.using.same-with-rhosts">
diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
index e71cada..ce34830 100644
--- a/winsup/doc/faq-what.xml
+++ b/winsup/doc/faq-what.xml
@@ -56,9 +56,7 @@ Guide, an API Reference, mailing lists and archives.
 <para>You can find documentation for the individual GNU tools typically
 as man pages or info pages as part of the Cygwin net distribution.
 Additionally you can get the latest docs at
-<ulink url="http://www.gnu.org/manual/"/>.  (You should read GNU manuals from a
-local mirror.  Check <ulink url="http://www.gnu.org/server/list-mirrors.html"/>
-for a list of them.)
+<ulink url="http://www.gnu.org/manual"/>.
 </para>
 </answer></qandaentry>
 
-- 
2.8.3
