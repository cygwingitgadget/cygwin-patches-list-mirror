Return-Path: <cygwin-patches-return-8076-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91998 invoked by alias); 26 Mar 2015 05:25:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91987 invoked by uid 89); 26 Mar 2015 05:25:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.3 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 26 Mar 2015 05:25:12 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2Q5PAXG007892	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)	for <cygwin-patches@cygwin.com>; Thu, 26 Mar 2015 01:25:10 -0400
Received: from localhost.localdomain ([10.10.116.17])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2Q5P83s005899	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Thu, 26 Mar 2015 01:25:10 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: add GNU basename(3)
Date: Thu, 26 Mar 2015 05:25:00 -0000
Message-Id: <1427347509-7940-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2015-q1/txt/msg00031.txt.bz2

winsup/cygwin/
* common.din (__gnu_basename): Export.
* path.cc (__gnu_basename): New function.

winsup/doc/
* posix.xml (std-gnu): Add basename.
(std-notes): Add note about two forms of basename.
---
This depends on the newlib patch currently under discussion.

 winsup/cygwin/common.din |  1 +
 winsup/cygwin/path.cc    | 28 ++++++++++++++++++++++++++++
 winsup/doc/posix.xml     |  6 +++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 42098ff..f14b331 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -61,6 +61,7 @@ __fsetlocking SIGFE
 __fwritable NOSIGFE
 __fwriting NOSIGFE
 __getreent NOSIGFE
+__gnu_basename NOSIGFE
 __infinity NOSIGFE
 __isinfd NOSIGFE
 __isinff NOSIGFE
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 47c687f..b05333f 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -48,6 +48,7 @@
      c: means c:\.
   */
 
+#define _BASENAME_DEFINED
 #include "winsup.h"
 #include "miscfuncs.h"
 #include <ctype.h>
@@ -4767,6 +4768,33 @@ basename (char *path)
   return path;
 }
 
+/* The differences with the POSIX version above:
+   - declared in <string.h> (instead of <libgen.h>);
+   - the argument is never modified, and therefore is marked const;
+   - the empty string is returned if path is an empty string, "/", or ends
+     with a trailing slash. */
+extern "C" char *
+__gnu_basename (const char *path)
+{
+  static char buf[1];
+  char *c, *d, *bs = (char *)path;
+
+  if (!path || !*path)
+    return strcpy (buf, "");
+  if (isalpha (path[0]) && path[1] == ':')
+    bs += 2;
+  else if (strspn (path, "/\\") > 1)
+    ++bs;
+  c = strrchr (bs, '/');
+  if ((d = strrchr (c ?: bs, '\\')) > c)
+    c = d;
+  if (c)
+    return c + 1;
+  else if (!bs[0])
+    return strcpy (buf, "");
+  return (char *)path;
+}
+
 /* No need to be reentrant or thread-safe according to SUSv3.
    / and \\ are treated equally.  Leading drive specifiers and
    leading double (back)slashes are kept intact as far as it
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 5df808b..95bc400 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -50,7 +50,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     atoi
     atol
     atoll
-    basename
+    basename			(see chapter "Implementation Notes")
     bind
     bsearch
     btowc
@@ -1139,6 +1139,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     asnprintf
     asprintf
     asprintf_r
+    basename			(see chapter "Implementation Notes")
     canonicalize_file_name
     dremf
     dup3
@@ -1603,6 +1604,9 @@ group quotas, no inode quotas, no time constraints.</para>
 <para><function>qsort_r</function> is available in both BSD and GNU flavors,
 depending on whether _BSD_SOURCE or _GNU_SOURCE is defined when compiling.</para>
 
+<para><function>basename</function> is available in both POSIX and GNU flavors,
+depending on whether libgen.h is included or not.</para>
+
 </sect1>
 
 </chapter>
-- 
2.1.4
