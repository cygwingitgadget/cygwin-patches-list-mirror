Return-Path: <SRS0=KLwD=WE=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id BE1E9385B51A
	for <cygwin-patches@cygwin.com>; Mon, 17 Mar 2025 18:15:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BE1E9385B51A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BE1E9385B51A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742235323; cv=none;
	b=LwQSunyp1bjaSGXKkk9DtuCxOSJ4BwHlM75e+qKOjs7M1Vbeuet8ZO5RR+cUkivzYTYGWNNdukOk7GFZvkaalqIIwsh3P3vzpBq0wLzEm/Bnr1k/Y1uIrlj6SyyLNQpTfM+uYlZPPkZU2/44LOyis+Mhdo6EVdTAktW1OtYvKPE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742235323; c=relaxed/simple;
	bh=+nLs2f0axcv02QtcYIHB10NWrCT+H3oCTed/5ebU1+I=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=xYD4iaalUyB/+Xo3qItU0tDU2yplhoTvJXQyHcninWFKj7daCZpY1ZcCxD189hrblIgj/HXXJQIPT5Kc6Q4PEIlnysN/wEEedOaH0WTBN++zbO25W9rpCUVGcp7udwjg0OvlHlxjsqn1EGRSYx3RmzPkePOYy4DttjuI5vXQpaY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BE1E9385B51A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=fGQwFpPB
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 90E8245C8D;
	Mon, 17 Mar 2025 14:15:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=DmTeXQxXvBq31NUM7eUxysR8Mbo=; b=fGQwF
	pPBOqlaF3ZAqf9GZCxPkIXSFnW1WwcvQz57zmzI4O8dt1NDGV6elD2eKRDN5t55s
	l9WAQXo5GEyHE+PmwZDvvmnVlPcIROpG0kEA0YR8rjRef1bbC4KZCzZNQhuxLTYi
	AVNK2Zacj8ulihDtWviNclJ3jxfeJ1K2NtZk60=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 89DC245C8C;
	Mon, 17 Mar 2025 14:15:22 -0400 (EDT)
Date: Mon, 17 Mar 2025 11:15:22 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
cc: Chris Denton <chris@chrisdenton.dev>
Subject: Re: [PATCH] fix native symlink spawn passing wrong arg0
In-Reply-To: <Z9AT-rlIU0StWEzQ@calimero.vinschen.de>
Message-ID: <4dd8a82a-d345-5339-5a90-7d5e72b65454@jdrake.com>
References: <19580bc11ec.e77085b5699413.240072222093655736@chrisdenton.dev> <Z886PJK2OMtcUwEC@calimero.vinschen.de> <19581e3058e.ebf97e1e733524.5029218649132507579@chrisdenton.dev> <Z9AT-rlIU0StWEzQ@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 11 Mar 2025, Corinna Vinschen wrote:

> Hi Chris,
>
> This was a bit of a puzzler for me, given we added the PC_SYM_NOFOLLOW_REP
> only 2011 with commit be371651146c ("* path.cc (path_conv::check): Don't
> follow reparse point symlinks if PC_SYM_NOFOLLOW_REP flag is set.")
>
> I think we should use this patch for the "Fixes:" info.
>
> > Signed-off-by: SquallATF <squallatf@gmail.com>
>
> Hmm, on second thought, we can't do that.
>
> Given you provide your own version of this patch, and given that this is
> a trivial patch, I would prefer your personal Signed-off-by.
>
> If you just agree here on the list, I will do the above changes manually.
> No reason to send another patch version.
>
> Ok?


Ping?
