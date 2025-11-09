Return-Path: <SRS0=HM4H=5R=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.178])
	by sourceware.org (Postfix) with ESMTPS id 4CD2A3858C52
	for <cygwin-patches@cygwin.com>; Sun,  9 Nov 2025 09:02:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4CD2A3858C52
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4CD2A3858C52
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762678938; cv=none;
	b=KIcqtantU9UFGTpTR8wK/dNY/0eWHXojIhmiI0JQ5i5SrJwK0NvT80bJY8KkY78rM23Y1y9AoXGiVyenV3nG0RzMyPKsGxTy8KZqt4XGoUQTtYrcY/luf92IF04njT9jSCwAUBHd2+444qDRQMEmlDXsV2bSNd/J0nl9Kn0aHps=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762678938; c=relaxed/simple;
	bh=CBqBJzpSGVRYuppzdHRDSn4RNHl+hBJmk7mNnVUUdr0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Si/DYgMuHuSrgLVawUqX/x5a3B4j4CWpIxZcGXQWWjWrF0KSlBYAR4VCnNXDxuqnrzvvMCP9TFik1EPchCnl+vErZiEjBqPgFa+Yk4t4dI86/nrs7jf+n5AvqT36MqG0df76KW60Y/WJCtKHhsnYS0SknghYBLy2LJ6GtjGoxC8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4CD2A3858C52
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PLp7lo1+
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20251109090215110.GXUA.45927.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 9 Nov 2025 18:02:15 +0900
Date: Sun, 9 Nov 2025 18:02:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fixes for dll_init.cc
Message-Id: <20251109180214.06d195f84ddb678ca1a0ca27@nifty.ne.jp>
In-Reply-To: <1034b8d0-4de7-407c-a9f1-6c2ba7744380@maxrnd.com>
References: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
	<20251105135842.e9c501e7cce6ec6603acc124@nifty.ne.jp>
	<1034b8d0-4de7-407c-a9f1-6c2ba7744380@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1762678935;
 bh=+C1ctx03212u/ZxL4UiWOI1Q+pemXOjVzJBCz1OLMcw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=PLp7lo1+uMKHJQXh9ITLiuYQqDlFIbiABgf7h4j4O0RCF9DsMTv5SjiYRI+g+go8Bbjmie+L
 rBl0Ijw9j9pOemNsUlDZ3KuKGlKmrVWbBBeA1k10jC2rhH8LkvvAbrnHogYSpGrhx510z6cGRA
 kiLQss6mPSQaex/ta6WprGx+shkw6uYxeuYymaMEUXnGiK2HMgYQaDvzRooVLcfYqMk/qOzUG5
 meK9+XGzdOKa+WeiVicaUXrkGSE6rw7xDZC6WuV8mqYzdksmhORJW+lhN/ssuHqmKLYacqvS4z
 uG0UgV56TnUCDyzeDqWR7/1V25WXFsTJic4kUjvpOOvHFp0w==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Sun, 9 Nov 2025 00:09:07 -0800
Mark Geisert wrote:
> Hi Takashi,
> 
> On 11/4/2025 8:58 PM, Takashi Yano wrote:
> > On Tue, 28 Oct 2025 20:48:40 +0900
> > Takashi Yano wrote:
> >> Takashi Yano (2):
> >>    Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD even in
> >>      exit_state
> >>    Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.
> >>
> >>   winsup/cygwin/dll_init.cc | 8 +++++---
> >>   1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> -- 
> >> 2.51.0
> >>
> > 
> > Could anyone please review if these patches make sense?
> 
> The patches look fine to me.  Do you happen to have an STC that 
> demonstrates to you the issue is fixed with your patch?

Thanks for reviewing. The STC is the attachment files in
https://cygwin.com/pipermail/cygwin/2025-October/258919.html

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
