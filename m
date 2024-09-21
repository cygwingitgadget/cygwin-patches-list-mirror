Return-Path: <SRS0=GWCD=QT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 706593858410
	for <cygwin-patches@cygwin.com>; Sat, 21 Sep 2024 21:15:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 706593858410
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 706593858410
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1726953343; cv=none;
	b=w9Su1Hyhn8/hh/9rBhNzpd/dG54tEFyYIHnNyed9bLJD/blBMlRoLslGvbjeterC5N+VK8W3o4r8qEz0Ra43vygkob2eydjCV/f4lQN6YCxgcWpxMilxPU9P8UG5oPkw6Zt5rUjl9WdE4lP0mfRrx9GmVC2dRCcMfYcalZe1hgc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726953343; c=relaxed/simple;
	bh=qat5fdi5d89AbagWQd/0I6GlOyuVM+t1N4v0xsVY22c=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=kgBJTSyTJWEwUNby4WiISqfwx/TNfuUNMRK3yO71B0XTKEwYp2sUrrlvV//qpiEfWMXa/dDsnOFEQQVxOcVIB5zKU4SceHh6Qvhs6XBtIMcYhzjRl4EOLZlxacjX6qg9w3ckL9p5bHGYO24ZZ0tvLv54vLV5KJQSJDNJ7mojyok=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20240921211539567.RMNU.96847.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 22 Sep 2024 06:15:39 +0900
Date: Sun, 22 Sep 2024 06:15:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4.2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
Message-Id: <20240922061538.64006c8b37c6a827988ffd90@nifty.ne.jp>
In-Reply-To: <20240920230917.3c81c71330834583ec1e3ff8@nifty.ne.jp>
References: <20240907024725.123-1-takashi.yano@nifty.ne.jp>
	<d197495e-b91e-4cfb-bc5e-84fbea62e6cb@cornell.edu>
	<20240917224901.b2569f125ffd15efd1992126@nifty.ne.jp>
	<7fb9a624-9a01-420c-913d-f7c70a04ea9f@cornell.edu>
	<21841d53-184a-4a89-8b18-8804a540da5d@cornell.edu>
	<20240920182335.183898c8a2e34f9a74b24a46@nifty.ne.jp>
	<20240920222414.fba7f30bf727f8ad4e61fed6@nifty.ne.jp>
	<20240920230917.3c81c71330834583ec1e3ff8@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1726953339;
 bh=00xw4fiTPbT2o4N/TVdteX2cvjFGqaoXFtkfOxtWbyo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=j4NgmQqJFbMQ60hknBZx+ZdWJ4GgKZiyIQYUg3H+gMaEO5U+MuQCr7Vnp4a8Sj1MSn5bnNtb
 1NoSlBL67GxNtk/mLio4Gs4T8BKmnmAp1ta93oyF+OoVgNVSVc9Efu1XVY4DFXw2cgTQ21wHs9
 8lYKznZYvm7HkEScDT5ZM6fEXJUwoh262o0gCa2yowGIiBVIUxUgiNwWD4A7au1TuWBnuuIPi/
 GD3GDgklAvNwJ0ggxuGdVxdMo648CumvVOfXcg4ri24HiiRLjZbAsUrBPoli5QpmKK3LAON45D
 1utywPtdpMnpdikLRkxsYn8K0lhwktqtYgfjXjhE/ddLIhQA==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 20 Sep 2024 23:09:17 +0900
Takashi Yano wrote:
> On Fri, 20 Sep 2024 22:24:14 +0900
> Takashi Yano wrote:
> > On Fri, 20 Sep 2024 18:23:35 +0900
> > Takashi Yano wrote:
> > > On Wed, 18 Sep 2024 10:03:13 -0400
> > > Ken Brown wrote:
> > > > One other thing that I missed in my first review.  Is there a possible 
> > > > race condition here?  What if the pipe is empty now but another writer 
> > > > fills the pipe before we try to write?  Can that happen?  If so, maybe 
> > > > it's safer to leave the pipe non-blocking instead of restoring it to 
> > > > blocking.
> > > 
> > > Thanks!
> > > Shouldn't we add mutex guard for raw_write() as well as raw_read()?
> > > 
> > > I think I have addressed all the points you have raised. Could you
> > > please check v5 patch?
> > 
> > Bug in v5 has been fixed in v6.
> 
> v7: Improve error handling in raw_write()

v8: Small bug fixes and trivial changes.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
