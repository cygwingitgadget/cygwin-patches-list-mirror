Return-Path: <SRS0=BFuG=DY=lesderid.net=les@sourceware.org>
Received: from anna.lesderid.net (anna.lesderid.net [178.62.57.241])
	by sourceware.org (Postfix) with ESMTP id E2BD03858D28
	for <cygwin-patches@cygwin.com>; Mon,  7 Aug 2023 10:13:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E2BD03858D28
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=lesderid.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=lesderid.net
DKIM-Signature: a=rsa-sha256; bh=JGlTPbnbQkr8Q9/uOi+VcuuIn89Iv2TB5wt391qXvSo=;
 c=relaxed/relaxed; d=lesderid.net;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@lesderid.net; s=default; t=1691403211; v=1; x=1691835211;
 b=NbpjMIS7rFfhK+PK1LTwOUJD0Nyiq8mfTXzQHfQNMiNfua6K+b1AetayOzfYeD3e6Y4D/0tK
 u1CjPvP6140yMm5LSc6Vt/2HztWtOpEEQ5eZMaZ7xiD6NVizC+3AkaGp77m+FXiPDlwDdKbnt5j
 23DWw8TMaHsqOR7IQSSjZ3XgHLyXkJTA7ESQPZU0wFS2JPVRCte9g0L3tLcWqs0hDeTGF9Lx/fA
 z9+KlR8DojMN+j2SDW2vTLueoesiPwQoZAFgMeVDAMBeguctlmLi2WMBpvvZCfM/ntzy5FcqM94
 oCn+J8eFDrjSgY/DcvmB8Wx6fNx27atY69LdA2wjZFGRw==
Received: by anna.lesderid.net (envelope-sender <les@lesderid.net>) with
 ESMTPS id 4168f043; Mon, 07 Aug 2023 12:13:31 +0200
From: Les De Ridder <les@lesderid.net>
To: cygwin-patches@cygwin.com
Cc: Les De Ridder <les@lesderid.net>
Subject: [PATCH 0/2] Fix RAM disk crash
Date: Mon,  7 Aug 2023 03:13:13 -0700
Message-ID: <cover.1690932049.git.les@lesderid.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Some executables cause a bugcheck when running Cygwin off a native RAM
disk, which AFAICT is caused by a buggy (Microsoft) driver. This issue
will most likely only occur on WinPE and similar environments (tested on
10.0.20348.1).

See <https://github.com/msys2/msys2-runtime/issues/160> for some
context.

I provide my patches under both the 2-clause BSD license and the CC0
license.

Les De Ridder (2):
  Detect RAM disks as a separate filesystem type
  Use init_reopen_attr in mmap

 winsup/cygwin/local_includes/mount.h |  2 ++
 winsup/cygwin/local_includes/path.h  |  1 +
 winsup/cygwin/mm/mmap.cc             |  5 ++---
 winsup/cygwin/mount.cc               | 12 ++++++++++++
 4 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.41.0

