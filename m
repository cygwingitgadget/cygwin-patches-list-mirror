Return-Path: <SRS0=KLwD=WE=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 49CFD3858D3C
	for <cygwin-patches@cygwin.com>; Mon, 17 Mar 2025 20:53:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 49CFD3858D3C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 49CFD3858D3C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742244781; cv=none;
	b=fS2iMVArqNhiiEGtZHKS6INfCNYYqB4MV6bxk1P5ziIoR3unWuR6ieKOfp/YeOz+7HWiPnOuYjBHG3x3u+4BTh9RZsgbnLG+1xGa+ciJZLwnlRtglGkHWI5mijYYQyo2mJMWHBGFfwmHJ+qaEPutfRyG4oL7flyCjvaLUgdvBRM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742244781; c=relaxed/simple;
	bh=kCo8RsYy9mVKgB1ILFCS86vySWzSF/Z39zCWWvq27+8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=soNMcJ+CZM/fA+eGmnSzeTzJ8ulz5Pjp18AGcMfjpgkvL4ZgLl7wYSmwbjDEe9bBvB97rIVGl8Y0y5/Ld2+kFoFN31Bh9Nv3UxLgbArKgSFK6LsePgOM7jWlXG1eLWCWGOSqEeB+ptj5EO9mVS9OngSDlGe7U4COruvxR/Jzr1I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 49CFD3858D3C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=sLMAjaZW
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A370C45C83
	for <cygwin-patches@cygwin.com>; Mon, 17 Mar 2025 16:53:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=akbsMfqjyKUnFJf1cnDgnqsqIxo=; b=sLMAj
	aZWuaCyDRdsWfK6oQu14X1D+S4qwaWxnQ6BRuRuYoFLl6/MpMorP0r7TRG6vFUXg
	4h9Ob00+AgnMkXJ6viXE5kOUb+T3F3NsVNPm9R8sp4UUA/BazPJVRYGAomOzR+H3
	zdQC9LNCWDas9gLF/+msp9N1MCrzVdunN2eXnk=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 821E145C7B
	for <cygwin-patches@cygwin.com>; Mon, 17 Mar 2025 16:53:00 -0400 (EDT)
Date: Mon, 17 Mar 2025 13:53:00 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix native symlink spawn passing wrong arg0
In-Reply-To: <Z9hwmMDsTXgBpeLZ@calimero.vinschen.de>
Message-ID: <64d492ad-1a4e-80e9-06f5-b25d867c065d@jdrake.com>
References: <19580bc11ec.e77085b5699413.240072222093655736@chrisdenton.dev> <Z886PJK2OMtcUwEC@calimero.vinschen.de> <19581e3058e.ebf97e1e733524.5029218649132507579@chrisdenton.dev> <Z9AT-rlIU0StWEzQ@calimero.vinschen.de> <4dd8a82a-d345-5339-5a90-7d5e72b65454@jdrake.com>
 <Z9hwmMDsTXgBpeLZ@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 17 Mar 2025, Corinna Vinschen wrote:

> > Ping?
>
> Ping who?  I for one am still waiting for Chris' ok.

Sorry, I was really pinging Chris.  I wanted to get this unblocked since
you had mentioned maybe releasing 3.6.0 soon

The other patch I was hoping would get into 3.6.0 was the fast cwd
adjustment for new insider builds.  Last I heard Johannes has not had time
to get back to that patch though.
