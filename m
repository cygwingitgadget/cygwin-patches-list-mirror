Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id AEF4A3858D21
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 17:48:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AEF4A3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AEF4A3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737395314; cv=none;
	b=HNhP7Ye3edOzkPkY1do4iTyabuaZ5zJEs00T9hvMgmifRlQ0jDstAlSHrZD6ReX3ocVd2v0Nnfi6eSAaYIGEuu9dSRI7q/0ymqy4yudpJLNW3pd/WTk8/z7xg/I4UQpKS0/rnJ9j38PdzmcEoTU3IQAjyzXnhHYxFDtdmVOQoT4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737395314; c=relaxed/simple;
	bh=k7/Kyz6tDpnRgxfHiHTef9UEaPqfhPPY9zF0HOTf89g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=cDXdoR4qKX044goZxmAfpQeRlW1jNZBKjshN/6q5grRn+jFHN4w3FXZ/lcVCOIsmbkXLaYNBWNNEcSM6J5/l5DstIEdNOzZueZXQdvv673ra2d0H6Zpg/HSYXSpXz7Gs6tLYBK8l5fpYmfQk8Hn+PnKJjXHBaTY9oQUDlwRNCD8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AEF4A3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=P7FMtmbH
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250120174831668.TPZJ.87244.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 02:48:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 0/3] Revert __SIGFLUSHFAST v2 patch and apply v5
Date: Tue, 21 Jan 2025 02:47:54 +0900
Message-ID: <20250120174811.43043-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737395311;
 bh=+jchYKYVt+Jrx+he9dusjKuS4iTR+W7UThRil6lbFWQ=;
 h=From:To:Cc:Subject:Date;
 b=P7FMtmbHbwpblUXev5hrRML/KUoREeVpygVxAowiOWBpUhMqYwUNcouESNXpt1YlWdtBXNhd
 G5h0awePa7vft3maQe2XHnN9TtCC81zRwqlXGNYNuz6eHShJ4Gyfm0s5+a9DYIb3IK7TB5QhvE
 hdDs7yCZkEeDqBmd/2dPVGESHohB0bdsd7QR7H5zRHrJ3Ld6RlcO0EW2Nd1+NKm5dOSAckveqE
 hip7IhjdK9/TEKHfFVV3dR1dPxMfJNNFUoKIYTsRR+NOVvUN1+ZPVbMpKgXNx+rz63DT2oI56n
 L4F2U24axnOaJfI30uowLDKPZuIyDvPONTTMyC4/UJ3G8HQg==
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Revert "Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is
    sent"
  Cygwin: cygwait: Make cygwait() reentrant
  Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent

 winsup/cygwin/cygtls.cc               |  2 ++
 winsup/cygwin/cygwait.cc              | 23 ++++++++++++++++-------
 winsup/cygwin/local_includes/cygtls.h |  3 ++-
 winsup/cygwin/release/3.5.6           |  3 ---
 winsup/cygwin/select.cc               | 21 +++++++++++++++------
 winsup/cygwin/sigproc.cc              | 24 ++++++++----------------
 6 files changed, 43 insertions(+), 33 deletions(-)

-- 
2.45.1

