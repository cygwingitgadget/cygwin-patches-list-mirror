Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id AE9DB4BB58FC
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:06:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AE9DB4BB58FC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AE9DB4BB58FC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774444025; cv=none;
	b=RT8iu811glviPB+8mDgMxGhOLEz/Stena7sci5lcGVyn1a1+Ad2bS2r+xkwB/ZxFiThzSxeQg56CJx0iXGXDM4vPSEmbRKeq7tRUncdy2IgG1zhP8bha/Dn/JK7ZxPPwPKmATkPmd8USMu4dPHX0woIsVQa6X7TRnufbmGAvdMI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774444025; c=relaxed/simple;
	bh=KygBGRfaOLEmK3R6YMXKp8E+1mDpImKR63oEMXjCBVM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=q3Rli4BEwhuDWbgOxChWiqpQQEiSC/oWQokjLmuou0/OC6YufRISNRa7rbivv5nmaMzyIVQX5pj+CAC35ZDZ2yVOSLIwuYaRHe2rpRyLE1F49SAi5JJ03yOtUblbzmkDA5c3ANSegAnmxPvkFbGrODmSwKDYpEVzAnj3/zY6uPY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AE9DB4BB58FC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=srnhS5wX
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260325130658048.CWWJ.14880.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:06:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Release pipe_sw_mutex in pcon_hand_over_proc()
Date: Wed, 25 Mar 2026 22:06:33 +0900
Message-ID: <20260325130644.64948-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774444018;
 bh=CYZ2njYwTzX0aQbsj98jvqC2k0O23kCbq8BcbBXEqJQ=;
 h=From:To:Cc:Subject:Date;
 b=srnhS5wXnOVzUR6GqtVX/MEx8+WkEwjYBymM5Pg9ob4aR8o6G0VEZGvP6Lq6QT5uYdXRp5J2
 H8TVmIKf31IxxTxpvJ+DZcUrOSrsqRv/bZrhfzelhjjcMP5yO+6ecZBzilfordKvv6sBe3ANuO
 fXPZXPmDxs8cFOU/AfIj5E3rTEJYYynT5Fei+aZg5vpwyWDlZyPteIgdQB+YQY1+gpcDq1VOZ3
 IoSp60CJwc/tpiVxY70LU+sqwQgbB/K3qmhMTQTCyXY/RKdGI0iqqgoxQKp2brki+PLR6prnSs
 2bt9pu+h/Z6BWUEjZsQ9dDdVSCGMjkYI31dckBWcaypV8wvA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, pipe_sw_mutex is held in the process which is running
in console inherited from pseudo console until the process ends.
Due to this behaviour, the process may cause deadlock when it
attempts to acuqire input_mutex in set_input_mode() called via
close_ctty(). This deadlock occurs because the pty master
acuires input_mutex first and acuire pipe_sw_mutex next while
the process exiting acuire pipe_sw_mutex first.

To avoid this deadlock, this patch releases pipe_sw_mutex in
pcon_hand_over_proc(). In addition, pointless pipe_sw_mutex
acquire/release is drppped in pcon_hand_over_proc().

Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from parent pty")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 29cdba0d3..1dd5dfa1d 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1994,8 +1994,6 @@ fhandler_console::pcon_hand_over_proc (void)
   char buf[MAX_PATH];
   shared_name (buf, PIPE_SW_MUTEX, parent_pty);
   HANDLE mtx = OpenMutex (MAXIMUM_ALLOWED, FALSE, buf);
-  WaitForSingleObject (mtx, INFINITE);
-  ReleaseMutex (mtx);
   DWORD res = WaitForSingleObject (mtx, INFINITE);
   if (res == WAIT_OBJECT_0 || res == WAIT_ABANDONED)
     {
@@ -2006,9 +2004,8 @@ fhandler_console::pcon_hand_over_proc (void)
     }
   else
     system_printf("Acquiring pcon_ho_mutex failed.");
+  ReleaseMutex (mtx);
   CloseHandle (parent_pty_input_mutex);
-  /* Do not release the mutex.
-     Hold onto the mutex until this process completes. */
 }
 
 bool
-- 
2.51.0

