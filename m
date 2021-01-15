Return-Path: <ben@wijen.net>
Received: from 10.mo173.mail-out.ovh.net (10.mo173.mail-out.ovh.net
 [46.105.74.148])
 by sourceware.org (Postfix) with ESMTPS id 405F6385800D
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:46:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 405F6385800D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.109.146.76])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 8C31915E374
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:46:09 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id BCB391A220286;
 Fri, 15 Jan 2021 13:46:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006937f258a-366d-4c5d-b28e-d7f20466232b,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 11/11] dir.cc: Try unlink_nt first
Date: Fri, 15 Jan 2021 14:45:34 +0100
Message-Id: <20210115134534.13290-12-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11286302143158306564
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 15 Jan 2021 13:46:12 -0000

Speedup deletion of directories.
---
 winsup/cygwin/dir.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index f912a9e47..2e7da3638 100644
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
@@ -398,6 +400,10 @@ rmdir (const char *dir)
 	  if (msdos && p == dir + 1 && isdrive (dir))
 	    p[1] = '\\';
 	}
+      if(NT_SUCCESS(unlink_nt (dir, FILE_DIRECTORY_FILE))) {
+        res = 0;
+        __leave;
+      }
       if (!(fh = build_fh_name (dir, PC_SYM_NOFOLLOW)))
 	__leave;   /* errno already set */;
 
-- 
2.29.2

