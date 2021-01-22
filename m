Return-Path: <ben@wijen.net>
Received: from 14.mo3.mail-out.ovh.net (14.mo3.mail-out.ovh.net
 [188.165.43.98])
 by sourceware.org (Postfix) with ESMTPS id 11F2A3894C19
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 15:47:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 11F2A3894C19
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player687.ha.ovh.net (unknown [10.108.54.156])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0208C27846C
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 16:47:18 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id B039D1A471418;
 Fri, 22 Jan 2021 15:47:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002854fa605-04f8-4779-bf11-6ef80dd3945a,
 D56DA46DA961A8A8A8B23CBF9B3EE5535B21C570) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 2/8] syscalls.cc: Deduplicate remove
Date: Fri, 22 Jan 2021 16:47:12 +0100
Message-Id: <20210122154712.3207-2-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122122215.GF810271@calimero.vinschen.de>
References: <20210122122215.GF810271@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17547713002217162500
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudeigdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 22 Jan 2021 15:47:21 -0000

The remove code is already in the _remove_r function.
So, just call the _remove_r function.
---
 winsup/cygwin/syscalls.cc | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 8651cfade..e6ff0fd7a 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1161,24 +1161,15 @@ _remove_r (struct _reent *, const char *ourname)
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
+  return _remove_r (_REENT, ourname);
 }
 
 extern "C" pid_t
-- 
2.30.0

