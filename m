Return-Path: <SRS0=xgHh=BD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 2330D4BAE7CF
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 11:07:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2330D4BAE7CF
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2330D4BAE7CF
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772536061; cv=none;
	b=g6MBTD9SNToBGmSB9Ki+D8Ar1Kk9myrhF/gS1X89F9KMTMST5rSOnulNzi6JsDyk3IuVcKUpAxVUZui7+8X65ixQEMg8j54p2ssPbU13M9JxmdAR1kbQFBuke5Mvoyj/Bx3FWBYIxUNNOnyf1R02vtoPMFGFtPmYYylIteb9A78=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772536061; c=relaxed/simple;
	bh=sTbLUHw59jFQ8aKawWTt9Hj6lZ40SvllUJy1YvYUWOo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=AuB0ZgKCP9yp28aE8AqSGetBvuGuhdNYOyZpHvAdoX3vuTxTDkTCP9sr2BRJbdPU/JZ9lGzcnVMJ70LOq9b1q2QrzJ+XFuZhXmfwJ/Eu2dcPKpkpyel2e17gnyybcSDorIP10SDNZuJCnO1zNTI+o2AXbA/8E34zkP0bzhelwFA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2330D4BAE7CF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Pj0eNOja
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20260303110727269.IAZI.116286.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Mar 2026 20:07:27 +0900
Date: Tue, 3 Mar 2026 20:07:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Do not call empty WriteFile() to
 to_slave_nat
Message-Id: <20260303200724.bd9256b81efbae0bb3b939fd@nifty.ne.jp>
In-Reply-To: <969e7005-6e43-dbb2-8524-33995c6cde3f@gmx.de>
References: <20260228192538.1908-1-takashi.yano@nifty.ne.jp>
	<969e7005-6e43-dbb2-8524-33995c6cde3f@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772536047;
 bh=VHX0PLncgt2KhqxQid03OwIMsvX9fiJSCZy686Ad3Cc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Pj0eNOjayuDcCRdpQ3wdOvoL3HJGDWRFZ56/NnjM4mz4HiIhQ2l8T+7qh42HT+4ejP2ytzi9
 R6sX/DRiCYFhHHUySA7uWt95DOhcILcS61TKBjoVK+FMDlBXfhJ+si8hvMm2Rv4wmAKqNxkglk
 BmwB0hYCUbefQM4A8YmqL9AcJJg6vosLG8iD0ej49UMUKif2UAkkerbQ+F78qC5IgayMEunkvI
 0SH0un+rtAuK/UVdOsURiHEvUl5Cy1TNpaVUa7CG7JxZKm3EighVTjDYSdNSr+r9qzcVzb3heL
 Q6VbPgeh3NeoG0o2G6usL3WNXt86dmuWxmExzvq75LSitWEQ==
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Mar 2026 13:41:10 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sun, 1 Mar 2026, Takashi Yano wrote:
> 
> > In Windows 11, it seems that conhost.exe crashes if WriteFile() of
> > zero-length data to to_slave_nat. This patch skip WriteFile() if
> > the data length is 0.
> 
> While it is surprising that this should crash, the patch does make sense
> to me.

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
