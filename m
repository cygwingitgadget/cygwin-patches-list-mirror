Return-Path: <SRS0=N3FD=EE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 626764A9E07D
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 13:35:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 626764A9E07D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 626764A9E07D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780925719; cv=none;
	b=noqKEKfCK3TOf1GXlp74xHhzCyHDSMdmZuE/LwaJ0aWnPM9VnPCsF5aufbe1HBbdjhnyLakIisfqJePobZYvhKTacqeVS7yKAfV6VGpSlvKWK/2AD+sEoRO7OX4mrSvUuwIbr17XR4hXNFIB8ujRc7Was27+bNhBomtpGHg3RvE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780925719; c=relaxed/simple;
	bh=IsUJHdgk5xy1Elfe2Vw2eap27AtQJb45r81gw1ZSv6Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jXvBegSygHoH6wuSvR0RJAPifBpXIH/7ArTgfT8xn+EaOYfrhS3EMe0eSJ46B0ZcK/z9v457uPRchMhwJ+c2J4BTzx2/y+218zrvDFQWXNj6uUoaqTys/v7I7XkfvNduCVltyozan3l+iD1xBWyIf7hEWFc0BiNIt2/ROOH26FA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L4Oqj54q
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 626764A9E07D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L4Oqj54q
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260608133516249.OZZB.102121.HP-Z230@nifty.com>;
          Mon, 8 Jun 2026 22:35:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/2] Prevent unintended conversion for cursor position report
Date: Mon,  8 Jun 2026 22:34:46 +0900
Message-ID: <20260608133507.1990-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780925716;
 bh=CP58yoWE6v8nfXrlo9+Idjvj6cthSpK0oOOAjsdlHzU=;
 h=From:To:Cc:Subject:Date;
 b=L4Oqj54q8ihZvqfKMzRiHbuP1eBX3AfPSWrngoMz5wZFSaz8XNXMFTvOM3JZTIlBbi6k1WEa
 gC0P0tuzDlkx57OqC6OAcJgl3jbiudhLS2iWhMbtbyeWO7+aGLNuABVmSkYdOq2yj0Bz7jzN5o
 zam42NoP4kIdWkBVjUg+K1kLJ25wmpVVjXlgUKUqajAWm9XfjzxKpqVR881akTCtHilGNWC0mK
 HWL1+SqOna/rNEUpppRlT5yJ5mXmkmYE7QW9cPT+gNSxVeAMw28xX7mS5JEgccldE10vXxoTm5
 rlcoRD4x/W9XrhgpFGqgHGl56Ofc8BWIA/3A49rAtlAL0ktA==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Cygwin: pty: Introduce a helper function get_handle_from_process()
  Cygwin: pty: Prevent unintended conversion for cursor position report

 winsup/cygwin/fhandler/pty.cc      | 109 ++++++++++++++++++++---------
 winsup/cygwin/local_includes/tty.h |   1 +
 2 files changed, 77 insertions(+), 33 deletions(-)

-- 
2.51.0

