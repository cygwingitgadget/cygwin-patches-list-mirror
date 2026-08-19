Return-Path: <SRS0=SG5m=GM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2a])
	by sourceware.org (Postfix) with ESMTPS id B05C24BA5435
	for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 11:53:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B05C24BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B05C24BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1787140416; cv=none;
	b=n+53dA3GofGYMi2Q0VELWfJagErvB3U6H8MCEO7iFE2KjH1VzhdGkx1LeTnejkL7kskfB4LE5R/N+/Pm/3qF9YF6heaAhISUPg0bWTz8qlKzULMIAJFsTHlTgC7yiI7GbXAbDFh3AYH17PPspq9bRZQX5wXaM42QwQQHbkVgU+0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787140416; c=relaxed/simple;
	bh=Sx02XdIyLenl/r7TXFBEsVA8AciYLrEIt0mtDgU8zZA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=D+iYTzXw60A1Ml88cffWmi757A2OcxFPEAwCfQpExJw/Jth82w7IGQljAj5fbm4oxPo60/2/6pQzfaoLA8ApiNBzWtwBZVADPprl+D4dOccjRcrWCvVDWoSDlacvhrukuhEaQSogjhjNS6pA3IIeGV8P2NKgt57e+BaFBy+rVbo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=b4jTax7W
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B05C24BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=b4jTax7W
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260819115332576.NKBT.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 20:53:32 +0900
Date: Wed, 19 Aug 2026 20:53:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v12] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260819205330.ebaf2be591d7574910d9fff1@nifty.ne.jp>
In-Reply-To: <20260819134318.33ed499c4c1008c39120b5b6@nifty.ne.jp>
References: <20260807121459.3116-1-takashi.yano@nifty.ne.jp>
	<6232ca34-e83a-621e-cc14-738a423cbc6c@gmx.de>
	<20260819134318.33ed499c4c1008c39120b5b6@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1787140412;
 bh=Gk0KL0bEhPltqoaZaXml7APcjsIqEhIZQLF+B1qm0uU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=b4jTax7W6hvFYjzwe5fJVB2bR+HZuTk+/m0qVFJh1qFiT1uCvaLDsVPFYN7YxtA+KTHPI2of
 HUgYyYZ7U12rNwvLs+tWiIYdmPr3ZePjFlthQjECLeAfIZO5VmY0EK5eIZZKB/FnwPUSKIW9e1
 g42b4EPiR6jNFymzmgzyuTUbyeNDBjzSvp9vl2W1FCr8bCsI5PVKluBw8TySJSa19HqSTde7sj
 H963F4wb/UAWNdt+7OaZV3/ZO5Y3R+FngFk0Id/SYVh1ah1knQrArILo5dh+5VM9+vste9DoOA
 B7SlmEjjpytDLOx4biKInjL5GWuG4uxpGRpzsasZ+ajrX/HA==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Wed, 19 Aug 2026 13:43:18 +0900
Takashi Yano wrote:
> Thanks again. I think I’ve addressed all of the points you raised.
> Could you please kindly review v13 patch?

Sorry, v13 seems to have a few bugs.
Please wait for v14.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
