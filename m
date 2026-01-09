Return-Path: <SRS0=EOBS=7O=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.227.115])
	by sourceware.org (Postfix) with ESMTPS id 900D84BA2E23
	for <cygwin-patches@cygwin.com>; Fri,  9 Jan 2026 12:35:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 900D84BA2E23
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 900D84BA2E23
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.115
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767962158; cv=none;
	b=VLEXuwX5SS0s2mtp9fdh2OaZ4OciRluCd9LWRQCg5v35eYrxHpUh86b6Pava2hPM7RKSHjsg1/Xeq1VWm1qgpmmjigCt3S69wskrto0Zep55DpkRjLcTWJsFfrHX1vVOiewBKSxNT9jS1oabxI9LL+1Lz0Sw1JpzWCCtTqIyGaI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767962158; c=relaxed/simple;
	bh=BHV7H8sXqMUx0SUmROg+ZIjE/x40svTPSgmK79iDNps=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YMi10tYghVpRLgPnCMZF8cGPuCNQ0/4Cp8d8wPswiDP0cwCAXJe/dHUhKZ9UyYVj7R2dI+r6CTSr40I0C7QSHK/JhmjmWhP6ShuVg/hdsdVG0QG4Eq3dqn/u6n3D3tps43Yx5XvWhrUkN9rhOnMlTmVarVJZZ0t3RHFDeHV2Yns=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 900D84BA2E23
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=relDJREy
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20260109123555749.NQRJ.47114.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 9 Jan 2026 21:35:55 +0900
Date: Fri, 9 Jan 2026 21:35:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Remove the unnecessary fdtab lock
Message-Id: <20260109213553.f8d75d8c575245521513bead@nifty.ne.jp>
In-Reply-To: <aWDcRkuPgqRN_E-l@calimero.vinschen.de>
References: <20260108123502.989-1-takashi.yano@nifty.ne.jp>
	<20260108214626.1487161c6da89f7f2603b05d@nifty.ne.jp>
	<aWDcRkuPgqRN_E-l@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1767962155;
 bh=K8BpR9anKbrehRaf+8BZviB8T9qkiwodsMm+bGF9uIY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=relDJREy7PbrV0jbdB588P/hdYuxaTtkjK7Ekh2ktyyBCJuCBDNs/Ml/iLasWjXiAq+/ga1G
 BxSqimfCg9/+IzxN83gj9PAYevQZNLIRFJvSSXEVeVH2iBkHU9rSrF6ewB3X1OsJi2QAnY4xij
 bATS8kSLu9mpczImseEYwqg5g54Koj3HeqCDW9ZTw4m2KfNtvQ91LrLx5qOwvlDQrBYXcJYgOa
 9gesnd+cPm1jmmXGzFHdshktRVRNXwc3u/4e5VdgDJQoKGzsI7KDcE8wTz+Mr/0vcTrr7g8Pbr
 HrR/1Fx2YxJO4z8vhfMjw/UVIroJrV+8LwyjgLKW1UfEgSWw==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 9 Jan 2026 11:45:26 +0100
Corinna Vinschen wrote:
> On Jan  8 21:46, Takashi Yano wrote:
> > On Thu,  8 Jan 2026 21:34:40 +0900
> > Takashi Yano wrote:
> > > There were two fdtab locks: one is in inode_t::del_my_locks(), and
> 
> I would write that as "There are two more fdtab enumerations using
> fdtab locking, ..."
> 
> > > The merely counts the file
>   They merely count ...
> 
> > > descriptors affected by the corresponding lock, so locking fdtab seems
> > > unnecessary.  The latter only only during execve(), when no other
> >                            ~~~~~~~~~
> > runs only
> 
> Patch is ok.

Thanks for reviewing. I'll push the patch modified as suggested to
main branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
