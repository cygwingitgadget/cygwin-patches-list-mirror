Return-Path: <SRS0=N3FD=EE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 829024900303
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 13:49:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 829024900303
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 829024900303
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780926593; cv=none;
	b=ZrX/3mlWMq+s2mva6dk5GlUyoC1iI3jVKOEp2FkauWq3lU18dqj37ltdQiUIVWOqNi70EHGDkAefqklyCfXJtj08ABst2qzXO1C4ELr/xqQyeIk4fG2n2t7D3OBVq7YTjDORyTA052cyxujAyHbbpQJSUcVwjJ37jP7butCfa5U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780926593; c=relaxed/simple;
	bh=sF0gdy6FDwzi95i8d7hKdiAbKOK/ojkgmQrnY7p0w7M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=le6EnGhN9MWNGDpRcVQXGy3Aq+O7pCMpdrUHqEntJ289FxZwdLiIObJy0YrOVIjlmVqf+uoeAFm58GG1UKZ3lp1ekIpdEtBwJzwy7FbtcGkq55ts09fYo7kvHu0jMmKZU2+5Un5GprqYQU8EljWfABrJHbEuK9AIBKdLfCEPrXE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Nd/VrJ0v
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 829024900303
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Nd/VrJ0v
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260608134950632.PIMX.17441.HP-Z230@nifty.com>;
          Mon, 8 Jun 2026 22:49:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/2] Prevent unintended conversion for cursor position report
Date: Mon,  8 Jun 2026 22:49:33 +0900
Message-ID: <20260608134943.2095-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780926590;
 bh=c+Sx8UqxFZrM+/RkPy3DXxRrSH1kzgM3R11HC5RPEes=;
 h=From:To:Cc:Subject:Date;
 b=Nd/VrJ0v9mR5ozwDMTbnG0gh+R6qEothcEv7zO01STCYtTSm1ZnlKuhVnSMIyq/Cw/fqpthZ
 g/IKfX8oMjeJC4YojJ7zgV0hU0PTblK6Iaa/mLnX0DskXIQ4tWIVNeOm3AbRhOStK7nbkrNrvK
 b/LmVsW6kNH1cHXw8+63qtV7WiaJT/+0PFe9Pm7ElFpguzPF16l1rQC+t+2zQ8vvGIQtEVXxTa
 w4eRc4TZ3reuoaMYyKNrxehT3rx4tS3guzT4FUwi+ENPaDUTONG6Q0s4wlc38QkUWdXtUOCIbM
 imItzxqpuD4AEcEdmOQIP+z8KJ71i/CcfprR7U2gIf+yzyDg==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2: Close pcon_handle_ready_event when the first (not the last) pcon owner
    is closed.

Takashi Yano (2):
  Cygwin: pty: Introduce a helper function get_handle_from_process()
  Cygwin: pty: Prevent unintended conversion for cursor position report

 winsup/cygwin/fhandler/pty.cc      | 113 ++++++++++++++++++++---------
 winsup/cygwin/local_includes/tty.h |   1 +
 2 files changed, 81 insertions(+), 33 deletions(-)

-- 
2.51.0

