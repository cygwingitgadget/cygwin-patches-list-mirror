Return-Path: <SRS0=qZUn=CQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
	by sourceware.org (Postfix) with ESMTPS id 8DD513858D37
	for <cygwin-patches@cygwin.com>; Wed, 28 Jun 2023 18:45:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8DD513858D37
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3C59ACCCC;
	Wed, 28 Jun 2023 14:45:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=xfMnBNGXe1cCy0B4ML52zE+0CXA=; b=bqQeH
	PtTFmDXkx11X1XCnXlHaS+4QzNPwU8JNf8oLMD2dEcSuCsvoauRnZXVL00fJxJAZ
	Yn6/OasyuDLA53g9sed3m4Vo8zZDCbtetWfasKogv+k8onxPlK5CR4N4YVjUD7n7
	a2JPqbIPwCRYuhnbe42fB6rBJGqDd/mh7VmFFg=
Received: from mail231 (mail231 [96.47.74.235])
	(using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 2C74CCC91;
	Wed, 28 Jun 2023 14:45:55 -0400 (EDT)
Date: Wed, 28 Jun 2023 11:45:55 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fchmodat/fstatat: fix regression with empty `pathname`
In-Reply-To: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.BSO.2.21.2306281142570.97921@resin.csoft.net>
References: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 27 Jun 2023, Johannes Schindelin wrote:

> In 4b8222983f (Cygwin: fix errno values set by readlinkat, 2023-04-18)
> the code of `readlinkat()` was adjusted to align the `errno` with Linux'
> behavior.
>
> 	I noticed this issue when one of my workflows failed consistently
> 	while trying to untar an archive containing a symbolic link and
> 	claiming this:
>
> 		Cannot change mode to rwxr-xr-x: Not a directory
>

I wonder if this is related to the issue from the thread
https://cygwin.com/pipermail/cygwin/2023-May/253738.html (sounds like it).
If so, tar was
rebuilt to pick up the new behavior in 3.4.7 (presumably via configure
checks), it may need another rebuild to pick up the fixed behavior after
this fix.
