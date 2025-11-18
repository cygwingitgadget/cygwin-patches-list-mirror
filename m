Return-Path: <SRS0=vCDf=52=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 42AB33858D35
	for <cygwin-patches@cygwin.com>; Tue, 18 Nov 2025 23:45:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 42AB33858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 42AB33858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763509554; cv=none;
	b=iJKQIq7dFcwFVxESPMZn9pjBrbA/CqWXVsNeQUrpwDTw9qS0pcF5L0YUiB9IQqSicJxmjhyGABlGdSott/1i/tZzgKTn/nKU03HowyALvRl7q1IR8RtbyJ2eMtWziyYvDVcWL9NGws75bv0bilsMbcQQ7wg6u9yQ0v1LQs96gOY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763509554; c=relaxed/simple;
	bh=Jpwba1BbXhzIeyOWTeoy+LmXDOuayUaOtlVL5+opRIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Z4Vy6Dl1/uItBcaS7jtBqg6P0gKOK2gYtqk4Sh5onCp0a6NsodFw4CQT8OAisnVAfQAJQDzyZ7b+ZUfIKsRoJ+TGmUW4MY7NQiDCMzn62Fmbep6KmBVSJDzwA+sqE/Fd2oPOhFGSAUR1YnfuVciPFSeNSWdpnPLHW/NRn8pArK8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 42AB33858D35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AcdZCMRr
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251118234550965.MGNK.50988.HP-Z230@nifty.com>;
          Wed, 19 Nov 2025 08:45:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/2] Fixes for dll_init.cc
Date: Wed, 19 Nov 2025 08:45:16 +0900
Message-ID: <20251118234535.194356-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763509551;
 bh=MDm60Dr8NOXobFFqV9eGIBkAB9UjMmpLfiftcw5oq2g=;
 h=From:To:Cc:Subject:Date;
 b=AcdZCMRrdG2ufmZcbkuxI/9qPBREttss5ie+l2b61Bf9BhHz7Uk9C2ta72vthkGfArodO5og
 EjT/RR/wSuRwhXE9YeJuMmytaZlezVqMt6SL8YlR7nfhYNuCWMaJrVaKgYKXHIwVZtAuL2/O7Q
 WUomLDkeWuJN06gApSTzbeTWgq3cOY9/ujoJxoScUDQ0HmGx7t0XUgHUT9O8myR+NvKJw32UyK
 +87t/tXCdSc+NZICUAIlKHz3XXbFKBtjtHHsvmKtPxIqkN3RzCazEf9dB1RJFUllfKXSlOpC2g
 bPfH/OiXOsLotzNo80IJgQLgsH713fFadDCm42IyzIKe2T3g==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Cygwin: dll_init: Always call __cxa_finalize() for DLL_LOAD
  Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.

 winsup/cygwin/dll_init.cc | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.51.0

