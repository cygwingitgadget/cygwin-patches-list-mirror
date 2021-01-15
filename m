Return-Path: <ben@wijen.net>
Received: from 3.mo69.mail-out.ovh.net (3.mo69.mail-out.ovh.net
 [188.165.52.203])
 by sourceware.org (Postfix) with ESMTPS id 3BDD33973062
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:46:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3BDD33973062
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.20.216])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 1BD59A491B
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:46:01 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 7583D1A2201EA;
 Fri, 15 Jan 2021 13:45:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006083c1806-a19f-467a-a4fd-f9b6d139b4bc,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 08/11] path.cc: Allow to skip filesystem checks
Date: Fri, 15 Jan 2021 14:45:31 +0100
Message-Id: <20210115134534.13290-9-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11284050345426962180
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 15 Jan 2021 13:46:05 -0000

When file attributes are of no concern,
there is no point to query them.
---
 winsup/cygwin/path.cc | 3 +++
 winsup/cygwin/path.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index abd3687df..f00707e86 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -931,7 +931,10 @@ path_conv::check (const char *src, unsigned opt,
 
     is_fs_via_procsys:
 
+	    if (!(opt & PC_SKIP_SYM_CHECK))
+	    {
 	      symlen = sym.check (full_path, suff, fs, conv_handle);
+	    }
 
     is_virtual_symlink:
 
diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index 62bd5ddd5..56855e1c9 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -59,6 +59,7 @@ enum pathconv_arg
   PC_KEEP_HANDLE	 = _BIT (12),	/* keep handle for later stat calls */
   PC_NO_ACCESS_CHECK	 = _BIT (13),	/* helper flag for error check */
   PC_SYM_NOFOLLOW_DIR	 = _BIT (14),	/* don't follow a trailing slash */
+  PC_SKIP_SYM_CHECK	 = _BIT (15),	/* skip symlink_info::check */
   PC_DONT_USE		 = _BIT (31)	/* conversion to signed happens. */
 };
 
-- 
2.29.2

