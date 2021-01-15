Return-Path: <ben@wijen.net>
Received: from 5.mo179.mail-out.ovh.net (5.mo179.mail-out.ovh.net
 [46.105.43.140])
 by sourceware.org (Postfix) with ESMTPS id 4C186385800D
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:45:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4C186385800D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.4.127])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id A36DC180F37
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:45:43 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id C4D921A22004B;
 Fri, 15 Jan 2021 13:45:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0067737648d-4047-46d9-90a6-bef6e551792c,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 00/11] Improve rm speed
Date: Fri, 15 Jan 2021 14:45:23 +0100
Message-Id: <20210115134534.13290-1-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11278983796032947972
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfetffegveefueekkeevtefhkeeigfeklefgffetgeejgeeltdegieduvdffgefgnecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 15 Jan 2021 13:45:47 -0000

Hi,

I have been working on speeding up rm.
The idea is to save on kernel calls.
While kernel calls are fast, not doing
them is still a lot faster.

I do think there is more to gain, but
before I proceed it's best to first see if
this is something you're willing to commit.

I guess the first five patches are trivial,
I would really like some feedback on the last six.

Also, I'd like to state: I provide my patches to
the Cygwin sources under the 2-clause BSD license


Thank you,

Ben Wijen (11):
  syscalls.cc: unlink_nt: Try FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE
    first
  syscalls.cc: Deduplicate _remove_r
  syscalls.cc: Fix num_links
  syscalls.cc: Use EISDIR
  Cygwin: Move post-dir unlink check
  cxx.cc: Fix dynamic initialization for static local variables
  syscalls.cc: Implement non-path_conv dependent _unlink_nt
  path.cc: Allow to skip filesystem checks
  mount.cc: Implement poor-man's cache
  syscalls.cc: Expose shallow-pathconv unlink_nt
  dir.cc: Try unlink_nt first

 winsup/cygwin/Makefile.in           |   2 +-
 winsup/cygwin/cxx.cc                |  10 -
 winsup/cygwin/dir.cc                |   6 +
 winsup/cygwin/fhandler_disk_file.cc |  24 +-
 winsup/cygwin/forkable.cc           |   4 +-
 winsup/cygwin/mount.cc              |  78 ++++--
 winsup/cygwin/mount.h               |   2 +-
 winsup/cygwin/ntdll.h               |   3 +-
 winsup/cygwin/path.cc               |   5 +-
 winsup/cygwin/path.h                |   2 +
 winsup/cygwin/syscalls.cc           | 366 +++++++++++++++++++++++-----
 11 files changed, 384 insertions(+), 118 deletions(-)

-- 
2.29.2

