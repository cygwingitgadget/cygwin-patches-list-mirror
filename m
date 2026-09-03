Return-Path: <SRS0=A5WQ=G3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id 8C55E4BB24C5
	for <cygwin-patches@cygwin.com>; Thu,  3 Sep 2026 23:49:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C55E4BB24C5
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C55E4BB24C5
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788479349; cv=none;
	b=vOFavKo2+Ik/F0AUUoiSVWe4OZgkP3su7wHKLVsTz6xmhoGXNA9NFxkbE/xz6W/4++FSbVmPdtc+jszl8/PnXvAlfNYm4MEHzeXv0gMHNsfTdcaBLxV/Ht7Sn3JlOnK/JNNer+PA1XNCuZ4TSW6dLeNxqi3dSfFVdjPcYCf53Gw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788479349; c=relaxed/simple;
	bh=J/QZzBuvJwMEsbWQD2xzmCJNxasSqtiq1c4lAsbmEdU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=lQbCHAkx7NMPPk3a/BwyEYYuBzU8yte4o1G/V8kAsdDmKeOSQJ/i/3YJyu+DuUYrg+Wu04kyrdH2+DnjFNdkCda9r2qbLasl6Kc49B9ApFXdOae8/ZLbSqIbkmqGF2vV0MXs2ycqHCCJ+TDYu/SZ1kJZvAlrzU38DrKwm/5eV90=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qlkT8WJa
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C55E4BB24C5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qlkT8WJa
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260903234906365.GSVD.60338.HP-Z230@nifty.com>;
          Fri, 4 Sep 2026 08:49:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Improve the performance of peek_console
Date: Fri,  4 Sep 2026 08:48:49 +0900
Message-ID: <20260903234859.344934-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788479346;
 bh=3kyNLWS42SsYPnU2km75a6USBgf8Rjfu3Q8egVeDNTE=;
 h=From:To:Cc:Subject:Date;
 b=qlkT8WJaqcgpGetS2NkP2+mBvSqc0RIMDfTnAbVD1z656tn4+4RBH5E+9oUllBLaDzaYjR7x
 SxSnTQ/MEohdlipQywYaXOhccamLYooQOQ5VNRYg+CAvM9eN50MpJjsRJu2nFzjbGX3UrQICX+
 uUt3D+zzTE/+gLsaFb7WhJcAUyHQuawJTIKpQKGyGrvY07gEniFWImepoGjFckPpx+3jT09l0T
 hbMDS2ZeQSRVhdmublmyex/G/obmz37XglTkoG4ex+HowTdGa8VDfENjFSGkMfoS7UwKVx6+SY
 CoNx4LBw4qKDj3EcY4549gahGml+fdt4UR996zcqJs+kdN5w==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, peek_console() used PeekConsoleInput() to confirm whether
the console input buffer has some input records. However, this need
attaching to the console if the process does not attach to the console.
To reduce that overhead, this patch uses WaitForSingleObject() with
console input handle instead. WaitForSingleObject() works without
attaching to the console, so this simplifies the peek_console()
code.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/select.cc | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 592f6d14d..d565f4d5b 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
       return 1;
     }
 
-  INPUT_RECORD irec;
-  DWORD events_read;
   HANDLE h;
   set_handle_or_return_if_not_open (h, me);
 
@@ -1161,12 +1159,7 @@ peek_console (select_record *me, bool)
       else
 	{
 	  fh->acquire_input_mutex (mutex_timeout);
-	  acquire_attach_mutex (mutex_timeout);
-	  DWORD resume_pid = fh->attach_console (fh->get_owner ());
-	  BOOL r = PeekConsoleInputW (h, &irec, 1, &events_read);
-	  fh->detach_console (resume_pid, fh->get_owner ());
-	  release_attach_mutex ();
-	  if (!r || !events_read)
+	  if (WaitForSingleObject (h, 0) != WAIT_OBJECT_0)
 	    {
 	      fh->release_input_mutex ();
 	      break;
-- 
2.51.0

