Return-Path: <SRS0=md63=RQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id C9B023858D20
	for <cygwin-patches@cygwin.com>; Sun, 20 Oct 2024 09:27:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C9B023858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C9B023858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729416433; cv=none;
	b=Hx1Xt47PZ/AhpnpmtDzkGuwctYsCHnc2um5ZLw3d6y9rjl/NFfmZ61o/ZdTBSauU2EVaSvu024MOcty8rn8/6EdT5gH1o66N8O7rBVy5f26iHSE8Yt21dlLU2pfBJg8Qq/Mef8n7xtBap9dc1piqj5ACRifZrKxp7FXY9zM4mUM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729416433; c=relaxed/simple;
	bh=Z5rcyZIc1K1gZvJKwpZ5ggUQDLVUnTFJd78pkJ2C8oY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=cJMabnIeoSh2ZPdirUCBeJzu5ErJIiaQ83VDocyYVPwi7hJpb0T9m3yf3+31Uap2TLAo8BE8/seRAv3Fgk9/tDFkPFlajUgWnVFjV0j10/pmnPYRyoeBDbW4IVBmC1rMqKiEQpiRV3Gq2m2nrBE7rZtGDK5GPQEr1C0tyayFSrs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e05.mail.nifty.com
          with ESMTP
          id <20241020092706501.WKSE.81160.localhost.localdomain@nifty.com>;
          Sun, 20 Oct 2024 18:27:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/2] Fix two bugs of lockf()
Date: Sun, 20 Oct 2024 18:26:35 +0900
Message-ID: <20241020092650.835-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1729416426;
 bh=WrKjqZFRsX7lSZbRq6dG4TQVhkfC1aQ2Sr+CT0dV4Qw=;
 h=From:To:Cc:Subject:Date;
 b=r/xOgzsHPyd/AAMOI6gMyyWrejkFzCkwkmzt82IyCldQATuWpz7OgF3EIqVM26WtMQ30RujK
 5nlzPh3ye0MlHZemHTl0UWeTwWn5dW20b2T9WKzLOeZx6lIEljcsxpxS/tetVaUnqdmHP0ipom
 5T/BFt9hy0Lw4spOiwo90w6gTIXb7hjAEFYQoJWO/SUSWDyz1kfqVInHjANs3MKdozRjyZy/zZ
 +hMhJzo147e4gY3xifi7/9VygzrY8vMNG1k6JcXgC3W0Ppqkg7GkXgJp1K0TbVmTW9Ii/MhyQc
 2DycV9VLa/EwRmbdkpjhIS6ThcChfRXBbKC9uZjY1NMFXo1w==
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Cygwin: lockf: Fix adding a new lock over multiple locks
  Cygwin: lockf: Make lockf() return ENOLCK when too many locks

 winsup/cygwin/flock.cc | 53 +++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

-- 
2.45.1

