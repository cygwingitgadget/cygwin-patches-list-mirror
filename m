Return-Path: <SRS0=BBfk=HO=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.168])
	by sourceware.org (Postfix) with ESMTP id 74E1B4B9DB66
	for <cygwin-patches@cygwin.com>; Tue, 22 Sep 2026 17:37:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 74E1B4B9DB66
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 74E1B4B9DB66
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.168
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790098671; cv=none;
	b=CU7Qbuj34Lfvp+P/wI1SST3gBKOOJXF+BiPeGf8MFcU+CJd59qHU0kHxEDzU8qWaN/ZYcUQw4yCFg/8KnjDEWyAsOqmQluIsn+iECtoEHLyQDdC60f0sb6uys/p66lsbvocvPH+2pAigctvVV6c2vfjjc8Ou78bZBz6L9GZTDsg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790098671; c=relaxed/simple;
	bh=8sTlAO6OeNa2PasTiHIkiR1x8z8hD6H8W2CI1gTUAjE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RAm6kj/qMtKsgwgh4e94MJuzfitpIR8FUFcmIAkBq+iyd1Wrs+7w1J6cnoMNi4gG74pjOE9uMiNHQW7ElNeESrxJMm7BSWhSIo9xaU52EAe8zkICJ+kcAC3dKJLvoYVdx+KcohWNYhj2triz+9pE5QtKtEpFbqkw25Uu/yYPwgE=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 74E1B4B9DB66
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6A715EB809681963
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFV0YFXz2YDk4UpaocoDrvRJbfS/w4kkUsarxdRtdd1wOb2pgy2PXqtz5lXB0RErhiaKXn4O6A5pwS7JdFlnTpas5S4BuF7Fdzbr1qiOz8iag5+DPy8tV3tB9mR/L3AtQ8fL2L7KV9FIoIo5qTXRgG5yEzUqUTvWga3aMaulEsb9S8SaHxbDevzC18svJHqLDJrGpdhO5qOPA9Z8Zeg7/xLT9HFShjF+S3xW5lssPH90G9xHOUbLtbb2c2uomEK9rvqQWX9AUU1zhi6kZa1o+wvSRxFOhwFdgSEavLGrtHYMpvIJi5Bpe/O2vrFGK9P/f8XZejkBfnFnuCznk7TooU4UKwhCMeqJTBtVxYHGc84NQ483a7ia9qpj4BN/kTiPjccwt88PAGYzFSPgn3jzitIr1sVIFvMSQstnfdMlJJfmo199LICQWXBLCVepWiiACAohJ0RAwcsX7UTlXKWcm/o6CdyyR8XtaiWa0xIxD/CRIOC6r0M7lRfYf+nZy2oL7s9d2nak5NlEETK0xBNmDdq81h13R5aFCWT8sM6ntlpWXfsrbjce+8VsaYGEpiGCd6j7OlIsVy3snp2/HqeUA2gF6+xqLPkJwDmrXRzG2RN0I2a40eObSuo2Pf1OAH/UGt5f8rzmKxjJ1HhI982qgZTHqAbwsHWfgCel+0D67P3Hg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (62.56.83.178) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715EB809681963; Tue, 22 Sep 2026 18:37:50 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] Cygwin: Variable 'prot' computed but never used
Date: Tue, 22 Sep 2026 18:37:36 +0100
Message-ID: <20260922173737.111763-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
References: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

../../../../src/winsup/cygserver/sysv_shm.cc: In function ‘int kern_shmat(thread*, int, const void*, int)’:
../../../../src/winsup/cygserver/sysv_shm.cc:345:19: error: variable ‘prot’ set but not used [-Werror=unused-but-set-variable=]
---
 winsup/cygserver/sysv_shm.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygserver/sysv_shm.cc b/winsup/cygserver/sysv_shm.cc
index 4578c53a2..322f9ed2f 100644
--- a/winsup/cygserver/sysv_shm.cc
+++ b/winsup/cygserver/sysv_shm.cc
@@ -342,7 +342,9 @@ kern_shmat(struct thread *td, int shmid, const void *shmaddr, int shmflg)
 	struct shm_handle *shm_handle;
 #endif
 	vm_offset_t attach_va;
+#ifndef __CYGWIN__
 	vm_prot_t prot;
+#endif
 	vm_size_t size;
 #ifndef __CYGWIN__
 	int rv;
@@ -379,13 +381,17 @@ kern_shmat(struct thread *td, int shmid, const void *shmaddr, int shmflg)
 		goto done2;
 	}
 	size = round_page(shmseg->shm_segsz);
+#ifndef __CYGWIN__
 #ifdef VM_PROT_READ_IS_EXEC
 	prot = VM_PROT_READ | VM_PROT_EXECUTE;
 #else
 	prot = VM_PROT_READ;
 #endif
+#endif
+#ifndef __CYGWIN__
 	if ((shmflg & SHM_RDONLY) == 0)
 		prot |= VM_PROT_WRITE;
+#endif
 	flags = MAP_ANON | MAP_SHARED;
 	debug_printf ("shmaddr: %x, shmflg: %x", shmaddr, shmflg);
 #ifdef __CYGWIN__
-- 
2.51.0

