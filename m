Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
	by sourceware.org (Postfix) with ESMTPS id D04FC3858C50
	for <cygwin-patches@cygwin.com>; Thu,  3 Nov 2022 18:22:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D04FC3858C50
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7F378CCF6;
	Thu,  3 Nov 2022 14:22:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=AuMzbC8V7MdJC3BedU/7aOT36DI=; b=b0lmB
	NR/4KHdwvCv3lvuCClZYS584DpmcDBtpRmuInvCwDEsd3WtdYa7s/d2Ah1Eeegvu
	WLzSe5DvS32G5eIsLSIkwbPwQX4zFwILmb88rxgxFYmNCb7SLT2afdNtzUyAIj+L
	mR5ggtvo//mIYjFLh1R9n7SDQEN7Bs8hvu+EbQ=
Received: from mail231 (mail231 [96.47.74.235])
	(using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 779BBCCED;
	Thu,  3 Nov 2022 14:22:15 -0400 (EDT)
Date: Thu, 3 Nov 2022 11:22:15 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
In-Reply-To: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
Message-ID: <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 3 Nov 2022, Jon Turney wrote:

> gdb supports 'set disable-randomization off' on Windows since [1]
> (included in gdb 13).
>
> https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=bcb9251f029da8dcf360a4f5acfa3b4211c87bb0;hp=8fea1a81c7d9279a6f91e49ebacfb61e0f8ce008

Is it really *disable*-randomization *off*?  The double-negative seems to
suggest that in that case ASLR would be left *on*.
