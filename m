Return-Path: <ben@wijen.net>
Received: from 13.mo3.mail-out.ovh.net (13.mo3.mail-out.ovh.net
 [188.165.33.202])
 by sourceware.org (Postfix) with ESMTPS id 7DAB7396EC90
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 16:11:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7DAB7396EC90
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.109.143.216])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 182E8277AD0
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 17:11:18 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 7286E1A4B38E3;
 Wed, 20 Jan 2021 16:11:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0024b83909a-c0ae-4f2c-8e2a-3e2bbeeb275e,
 8CFA42CD5E5EA73EE1AEF67635B773D7FE4E734C) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 7/8] dir.cc: Try unlink_nt first
Date: Wed, 20 Jan 2021 17:10:55 +0100
Message-Id: <20210120161056.77784-8-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6207649140041991940
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 20 Jan 2021 16:11:21 -0000

Speedup deletion of directories.
---
 winsup/cygwin/dir.cc | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index 7762557d6..470f83aee 100644
--- a/winsup/cygwin/dir.cc
+++ b/winsup/cygwin/dir.cc
@@ -22,6 +22,8 @@ details. */
 #include "cygtls.h"
 #include "tls_pbuf.h"
 
+extern NTSTATUS unlink_nt (const char *ourname, ULONG eflags);
+
 extern "C" int
 dirfd (DIR *dir)
 {
@@ -398,6 +400,14 @@ rmdir (const char *dir)
 	  if (msdos && p == dir + 1 && isdrive (dir))
 	    p[1] = '\\';
 	}
+      if (has_dot_last_component (dir, false)) {
+        set_errno (EINVAL);
+        __leave;
+      }
+      if (NT_SUCCESS (unlink_nt (dir, FILE_DIRECTORY_FILE))) {
+        res = 0;
+        __leave;
+      }
       if (!(fh = build_fh_name (dir, PC_SYM_NOFOLLOW)))
 	__leave;   /* errno already set */;
 
@@ -408,8 +418,6 @@ rmdir (const char *dir)
 	}
       else if (!fh->exists ())
 	set_errno (ENOENT);
-      else if (has_dot_last_component (dir, false))
-	set_errno (EINVAL);
       else if (!fh->rmdir ())
 	res = 0;
       delete fh;
-- 
2.30.0

