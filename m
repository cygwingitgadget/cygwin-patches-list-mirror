Return-Path: <SRS0=BBfk=HO=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.168])
	by sourceware.org (Postfix) with ESMTP id 011F14B9DB6C
	for <cygwin-patches@cygwin.com>; Tue, 22 Sep 2026 17:37:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 011F14B9DB6C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 011F14B9DB6C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.168
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790098669; cv=none;
	b=NYbDkk5SBgNYgcd6UQt93U3JpO0Xfc4bRWX+l10cfNK7kse5PJXkiAf1mYu2VDzyyAVMOnb8KDcMyIA8/ZWSrTuwjZd18ntVXlzJVwoIarl+KRPoX+06XeyBDS7k4MBS82kNfz/NJAgk1+PsRXR3+qEbCi4xgwM88t9BBU2ZwxI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790098669; c=relaxed/simple;
	bh=uzSuY8yEAwRYjNR+DvoPLwwb9kdgHTmbJNel98Ckrpk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hLls9z0/nhy4fm8WpZKUTB5+vXt0N5XM57tUf8ODyOvS6sH9OtNhroLYTtWJ4XoIHtwCskVxClS3Xk2WPCr06eQPeUsaS/OE/sb50yKLqrsSE/nWfCx1AWanCYDYfc+YyhxOX9OoroN2d0zJO1bIbbmgOzqEIJAjjJP6PkMfH3g=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 011F14B9DB6C
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6A715EB8096818B0
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGfRThZNFKdnD2ygZaibrErPjw2nP+G+7sq/i3vv/yBpTEF2PECltRBx4Bp4X5XltlIEKJCP/QTpUnhrH4L4IJ3fgHJelgfqigbIbKSktbOHRKs8aCAYe587RprEvo4egmimrgb1gDongLg/tlX5zOyBsET1mq8pKwwMGFxtbSU65uVU+ZoR2BX6X7xEaBhDROSW6kBiPlf5uvVuJzlpe/YXr0mGvhn8pXQP5doLyENURtBEdavpC0B6VDePReLO5gdlvsyWakrBY5GFIQIwRxQ6BcWAMEvqrdvbMK6wTU/JO0bQjNG+PlBQ1r2sqEChlPMtM0HyVctLqRSOntkIjEonuptTKYuXq91lNLYKpq5bpBUZH3HlaNXPwcTR9Nc1octMCe75Bk9kyWmWtN4shICdR2fV6DwBh2WCI8x9/mMrLLkIKbyIYIKeOpv4wjfARuUJH5/AkxfTKkQbjyt4NIpUZlg/w8j8nCBgK3LcOZI7AqvlOEzLQHHrbvgcqxQwVXTzsgyKnlF4ewRyAEZAzG1OAjseHXkq36fP9hbxyQRCxswKBR6mPFH6Kpl7Kd9/ScTHcHHxx3/e5bC40vknF2Xu6gLi2dR2QaWV8PnEbhVXNRun61yyo1xVYnyCgvsfag4W0tpzBznFmr6P0CqR2yAuxzYwKzifLKg25O2lmJxPw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (62.56.83.178) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715EB8096818B0; Tue, 22 Sep 2026 18:37:48 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Cygwin: Variable 'looped' computed but never used
Date: Tue, 22 Sep 2026 18:37:35 +0100
Message-ID: <20260922173737.111763-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
References: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

../../../../src/winsup/cygwin/spawn.cc: In member function ‘int child_info_spawn::worker(const char*, const char* const*, const char* const*, int, int, int)’:
../../../../src/winsup/cygwin/spawn.cc:328:7: warning: variable ‘looped’ set but not used [-Wunused-but-set-variable=]
---
 winsup/cygwin/spawn.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 8f976b9a0..cf21b985b 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -325,7 +325,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
   int c_flags;
 
   STARTUPINFOW si = {};
-  int looped = 0;
 
   fhandler_termios::spawn_worker term_spawn_worker;
 
@@ -844,7 +843,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    {
 	      if (!proc_retry (pi.hProcess))
 		{
-		  looped++;
 		  goto loop;
 		}
 	      close_all_files (true);
-- 
2.51.0

