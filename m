Return-Path: <SRS0=ejch=WS=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 588E6385B52C;
	Mon, 31 Mar 2025 22:48:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 588E6385B52C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 588E6385B52C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743461330; cv=none;
	b=lC9siw9ze+dwM7ZDi6v9SSqp3EygD89wohv2O4iQyuF5Q1uDVUg9RAlpk+3/Js/cvY5dmI8CBzwn+QGCmWP56gSG0KtmZPqLyxAmOPDRbz2NBnIlUfQynOTi6fU4UMytBZhK/DQozTvSBYOgsDxxsVJZ6uJXw0Fi/a8tAAIeSvM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743461330; c=relaxed/simple;
	bh=o0I69eELTfgDLbD8mkplW2qtMwjVn3zCTIOjCEC0EAc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=U2K6YkplYW/ybvFwHf5LwnCLPFsWX3XOzUwVcEHQnLv+RkBE8EeGH6Lkmb7wg/bq/jcC1OuVk9Aie8rJYGEYPUlWibm75RF80fyLcudSIvA+FUmpqfhVpIefVA0hwpVk+V2MN9ymSWgEl5PAUGSZujNi6tnaCvGK1qtEsBC4ZS0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 588E6385B52C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=fihyKoHR
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id BC98745C92;
	Mon, 31 Mar 2025 18:48:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=yPS7+et0x/a7XFDDoc7HP2Q+Ddw=; b=fihyK
	oHRasJ4n41alwlCfrMCAdZ73M+BCL4lsMfBeqwSV13cxnl0+cWTe0Kq4nWUIeCZQ
	KFAEvaAfnyjgNlIPaMyU3fdL9h9J/ybLfSyovcpxAzZ7kMG7JRdGBtiN5Dy8Xfof
	YbboP1bwdqQ+EevWH93QrjxhDOgk6qmx7P/Y2w=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B89DB45C78;
	Mon, 31 Mar 2025 18:48:49 -0400 (EDT)
Date: Mon, 31 Mar 2025 15:48:49 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
Message-ID: <236d3480-bda4-08cc-9ef5-e83ff9f668d3@jdrake.com>
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com> <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com> <Z-pQB1d2It9jkuFS@calimero.vinschen.de> <Z-r0vQTnzdkrCIsq@calimero.vinschen.de> <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 31 Mar 2025, Corinna Vinschen wrote:

> On Mar 31 13:58, Jeremy Drake via Cygwin-patches wrote:
> > On Mon, 31 Mar 2025, Corinna Vinschen wrote:
> >
> > > Hi Jeremy,
> > >
> > > Thank you, I approved your request on sware.  You now have
> > > write-after-approval permissions, so please continue to send patches to
> > > cygwin-patches first and wait for approval from Takashi, Jon or me.
> >
> > I tried to push this patchset but I'm getting Permission denied
> > (publickey) from ssh.  I assume this is still waiting on overseers.
> > Should I expect an email from them when things are ready?
>
> Usually you should get a mail from overseers.  I CCed them, just to
> be sure.

Got the mail, patch series pushed.  I guess I need to start worrying about
getting the "committer" identity right for which project I'm pusing to now
too ;)
