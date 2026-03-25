Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id B17074BBC08B
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:05:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B17074BBC08B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B17074BBC08B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774443945; cv=none;
	b=ASvE0uLEW2EsUfl5/UpWYxhqVHY1f7U3BsThvfzdtC651CU3EQFg5oCDmsZ0E3+363itv1Se+Ctar7qAGhghEb6W/w7qL6DwgtP4l3Qa+GfWWbNlgUnh08x8gFXsEPDeoRZrG4Y+D0Yzb5gqfG+54/sUP1VqehvkHcLQ92fmF8E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774443945; c=relaxed/simple;
	bh=P/pltq9uzNKBx3Xb7VxpvT1JNNR7f4AVlZ1l0fTU1WQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=mGdzXyiqMYVzLxJ75rbR+wmERF4eOLmvQ4D8dD8W7xtsEAElLCzX2FBgmJ+YaRB2IpAzqPN/uDWa09da/PtutrXoNE5hZgLo4O68kp/N3Z5gT38skTs3tdOCVhWDQCiqY1yeyL+WdFT3Eer4qW0hJz2LjTNmUqd8Wf75QBKf+Dg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B17074BBC08B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YDFeq8c1
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260325130542727.TUFS.127398.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:05:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v7 7/7] Cygwin: pty: Drop nat_fg() check from to_be_read_from_nat_pipe()
Date: Wed, 25 Mar 2026 22:04:13 +0900
Message-ID: <20260325130453.62246-8-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
 <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774443942;
 bh=j2igzKC4ihP0bxulgupxVZOYGAk9TtvrRYbV3D1XsAk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YDFeq8c1DJSqG373GjXCzlI094v13uwqs3nvQXQmUJhXTtg/m4Z4syulFfgCsFZCS4br6aQD
 cux+YILqXZ8RO/3wGH1uHull6u1vSj2hEoZWX6bY/lCBKv6nvcqnz5Ttpu41SaRI6faRdk1Lpj
 Oah7oSPaVPqZ4BwnXPCmUm417UIHIhsJgJWVePBdCKTqVxRykXd6ts6p5FRkzcyitBEmgLC61o
 5ICMvGOnzKKlhtd1Ir/fanNQ7UioGn2yYN14kYrb3qhKvPzI1I68ZbAPoV8fsa5DKT+17t658k
 q/O2c8dzv2Pq8GqR1xEFaHP+ILoTx5fSu8TXFdtp2PAx25zw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

While non-cygwin app exited but the stub process is not terminated
yet, nat_fg() returns false because no non-cygwin app is running.
In this duration, pty input goes cyg pipe. Due to this behaviour,
the key stroke oder is swapped unexpectedly in the following steps.

1) start non-cygwin app
2) press 'a' ('a' goes to nat pipe)
3) non-cygwin app exited
4) press 'b' ('b' goes to cyg pipe)
5) the stub process for non-cygwin app transfers input in nat pipe
   to cyg pipe ('a' goes to cyg pipe)
6) the result in the cyg pipe is "ba"

To fix this issue, this patch drops nat_fg() check from
to_be_read_from_nat_pipe(). With this patch, it retunrs true when
(!pcon_start && switch_to_nat_pipe && !masked).

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index c7e3ddf50..4187dafce 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1338,14 +1338,8 @@ fhandler_pty_common::to_be_read_from_nat_pipe (void)
     }
   while (false);
 
-  if (!pinfo (get_ttyp ()->getpgid ()))
-    /* GDB may set invalid process group for non-cygwin process. */
-    {
-      ret = true;
-      goto out;
-    }
+  ret = true; /* !pcon_start && switch_to_nat_pipe && !masked */
 
-  ret = get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
 out:
   ReleaseMutex (pipe_sw_mutex);
   return ret;
@@ -2391,6 +2385,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   /* This input transfer is needed when cygwin-app which is started from
      non-cygwin app is terminated if pseudo console is disabled. */
   if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
+      && get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
       && get_ttyp ()->pty_input_state == tty::to_cyg)
     {
       acquire_attach_mutex (mutex_timeout);
-- 
2.51.0

