Return-Path: <SRS0=qRrv=ND=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3E7DC387088E
	for <cygwin-patches@cygwin.com>; Sat,  1 Jun 2024 19:48:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E7DC387088E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E7DC387088E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717271292; cv=none;
	b=mmHhdgOnZQXmL6fddUZ2mLyCJkeplQM9PvXLaIcFSDrm4kE3DZ4oUxsqGvHypDEUttVY+fes9p1IjKhkdGk9dP4EDgbmMGT+oMcMbFT+CXsKke2SFUS9UGI4MXAPoxRExMce18+mBimphrSpUAE2Xi1wM0lMdjKWA5AVRxcNQgs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717271292; c=relaxed/simple;
	bh=cI+cpwwV6ephqvfrR6aIjNCzs/MDb6xAYFHUQEzZcsk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=sf41lOdn7HHuRvcd+Y2hI+Fo9FhxI/jrCt4NS12E/2+zQVPoE5uMc04Hpq04U64eTPoLmqqWEgQ+xVugBQq43FUEL2xq6yKn/jPiS7PnHZ/I6J973BFSOHjJAqL94U+Z2VMEbMFkczExpS/MO394qhfjuFbVfWSlyqWapII/36k=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 8F51645B9D;
	Sat,  1 Jun 2024 15:48:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Rc/62uUiAI6T1YKIepIflZ0KZK4=; b=zN/Ts
	l8P9RREWChhiH+F7waNv/yNQl7f166AzmSeyScNsiMBXcbl0NJRYlpUy89NO3a6v
	9/hu2RNh32KxvFKapvMUMyIm/RXCEtuYdpVBHDvrHg/hMesO4QwwiOOjzSaFqbiv
	cvHvz53GD/glhloA4WT02zOEinbnGuhx89ciKg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 6288445B96;
	Sat,  1 Jun 2024 15:48:07 -0400 (EDT)
Date: Sat, 1 Jun 2024 12:48:07 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Bruno Haible <bruno@clisp.org>
Subject: Re: [PATCH v4] Cygwin: pthread: Fix a race issue introduced by the
 commit 2c5433e5da82
In-Reply-To: <20240601141700.3911-1-takashi.yano@nifty.ne.jp>
Message-ID: <9abc6820-e1a6-b033-5ffe-dfaa32ef62db@jdrake.com>
References: <20240601141700.3911-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 1 Jun 2024, Takashi Yano wrote:

> +  const int destroyed = INT_MIN >> 1;	/* 0b1100000000000000 */

I thought whether or not right shifting a negative number sign-extends was
undefined in the C/C++ standards?
