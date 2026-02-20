Return-Path: <SRS0=/go4=AY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 99F554BA23C0
	for <cygwin-patches@cygwin.com>; Fri, 20 Feb 2026 17:03:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 99F554BA23C0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 99F554BA23C0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771606984; cv=none;
	b=BF0UldGKDoIUHY75HBvQOBiUHb3HM5/0fDUkWG7I/fF2zTqKmI40MntCXEtdmyRqFh0Gz+4zsmr3lVsm6NU8EuCz+m5DCItzSxon5Q5nNPnTe06Er5k17TdSAcRGRtuRKycmmdj8nZF3IH2gY7KOqWbD89nK/Os/egwhG5WTfm4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771606984; c=relaxed/simple;
	bh=MDdydFhaLOyDSEFHLh4dLB/IBm1k8ZoYkxPTqiYS448=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=MOy3FmdPeZDQuTgHb0gyHml6EIV+d30chOopIfQ0xwjtiX3crN7zBXRzyBj+W+QC3zkVsgJBKFfcWSJ0ralCzzbXO6Duz0TIWkDkbnyxILOMjDWlADEma8j6wwx6qu/x+lA0nUTes1mV+U9su2zyUxmLpcdvdZorSZjdbHwdnCY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 99F554BA23C0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=sN6GLe7y
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260220170301796.KSWB.83778.HP-Z230@nifty.com>;
          Sat, 21 Feb 2026 02:03:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/4] Add support for OpenConsole.exe
Date: Sat, 21 Feb 2026 02:02:39 +0900
Message-ID: <20260220170253.815-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771606981;
 bh=i11yaOGhQjJg3WvKt6sWQy8aSTEs/22YwHHYLhjdtOk=;
 h=From:To:Cc:Subject:Date;
 b=sN6GLe7yebGF69DgQUQ5pt2IR4ZvOjdxbr2SKLzwSzPfbxuLb8XyqWmbCaervAcUpAD+BxXk
 MXW5/Bu88i8m/QVIuwor5LYRX7aG3Ryn9qjuvqH6IoX+FlSi9xfVcWeC0vC65BSPZP8lZxMSUF
 lfuGeV/nMuVrLo7vyZ7vglBYBGLt77PGFg8EvsC0tyX12CSvJ9QRnhPvYAqR3mC6BS4TXVTVNG
 5EjXmQUl9Ayt8AODmV6Z9iTUj8JOdLabMW+cfeEzLl4mkHolhuz192y6AjhSkd8e6BBv07kUqI
 jSHQaVpUL7wf6OYroSCVeUB4vq2qOslZUwGrLvvJA1FMNDOg==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (4):
  Cygwin: pty: Use OpenConsole.exe if available
  Cygwin: pty: Update workaround for rlwrap for pseudo console
  Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
  Cygwin: pty: Fix the terminal state after leaving pcon

 winsup/cygwin/fhandler/pty.cc | 371 ++++++++++++++++++++++++++++++----
 1 file changed, 331 insertions(+), 40 deletions(-)

-- 
2.51.0

