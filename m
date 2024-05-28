Return-Path: <SRS0=tiif=M7=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id B78E1385B52B
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 17:18:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B78E1385B52B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B78E1385B52B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1716916710; cv=none;
	b=Z0dcqKZe1VJkXcxfPze62ymf7W9N6DHA92jLYMYjbX6ECFFu9u6ilIHxsUgDGo1aP7aiFJUJ9/6UxnoDdLmKeLXUFvG6FwSjDzRhNEL8RAIORRvrZt6VrnpNp1an6/0AsMP0ltTx0US5eqiiZXlNQrx01UqZYPklOc8Z7ZYh/UU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716916710; c=relaxed/simple;
	bh=FgxG7b3h4kK9fLQW9TyHpqxUSmglNtaCoNcJx+4PM48=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=h4F55Vc7ehCBU4k7ImgQB4e0C1OwycUQSoolCdkc/C3xLh2iJMBe9HdPoMv1mA0/zCcua17kKq+FUHzYiYXsYT9KBrHuI56Woa5Kmi81GgAz1aLyO89jvo15R07JEMnVPv0MsMVMBhKihs+1vbBQJ/6Ry3AlDgp2gaU9H7ddinE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 0CCDF45B20;
	Tue, 28 May 2024 13:18:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=tVUgGr0EtJHL2xYaWbpBOMUuKro=; b=RCt1o
	S36W2H0A2O2K4dHP+v2ljXcpHjJAVyvd3FcCMSAuvC8zM8jDEw43tuO59iFurp3C
	CoxAzmedMNCTCFinY2uHUtONRqbFbBu8ZafAqm8pFphPjAEXxODCEq6iLKuyylJN
	uuW5IlDxm0iqloq3qSG6tzxzpnEaNXj7yKH64M=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0687F45B1E;
	Tue, 28 May 2024 13:18:27 -0400 (EDT)
Date: Tue, 28 May 2024 10:18:26 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: disable high-entropy VA for ldh
In-Reply-To: <20240528163142.218a0089041defc754c6472d@nifty.ne.jp>
Message-ID: <53ffd015-f61d-ebcd-2faf-cf2e5a943026@jdrake.com>
References: <719ef5af-7945-6ffd-d217-6a9cec1540fb@jdrake.com> <20240528163142.218a0089041defc754c6472d@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 28 May 2024, Takashi Yano wrote:

> On Mon, 27 May 2024 22:36:07 -0700 (PDT)
> Jeremy Drake wrote:
> > If ldd is run against a DLL or EXE which links to the Cygwin DLL, ldh
> > will end up loading the Cygwin DLL dynamically, much like cygcheck or
> > strace.
>
> IIUC, ldh is not used for EXE.


You are correct.  I didn't read ldd.cc.  I'll send the patch again with
"or EXE" removed from the commit message.
