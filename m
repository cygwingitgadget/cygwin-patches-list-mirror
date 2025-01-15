Return-Path: <SRS0=KApf=UH=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id A86A53857B94
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 23:53:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A86A53857B94
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A86A53857B94
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736985198; cv=none;
	b=gDYVwJ6qQcU1z99wdAJE/e4uTbJiA24DCHXd1Sej8xpn4/cs/YabnSwF4zY/FLZLJTsMGUhMh7ZwJP+kxNL6+8TPs1IjiQ7VQ7+Ea6TeYW8hvWKHyA4rHT7erm5GWz9Qvm37lB7hQxYeaYa0eYsG1nnjNPM76Z/bYkbEIoNu7t4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736985198; c=relaxed/simple;
	bh=z8MU67RM2W6v95lsKjwFzguQi8+IlhyDZwRUeZSrhiw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=CXNPb0CHKDwfGARgnGZaqFWIoiPCpkOCI03XNBmzCB6c61lINNXTMdg+Epy8T7Jfe9iWNP4hI7JSCK6xhjBdoBypPgxhb1oSEMy8op5QiIFyvNHBfPjRh+l6cWA91UF3Wk3v+gR9J+H4WWOoG7yELog0G8NOwjU31z3Lfi+fuNQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A86A53857B94
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=LAGINxMC
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 501FF45C84;
	Wed, 15 Jan 2025 18:53:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=hZIkxUCPHtc+YW+DmSywzkiuStw=; b=LAGIN
	xMCbi49Q6qOZYJnZnzi421MwSKV6oBSHlzoMUu1dawRGQjF/3o7kGURSwjW2sw9F
	nPG+qSV28nK9jM5zZgTxQoAsWYz9V1mzDxkST22y/DuNEgGd6/RbpFZuTZqm6PJJ
	aoLrYMXbKzBqLoOmmfDHabcBCrb/8QbmsxwFDw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1F91E45C81;
	Wed, 15 Jan 2025 18:53:17 -0500 (EST)
Date: Wed, 15 Jan 2025 15:53:16 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v6 4/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
In-Reply-To: <6da73f73a786a556d4c7be93ed05bc50b268bb30.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
Message-ID: <4434e97d-ce1e-f05a-c06b-405f6b2d67c7@jdrake.com>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca> <6da73f73a786a556d4c7be93ed05bc50b268bb30.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 15 Jan 2025, Brian Inglis wrote:

> +<<<<<<< HEAD
>      isastream
> +=======
> +    kill_dependency		(not available in "stdatomic.h" header)
> +>>>>>>> 5888275d7f48 (Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries)

Conflict added here, removed in next patch (5/8).
