Return-Path: <SRS0=UdKb=V6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id 1CFF33858C5F
	for <cygwin-patches@cygwin.com>; Tue, 11 Mar 2025 11:52:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1CFF33858C5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1CFF33858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741693941; cv=none;
	b=SXLwGXhguDlG1BfsyiM1RlfN1hca5B+k7iNwESJEoARQC3GgtSi42DpBAcZ7D9t5gE7NMUCZxQQ2Zct5DsNG4ShQ7c/6rmL4Fc8i8FBexTlNmgDmX3fMTrXY0ryaiyi8vXBZWx8jFP2Q5BTjAX1L8r/BRW+EaGiGLEMLEL2uFnU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741693941; c=relaxed/simple;
	bh=oVGJlZXlrEjjqcUOhcbOnu2fh35g9iGROqyscTsXglw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=TlCIPP+1OR6GfAZ1j2pNZToNEVRujMDsHxt5XuGEJpWYHwuA1FbSq5Pqu62M39tE0FbI2Mglt8/WUXW7b8z1OLS2FMkBgnwW1OaZMGV4UQ0Rc+ZhBOC5Qg69wA1YVbvOlY62C2ZnDn+LpU/6IUYCnRC5jj2EKZXkLKN6bXwUa3k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1CFF33858C5F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aXY25iGt
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20250311115219375.UNIO.37487.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 11 Mar 2025 20:52:19 +0900
Date: Tue, 11 Mar 2025 20:52:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signa: Redesign signal queue handling
Message-Id: <20250311205218.5ba2ae2a38e23f45d9f1c3b7@nifty.ne.jp>
In-Reply-To: <20250311205005.1e4aa4da870526b45ce97728@nifty.ne.jp>
References: <20250307121626.1365055-1-takashi.yano@nifty.ne.jp>
	<21db86b5-d9db-734b-7fea-922b18dab292@t-online.de>
	<Z89SULIpjgwSeQST@calimero.vinschen.de>
	<20250311175642.965ccd440c67ad956e1206b9@nifty.ne.jp>
	<Z9AQaVQxMemHm4SH@calimero.vinschen.de>
	<20250311205005.1e4aa4da870526b45ce97728@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741693939;
 bh=44h87ochIeoVuVY22pAbR/CRobZWzX88DbD9UtEQivE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=aXY25iGtjmPWq7Xj4kxEZu5CGcBCIkXw50Xsj41UtFhP589KRRKHYB8QKmO89SzYJ8MNIfu/
 OcB7uYZGnkGF76GMQ3ek3jBfDkuOYq/9X1I1SA8AGtkXXx6jNAFqX5cehE3uGZs8QOm9VAFARW
 nlhnKbZf1t46YZRLAkcAVfU8cG/uzP1CFxopEvGurb6W1sE8wrybmVe/GYzTeALpAvaxJtxeyr
 aef6YP0rYGlfKIn1pNztnWHqSKeLrN2yV+GhuvCP8/wID2gGBEesmfnhc85Iw+m2jrvVcTxkyX
 FNb3GrAPh8r0wzxmGDqpmcfnOCZ0REqmpcpLMzuzIJEHNEeg==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 11 Mar 2025 20:50:05 +0900
Takashi Yano wrote:
> BTW, I found another bug in signal handling.
> 
> The following testcase (that is the modified version of Christian's one)
> hangs with my v2 signal queue patch.

Not always, but sometimes.

> It seems that the signal handler
> is called from inside of the signal handler, _cygtls::context seems
> to be destroyed. To confirm this, I tested the patch attached.
> The patch is not good enough yet, however, the test case works with
> this patch.
> 
> Any idea?


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
