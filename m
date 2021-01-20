Return-Path: <ben@wijen.net>
Received: from 14.mo4.mail-out.ovh.net (14.mo4.mail-out.ovh.net [46.105.40.29])
 by sourceware.org (Postfix) with ESMTPS id C25BF3857C52
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 16:11:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C25BF3857C52
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.109.156.133])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 4765526404B
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 17:11:01 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 1E1D01A4B3790;
 Wed, 20 Jan 2021 16:10:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0021cabea78-5c9d-4c11-8619-4bc873264258,
 8CFA42CD5E5EA73EE1AEF67635B773D7FE4E734C) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/8] Improve rm speed
Date: Wed, 20 Jan 2021 17:10:48 +0100
Message-Id: <20210120161056.77784-1-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6202582590913988356
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
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
X-List-Received-Date: Wed, 20 Jan 2021 16:11:05 -0000

Hi,

I think I got all remarks, please let me know if I missed something.

I'm still thinking on a better way to use fs_info::update cache,
but it requires more testing.


Thank you,

Ben Wijen (8):
  syscalls.cc: unlink_nt: Try FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE
  syscalls.cc: Deduplicate remove
  Cygwin: Move post-dir unlink check
  syscalls.cc: Implement non-path_conv dependent _unlink_nt
  path.cc: Allow to skip filesystem checks
  syscalls.cc: Expose shallow-pathconv unlink_nt
  dir.cc: Try unlink_nt first
  fhandler_disk_file.cc: Use path_conv's IndexNumber

 winsup/cygwin/dir.cc                |  12 +-
 winsup/cygwin/fhandler_disk_file.cc |  48 +---
 winsup/cygwin/forkable.cc           |   4 +-
 winsup/cygwin/ntdll.h               |   3 +-
 winsup/cygwin/path.cc               |   7 +-
 winsup/cygwin/path.h                |   2 +
 winsup/cygwin/syscalls.cc           | 346 +++++++++++++++++++++++-----
 winsup/cygwin/wincap.cc             |  11 +
 winsup/cygwin/wincap.h              |  56 ++---
 9 files changed, 354 insertions(+), 135 deletions(-)

-- 
2.30.0

