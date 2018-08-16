Return-Path: <cygwin-patches-return-9182-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126322 invoked by alias); 16 Aug 2018 18:55:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126311 invoked by uid 89); 16 Aug 2018 18:55:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-25.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=Drop, para
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Aug 2018 18:55:39 +0000
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w7GItbR1032460;	Thu, 16 Aug 2018 14:55:37 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w7GItTJF006946	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Thu, 16 Aug 2018 14:55:36 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] setfacl: Rename the option --file to --set-file, as on Linux
Date: Thu, 16 Aug 2018 18:55:00 -0000
Message-Id: <20180816185528.11200-1-kbrown@cornell.edu>
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00077.txt.bz2

Retain --file as an undocumented option for backwards compatibility.
---
 winsup/cygwin/release/2.11.0 | 2 ++
 winsup/doc/new-features.xml  | 4 ++++
 winsup/doc/utils.xml         | 4 ++--
 winsup/utils/setfacl.c       | 5 +++--
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/release/2.11.0 b/winsup/cygwin/release/2.11.0
index 2d86dea3f..171b5d4d0 100644
--- a/winsup/cygwin/release/2.11.0
+++ b/winsup/cygwin/release/2.11.0
@@ -18,6 +18,8 @@ What changed:
 
 - Drop denormal-operand exception from FE_ALL_EXCEPT, as on Linux.
 
+- Rename the --file option of setfacl(1) to --set-file, as on Linux.
+
 
 Bug Fixes
 ---------
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index ad45a56e0..0107f75e2 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -30,6 +30,10 @@ New Header: &lt;aio.h&gt;.
 Drop denormal-operand exception from FE_ALL_EXCEPT, as on Linux.
 </para></listitem>
 
+<listitem><para>
+Rename the --file option of setfacl(1) to --set-file, as on Linux.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 948db5832..182134379 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -1968,7 +1968,7 @@ setfacl [-n] {[-bk]|[-x acl_entries] [-m acl_entries]} FILE...
       <screen>
   -b, --remove-all       remove all extended ACL entries\n"
   -x, --delete           delete one or more specified ACL entries\n"
-  -f, --file             set ACL entries for FILE to ACL entries read\n"
+  -f, --set-file         set ACL entries for FILE to ACL entries read\n"
                          from ACL_FILE\n"
   -k, --remove-default   remove all default ACL entries\n"
   -m, --modify           modify one or more specified ACL entries\n"
@@ -2035,7 +2035,7 @@ At least one of (-b, -x, -f, -k, -m, -s) must be specified\n"
          d[efault]:o[ther][:]
 </screen> </para>
 
-    <para> <literal>-f</literal>,<literal>--file</literal> Take the Acl_entries
+    <para> <literal>-f</literal>,<literal>--set-file</literal> Take the Acl_entries
       from ACL_FILE one per line. Whitespace characters are ignored, and the
       character "#" may be used to start a comment. The special filename "-"
       indicates reading from stdin. Note that you can use this with
diff --git a/winsup/utils/setfacl.c b/winsup/utils/setfacl.c
index 2577ab776..926581a39 100644
--- a/winsup/utils/setfacl.c
+++ b/winsup/utils/setfacl.c
@@ -536,7 +536,7 @@ usage (FILE *stream)
 "\n"
 "  -b, --remove-all       remove all extended ACL entries\n"
 "  -x, --delete           delete one or more specified ACL entries\n"
-"  -f, --file             set ACL entries for FILE to ACL entries read\n"
+"  -f, --set-file         set ACL entries for FILE to ACL entries read\n"
 "                         from ACL_FILE\n"
 "  -k, --remove-default   remove all default ACL entries\n"
 "  -m, --modify           modify one or more specified ACL entries\n"
@@ -595,7 +595,7 @@ usage (FILE *stream)
 "    d[efault]:m[ask][:]\n"
 "    d[efault]:o[ther][:]\n"
 "\n"
-"-f, --file\n"
+"-f, --set-file\n"
 "  Take the Acl_entries from ACL_FILE one per line.  Whitespace characters are\n"
 "  ignored, and the character \"#\" may be used to start a comment.  The special\n"
 "  filename \"-\" indicates reading from stdin.\n"
@@ -652,6 +652,7 @@ usage (FILE *stream)
 struct option longopts[] = {
   {"remove-all", no_argument, NULL, 'b'},
   {"delete", required_argument, NULL, 'x'},
+  {"set-file", required_argument, NULL, 'f'},
   {"file", required_argument, NULL, 'f'},
   {"remove-default", no_argument, NULL, 'k'},
   {"modify", required_argument, NULL, 'm'},
-- 
2.17.0
