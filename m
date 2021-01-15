Return-Path: <ben@wijen.net>
Received: from 18.mo3.mail-out.ovh.net (18.mo3.mail-out.ovh.net
 [87.98.172.162])
 by sourceware.org (Postfix) with ESMTPS id 5F2263973016
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:45:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5F2263973016
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.57.38])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id C6ED5277291
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:45:45 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 311C91A22007F;
 Fri, 15 Jan 2021 13:45:43 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0065c8f279a-cec8-400f-9f42-1914ea482b4e,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 01/11] syscalls.cc: unlink_nt: Try
 FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE first
Date: Fri, 15 Jan 2021 14:45:24 +0100
Message-Id: <20210115134534.13290-2-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11279546745477220100
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 15 Jan 2021 13:45:48 -0000

---
 winsup/cygwin/ntdll.h     |  3 ++-
 winsup/cygwin/syscalls.cc | 20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
index d4f6aaf45..7eee383dd 100644
--- a/winsup/cygwin/ntdll.h
+++ b/winsup/cygwin/ntdll.h
@@ -497,7 +497,8 @@ enum {
   FILE_DISPOSITION_DELETE				= 0x01,
   FILE_DISPOSITION_POSIX_SEMANTICS			= 0x02,
   FILE_DISPOSITION_FORCE_IMAGE_SECTION_CHECK		= 0x04,
-  FILE_DISPOSITION_ON_CLOSE				= 0x08
+  FILE_DISPOSITION_ON_CLOSE				= 0x08,
+  FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE		= 0x10,
 };
 
 enum
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 525efecf3..ce4e9c65c 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -709,11 +709,23 @@ _unlink_nt (path_conv &pc, bool shareable)
 			   flags);
       if (!NT_SUCCESS (status))
 	goto out;
-      /* Why didn't the devs add a FILE_DELETE_IGNORE_READONLY_ATTRIBUTE
-	 flag just like they did with FILE_LINK_IGNORE_READONLY_ATTRIBUTE
-	 and FILE_LINK_IGNORE_READONLY_ATTRIBUTE???
+      /* Try FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE first
+         it was added with Redstone 5 (Win10 18_09) (as were POSIX rename semantics)
+         If it fails: fall-back to usual trickery */
+      if (wincap.has_posix_rename_semantics ())
+        {
+          fdie.Flags = FILE_DISPOSITION_DELETE | FILE_DISPOSITION_POSIX_SEMANTICS;
+          fdie.Flags|= FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE;
+          status = NtSetInformationFile (fh, &io, &fdie, sizeof fdie,
+                                         FileDispositionInformationEx);
+          if (NT_SUCCESS (status))
+            {
+              NtClose (fh);
+              goto out;
+            }
+        }
 
-         POSIX unlink semantics are nice, but they still fail if the file
+      /* POSIX unlink semantics are nice, but they still fail if the file
 	 has the R/O attribute set.  Removing the file is very much a safe
 	 bet afterwards, so, no transaction. */
       if (pc.file_attributes () & FILE_ATTRIBUTE_READONLY)
-- 
2.29.2

