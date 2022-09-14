Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
	by sourceware.org (Postfix) with ESMTPS id D5A07386545B
	for <cygwin-patches@cygwin.com>; Wed, 14 Sep 2022 04:41:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D5A07386545B
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj136180.dynamic.ppp.asahi-net.or.jp [220.150.136.180]) (authenticated)
	by conssluserg-03.nifty.com with ESMTP id 28E4f4EK011920;
	Wed, 14 Sep 2022 13:41:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28E4f4EK011920
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1663130465;
	bh=gukW/uMKw0iIA3tKyEJhLno5Ie6wLhJqCDrIx3RoZl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CAdmHhkBaT0hgmYRPM8f2+cpABCyduR+LestVWYLqgfj8InUO/PXbAfo9IY8SJ7L3
	 oHXqbAgziC5S/MFVl2tkQR4Zz/iLq4xGjK7voMxGAosyovD2Ir7CrJIxylOTKCmcYJ
	 NLYcwfWRX4Gr3p1GzbOQyAKDHH9W8H+XT6TXxu5TYoO9S3Qms8mrJh1CRg72d4Xw+R
	 Rm2Jy1ohxF325IewoqSngwARVjVlLnsgx8bvB3NiXt6swap4yG7nSN+6Hmo8/QwVNv
	 6KgsiuqRwvJfYXLLViik8Gr57ktOKUUYq7fHniQtJk5or7EtdnjcZxuotyw94P94qE
	 9cXiCIyI97jGQ==
X-Nifty-SrcIP: [220.150.136.180]
Date: Wed, 14 Sep 2022 13:41:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: Cygwin 32 Build Branch
Message-Id: <20220914134106.3fbad135a1f6627457ae3ec3@nifty.ne.jp>
In-Reply-To: <fb1170f1-b58f-b428-fb2e-647930315db4@SystematicSw.ab.ca>
References: <fb1170f1-b58f-b428-fb2e-647930315db4@SystematicSw.ab.ca>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 13 Sep 2022 21:27:25 -0600
Brian Inglis wrote:
> What is the branch to checkout to build Cygwin 32?

cygwin-3_3-branch

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
