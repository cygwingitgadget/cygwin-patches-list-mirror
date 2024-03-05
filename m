Return-Path: <SRS0=ZRpm=KL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1017.nifty.com (mta-snd01006.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id E41193858C98
	for <cygwin-patches@cygwin.com>; Tue,  5 Mar 2024 18:46:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E41193858C98
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E41193858C98
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709664398; cv=none;
	b=P+CixoTed+SWFPKhD/sgT9+DA0B6XhR3OpMPWnHgUHCEJqc2apg42TReq/bvoIFt8P2gH1dk8i3z1edOTv0YtBKfK6f/nmizl7Dg1VM1PVz1i7S5k2R518PuysGhuh09QMVTCDRuKJpn6vfIPt7KOcs3W2CRz2S6CmqIVeRaocs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709664398; c=relaxed/simple;
	bh=jQ7NR7GkAFwKY0ROxi73J4Ny0DGwIczXVS1GuYuEp9c=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=qkPOm58Vr0vRfYwV7oisdG6RJa6r6C7eHXplvu9FswBK9s916IoEiUJ5jyU3lTrPX3UHevZYZl7RUd46d3i81QoJ6WymSh2aa3lWSGozR8JNi6epyl2F5SCZcZesf7tPxHH1MlCWrCdeILgfQkqVVfK/OR6R86jW0yAXKWtMukk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta1017.nifty.com with ESMTP
          id <20240305184633969.FQRD.70310.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 6 Mar 2024 03:46:33 +0900
Date: Wed, 6 Mar 2024 03:46:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-Id: <20240306034632.8167f25a8eac557923be8153@nifty.ne.jp>
In-Reply-To: <20240306034223.4d02b898542324431341b2bb@nifty.ne.jp>
References: <b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
	<20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
	<87a5nfbnv7.fsf@Gerda.invalid>
	<20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
	<ZeWjmEikjIUushtk@calimero.vinschen.de>
	<87edcqgfwc.fsf@>
	<ZeYG_11UfRTLzit1@calimero.vinschen.de>
	<20240305090648.6342d8f9cb8fd4ca64b47d38@nifty.ne.jp>
	<ZebwloVEzedGcBWj@calimero.vinschen.de>
	<20240305234753.b484e79322961aba9f8c9979@nifty.ne.jp>
	<ZedOO5gM1xApOb3A@calimero.vinschen.de>
	<20240306034223.4d02b898542324431341b2bb@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 6 Mar 2024 03:42:23 +0900
Takashi Yano wrote:
> +      name.MaximumLength = MAX_PATH * sizeof (WCHAR);

This should be:
name.MaximumLength = sizeof (pipename_buf);

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
