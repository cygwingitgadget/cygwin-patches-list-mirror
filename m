Return-Path: <ben@wijen.net>
Received: from 13.mo5.mail-out.ovh.net (13.mo5.mail-out.ovh.net
 [87.98.182.191])
 by sourceware.org (Postfix) with ESMTPS id 08613385800D
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:45:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 08613385800D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.54.217])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id BED302AC350
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:45:50 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id D83441A220106;
 Fri, 15 Jan 2021 13:45:47 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0061442d78d-17da-43ee-84a5-6dfdc71c7e69,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 03/11] syscalls.cc: Fix num_links
Date: Fri, 15 Jan 2021 14:45:26 +0100
Message-Id: <20210115134534.13290-4-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11280954118021007108
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 15 Jan 2021 13:45:53 -0000

NtQueryInformationFile on fh_ro needs FILE_READ_ATTRIBUTES
to succeed.
---
 winsup/cygwin/syscalls.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 0e89b4f44..227d1a911 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -767,8 +767,9 @@ _unlink_nt (path_conv &pc, bool shareable)
       if ((pc.fs_flags () & FILE_SUPPORTS_TRANSACTIONS))
 	start_transaction (old_trans, trans);
 retry_open:
-      status = NtOpenFile (&fh_ro, FILE_WRITE_ATTRIBUTES, &attr, &io,
-			   FILE_SHARE_VALID_FLAGS, flags);
+      status = NtOpenFile (&fh_ro,
+                           FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES,
+                           &attr, &io, FILE_SHARE_VALID_FLAGS, flags);
       if (NT_SUCCESS (status))
 	{
 	  debug_printf ("Opening %S for removing R/O succeeded",
-- 
2.29.2

