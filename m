Return-Path: <SRS0=TcHI=ND=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id A4B2C3858C3A
	for <cygwin-patches@cygwin.com>; Sat,  1 Jun 2024 06:34:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A4B2C3858C3A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A4B2C3858C3A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717223698; cv=none;
	b=QsSJam0sdzpqij/EuVhJqIWxt51VI6U6JedkRJ98NS2isseCIUOegHUYZ8fH7KGnL2qp07+C7O/XsZ9mC6NE8qFfRRn/KKpXYtzLLSu9lcZVNPO80phXPKg2ab4hVaq3BqwKCDWNa4qyJkBHknBIl/YwJ+i4+C8UmyAa33DGcIE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717223698; c=relaxed/simple;
	bh=grBzZ10W7YjXoJ6wDc0TKThozHhNlyWKmmq1oi+xwGI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=T3a4B2TRE8nYb/q5H2AFS6/STHEG570UIUCHQTnuVQWM7XJMZ5+8bv40QCz4cBg1JhzOfxx8S5aVnfRg7ledXuJGhJpgp+XFhygun9b3+zKXLIev+fgQgg/gm+On8R6HAfLfro5tKeJLhntaDujT6c9qILeg5BjQgXdYswW2e+s=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w08.mail.nifty.com
          with ESMTP
          id <20240601063451428.XXGF.116607.localhost.localdomain@nifty.com>;
          Sat, 1 Jun 2024 15:34:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: mixer: Fix volume control for no WAVECAPS_LRVOLUME device
Date: Sat,  1 Jun 2024 15:34:26 +0900
Message-ID: <20240601063436.61197-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717223691;
 bh=DdBUTiz+99vCYvnZxFxoj4iYvmvTWttxKrZ7NNnNAhU=;
 h=From:To:Cc:Subject:Date;
 b=XiWwzD9m0nElyXg+M4Kt7RbOQ9GedCTddIl/OVxbcur4vbxDQh1Vt3jFFJOE7FDcamcDNTod
 vlnL4Lpsh6GVZNWx93feAxMxshNtDxLMLMOp12b2gv0co7O058TWxatCvL0F4zT5GMNAN6osFm
 rxRjdTT+Lnj0Am3cwpMpNJ3+cbNdz7VSFyaU59L3PbYvGbIn9szqOmdW0wLGPus+HO0zCzFLIf
 +zemtN4Wrt8JIzCMYi9dQ94SO8F1l0uPUP8R7YiIiAedlgS3JRp7sdh6eGQF4PTi9EFfdApfZL
 qxJBH9+9N0x09YOH5VzC0VSld5t2q1Trn46Bj4TXDh8Kas2g==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, if the device does not have capability WAVECAPS_LRVOLUME,
the volume control does not work properly. This patch fixes that.

Fixes: 2a4af3661470 ("Cygwin: Implement sound mixer device.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/autoload.cc       |  2 ++
 winsup/cygwin/fhandler/mixer.cc | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index c262c7efb..7e882ef1e 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -603,6 +603,8 @@ LoadDLLfuncEx3 (waveOutReset, winmm, 1, 0, 1)
 LoadDLLfuncEx3 (waveOutSetVolume, winmm, 1, 0, 1)
 LoadDLLfuncEx3 (waveOutUnprepareHeader, winmm, 1, 0, 1)
 LoadDLLfuncEx3 (waveOutWrite, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (waveOutMessage, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (waveOutGetDevCapsA, winmm, 1, 0, 1)
 
 LoadDLLfunc (accept, ws2_32)
 LoadDLLfunc (bind, ws2_32)
diff --git a/winsup/cygwin/fhandler/mixer.cc b/winsup/cygwin/fhandler/mixer.cc
index fabd397b7..f4997f952 100644
--- a/winsup/cygwin/fhandler/mixer.cc
+++ b/winsup/cygwin/fhandler/mixer.cc
@@ -15,6 +15,7 @@ details. */
 #include "fhandler.h"
 #include "dtable.h"
 #include "cygheap.h"
+#include <mmddk.h>
 
 ssize_t
 fhandler_dev_mixer::write (const void *ptr, size_t len)
@@ -88,7 +89,9 @@ int
 fhandler_dev_mixer::ioctl (unsigned int cmd, void *buf)
 {
   int ret = 0;
+  DWORD id, flag;
   DWORD vol;
+  WAVEOUTCAPS woc;
   switch (cmd)
     {
     case SOUND_MIXER_READ_DEVMASK:
@@ -115,7 +118,12 @@ fhandler_dev_mixer::ioctl (unsigned int cmd, void *buf)
       *(int *) buf = 1 << rec_source;
       break;
     case MIXER_WRITE (SOUND_MIXER_VOLUME):
+      waveOutMessage ((HWAVEOUT)WAVE_MAPPER, DRVM_MAPPER_PREFERRED_GET,
+		      (DWORD_PTR)&id, (DWORD_PTR)&flag);
+      waveOutGetDevCaps ((UINT)id, &woc, sizeof (woc));
       vol = volume_oss_to_winmm (*(int *) buf);
+      if (!(woc.dwSupport & WAVECAPS_LRVOLUME))
+	vol = max(vol & 0xffff, (vol >> 16) & 0xffff);
       if (waveOutSetVolume ((HWAVEOUT)WAVE_MAPPER, vol) != MMSYSERR_NOERROR)
 	{
 	  set_errno (EINVAL);
@@ -123,13 +131,17 @@ fhandler_dev_mixer::ioctl (unsigned int cmd, void *buf)
 	}
       break;
     case MIXER_READ (SOUND_MIXER_VOLUME):
-      DWORD vol;
+      waveOutMessage ((HWAVEOUT)WAVE_MAPPER, DRVM_MAPPER_PREFERRED_GET,
+		      (DWORD_PTR)&id, (DWORD_PTR)&flag);
+      waveOutGetDevCaps ((UINT)id, &woc, sizeof (woc));
       if (waveOutGetVolume ((HWAVEOUT)WAVE_MAPPER, &vol) != MMSYSERR_NOERROR)
 	{
 	  set_errno (EINVAL);
 	  ret = -1;
 	  break;
 	}
+      if (!(woc.dwSupport & WAVECAPS_LRVOLUME))
+	vol |= (vol & 0xffff) << 16;
       *(int *) buf = volume_winmm_to_oss (vol);
       break;
     default:
-- 
2.45.1

