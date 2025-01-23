Return-Path: <SRS0=n3iE=UP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id EC41F3858C2B
	for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2025 10:45:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC41F3858C2B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EC41F3858C2B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737629101; cv=none;
	b=JvLmbNvkShwdq9+Qr+Ud0PaFnqNqLyRTxtB8B7/KpWkROqFU8O2vGE+NgzAmxhNcCjDcVhwVeS0hWh60vShGBkuv9kdiodzBMTH9AdaBuCyX80fynCmFHHtXXyzDIUji/RzTMQi8EBnc5x2/0+zxpPIntmJwvj+S/MUw1qxx2yY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737629101; c=relaxed/simple;
	bh=XCsUZoDjUHp+/D5/CVMgjxW3n2p54ZqHkcPtVJFTyIU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=NMCX0DHUHllQLs9NNPRhi9VQWg+jH3bVVMxqf5tzZTSEI+9xGr37xNZ3d2OAZqbX5+/9PE1A5eYUP1AhLl+zDjTze56uJrcuF2XroQ2QZfqNVYXIjDw0fnTaQv3+bZQbiCySLJrLsEJN/RuPN6K/Z38FTfk8XRjMtRfP0OWr3Kc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EC41F3858C2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GUoH0tzq
Received: from localhost.localdomain by mta-snd-e08.mail.nifty.com
          with ESMTP
          id <20250123104458790.CWPA.67122.localhost.localdomain@nifty.com>;
          Thu, 23 Jan 2025 19:44:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: Add new APIs tc[gs]etwinsize()
Date: Thu, 23 Jan 2025 19:44:26 +0900
Message-ID: <20250123104441.665-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737629098;
 bh=CvDOb9kLDqDFH9NCL3zZI3RI5kOwRV8A/JwopNvwCdA=;
 h=From:To:Cc:Subject:Date;
 b=GUoH0tzqdEmjtVf6og96zdPiaN5K1L4xhXU3o1rfabPrBxAIORQDcW/ZFqH/KkEFP+qtkIAj
 jBG0+YD+ZkR0SQQ7Rcy+Nliak6NX1WeKfvzWHNFeZ4ytqEhxSfbOm5Q4aglALBYvkUFnS8xdJh
 SZZ7mWeZfwVY4mItN/VocHECiR9qs7ZKDdX9cc09qsFwww49JmrwOvCuUg9pB3+dQ9FifKgatU
 UMFp9Zk7t43PpynT/gC+t8RzhFMfgmQAgrlEXX7D5ahyPOPJGAEh10VQ2oJUCw/t8Evj8Z6aA3
 QNscQ3v+tjdr7CJV3Z61ardOWubnLvflxG5V2mQPtdY1qyCw==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

New APIs tcgetwinsize/tcsetwinsize are added, which is added in
POSIX.1-2024.

Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/cygwin.din            |  2 ++
 winsup/cygwin/fhandler/base.cc      |  2 ++
 winsup/cygwin/include/sys/termios.h |  2 ++
 winsup/cygwin/termios.cc            | 12 ++++++++++++
 winsup/doc/new-features.xml         | 12 ++++++++++++
 winsup/doc/posix.xml                |  2 ++
 6 files changed, 32 insertions(+)

diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index efc750e83..95a21378b 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -1530,9 +1530,11 @@ tcflush SIGFE
 tcgetattr SIGFE
 tcgetpgrp SIGFE
 tcgetsid SIGFE
+tcgetwinsize SIGFE
 tcsendbreak SIGFE
 tcsetattr SIGFE
 tcsetpgrp SIGFE
+tcsetwinsize SIGFE
 tdelete SIGFE
 tdestroy NOSIGFE
 telldir SIGFE
diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
index e5e9f2325..0902bf0c2 100644
--- a/winsup/cygwin/fhandler/base.cc
+++ b/winsup/cygwin/fhandler/base.cc
@@ -1333,6 +1333,8 @@ fhandler_base::ioctl (unsigned int cmd, void *buf)
       break;
     case FIONREAD:
     case TIOCSCTTY:
+    case TIOCGWINSZ:
+    case TIOCSWINSZ:
       set_errno (ENOTTY);
       res = -1;
       break;
diff --git a/winsup/cygwin/include/sys/termios.h b/winsup/cygwin/include/sys/termios.h
index d701e2f72..687fb92af 100644
--- a/winsup/cygwin/include/sys/termios.h
+++ b/winsup/cygwin/include/sys/termios.h
@@ -301,6 +301,8 @@ speed_t cfgetospeed(const struct termios *);
 int cfsetispeed (struct termios *, speed_t);
 int cfsetospeed (struct termios *, speed_t);
 int cfsetspeed (struct termios *, speed_t);
+int tcgetwinsize(int fd, const struct winsize *winsz);
+int tcsetwinsize(int fd, const struct winsize *winsz);
 
 #ifdef __cplusplus
 }
diff --git a/winsup/cygwin/termios.cc b/winsup/cygwin/termios.cc
index 1dfd57079..6adf47497 100644
--- a/winsup/cygwin/termios.cc
+++ b/winsup/cygwin/termios.cc
@@ -398,3 +398,15 @@ cfmakeraw(struct termios *tp)
   tp->c_cflag &= ~(CSIZE | PARENB);
   tp->c_cflag |= CS8;
 }
+
+extern "C" int
+tcgetwinsize (int fd, const struct winsize *winsz)
+{
+  return ioctl (fd, TIOCGWINSZ, winsz);
+}
+
+extern "C" int
+tcsetwinsize (int fd, const struct winsize *winsz)
+{
+  return ioctl (fd, TIOCSWINSZ, winsz);
+}
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 17c688f89..b3daabd50 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -4,6 +4,18 @@
 
 <sect1 id="ov-new"><title>What's new and what changed in Cygwin</title>
 
+<sect2 id="ov-new3.6"><title>What's new and what changed in 3.6</title>
+
+<itemizedlist mark="bullet">
+
+<listitem><para>
+New API calls: tcgetwinsize, tcsetwinsize.
+</para></listitem>
+
+</itemizedlist>
+
+</sect2>
+
 <sect2 id="ov-new3.5"><title>What's new and what changed in 3.5</title>
 
 <itemizedlist mark="bullet">
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index eb5835c50..26d4fcfa4 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -990,9 +990,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     tcgetattr
     tcgetpgrp
     tcgetsid
+    tcgetwinsize
     tcsendbreak
     tcsetattr
     tcsetpgrp
+    tcsetwinsize
     tdelete
     telldir
     tempnam
-- 
2.45.1

