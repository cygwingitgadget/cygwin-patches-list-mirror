Return-Path: <SRS0=RxEm=YA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id F086B3858415
	for <cygwin-patches@cygwin.com>; Fri, 16 May 2025 21:26:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F086B3858415
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F086B3858415
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747430807; cv=none;
	b=Q9z6oEl9WHsE9Tax1V1bTzYvU+Gq+iuSEvDvDJpmftBDBErlxdJGL94EO8j0o/DlRBhDiyL0PEXsE2WjKFjUAV0nvXokhzEOHKM/JuxsltYPedmPGjVaQ9kxalYcbtYROcG8ivOVNve6pDb5+MYeU8NquDQD1J8bcZXnUwOQjM8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747430807; c=relaxed/simple;
	bh=dELowB8cvU8QTfG3P/Wa5ZdA0aguroGpnYfpu+Ot/uo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=U/8Ea6lnZljuX1mW3hvF+0lATwI4phDw1l0l4cuZ/uwhDKl0D9mgK5x0XS2FAJLJvlQKnp13B/vpTaiOWK+FcSgi9ftOzLy0irqOrGM6QK7EJa4VAsFLHC+VsSa6MMh7Mxig0D7SLZVWEgGPX3RqWP8V9WCgIXIZgcDL6S1iVJk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F086B3858415
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FZC5LGxy
Received: from localhost.localdomain by mta-snd-e06.mail.nifty.com
          with ESMTP
          id <20250516212645378.FMGP.111119.localhost.localdomain@nifty.com>;
          Sat, 17 May 2025 06:26:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: open: Fix deadlock for opening fifo both side in a process
Date: Sat, 17 May 2025 06:26:18 +0900
Message-ID: <20250516212628.1825-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1747430805;
 bh=yUn0qOyh1SGyK9Dgl2v1fDNpQXK9T3vHfGf+78zp+VU=;
 h=From:To:Cc:Subject:Date;
 b=FZC5LGxySt473vxalITS6z8xrYa+rI6VkiOFtcH9XQMWVNgJIdL+jAUgVPCU5odu2bwjpU6u
 gJkXA56LCo3lcbjc5iC5dxvUfb9GBchBR7Q/EfoxY3iy0EJ5sXC02Dyj9JhYzl6lBS9edffF0N
 JQJAQCduOoBpIA4IW7F3coksGgabLleFKhsEW4o0osvRXUwkuMuOO/IWYEzz7iAth3K5ozevEY
 //MxExHKeKMbYBs+j4enkmCb+sfTTpuvGQbT9o8V0fr/fa5y1HWtE0Tx72xOXQH0MdGlOQp2ca
 R4xXnmAiTkzBmyvT7upQ8WS4Mpc/B8JUxru/FKTO2JI8qC6A==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, opening both side of fifo in a process hangs if the
read side is opened first. The following test case exhibit the
hang while it works in linux.

  #include <unistd.h>
  #include <pthread.h>
  #include <sys/stat.h>
  #include <fcntl.h>

  #define fifo1 "/tmp/fifo-test"

  void *thr1(void *)
  {
    int fd;
    usleep(100000);
    fd = open(fifo1, O_WRONLY);
    write(fd, "A", 1);
    usleep(100000);
    close(fd);
    return NULL;
  }

  int main()
  {
    int fd;
    pthread_t th;
    char c;
    mkfifo(fifo1, 0600);
    pthread_create(&th, NULL, thr1, NULL);
    fd = open(fifo1, O_RDONLY);
    pthread_join(th, NULL);
    read(fd, &c, 1);
    write(1, &c, 1);
    close(fd);
    unlink(fifo1);
    return 0;
  }

The mechanism of hang is as follows. The main thread tries to open
the fifo for reading, but fhandler_fifo::open blocks until it detects
that someone is opening the fifo for writing. The other thread wants
to do that, but it never gets to the point of calling fhandler_fifo::
open because it is stuck waiting for the lock on cygheap->fdtab.

To fix this, this patch delays the construction of the cygheap_fdnew
object fd until after fhandler_fifo::open has been called.

Fixes: df63bd490a52 ("* cygheap.h (cygheap_fdmanip): New class: simplifies locking and retrieval of fds from cygheap->fdtab.")
Reviewd-by: Ken Brown <kbrown@cornell.edu>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/syscalls.cc | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index c93bf4c95..d6a2c2d3b 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1472,11 +1472,6 @@ open (const char *unix_path, int flags, ...)
       mode = va_arg (ap, mode_t);
       va_end (ap);
 
-      cygheap_fdnew fd;
-
-      if (fd < 0)
-	__leave;		/* errno already set */
-
       /* When O_PATH is specified in flags, flag bits other than O_CLOEXEC,
 	 O_DIRECTORY, and O_NOFOLLOW are ignored. */
       if (flags & O_PATH)
@@ -1577,6 +1572,12 @@ open (const char *unix_path, int flags, ...)
       if ((flags & O_TMPFILE) && !fh->pc.isremote ())
 	try_to_bin (fh->pc, fh->get_handle (), DELETE,
 		    FILE_OPEN_FOR_BACKUP_INTENT);
+
+      cygheap_fdnew fd;
+
+      if (fd < 0)
+	__leave;		/* errno already set */
+
       fd = fh;
       if (fd <= 2)
 	set_std_handle (fd);
-- 
2.45.1

