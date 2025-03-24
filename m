Return-Path: <SRS0=g3Q1=WL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id AADF13857039
	for <cygwin-patches@cygwin.com>; Mon, 24 Mar 2025 01:28:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AADF13857039
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AADF13857039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742779732; cv=none;
	b=yGIqFUjWgSRk1Z20oF5hmhjl2xMK2TxS+sr7Ia4bp0HmY+9lOTFmturMZ3AJofo5Ux8iEQ3FnVpgd2QhFVUJouUnEJwBlEx4ow1f6hhVGi0rtYgLEfLLbTF7+Vc+/qRQYk9LrU0MZoVRYC+p6OIvftAPXbpYbQIule5KS1rMnXY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742779732; c=relaxed/simple;
	bh=8V4YXsPpnyvUhAkoyWKWB7u9u6nCU/oYdbbf30Jbt+k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Voxx66z3m5lVAh42D2SnMG8SHIa2F6my1FJysdwG53gy2mitSsm0jSg5CNcDWJpISH1yad9PTrL6mnjlA1BPmHc5B5ZSmuXfzZS8OIcDuceLl+KfWZFdleXtHV6URlTlkWd/yvZqqno2C6/0ZXnUiuqBq2jKgJ9jAf819gAEZco=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AADF13857039
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=HbefUQ72
Received: from localhost.localdomain by mta-snd-e04.mail.nifty.com
          with ESMTP
          id <20250324012849852.EBR.90539.localhost.localdomain@nifty.com>;
          Mon, 24 Mar 2025 10:28:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: signal: Clear direction flag in sigdeleyed
Date: Mon, 24 Mar 2025 10:28:25 +0900
Message-ID: <20250324012833.518-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742779729;
 bh=D9ny0dvdS25m08tXN7lbEUWeyicKmPhJY/dbvapzoVs=;
 h=From:To:Cc:Subject:Date;
 b=HbefUQ72MMMkJnbxLRJ7g8HOo/fIVeIB9MA3tZNgqTjGNK2QMvUyZ4jiBVHHfk+GA4042smq
 pIeb4jJKIRUXrnf4K+un5GnZIZMqr5WOayEHtlyB6lKue8bhKQ78gVg0RVjrN95mWiENC5YR8B
 lFtzdd4tBlLwk+lG/d+rs3WflLjf9LVEEHpRtL/52GGHo+0ElRd5s4wEZiQack6t64PaEpCGVU
 Bgk7uqshbBadXdvMLI6ShY9+/eJD1EBEVRykBoDYwy3uYEyDHGntVX/c/nwAPmspn941ZmZ9UP
 QMGQ0KJfNboExzq9gx62aDN128atbgQ3uEH+Gi5EkK6+O/ug==
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,URI_TRY_3LD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

x86_64 ABI requires the direction flag in CPU flags register cleared.
https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions
However, currently that flag is not maintained in signal handler.
Therefore, if the signal handler is called when that flag is set, it
destroys the data and may crash if rep instruction is used in the
signal handler. With this patch, the direction flag is cleared in
sigdelayed() by adding cld instruction.

Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257704.html
Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/scripts/gendef | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index a2f0392bc..861a2405b 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -179,6 +179,7 @@ sigdelayed:
 	movq	%rsp,%rbp
 	pushf
 	.seh_pushreg %rax			# fake, there's no .seh_pushreg for the flags
+	cld					# x86_64 ABI requires direction flag cleared
 	# stack is aligned or unaligned on entry!
 	# make sure it is aligned from here on
 	# We could be called from an interrupted thread which doesn't know
-- 
2.45.1

