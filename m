Return-Path: <SRS0=9siz=EI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 06A174BA23D3
	for <cygwin-patches@cygwin.com>; Fri, 12 Jun 2026 13:42:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 06A174BA23D3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 06A174BA23D3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781271755; cv=none;
	b=qlu3G06+V7TkWrJlE7NIh93MuITdFSOLLuxRHHc/RnEr4AEyZKnamN2yOZIOBqdhj/+tB9o3AnTSp6DqpP7Nq4YZlv/6fPRjI/752MKTcTM1+yHrICitfCTfYecEZgs7lbmPck8S6TQnhBo+SiGZlYnDuiAzvcz3g3rAtkdOiFU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781271755; c=relaxed/simple;
	bh=Rquh1vtt5ZYGJkTy39atKnkgKTqZtSv5bQ8CAX/2SyY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Y4w87dDEk/WY6sn3zMzNC5Y5ojeFxoNLI50zqAb2Kk3v0S/cxwctxJoaUf+KpM/iq/ED76vs3yQZdSqEc/5mgL21kTODe4GD9TjIieRLQhqhqcxs5k4mxjYL0htYxcB1vtzKGDykxjAWltJ/Q/Q81T4p/VteuuvGST+Chw2dJGo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pcm6ZYBA
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 06A174BA23D3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pcm6ZYBA
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260612134231503.GFSA.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 12 Jun 2026 22:42:31 +0900
Date: Fri, 12 Jun 2026 22:42:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Status of patches I proposed recently
Message-Id: <20260612224229.a1b848b8a14bb84a471fc958@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781271751;
 bh=0dP40JU/wdAOIXxgxaObD+w0pgOyOmaREQG6OvHI4YQ=;
 h=Date:From:To:Subject;
 b=pcm6ZYBAEQvXQ+6UyxecX83hFpL6UGDd2WUsZoOs0krHljv7On6DmMjioMOkS3hznTxDY/sr
 PFrpuvTQG4vfwYKLmHDCJqbJm9vbqhH+rjXEIzM6/Vn3az4U8qrIAP8uNzRLU5k86EjPYVFU3X
 Mg0IpGqNB+cGb8Kwf8UBMVqmKE1npKoVAzGQKkLYIVKAxyyGEvvEdNAeDcKOv+kj57jhx08Y4/
 lm0ZhyFdYbiAQsOuOxLq7S6QfaW5mGCG6BL1Tfn/7gQWjB01V423QQec/Z82yQl/gjrAlQOCyt
 zCY4Ej5ADl1tr8+bq65OaCm8WyhvuECS8/aCOoq8zBBqy9qA==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

All patches are not reviewed yet. Three patches are testted by Koichi.

* pty/console pathces:
[PATCH] Cygwin: pty: Do not set input_available_event when applying line_edit()          (T)
[PATCH v2 1/2] Cygwin: pty: Introduce a helper function get_handle_from_process()        (T)
[PATCH v2 2/2] Cygwin: pty: Prevent unintended conversion for cursor position report     (T)
[PATCH v4] Cygwin: pty: Fix race issue between starting and exiting non-cygwin app
[PATCH 1/3] Cygwin: console: Ensure the master thread runs only when it is supposed to
[PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little
[PATCH 3/3] Cygwin: console: Fix typeahead input for bash
[PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in transfer_input()

* Others
[PATCH] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN                   (R?)

(T) Tested
(R) Under review
(P) Pushed

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
