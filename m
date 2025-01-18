Return-Path: <SRS0=STgq=UK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id E415A3858D1E
	for <cygwin-patches@cygwin.com>; Sat, 18 Jan 2025 19:57:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E415A3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E415A3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737230278; cv=none;
	b=dUPNLxr2PzvPd5tiNufSoTbCbG5196HQVQj5NGL2Yc9u1cnqeEJ5y3Ww3kXXW08mNoLOwmWwzV1UM68suyfQ6XKheyzhB7ZPU8o0yfF14LaHKym5nK2W7k57PCy7KTrLio6hYJi5+K+IsWgJPvVDglekbofOMG79yY/pX45IFJE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737230278; c=relaxed/simple;
	bh=UH389mgo99HfuH3L3HjZbP5/pZxoBhDSNoJjHqedh5w=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=xko2wYIEV/fQe/FvimR+X2UDHhxqdoqRPtZljBJn2c0ZitSzhU33/92pBhyOZyeXahLxmuEK+SP9sGgZGCIHho8DF/aAb8KTYeqw3aLw6noAahnie2NIAE0rEBV9B89PdfyoSgBIovXzM7vxFcSpE3xjQFaW7N5K8BOyeWs5KlI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E415A3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=M2U66uBi
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20250118195754604.QMGJ.93209.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 04:57:54 +0900
Date: Sun, 19 Jan 2025 04:57:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250119045753.24b173f0ccadd44fc0571748@nifty.ne.jp>
In-Reply-To: <c76fbd4d-c3c4-b5e6-0e1f-22bb43416060@jdrake.com>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
	<20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
	<c76fbd4d-c3c4-b5e6-0e1f-22bb43416060@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737230274;
 bh=83M3zQBenFsqTh+nRXdmmMnR4jcQqxNUL2hHF+nBPZk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=M2U66uBiU5NIOXxF3DWGwUk5vcxL1JQx30FoF6GxETUsvv0YQz+CUfdhNqesSOTvi+dQOGB/
 ojzul1YVeM0gs4KvTTKaLNt3vwJtG7NqNg10/Iu3QXOY/uoZdn12I/afpz5a5vws252N0COJjb
 B7otP3wT2526CmR+DwNP3jdhOt9HlxDWUfq5TJaQHDK1I1+fAhKSxP47h76wwTtiS8u4IBnfJc
 08vPHvFVv3tKXlZ+v8fFFHN5YFDvKoiDEDvpMTnQb+9PI7/5oQ0+BROiM/EPivQeEJ778DSC2w
 SGD234E7dRdQNxAW/UigY84Dq2GyR+tSc1besnmw2HiGPXCg==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 18 Jan 2025 10:58:34 -0800 (PST)
Jeremy Drake wrote:
> On Sat, 18 Jan 2025, Takashi Yano wrote:
> 
> > Jeremy,
> > could you please apply the attached patches:
> > 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> > 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> > against cygwin-3_5-branch and test if these fix the issue?
> 
> I opened a draft PR at https://github.com/msys2/msys2-runtime/pull/253,
> but those patches didn't apply cleanly (probably because we already
> applied your v2 patch) so I'd like your confirmation that they are what
> you intended.

Yeah, please revert v2 __SIGFLUSHFAST patch before applying
0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
