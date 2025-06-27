Return-Path: <SRS0=IwXV=ZK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id EABDB385700E
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 11:41:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EABDB385700E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EABDB385700E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751024499; cv=none;
	b=S+tQqYmkBz7iIHMjZ4ShXKlbFKwJq5h2bjZrJ8egU5KBav51AtFRrlUYuMbXU9/BsBiTn0RWiUpWwzfhyPlYh8zImhPHjE0z4UbtCUrL37PgUKhWawXhnYJYiIn6t0fgPugooi12AV2ktZk6+1gR9cJ7Ey0x0ExUIxCD1nVYM6w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751024499; c=relaxed/simple;
	bh=urfUse1mDACGXGYqmP8zBb4laqbk2s4NYMUqx3e43kk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=G3sdYeJDRZVtRa+QVaqqYVZemvhXTpJZkmoek+g6ajXoVlbUe8MsV9T2qVOsj2Q2CRbKpPVqXtC8dNxkolXTKhM6MRx1JfJlScPPLDkm8jnaSLhnPJRSHOHPUCm13iIaUyD8KdroC1uu4VzpFBftS2Wr/B/ZY0C4CGHtnAAVJRw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250627114136579.QOUV.69071.localhost.localdomain@nifty.com>;
          Fri, 27 Jun 2025 20:41:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 3/3] Cygwin: pipe: Make pipe_data_available() return PDA_UNKNOWN
Date: Fri, 27 Jun 2025 20:40:15 +0900
Message-ID: <20250627114103.30364-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250627114103.30364-1-takashi.yano@nifty.ne.jp>
References: <20250627114103.30364-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751024496;
 bh=GRkfWKdc0QwJrL4Kq0X28wUHGHiOgP5YGe9ulkFyM9Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=stEUEWIGVZnNJ5Xs6NA2jlpfBgAiInP/1i+qz6tAhTrQBcDeSjHq67+hq34GYGfAi67uOT/1
 5C/8GSvwo6EMlAdRhxDkwRmJOwhKZLPw2eiBcBZ7e5WGyEFNAne1uIP6AGoFwhYOE1HiiM1Cs+
 RNN5pjD2l7P8F7eq//m0uw+t0Co0ZeCiL3RA8r1WrwNEPAOHo90yCtlfK+kE6003F5M6S+kQgY
 T2WYFvJfil67im+71lp5ZQHYPwBqSZhp9go7mjG1Z99gOjRF/7ge3Ms+nNhQifpnxwvM0V3TtR
 rwn1Q72bJ3nmyQoOx9S7qP5ARX8lrTqJ3s2x9nFoAd3SwfzQ==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

... rather than 1 when the pipe space estimation fails, so that
select() and raw_wrie() can perform appropriate fallback handling.
In select(), even if pipe space is unknown, return writable to avoid
deadlock.  Even with select() returns writable, write() can blocked
anyway, if data is larger than pipe space. In raw_write(), if the
pipe is real non-blocking mode, attempting to write larger data than
pipe space is safe. Otherwise, return error.

Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc        |  7 ++++---
 winsup/cygwin/local_includes/select.h |  3 +++
 winsup/cygwin/select.cc               | 18 +++++++++---------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 22addbb18..7e2c1861b 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -663,12 +663,13 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	     in a very implementation-defined way we can't emulate, but it
 	     resembles it closely enough to get useful results. */
 	  avail = pipe_data_available (-1, this, get_handle (), PDA_WRITE);
-	  if (avail < 1)	/* error or pipe closed */
+	  if (avail == PDA_UNKNOWN && real_non_blocking_mode)
+	    avail = len1;
+	  else if (avail == 0 || !PDA_NOERROR (avail))
+	    /* error or pipe closed */
 	    break;
 	  if (avail > len1)	/* somebody read from the pipe */
 	    avail = len1;
-	  if (avail == 1)	/* 1 byte left or non-Cygwin pipe */
-	    len1 >>= 1;
 	  else if (avail >= PIPE_BUF)
 	    len1 = avail & ~(PIPE_BUF - 1);
 	  else
diff --git a/winsup/cygwin/local_includes/select.h b/winsup/cygwin/local_includes/select.h
index 43ceb1d7e..afc05e186 100644
--- a/winsup/cygwin/local_includes/select.h
+++ b/winsup/cygwin/local_includes/select.h
@@ -143,5 +143,8 @@ ssize_t pipe_data_available (int, fhandler_base *, HANDLE, int);
 
 #define PDA_READ	0x00
 #define PDA_WRITE	0x01
+#define PDA_ERROR	-1
+#define PDA_UNKNOWN	-2
+#define PDA_NOERROR(x)	(x >= 0)
 
 #endif /* _SELECT_H_ */
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 701f4d9a6..050221a9f 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -601,7 +601,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
       if (mode == PDA_READ
 	  && PeekNamedPipe (h, NULL, 0, NULL, &nbytes_in_pipe, NULL))
 	return nbytes_in_pipe;
-      return -1;
+      return PDA_ERROR;
     }
 
   IO_STATUS_BLOCK iosb = {{0}, 0};
@@ -618,7 +618,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
 	 access on the write end.  */
       select_printf ("fd %d, %s, NtQueryInformationFile failed, status %y",
 		     fd, fh->get_name (), status);
-      return (mode == PDA_WRITE) ? 1 : -1;
+      return (mode == PDA_WRITE) ? PDA_UNKNOWN : PDA_ERROR;
     }
   if (mode == PDA_WRITE)
     {
@@ -660,7 +660,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
 	    return fpli.WriteQuotaAvailable; /* Not empty */
 	  else if (!NT_SUCCESS (status))
 	    /* We cannot know actual write pipe space. */
-	    return 1;
+	    return PDA_UNKNOWN;
 	  /* Restore pipe mode to blocking mode */
 	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
 	  /* Empty */
@@ -684,7 +684,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
       return fpli.ReadDataAvailable;
     }
   if (fpli.NamedPipeState & FILE_PIPE_CLOSING_STATE)
-    return -1;
+    return PDA_ERROR;
   return 0;
 }
 
@@ -734,7 +734,7 @@ peek_pipe (select_record *s, bool from_select)
       if (n == 0 && fh->get_echo_handle ())
 	n = pipe_data_available (s->fd, fh, fh->get_echo_handle (), PDA_READ);
 
-      if (n < 0)
+      if (n == PDA_ERROR)
 	{
 	  select_printf ("read: %s, n %d", fh->get_name (), n);
 	  if (s->except_selected)
@@ -775,8 +775,8 @@ out:
 	}
       ssize_t n = pipe_data_available (s->fd, fh, h, PDA_WRITE);
       select_printf ("write: %s, n %d", fh->get_name (), n);
-      gotone += s->write_ready = (n > 0);
-      if (n < 0 && s->except_selected)
+      gotone += s->write_ready = (n > 0 || n == PDA_UNKNOWN);
+      if (n == PDA_ERROR && s->except_selected)
 	gotone += s->except_ready = true;
     }
   return gotone;
@@ -989,7 +989,7 @@ out:
       ssize_t n = pipe_data_available (s->fd, fh, fh->get_handle (), PDA_WRITE);
       select_printf ("write: %s, n %d", fh->get_name (), n);
       gotone += s->write_ready = (n > 0);
-      if (n < 0 && s->except_selected)
+      if (n == PDA_ERROR && s->except_selected)
 	gotone += s->except_ready = true;
     }
   return gotone;
@@ -1415,7 +1415,7 @@ out:
       ssize_t n = pipe_data_available (s->fd, fh, h, PDA_WRITE);
       select_printf ("write: %s, n %d", fh->get_name (), n);
       gotone += s->write_ready = (n > 0);
-      if (n < 0 && s->except_selected)
+      if (n == PDA_ERROR && s->except_selected)
 	gotone += s->except_ready = true;
     }
   return gotone;
-- 
2.45.1

