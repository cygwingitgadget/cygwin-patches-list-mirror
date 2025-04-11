Return-Path: <SRS0=sFd1=W5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 48DE53831E15
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 11:13:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 48DE53831E15
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 48DE53831E15
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744370004; cv=none;
	b=HSTUhGClgKxwdbEX2DXhtrYjL78WZEq5cFLem4meHZuw6A68QYIebGiRd6SFzBu6hrl2eiLefNsK3HoBqE8iUEIhf7lA2LGEZgLNQYt//rtTDI2aRma5+eRTfV5CICe4TDF3XiyLN5Jm3CxBXWY6RqB5Q5e7SVngLRl1Ksm1kbM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744370004; c=relaxed/simple;
	bh=fV1IRyqNQYgZu0Nl9s2ZHkz/l0ft0gN4OqSESRkdaf0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=fJNHHL0OqtCOEsqshHZALg6XgPgm+Ofz4HP9GLhEZhfohsXHR37LUaeSuQYOBJeDJa5kkv1qZ4JNylfJD3GfnXUqfqHVZGYGfuT/1ygowA3zv9oYmg08LKDWckYska96qpH8EIfh2GzecLfC76/rLaucVn9i3fw98comOxB9nQU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 48DE53831E15
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OCgk4ES/
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20250411111321154.HSGA.4197.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 20:13:21 +0900
Date: Fri, 11 Apr 2025 20:13:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: compiles fail with sys/unistd.h ...inline... setproctitle_init
Message-Id: <20250411201319.c64e33349cad4a6798102cee@nifty.ne.jp>
In-Reply-To: <75e51a8e-8c25-414d-905a-60b380d939d4@SystematicSW.ab.ca>
References: <f34666fe-f8da-4364-a5e7-b2328b2f1c80@SystematicSW.ab.ca>
	<75e51a8e-8c25-414d-905a-60b380d939d4@SystematicSW.ab.ca>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1744370001;
 bh=e+Y+AI/GO7hVa1YggDRD1j8rlr1FUQ0FHGFXXCqFHzc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=OCgk4ES/6Rs7EW2NjN/icAUG+4RyzTdRJKzA7CkK31FxZXnWS0CvSGkNAcUZIzr4TiZnF04g
 F9UCVgIj0eVq5TJkQSxcbvef1RMkTwhc+nt5Am068adLWkxBGQlufgIsHWtLWgARfv1Gp3c0wX
 kVGue9snu9g/UIiMbV0VGL7up1HCbpSRNJfmdIPwN+BWPFRNvmLnUkw/ZqpFnuvdwSQdYDjUyR
 B7kH/E2IC4fEJ3YGwD5HrcTlNd0uhmqiPtlk21I6EPgtigIqmz1KOTdhh6sG2TlEZ1YOoLh8SO
 RaB+gcmN8JhgDfmi6nfiYTYRKfJD6EZU2xHDW16k8RU9Hmbg==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 10 Apr 2025 15:38:59 -0600
Brian Inglis wrote:
> Hi folks,
> 
> Latest c-ares build failing with gcc 12.4 and Cygwin 3.6.0 header:
> 
> $ uname -srvmo
> CYGWIN_NT-10.0-19045 3.6.0-1.x86_64 2025-03-18 17:01 UTC x86_64 Cygwin
> $ gcc --version
> gcc (GCC) 12.4.0
> Copyright (C) 2022 Free Software Foundation, Inc.
> ...
> 
> /usr/include/sys/unistd.h:218:14: error: expected ';' before 'void'
>     218 | static inline void setproctitle_init (int _c, char *_a[], char *_e[]) {}
>         |              ^~~~~
>         |              ;
> 
> Doing some more `make`-ing in that directory with permutations of specifiers, 
> complaint comes after `inline`; seems like it does not like `inline` anywhere in 
> that line, although `__inline__` works just fine!
> 
> Perhaps a patch is warranted, possibly conditional on GCC <= 12?

Thanks for the report. Fixed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
