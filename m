Return-Path: <cygwin-patches-return-8222-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42282 invoked by alias); 5 Jul 2015 18:12:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42271 invoked by uid 89); 5 Jul 2015 18:12:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=2.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,URIBL_BLACK autolearn=no version=3.3.2
X-HELO: rgout01.bt.lon5.cpcloud.co.uk
Received: from rgout01.bt.lon5.cpcloud.co.uk (HELO rgout01.bt.lon5.cpcloud.co.uk) (65.20.0.178) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 05 Jul 2015 18:12:10 +0000
X-OWM-Source-IP: 86.179.113.166(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.55997377.0096,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.7.5.161516:17:27.888,ip=86.179.113.166,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __STOCK_PHRASE_7, BODY_SIZE_3000_3999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[166.113.179.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_HTTPS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.113.166) by rgout01.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 558FEB1500CEFC5D; Sun, 5 Jul 2015 19:12:07 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] winsup/doc: Add a configure test to find docbook2xtexi
Date: Sun, 05 Jul 2015 18:12:00 -0000
Message-Id: <1436119898-2752-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q3/txt/msg00004.txt.bz2

Fedora installs docbook2texi under the name db2x_docbook2texi
Other distros and Cygwin install docbook2texi under the name docbook2x-texi

Add a configure test to find either.

2015-07-05  Jon Turney  <jon.turney@dronecode.org.uk>

	* configure.ac: Add check for DOCBOOK2XTEXI
	* configure: Regenerate.
	* Makefile.in (DOCBOOK2XTEXI): Use.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog    |  6 ++++++
 winsup/doc/Makefile.in  |  2 +-
 winsup/doc/configure    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 winsup/doc/configure.ac |  1 +
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 841bbe2..b452fa9 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,9 @@
+2015-07-05  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* configure.ac: Add check for DOCBOOK2XTEXI
+	* configure: Regenerate.
+	* Makefile.in (DOCBOOK2XTEXI): Use.
+
 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
 
 	* README: Update.
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index 7cdc72c..cfe206d 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -30,7 +30,7 @@ CC:=@CC@
 CC_FOR_TARGET:=@CC@
 
 XMLTO:=xmlto --skip-validation --with-dblatex
-DOCBOOK2XTEXI:=docbook2x-texi --xinclude --info --utf8trans-map=charmap
+DOCBOOK2XTEXI:=@DOCBOOK2XTEXI@ --xinclude --info --utf8trans-map=charmap
 
 include $(srcdir)/../Makefile.common
 -include Makefile.dep
diff --git a/winsup/doc/configure b/winsup/doc/configure
index a484c8d..6e053bd 100755
--- a/winsup/doc/configure
+++ b/winsup/doc/configure
@@ -608,6 +608,7 @@ build_os
 build_vendor
 build_cpu
 build
+DOCBOOK2XTEXI
 INSTALL_DATA
 INSTALL_SCRIPT
 INSTALL_PROGRAM
@@ -1874,6 +1875,49 @@ test -z "$INSTALL_SCRIPT" && INSTALL_SCRIPT='${INSTALL}'
 
 test -z "$INSTALL_DATA" && INSTALL_DATA='${INSTALL} -m 644'
 
+for ac_prog in docbook2x-texi db2x_docbook2texi
+do
+  # Extract the first word of "$ac_prog", so it can be a program name with args.
+set dummy $ac_prog; ac_word=$2
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
+$as_echo_n "checking for $ac_word... " >&6; }
+if ${ac_cv_prog_DOCBOOK2XTEXI+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  if test -n "$DOCBOOK2XTEXI"; then
+  ac_cv_prog_DOCBOOK2XTEXI="$DOCBOOK2XTEXI" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+    for ac_exec_ext in '' $ac_executable_extensions; do
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
+    ac_cv_prog_DOCBOOK2XTEXI="$ac_prog"
+    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+  done
+IFS=$as_save_IFS
+
+fi
+fi
+DOCBOOK2XTEXI=$ac_cv_prog_DOCBOOK2XTEXI
+if test -n "$DOCBOOK2XTEXI"; then
+  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $DOCBOOK2XTEXI" >&5
+$as_echo "$DOCBOOK2XTEXI" >&6; }
+else
+  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+$as_echo "no" >&6; }
+fi
+
+
+  test -n "$DOCBOOK2XTEXI" && break
+done
+test -n "$DOCBOOK2XTEXI" || DOCBOOK2XTEXI="true"
+
 
 # Make sure we can run config.sub.
 $SHELL "$ac_aux_dir/config.sub" sun4 >/dev/null 2>&1 ||
diff --git a/winsup/doc/configure.ac b/winsup/doc/configure.ac
index 30439b8..b461750 100644
--- a/winsup/doc/configure.ac
+++ b/winsup/doc/configure.ac
@@ -16,6 +16,7 @@ AC_CONFIG_SRCDIR(cygwin-api.xml)
 AC_CONFIG_AUX_DIR(../..)
 
 AC_PROG_INSTALL
+AC_CHECK_PROGS([DOCBOOK2XTEXI], [docbook2x-texi db2x_docbook2texi], [true])
 AC_NO_EXECUTABLES
 AC_CANONICAL_SYSTEM
 
-- 
2.4.5
