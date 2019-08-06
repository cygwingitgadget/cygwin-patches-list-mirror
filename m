Return-Path: <cygwin-patches-return-9546-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129645 invoked by alias); 6 Aug 2019 08:54:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129595 invoked by uid 89); 6 Aug 2019 08:54:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=family, HContent-Transfer-Encoding:8bit
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 06 Aug 2019 08:54:01 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N6t3Z-1iP24429nD-018O1j; Tue, 06 Aug 2019 10:53:55 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 85A11A806B8; Tue,  6 Aug 2019 10:53:54 +0200 (CEST)
From: Corinna Vinschen <corinna@vinschen.de>
To: cygwin-patches@cygwin.com
Cc: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: exec: check execute bit prior to evaluating script
Date: Tue, 06 Aug 2019 08:54:00 -0000
Message-Id: <20190806085354.14996-1-corinna@vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00066.txt.bz2

From: Corinna Vinschen <corinna-cygwin@cygwin.com>

When the exec family of functions is called for a script-like
file, the av::setup function handles the exec[vl]p case as
well.  The execve case for files not starting with a she-bang
is handled first by returning ENOEXEC.  Only after that, the
file's executability is checked.

This leads to the problem that ENOEXEC is returned for non-executable
files as well.  A calling shell interprets this as a file it should try
to run as script.  This is not desired for non-executable files.

Fix this problem by checking the file for executability first.  Only
after that, follow the other potential code paths.
---
 winsup/cygwin/spawn.cc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 7f7af4449da1..d95772802f8f 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -1172,6 +1172,12 @@ av::setup (const char *prog_arg, path_conv& real_path, const char *ext,
 	  }
 	UnmapViewOfFile (buf);
   just_shell:
+	/* Check if script is executable.  Otherwise we start non-executable
+	   scripts successfully, which is incorrect behaviour. */
+	if (real_path.has_acls ()
+	    && check_file_access (real_path, X_OK, true) < 0)
+	  return -1;	/* errno is already set. */
+
 	if (!pgm)
 	  {
 	    if (!p_type_exec)
@@ -1188,12 +1194,6 @@ av::setup (const char *prog_arg, path_conv& real_path, const char *ext,
 	    arg1 = NULL;
 	  }
 
-	/* Check if script is executable.  Otherwise we start non-executable
-	   scripts successfully, which is incorrect behaviour. */
-	if (real_path.has_acls ()
-	    && check_file_access (real_path, X_OK, true) < 0)
-	  return -1;	/* errno is already set. */
-
 	/* Replace argv[0] with the full path to the script if this is the
 	   first time through the loop. */
 	replace0_maybe (prog_arg);
-- 
2.20.1
