Return-Path: <SRS0=5dpU=SW=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C95503858C62
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 16:47:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C95503858C62
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C95503858C62
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732726022; cv=none;
	b=xEp7M4mR5jRYOrhndEtmKvM9mBhYwmnFJg9493YUsRyFRjnDsIJ1cW8dpTboIa/DDbyLuKpmQj11KizkLcJbj72RqdN0uTenL7+u5E5qeOqggyZIMFWrPTyDBMQU3YURNk7kY79q4cKNSLq0worVUnshOMhhuhwIVMb484k54VU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732726022; c=relaxed/simple;
	bh=BHjcfyk7kOzXj4rL+/O+iheMNBjXZJaWSiaUKcZkPFs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mAgoqhFaEE6v2lyKMonfS3lFYRen4oz3DeHjaM6+kDnVZySr+gVm+7FHSbk5jPbocBdfnSQFbuxpjVb+MLuOBoYoQ9ZCUj+OEfPEG3bz/ODvDPsR9sekJsFtiOOLfjKDunapf9Uo/fYw4dErvuIiJFTGjKhJXtcsVRIVal5J9z4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 6FF4B45C73
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 11:47:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=0O/Y13emaEdhgTfKVbOJBucrUp4=; b=mW/6J
	dQmojtJJd2kBVMLcZ86wfPSlccgyu0+WFqmr/1dNUCDKN3khPnTmjrg/w9XDdLAb
	I+rYsusAdPMW2ynbxo1sWWeVJvWsgWZ3Gq9PJiKfFTqsCQxSNz2tW03QPFNQFJdz
	pxc+WsSyjZrLDC6WxITUYH+Q6NbmKmOG9ae3bc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 65F8545C42
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 11:47:01 -0500 (EST)
Date: Wed, 27 Nov 2024 08:47:01 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: uname: add host machine tag to sysname.
In-Reply-To: <Z0c71iqtu1Zk2vNK@calimero.vinschen.de>
Message-ID: <4cdfd5dc-dfe0-7b71-3e3b-59469b2fe094@jdrake.com>
References: <ecdfa413-1ad4-ea0e-4f01-33579f1616e9@jdrake.com> <Z0XNgZoVQI_P5FMD@calimero.vinschen.de> <42819a86-1e9f-6569-a08e-fd719115a2c3@jdrake.com> <Z0c71iqtu1Zk2vNK@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 27 Nov 2024, Corinna Vinschen wrote:

> I'm not opposed to a switch statement consisting of an
> IMAGE_FILE_MACHINE_ARM64 case and a default case adding "-???" or
> something.  Chances are so extremly slim that we'll ever see another
> CPU emulated on x86_64, we can always add a case for that if it turns
> out that I'm totally wrong, right?

OK, does the default case have to be a fixed string or can I use the hex?
Lately it seems like MS is making the hex form almost "meaningful" - AMD64
is 0x8664 and ARM64 is 0xaa64.  I don't know if they can keep that up for
any new arch, but putting the value in there at least gives us something
to go on until a new case can be added.
