Return-Path: <ben@wijen.net>
Received: from 7.mo179.mail-out.ovh.net (7.mo179.mail-out.ovh.net
 [46.105.61.94])
 by sourceware.org (Postfix) with ESMTPS id 28DB73973016
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:45:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 28DB73973016
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.109.138.183])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id D238618363A
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:45:47 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 7F4811A2200AE;
 Fri, 15 Jan 2021 13:45:45 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0067895e6d8-3fc6-410e-9572-75586ed23db6,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 02/11] syscalls.cc: Deduplicate _remove_r
Date: Fri, 15 Jan 2021 14:45:25 +0100
Message-Id: <20210115134534.13290-3-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11280109693313566468
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 15 Jan 2021 13:45:50 -0000

The _remove_r code is already in the remove function.
Therefore, just call the remove function and make
sure errno is set correctly in the reent struct.
---
 winsup/cygwin/syscalls.cc | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index ce4e9c65c..0e89b4f44 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1133,18 +1133,15 @@ unlink (const char *ourname)
 }
 
 extern "C" int
-_remove_r (struct _reent *, const char *ourname)
+_remove_r (struct _reent *ptr, const char *ourname)
 {
-  path_conv win32_name (ourname, PC_SYM_NOFOLLOW);
+  int ret;
 
-  if (win32_name.error)
-    {
-      set_errno (win32_name.error);
-      syscall_printf ("%R = remove(%s)",-1, ourname);
-      return -1;
-    }
+  errno = 0;
+  if ((ret = remove (ourname)) == -1 && errno != 0)
+    ptr->_errno = errno;
 
-  return win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
+  return ret;
 }
 
 extern "C" int
-- 
2.29.2

