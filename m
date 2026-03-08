Return-Path: <SRS0=dH/q=BI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id D7A114BA2E10
	for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2026 06:57:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D7A114BA2E10
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D7A114BA2E10
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772953049; cv=none;
	b=arbxLZx8BcqtXVq2PFy5qTlgVCPXBoIBpJKyvmbZVohzSMN1lPFEpqNJThuaSIvuyBbl0N/d2urkFoIbIq4wSbNoDfKeWhZZbWhvbuhxlZzRufu0HQoql7jFZF002+Gxh5uVrsk9UBh4aV/2hYuywjPeR0mb7JlVjcfUrCL1E5E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772953049; c=relaxed/simple;
	bh=qYAIVBkmWWCihg/NpUveR9OTHEmv6vthsFXYOkOZWaA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uIR2dhsmFLvla79RJdrp7GX2s/0TeZzwaajyUfVx3sh2BeX5JGYpVDI+VWVqEg1R20R3MlaHehpyXjEWwSr5XRSYeWCQOEfDzAJgoKl9phE60n2MQUnleOtOE1Qj7Nl/AncWEsMEe/rhuzOygXULPhsm7rRKH6ahBhDJCW8wMGc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D7A114BA2E10
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RcoMlchW
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260308065726821.HZIF.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 8 Mar 2026 15:57:26 +0900
Date: Sun, 8 Mar 2026 15:57:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pty: Fix handling of data after CSI6n
 response
Message-Id: <20260308155725.1c92de92c2469c1ee3b298b4@nifty.ne.jp>
In-Reply-To: <f57571f3-e2d6-bfa6-875c-edaca6c24d64@gmx.de>
References: <20260305233757.886-1-takashi.yano@nifty.ne.jp>
	<f57571f3-e2d6-bfa6-875c-edaca6c24d64@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772953046;
 bh=YA/LeMogWiD9+vipfD3WFAfStxDwYWmOjpJ5WhbcB44=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=RcoMlchW4Ij+y/fsFg4NJB/KM4r+xd7XbUfuVsI93di2dznSonj8GHhbZoxR2sl/Qc4yz9vb
 nJOnwXSjIF/sZXV3F+LJguaH0r1bjxtgK9npKAwHWu4ge5waIJ3I8NZxTM78W42We9DLdsvtTd
 YCP0fsA9hui1WE3d6J0393PA/o/dhOLC78L63mXVoX2oa6QyntQF0H2rlzAbnJQAYsI71oQAJK
 bDawZ6+Pv6karVP3RMM6Mi7LA/xmtdluRbAuS/QQFIPWysfa/LIzqS//UR971MYwgEtubm4ajW
 bGIxo7HILQ3l11BhtYhzHQ2QzqInUrUnpFMlsqXo3pNEc0Mg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 7 Mar 2026 12:58:00 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 6 Mar 2026, Takashi Yano wrote:
> 
> > Previously, CSI6n was not handled correctly if the some sequences
> > are appended after the response for CSI6n. Especially, if the
> > appended sequence is a ESC sequence, which is longer than the
> > expected maximum length of the CSI6n response, the sequence will
> > not be written atomically.
> > 
> > Moreover, when the terminal's CSI 6n response and subsequent data
> > (e.g. keystrokes) arrive in the same write buffer, master::write()
> > processes all of it inside the pcon_start loop and returns early.
> > Bytes after the 'R' terminator go through per-byte line_edit() in
> > that loop instead of falling through to the `nat` pipe fast path
> > or the normal bulk `line_edit()` call. Due to this behaviour,
> > the chance of code conversion to the terminal code page for the
> > subsequent data in `to_be_read_from_nat_pipe()` case, will be lost.
> > 
> > Fix this by breaking out of the loop when 'R' is found and letting
> > the remaining data fall through to the normal write paths, which
> > are now reachable because `pcon_start` has been cleared.
> > 
> > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Thank you! This version looks good to me!

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
