Return-Path: <SRS0=3SWy=EU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id EA9BB4BA5434
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 13:18:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EA9BB4BA5434
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EA9BB4BA5434
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782307120; cv=none;
	b=rEEVNFk5wKBjnNutKn+uXxcYaKJH5Vw5b5lcsniKTtQavOf+fPL7VYTloFCnwY/otbMZHO9OBAVavpmQlwXyfNvAl5DJd10WoE/cYQALBtF7eHD91X56vFM02R5hbbhybluF8B0mtJAOFQXUY8V/Rtb2PutQgFSQnhgyVDSuXuE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782307120; c=relaxed/simple;
	bh=h9eMC2dvjmPBYnHqnXftJv/C+o05NwyuC/TZj7tPGnQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Pn7yK3IYFmJ1H7GNMQKJOKFFtLzWCmLRMnStGhL7lMYJNu+MYcLOmjPhCTZbVqmHSOSZfj/H2HQlgHtEUbodG7ffUs96dWLZyTvuxUhqkD+/zPFQqv+wsUfOS16kfesa83Ih42K6QBAdfsGJSPx3x8zGg4y14vyLFaI5IUTkhr4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aHgSa/PX
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EA9BB4BA5434
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aHgSa/PX
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260624131838176.FOAJ.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 22:18:38 +0900
Date: Wed, 24 Jun 2026 22:18:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Status of patches I proposed recently
Message-Id: <20260624221835.2546166d80d29e84b0921e65@nifty.ne.jp>
In-Reply-To: <20260623103504.64c32ed071e6908b1684432b@nifty.ne.jp>
References: <20260612224229.a1b848b8a14bb84a471fc958@nifty.ne.jp>
	<20260613232444.d4bf8f3d8d33908d8be14e74@nifty.ne.jp>
	<20260619140542.158c4f34e9083169a1882b9c@nifty.ne.jp>
	<20260623103504.64c32ed071e6908b1684432b@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782307118;
 bh=syVuNG+szLIdlQ2HRYT+QDKKca03f5Xyf2XrUcfzBoo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=aHgSa/PXXryL8NqBOsh15L6cHbYDbyhggM/XsFYXDzWXR62XYb12siMb6cTDvRukQXQ4HK47
 bH0IDLl1SP1AVmT9rVZF8niTtZH2e5p4oEf91+honY6eqpuOPc0gXmcS+as9BSvsNPo6d4QXPV
 suf5e2XUd5INh+0rZ6yjALgDHwkTygiFI/7XgjTB4nTyUaKaWNWHSvrcbGbJwBm+NdpL2TqNvC
 RjeXKDP2zrFR1/d5LxGQhW+68qDAQViocw4eRe59FTQh24ZX99srfm7lDSW9LoeSB4h6QQ9cXV
 vNMRAHK5X/OyaWgK8nxLXV4E+U7gdDa2Pj2RNHXu2DnoT6sg==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Now, all patches have been pushed.

Mark, thank you very much for reviewing so many patches in such a short period.

On Tue, 23 Jun 2026 10:35:04 +0900
Takashi Yano wrote:
> Status updated.
> 
> * pty patches [New feature]:
> [PATCH v2 2/3] Cygwin: pty: Discard pcon input buffer when discard_input is called.            [13 Jun]
> [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app exits                           [13 Jun]
> (These two patches require following pty bug fix patches.)
> 
> * pty/console pathces [Bug fix]:
> [PATCH v5] Cygwin: pty: Fix race issue between starting and exiting non-cygwin app             [11 Jun]
> [PATCH 1/3] Cygwin: console: Ensure the master thread runs only when it is supposed to         [11 Jun]
> [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little                                          [11 Jun]
> [PATCH 3/3] Cygwin: console: Fix typeahead input for bash                                      [11 Jun]
> [PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in transfer_input()             [12 Jun]
> 
> 
> [Done]
> * pty/console pathces [Bug fix]:
> [PATCH] Cygwin: pty: Do not set input_available_event when applying line_edit()          (T)(R)(P)  [ 8 Jun]
> [PATCH v3 1/2] Cygwin: pty: Introduce a helper function get_handle_from_process()        (T)(R)(P)  [ 8 Jun]
> [PATCH v3 2/2] Cygwin: pty: Prevent unintended conversion for cursor position report     (T)(R)(P)  [ 8 Jun]
> 
> * Others
> [PATCH v3] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN                (R)+(P)
> 
> + Patch revised after the last report
> (T) Tested
> (R) Under review
> (P) Pushed
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
