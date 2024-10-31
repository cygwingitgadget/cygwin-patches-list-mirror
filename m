Return-Path: <SRS0=MmMu=R3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id EF8B63858CDB
	for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 16:34:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EF8B63858CDB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EF8B63858CDB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730392494; cv=none;
	b=RYzyFA6wmR1HUNXAgYKH4NrYnmn7q86ibIRApYfHDGOuy8Q5k9j7gsDKFJhcUjjqMa0JsDtyYqKxp+6TYJ52+nplPo7ZsTsnAUrlmBF/ml47NbxEDWb61jBOwOLI9K0ZZ0HnKaB3tIbw171LTAYIMhsyHwiTu2OmcCJl3sGauHs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730392494; c=relaxed/simple;
	bh=lSG9dQw/QotdybLQ/PPinsCWNLAlDvylKk2WIZFZ2L8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uVeFiNL+RIII/uBKx+3Wwap/LuPXdC4A7SegT4EuwLtSLCIibNl9ximG45WaN2wuOsyspDRcVwpBoWuKk/kdmeUU8BzNmThRQWml9k1vciFNaeQx6QTFJEgayXRqOceP19bZ4YLFJQqErcc3Mrbc52fjnCofWCeHrXumsexMP0g=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20241031163450233.EGVL.116458.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 1 Nov 2024 01:34:50 +0900
Date: Fri, 1 Nov 2024 01:34:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20241101013449.24ab0ac8929133f7af12220e@nifty.ne.jp>
In-Reply-To: <ZyNY36rwRtAVglBP@calimero.vinschen.de>
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
	<Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
	<20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
	<ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
	<20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
	<Zx9fk6yQ1etCVwek@calimero.vinschen.de>
	<20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
	<20241028202516.0dd4c86cb2efa9f7db8c856d@nifty.ne.jp>
	<Zx98ETE7E1DMGirF@calimero.vinschen.de>
	<20241031173642.34cf4980cea2276e7402c4d2@nifty.ne.jp>
	<ZyNY36rwRtAVglBP@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730392490;
 bh=jMrnDi9e63CBqAzS/I5+u0P0TbJsHLq0IMX01hmXWDM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=SbKC+KtATEiqU8EBMooTqJCA3RDF1dx3a7aIwXOnzwAObRVgmhm0aR7LeeZpAHsEAhwIGd0u
 JYxnJicp1vRH+lrzgsPwBkbtdQWLgNeomIczTBPTfexf/2nkzZP+GGKuQb+OL3Wyx6BNIVnA1l
 DkfPxfR6V+tWZTlxweax3TdXOP7s6ldWNAHMEv6sWwlD72ovUvinTVG7Y7VJbYRq3VHtmFeyYp
 Q+k/OQQDEx0xUFht8Bd2j9/XXY6run2HrvCD+JkEtw7CC+rx3W7um7uc3QJIP8XdOdY+JBjoiN
 FbQAzWjb/fg5nTN5/CPE5ytip1ilN1w6nNRGqHaO6fhA7AHw==
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 31 Oct 2024 11:15:59 +0100
Corinna Vinschen wrote:
> Do you get a different result?  Do you run this on an AMD CPU perhaps,
> and the AMDs implement the SAL instruction differently?

BTW, how could you know I am using AMD cpu? :)

$ cat /proc/cpuinfo | grep 'model name' |uniq
model name      : AMD Ryzen Threadripper 1950X 16-Core Processor

Not ready for Windows 11 :(

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
