Return-Path: <ben@wijen.net>
Received: from 10.mo4.mail-out.ovh.net (10.mo4.mail-out.ovh.net
 [188.165.33.109])
 by sourceware.org (Postfix) with ESMTPS id 83E3D396EC8C
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 16:11:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 83E3D396EC8C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.35.95])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 69D98264082
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 17:11:21 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id CD0641A4B38FF;
 Wed, 20 Jan 2021 16:11:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002d0c34d80-0287-47ee-89b4-0874e2fc08d7,
 8CFA42CD5E5EA73EE1AEF67635B773D7FE4E734C) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 8/8] fhandler_disk_file.cc: Use path_conv's IndexNumber
Date: Wed, 20 Jan 2021 17:10:56 +0100
Message-Id: <20210120161056.77784-9-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6208493565323396868
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Wed, 20 Jan 2021 16:11:23 -0000

path_conv already knows the IndexNumber, so just use it.

This commit also fixes the potential handle leak.
---
 winsup/cygwin/fhandler_disk_file.cc | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index fe04f832b..39f914a59 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -2029,9 +2029,6 @@ readdir_get_ino (const char *path, bool dot_dot)
 {
   char *fname;
   struct stat st;
-  HANDLE hdl;
-  OBJECT_ATTRIBUTES attr;
-  IO_STATUS_BLOCK io;
   ino_t ino = 0;
 
   if (dot_dot)
@@ -2044,26 +2041,17 @@ readdir_get_ino (const char *path, bool dot_dot)
       path = fname;
     }
   path_conv pc (path, PC_SYM_NOFOLLOW | PC_POSIX | PC_KEEP_HANDLE);
-  if (pc.isspecial ())
+  if (pc.isgood_inode (pc.fai ()->InternalInformation.IndexNumber.QuadPart))
+    ino = pc.fai ()->InternalInformation.IndexNumber.QuadPart;
+  else if (pc.isspecial ())
     {
       if (!stat_worker (pc, &st))
 	ino = st.st_ino;
     }
-  else if (!pc.hasgood_inode ())
+
+  if (!ino)
     ino = hash_path_name (0, pc.get_nt_native_path ());
-  else if ((hdl = pc.handle ()) != NULL
-	   || NT_SUCCESS (NtOpenFile (&hdl, READ_CONTROL,
-				      pc.get_object_attr (attr, sec_none_nih),
-				      &io, FILE_SHARE_VALID_FLAGS,
-				      FILE_OPEN_FOR_BACKUP_INTENT
-				      | (pc.is_known_reparse_point ()
-				      ? FILE_OPEN_REPARSE_POINT : 0)))
-	  )
-    {
-      ino = pc.get_ino_by_handle (hdl);
-      if (!ino)
-	ino = hash_path_name (0, pc.get_nt_native_path ());
-    }
+
   return ino;
 }
 
-- 
2.30.0

