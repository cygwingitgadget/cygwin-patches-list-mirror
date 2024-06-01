Return-Path: <SRS0=TcHI=ND=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id D91C63881806
	for <cygwin-patches@cygwin.com>; Sat,  1 Jun 2024 21:09:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D91C63881806
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D91C63881806
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717276195; cv=none;
	b=JFvR4QyfV23Ao15irOj/1/Xms2GVchjMV8S9dbRnUuPsR38fPzLTT8m5Khmqd+TDbulTR5vOA8FfugrprNDTaqC1GAKo5MiomL6l/hzoXjlkwYPamb39nDrF52hbGFx6QpFRycVifdqJQPTvxOJ3g0gyS60BpRVOUHCV0P2c3gQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717276195; c=relaxed/simple;
	bh=rs05cAHBHibMc6nJwUEPmphMeG8DeMf9e2VNikHGX28=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=nPWRDSb9/h8Vdks5ZUydsll2nHuCxcrQd5JUHdoLukhyLIgCn//QQ1hH8SCsJNBi8dIPDO3JKCxTDkwPtExQDVl/GTLiyk2VpCcNXrJM2b/4QaUdn7IbvzsRK8RpWcHNVLbbzRDgm2hTmTH9q4VDxSMaiKFgvyzsSluz7ioa0H0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20240601210949586.PLBI.7571.HP-Z230@nifty.com>;
          Sun, 2 Jun 2024 06:09:49 +0900
Date: Sun, 2 Jun 2024 06:09:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com, Bruno Haible <bruno@clisp.org>
Subject: Re: [PATCH v4] Cygwin: pthread: Fix a race issue introduced by the
 commit 2c5433e5da82
Message-Id: <20240602060948.87af3449689d3f50805702d9@nifty.ne.jp>
In-Reply-To: <9abc6820-e1a6-b033-5ffe-dfaa32ef62db@jdrake.com>
References: <20240601141700.3911-1-takashi.yano@nifty.ne.jp>
	<9abc6820-e1a6-b033-5ffe-dfaa32ef62db@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717276189;
 bh=FIZ3ORTGE+l5twDC7NvvmnPuCMngbIMd8yD5NUC6Ss8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=V3eATtOaFlm4w2Sp27ey5/ejP27Q4W8d3hAXNHLSR6OROTnxrJ1PXqfMxGo5Gg9YQ58f9h1o
 fJe3RJbU1d125gKN2p8L1jv9YQzQu3wPQN8c02KrvT13yPAFsdM26jNUkXiFzfwV4OHB2PV4My
 Ou0iDkBcn91pMpZe29qssdGyYq8Y391gI/Y+OD9C4EeC2I2ScQdMQUj/gkgagCJ5QDt0yfhytJ
 D8Grx5sIueCbDgFJBn6RNb7c49I0VrqsmjRpH51NUl2SONMFmBdBmJc5ceow965OkUWLlSOBEM
 9TVnHsdxe4AR/mszjxnzMig/veDrn8OSpfSP9tApyN6Kw5EA==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 1 Jun 2024 12:48:07 -0700 (PDT)
Jeremy Drake <wrote:
> On Sat, 1 Jun 2024, Takashi Yano wrote:
> 
> > +  const int destroyed = INT_MIN >> 1;	/* 0b1100000000000000 */
> 
> I thought whether or not right shifting a negative number sign-extends was
> undefined in the C/C++ standards?

It seems that it's implementation-defined till C++17 and arithmetic
shift since C++20.

gcc defines:
	"Signed ‘>>’ acts on negative numbers by sign extension."

Therefore, this works as intended. However, relying on implementation-defined
behavior may not be certainly a good idea.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
