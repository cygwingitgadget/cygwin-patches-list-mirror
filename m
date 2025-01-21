Return-Path: <SRS0=jwxA=UN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 6771C3858D28
	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 22:58:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6771C3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6771C3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737500304; cv=none;
	b=Lpg+HOmUQYIQ87J80U1R6I0UumBE6q5kStz4115jRADzY4zk9SalpxQf+0mhbi3V67iTdKVQtGvSHv4hAdZw05Cq8U3DuRpCi5dahByN7jNN6Afkvm5ks8NG7zHRFi4gdB6yaf4U2Y2KsXKEiZgnVf8xs4hzsEGQtuYH8MS7gws=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737500304; c=relaxed/simple;
	bh=AAVkVtePPH5Ita7as+0xztKq4fVLRZVbZQR41tyZnrQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=JD3IZB7OwoZEgoXvnJwheMNQHZ8iL6MyKTfkHqjuTbLcsm+U/YoVXkVQ2JW3pMDTiNUeEFV2txUpABsrfVsImRmWVaqJATrPALyDdyXLdGpUgeKBBc/acXHq5Y0Ml/8P87FChySFsCRx5+nhTzQoRxndEaKYHyONPRngAbbyHe8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6771C3858D28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LGRBJiAY
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20250121225821481.BPVV.13595.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 07:58:21 +0900
Date: Wed, 22 Jan 2025 07:58:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Avoid frequent TLS lock/unlock for
 SIGCONT processing
Message-Id: <20250122075820.47f0b776c0fdfd63437cef09@nifty.ne.jp>
In-Reply-To: <9223d8f6-bc85-a2cb-d1d3-9517041f0034@jdrake.com>
References: <20250120142316.3606760-1-takashi.yano@nifty.ne.jp>
	<9223d8f6-bc85-a2cb-d1d3-9517041f0034@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737500301;
 bh=l/RkcfhtZ9mOEontFfiiL8RIWcTnRZCenpUU239Fg7s=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=LGRBJiAYNHSg6Ubgaqb/Nomd8TNxxZAwtuQg1SsglkVKbWWgmyMOc1bmL6kWmITpajL81N1L
 hOY30QiDnRU70UsITK10FZgcYi0H/5WaHvKoisnYt3KoZvj0K27DKqFVWjUigZ0sG1vSkoXrK8
 hFwn3duF07HgDnXwoGylB1PGjVo/pYyHm4gMCBJ6u1FyY3dMXgXSUiaUSzITZu7uQh0WpD0N+2
 IbfnNDnqymRjM0k+ToDYqzBhCnms+7wpydkuaLbsOlGhxAUMT9JSPPbz5dloj+DptX/ZU4cLAs
 c2kyKpAYp9NrcIKQG+C7fiqfjl6PB60tMLLqWIPwxF3TJemw==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 21 Jan 2025 13:20:46 -0800 (PST)
Jeremy Drake wrote:
> dscho hooked me up with a workflow to run Git for Windows' test suite on
> an msys2-runtime pull request's CI artifacts. With this patch and the
> three you pushed (reverting the v2 patch we had applied already, and
> applying the two from the cygwin-3_5-branch), the test suite no longer
> hangs.

Thanks for testing! I'm happy to hear that.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
