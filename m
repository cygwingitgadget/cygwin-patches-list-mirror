Return-Path: <SRS0=pTTn=N6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id E0F82382EF3D
	for <cygwin-patches@cygwin.com>; Fri, 28 Jun 2024 10:56:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E0F82382EF3D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E0F82382EF3D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1719572179; cv=none;
	b=eg/R1mxSCkRvPihgguNqG2Pgs/3wVX60vFbpca71FdgaiC9RjoWhSEj2UE2G648cO3jTzbnGXboaj498DKDcWxBoAtGG3h85aVz9L0VQhWtW9PW6k3JgzIuPo4blVGPr5D7bb12zdFgfs5vZGn7LYNjuVmefRzIe2pl1ChSzHFE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1719572179; c=relaxed/simple;
	bh=0aV5Wsv3bNiZw0uaOBZ4S5u1Ml1MdPpNV8luLqcD7pU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=skSWfssgHHAhPiAloL55Tfh4TNqx33El5/MAcrG/H+1vkA/vzGFux2TMc7LmvgONzig8m+1R700/lvPkqNbNe1TtLXVBK7nAA6E2zjFEW9DZU5ahDpLnv5/BfPZQjfML3zmfu2eBwh5rIV7SwqY0nvb1qElBq8dcKiIxEBSGJmQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e07.mail.nifty.com
          with ESMTP
          id <20240628105611904.FNRP.55939.localhost.localdomain@nifty.com>;
          Fri, 28 Jun 2024 19:56:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Fix incorrect openflags when opening multiple /dev/dsp
Date: Fri, 28 Jun 2024 19:55:42 +0900
Message-ID: <20240628105552.9507-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1719572171;
 bh=N2gGVnhITQo/YnFrMGrdn0TgAbRJ58p6KKraSho9t2c=;
 h=From:To:Cc:Subject:Date;
 b=nx2EYK5G6vdElcETEpTfVERzvcwurEWi6wKGMu15KdZ2FZLcvnZ5qI4BGapsKgJIlCizIDI6
 /5nb0aL5h46m9F6CkoEmIxG7MGmLtqfJnBYmIpaXqXIxPTDTiflLalZVkP1eUvNSDtrZnsjG0G
 r2ApZlsdhwNoYfFxUzaMBYbQ+pldQ9QbltpN3WHh5yVLLbOJbHyTCEXoyfK8k5U9OpEK3+CFiP
 hgjY2QvaehWrlRngpplid6v+GRLs9ZqRPe9sbu9DwGsOutqlF7Lawwc5LD332b1UMzIGPp5r9x
 VRlr2d9AyIIMBvNKzBngw6SjTrjF09XHEokJZFAYhhWQpfmg==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the following steps failed with error:
  1) Open /dev/dsp with O_RDONLY
  2) Open /dev/dsp with O_WRONLY
  3) Issue SNDCTL_DSP_GETOSPACE ioctl() for 2)
This is because IS_WRITE() returns false for 2) due to incorrect
openflags handling in archetype instance. This patch fixes the
issue by adding open_setup() to fhandler_dev_dsp to set openflags
correctly for each instance.

Fixes: 92ddb7429065 ("* fhandler_dsp.cc (fhandler_dev_dsp::open): Remove archetype handling.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc           | 26 +++++++++++++++----------
 winsup/cygwin/local_includes/fhandler.h |  7 ++++---
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 59c11ac23..605a048f3 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -1026,19 +1026,19 @@ fhandler_dev_dsp::fhandler_dev_dsp ():
 ssize_t
 fhandler_dev_dsp::write (const void *ptr, size_t len)
 {
-  return base ()->_write (ptr, len);
+  return base ()->_write (ptr, len, this);
 }
 
 void
 fhandler_dev_dsp::read (void *ptr, size_t& len)
 {
-  base ()->_read (ptr, len);
+  base ()->_read (ptr, len, this);
 }
 
 int
 fhandler_dev_dsp::ioctl (unsigned int cmd, void *buf)
 {
-  return base ()->_ioctl (cmd, buf);
+  return base ()->_ioctl (cmd, buf, this);
 }
 
 int
@@ -1065,7 +1065,6 @@ fhandler_dev_dsp::open (int flags, mode_t mode)
 {
   int ret = -1, err = 0;
   UINT num_in = 0, num_out = 0;
-  set_flags ((flags & ~O_TEXT) | O_BINARY);
   // Work out initial sample format & frequency, /dev/dsp defaults
   audioformat_ = AFMT_U8;
   audiofreq_ = 8000;
@@ -1105,11 +1104,11 @@ fhandler_dev_dsp::open (int flags, mode_t mode)
   return ret;
 }
 
-#define IS_WRITE() ((get_flags() & O_ACCMODE) != O_RDONLY)
-#define IS_READ() ((get_flags() & O_ACCMODE) != O_WRONLY)
+#define IS_WRITE() ((fh->get_flags() & O_ACCMODE) != O_RDONLY)
+#define IS_READ() ((fh->get_flags() & O_ACCMODE) != O_WRONLY)
 
 ssize_t
-fhandler_dev_dsp::_write (const void *ptr, size_t len)
+fhandler_dev_dsp::_write (const void *ptr, size_t len, fhandler_dev_dsp *fh)
 {
   debug_printf ("ptr=%p len=%ld", ptr, len);
   int len_s = len;
@@ -1168,7 +1167,7 @@ fhandler_dev_dsp::_write (const void *ptr, size_t len)
 }
 
 void
-fhandler_dev_dsp::_read (void *ptr, size_t& len)
+fhandler_dev_dsp::_read (void *ptr, size_t& len, fhandler_dev_dsp *fh)
 {
   debug_printf ("ptr=%p len=%ld", ptr, len);
 
@@ -1244,7 +1243,7 @@ fhandler_dev_dsp::close ()
 }
 
 int
-fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
+fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf, fhandler_dev_dsp *fh)
 {
   debug_printf ("audio_in=%p audio_out=%p", audio_in_, audio_out_);
   int *intbuf = (int *) buf;
@@ -1349,7 +1348,7 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
       CASE (SNDCTL_DSP_STEREO)
       {
 	int nChannels = *intbuf + 1;
-	int res = _ioctl (SNDCTL_DSP_CHANNELS, &nChannels);
+	int res = _ioctl (SNDCTL_DSP_CHANNELS, &nChannels, fh);
 	*intbuf = nChannels - 1;
 	return res;
       }
@@ -1547,3 +1546,10 @@ fhandler_dev_dsp::read_ready ()
 {
   return base ()->_read_ready ();
 }
+
+bool
+fhandler_dev_dsp::open_setup (int flags)
+{
+  set_flags ((flags & ~O_TEXT) | O_BINARY);
+  return fhandler_base::open_setup (flags);
+}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 978d3e514..fa6159565 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2881,11 +2881,12 @@ class fhandler_dev_dsp: public fhandler_base
   int close ();
   void fixup_after_fork (HANDLE);
   void fixup_after_exec ();
+  bool open_setup (int);
 
  private:
-  ssize_t _write (const void *, size_t);
-  void _read (void *, size_t&);
-  int _ioctl (unsigned int, void *);
+  ssize_t _write (const void *, size_t, fhandler_dev_dsp *);
+  void _read (void *, size_t&, fhandler_dev_dsp *);
+  int _ioctl (unsigned int, void *, fhandler_dev_dsp *);
   int _fcntl (int cmd, intptr_t);
   void _fixup_after_fork (HANDLE);
   void _fixup_after_exec ();
-- 
2.45.1

