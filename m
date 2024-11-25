Return-Path: <SRS0=SJZz=SU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 1FC453858CD1
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 12:17:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1FC453858CD1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1FC453858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732537043; cv=none;
	b=m3atFB+ohYhzgCTNxtWpgSgki//jBk6vMVxpAVUVLJEoU293FvvrkcrQ5UpoHdL244rBbNXeFsLTMEaicuibs3e56V2buWbsiZopcNzZD5x2NMZjQ7ziEdELfx3WNC5zC18tfg8PxoAXNSlY6yWmkm6VP12CmIVZofYEGInVMD0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732537043; c=relaxed/simple;
	bh=tXg2xoV/fQl8KN7prjm2Ose0BeH74t1DFCaXV9NT9So=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Elw62G0LIc0OAjdtuZDFYBSevw+x7W99rIZVizt1Se+GO3aQuIEtQVTqI+icB/U5b5lIDnINf8klKzmzPVHpMFyt4GvmRycswu9GP/lNBawPHPSh00Xs5VexZQKu0gttKAJB8AhKV6EXmJRnDtrtp7ie/ZVmP536Y8RgO/Ozass=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1FC453858CD1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pEOF0zUd
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241125121721327.KELP.47547.localhost.localdomain@nifty.com>;
          Mon, 25 Nov 2024 21:17:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 3/6] Cygwin: signal: Cleanup signal queue after processing it
Date: Mon, 25 Nov 2024 21:16:19 +0900
Message-ID: <20241125121632.1822-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
References: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732537041;
 bh=6Dmruzz9szculRqiarWJYxi6NXaHSIR2hgFm4Lc75Dg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pEOF0zUdfv4XYrwwqh1VgS8X0MpTsIqB+81hHDmllFqmMh+/KE7lCseJ8iaew1XHlLZsC81s
 yZivQZZ/iYJb0bTZgMpcay0z87y1z5gHOWOm6xdefRJJG825Ai4+JW0N3R60uUFv8HJJ18mBSg
 o0NmIBtqzKNc6wJPJ63ruB5K17Pj+KkJaHSlN027yLgOCdVxGEV+iv7E+LV11/ILUchyuZQXzR
 Q9tgtSCXtL2GYqGHeQNvQ8JeI/VG7FtLBphx0OAaNYjrueXarfBN8J945ifSUGdz1/I8VPcPdI
 bfvRIHv9Lm0QUzxTwaAIVRUePgMlpZU/LVirjFa0N4Gsg+rQ==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The queue is once cleaned-up, however, sigpacket::process() may set
si_signo in the queue to 0 by calling sig_clear(). This patch adds
another loop for cleanup after calling sigpacket::process().

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 34e459070..541f90cb7 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1471,6 +1471,17 @@ wait_sig (VOID *)
 		      qnext->si.si_signo = 0;
 		    }
 		}
+	      /* Cleanup sigq chain. Remove entries having si_signo == 0.
+		 There were once cleaned obeve, however sigpacket::process()
+		 may set si_signo to 0 using sig_clear(). */
+	      q = &sigq.start;
+	      while ((qnext = q->next))
+		{
+		  if (qnext->si.si_signo)
+		    q = qnext;
+		  else
+		    q->next = qnext->next;
+		}
 	      /* At least one signal still queued?  The event is used in select
 		 only, and only to decide if WFMO should wake up in case a
 		 signalfd is waiting via select/poll for being ready to read a
-- 
2.45.1

