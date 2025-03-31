Return-Path: <SRS0=ejch=WS=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C5BAF385AC35
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 20:58:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C5BAF385AC35
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C5BAF385AC35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743454702; cv=none;
	b=XQIenW+9AHoDJE5KEvfB5N8XgyJwHT0CsWWVxeo91zfZ18q+iHmvmOU/a1ecWeowoAh+pGiIuJUePoJnixC8A73OWHGr9OAxDEMe7bxc+OnWA3zX1X6skbLZ/+xgRrQgyCp2dUwx0QtwpBgcMftwqEmrrjnb4bdL+3Fm1TR8Nuo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743454702; c=relaxed/simple;
	bh=O8lF9h5rKLCVdAXUKBZtqWWEnF/Y12sUXc80YiGFYl0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lqsua8YRm3DRd3PX4cQgWyFLUOq7N1odumFYGq/Iy1TbKt9/8Jc3s1QOISlpx+DInPAsyGQx0XIzBCuJoRZP1JDsmL8vEi8L6LiGzLptf8uucjR5Fh5bwlEd1W1yeGUdl1zbOYgZK0fJ1lXgV7qKLXg2nQ8owOqh01cJZ/BK4mU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C5BAF385AC35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=zj3sQ71c
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 41B5D45C8C
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 16:58:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=qu9NDTFOpGK8wXaXw2JxM4Ybnw0=; b=zj3sQ
	71cqBqnoaipxCOpxmrF5YQT0K9vZProEn6uJoykkQjLoULz/TQfauFvE1R2Unyp3
	s9QoIsVeGprmWoEeNvhPv8jzjIX9rK9j69L2o4ZgWg0iNroe+3Ee0ImVw6HYOTZ2
	C/2GO3rD+9NJJr8MIzbd57OkcSvCfG89m/Qw34=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 3C80B45C86
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 16:58:22 -0400 (EDT)
Date: Mon, 31 Mar 2025 13:58:22 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
Message-ID: <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com> <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com> <Z-pQB1d2It9jkuFS@calimero.vinschen.de> <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 31 Mar 2025, Corinna Vinschen wrote:

> Hi Jeremy,
>
> Thank you, I approved your request on sware.  You now have
> write-after-approval permissions, so please continue to send patches to
> cygwin-patches first and wait for approval from Takashi, Jon or me.

I tried to push this patchset but I'm getting Permission denied
(publickey) from ssh.  I assume this is still waiting on overseers.
Should I expect an email from them when things are ready?
