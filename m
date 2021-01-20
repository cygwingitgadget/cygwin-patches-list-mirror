Return-Path: <ben@wijen.net>
Received: from 7.mo177.mail-out.ovh.net (7.mo177.mail-out.ovh.net
 [46.105.61.149])
 by sourceware.org (Postfix) with ESMTPS id BC3CD385480F
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 16:11:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BC3CD385480F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.57.95])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 5F22C151ED8
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 17:11:06 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 77F9B1A4B37FA;
 Wed, 20 Jan 2021 16:11:03 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0025665a42d-d872-4d65-be85-a55e43ec6a7f,
 8CFA42CD5E5EA73EE1AEF67635B773D7FE4E734C) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/8] syscalls.cc: Deduplicate remove
Date: Wed, 20 Jan 2021 17:10:50 +0100
Message-Id: <20210120161056.77784-3-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6204271437936346884
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 20 Jan 2021 16:11:08 -0000

The remove code is already in the _remove_r function.
So, just call the _remove_r function.
---
 winsup/cygwin/syscalls.cc | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 2e50ad7d5..54b065733 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1133,24 +1133,15 @@ _remove_r (struct _reent *, const char *ourname)
       return -1;
     }
 
-  return win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
+  int res = win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
+  syscall_printf ("%R = remove(%s)", res, ourname);
+  return res;
 }
 
 extern "C" int
 remove (const char *ourname)
 {
-  path_conv win32_name (ourname, PC_SYM_NOFOLLOW);
-
-  if (win32_name.error)
-    {
-      set_errno (win32_name.error);
-      syscall_printf ("-1 = remove (%s)", ourname);
-      return -1;
-    }
-
-  int res = win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
-  syscall_printf ("%R = remove(%s)", res, ourname);
-  return res;
+  return _remove_r(_REENT, ourname);
 }
 
 extern "C" pid_t
-- 
2.30.0

