Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 6FEBE4BA2E0E
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 14:24:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6FEBE4BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6FEBE4BA2E0E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781360690; cv=none;
	b=KZeqGNVM4wkVbPgtPuAjl9V772/Y6Qr6nHzg3zyUmNTUgQl3fF2WWlIUhzLWyEC9Xx6bTLY+IA9EQAESnp+2btvxGeGw2yZegYX9napEx28J6sAQmq3MDuo6G0EGjcYuLTlEqnTUrGVT/wcmJ7c3Hrn4irtGI0EDL36pWEYVSc0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781360690; c=relaxed/simple;
	bh=/4LeV8TKes0JnfCPQFtRU/vOyMnCoDa8niNoRlC5qX4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=czamZdMk1PRP8qT1YimxIv6PQlRK7phWCZaeBj763DCCmAGDkDw1faLUL648sMkzPBn6xmq1hdb50Qc9GGprdJJmi0yPzuzA9cNl6YmAz7R6EuOVNm0w5isdyDVr+g/txKbOKwnIi2W2tVl1To0/CdDD1bma+o54gOYpmmBrrbA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jedPQ7RP
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6FEBE4BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jedPQ7RP
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260613142446778.PXED.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 23:24:46 +0900
Date: Sat, 13 Jun 2026 23:24:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Status of patches I proposed recently
Message-Id: <20260613232444.d4bf8f3d8d33908d8be14e74@nifty.ne.jp>
In-Reply-To: <20260612224229.a1b848b8a14bb84a471fc958@nifty.ne.jp>
References: <20260612224229.a1b848b8a14bb84a471fc958@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781360686;
 bh=nu7+42QOimMdeh015+POFYjrSmrQcXUd1T9nHYY+Vmc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=jedPQ7RPA5Pqndm0swaMCPlPZ8/nE6Xbo3JuDbWjh3ZAFp9USxKcoN9SGOJak37YVYmPH29Y
 6DPiHL8WXgWg/vK1UT8EoQ26ODz8Cr4EVCMcT37j5Vrz7g1bwzxqIukEUszQL3suMOX4fOchVw
 dUjTfmqyYAIUi0ZZDnNa8rhgrvFzUDJN6/ovWXL6h9WsUwmZ+ZlVG5ByFfZlmb0z5TkqgjSb7c
 jFRmhB2RG+9H83ac4tNvQizDWpCqbK6scG2VB8/PdBPPvI/bzxMbiwgIhB76HnxUAOp5c+so9w
 PXjPtz/5MKx6kKAo4uvvrtZpgNL3VmOFpfrvynqFUocLhIFw==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

All pty/console patches are not reviewed yet. Three patches are tested by Koichi.

* pty patches [New feature]:
[PATCH v2 2/3] Cygwin: pty: Discard pcon input buffer when discard_input is called.      +
[PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app exits                     +
(These two patches require following pty bug fix patches.)

* pty/console pathces [Bug fix]:
[PATCH] Cygwin: pty: Do not set input_available_event when applying line_edit()          (T)
[PATCH v3 1/2] Cygwin: pty: Introduce a helper function get_handle_from_process()        (T)+
[PATCH v3 2/2] Cygwin: pty: Prevent unintended conversion for cursor position report     (T)+
[PATCH v5] Cygwin: pty: Fix race issue between starting and exiting non-cygwin app       +
[PATCH 1/3] Cygwin: console: Ensure the master thread runs only when it is supposed to
[PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little
[PATCH 3/3] Cygwin: console: Fix typeahead input for bash
[PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in transfer_input()

* Others [ALl done]
[PATCH v3] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN                (R)+(P)

+ Patch revised after the last report
(T) Tested
(R) Under review
(P) Pushed

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
