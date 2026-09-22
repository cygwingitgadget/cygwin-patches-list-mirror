Return-Path: <SRS0=BBfk=HO=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.168])
	by sourceware.org (Postfix) with ESMTP id DBE554B99F59
	for <cygwin-patches@cygwin.com>; Tue, 22 Sep 2026 17:37:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DBE554B99F59
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DBE554B99F59
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.168
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790098674; cv=none;
	b=MHsoYbb+sXmt6cjxtmAfoIuQZicbgCR8eOrny/t59g1ECjNWnif+wbdQjyW5TFONYe+ygi+n0X5+7QA8vaMch3YVoWdnVmyEoqRpHCm0HqfuqOUU35fJ2Q5wmK//abXVV2Gl5c30nftpty+q6tu85SYERIdtcqT1k63I8C7WFzU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790098674; c=relaxed/simple;
	bh=mrpu157s1T6ROHf6RwVjV0Ax5xUu44v7tzasejdr2U8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HY/ymILzOscGiMARiACBgBBFGzxTnTV+LWkCjB/vbwDkRLUEQvgQ47u7U0gsK0cOMEwngPyG8AkGl20sAvLN3yRVh9M8rTuDE5QVaJCKY7AsUtx7tzaPkmTyOZEHGCw3TwMqP0iFpOBdyVst2ADF5crN6zJLPqzLGZ7KIa2dMHk=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DBE554B99F59
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6A715EB8096819EE
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFV0YFXz2YDk4UpaocoDrvRJbfS/w4kkUsarxdRtdd1wOb2pgy2PXqtz5lXB0RErhiaKXn4O6A5pwS7JdFlnTpas5S4BuF7Fdzbr1qiOz8iag5+DPy8tV3tB9mR/L3AtQ8fL2L7KV9FIoIo5qTXRgG5yEzUqUTvWga3aMaulEsb9S8SaHxbDevzC18svJHqLDJrGpdhO5qOPA9Z8Zeg7/xLT9HFShjF+S3xW5lssPH90G9xHOUbLtbb2c2uomEK9rvqQWX9AUU1zhi6kZa1o+wvSRxFOhwFdgSEavLGrtHYMpvIJi5Bpe/O2vrFGK9P/f8XZejkBfnFnuCznk7TooU4M29bw+SlSHBAa18Re3nKdDTLiL+R3AjSvdl0JTHHN1wii8ESw0+33DKV2acGbKl5N2b32O6EViXFfOLLuqcUGmvuQ8+p6JHgcErn+tFlmWx9/bAnTeOk5V1qewGK4CP7ELmTwWwTJB6hk2aY81bi4qaGyRmooQWm04prKrXxWYC0ZvflMI4cEWhtE/Su8h4xtQEW1w109XbCZiNjRicw2nQcabc85sbQkj/zhSEeNxN0DC73UtXbJrP+kdnLXnwOVqIMpNYqyILANH8JKcORFWpgORTzNl6MShuBecrsD1N+86nsqwUJtRhPNbv0GaHSUJzBPSpciat7NPyYBMv20A
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (62.56.83.178) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715EB8096819EE; Tue, 22 Sep 2026 18:37:53 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/3] Cygwin: Variable 'nfences' computed but never used
Date: Tue, 22 Sep 2026 18:37:37 +0100
Message-ID: <20260922173737.111763-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
References: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

../../../../src/winsup/cygwin/mm/malloc.cc: In function ‘void add_segment(mstate, char*, size_t, flag_t)’:
../../../../src/winsup/cygwin/mm/malloc.cc:3995:7: error: variable ‘nfences’ set but not used [-Werror=unused-but-set-variable=]
---
 winsup/cygwin/mm/malloc.cc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/mm/malloc.cc b/winsup/cygwin/mm/malloc.cc
index 8a1fc257e..c2b1a333e 100644
--- a/winsup/cygwin/mm/malloc.cc
+++ b/winsup/cygwin/mm/malloc.cc
@@ -3992,7 +3992,9 @@ static void add_segment(mstate m, char* tbase, size_t tsize, flag_t mmapped) {
   msegmentptr ss = (msegmentptr)(chunk2mem(sp));
   mchunkptr tnext = chunk_plus_offset(sp, ssize);
   mchunkptr p = tnext;
+#if DEBUG != 0
   int nfences = 0;
+#endif
 
   /* reset top to new space */
   init_top(m, (mchunkptr)tbase, tsize - TOP_FOOT_SIZE);
@@ -4010,7 +4012,9 @@ static void add_segment(mstate m, char* tbase, size_t tsize, flag_t mmapped) {
   for (;;) {
     mchunkptr nextp = chunk_plus_offset(p, SIZE_T_SIZE);
     p->head = FENCEPOST_HEAD;
+#if DEBUG != 0
     ++nfences;
+#endif
     if ((char*)(&(nextp->head)) < old_end)
       p = nextp;
     else
-- 
2.51.0

