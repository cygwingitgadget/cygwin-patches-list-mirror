Return-Path: <ben@wijen.net>
Received: from 7.mo178.mail-out.ovh.net (7.mo178.mail-out.ovh.net
 [46.105.58.91])
 by sourceware.org (Postfix) with ESMTPS id 76A6D3857C52
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 16:11:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 76A6D3857C52
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.20.52])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 42A8FB81A5
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 17:11:14 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id AC1321A4B38A3;
 Wed, 20 Jan 2021 16:11:11 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0029f5c3658-be6a-438a-88f2-5fdd4a824a18,
 8CFA42CD5E5EA73EE1AEF67635B773D7FE4E734C) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 5/8] path.cc: Allow to skip filesystem checks
Date: Wed, 20 Jan 2021 17:10:53 +0100
Message-Id: <20210120161056.77784-6-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6206523239694616324
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Wed, 20 Jan 2021 16:11:17 -0000

When file attributes are of no concern, there is no point to query them.
This can greatly speedup code which doesn't need it.

The idea is to have a shallow path conversion with only minimal information.

The upcoming unlink_nt for example, first tries a path without filesystem
checks, then - if necessary - retries with filesystem checks.
---
 winsup/cygwin/path.cc | 7 ++++---
 winsup/cygwin/path.h  | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index abd3687df..441fe113b 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -627,7 +627,7 @@ path_conv::check (const char *src, unsigned opt,
   char *pathbuf = tp.c_get ();
   char *tmp_buf = tp.t_get ();
   char *THIS_path = tp.c_get ();
-  symlink_info sym;
+  symlink_info sym = { 0 };
   bool need_directory = 0;
   bool add_ext = false;
   bool is_relpath;
@@ -931,7 +931,8 @@ path_conv::check (const char *src, unsigned opt,
 
     is_fs_via_procsys:
 
-	      symlen = sym.check (full_path, suff, fs, conv_handle);
+	      if (!(opt & PC_SKIP_SYM_CHECK))
+		symlen = sym.check (full_path, suff, fs, conv_handle);
 
     is_virtual_symlink:
 
@@ -1172,7 +1173,7 @@ path_conv::check (const char *src, unsigned opt,
 	  return;
 	}
 
-      if (dev.isfs ())
+      if (!(opt & PC_SKIP_FS_CHECK) && dev.isfs ())
 	{
 	  /* If FS hasn't been checked already in symlink_info::check,
 	     do so now. */
diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index 62bd5ddd5..5821cdf57 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -59,6 +59,8 @@ enum pathconv_arg
   PC_KEEP_HANDLE	 = _BIT (12),	/* keep handle for later stat calls */
   PC_NO_ACCESS_CHECK	 = _BIT (13),	/* helper flag for error check */
   PC_SYM_NOFOLLOW_DIR	 = _BIT (14),	/* don't follow a trailing slash */
+  PC_SKIP_SYM_CHECK	 = _BIT (15),	/* skip symlink_info::check */
+  PC_SKIP_FS_CHECK	 = _BIT (16),	/* skip fs::update check */
   PC_DONT_USE		 = _BIT (31)	/* conversion to signed happens. */
 };
 
-- 
2.30.0

