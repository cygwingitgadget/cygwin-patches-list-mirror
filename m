Return-Path: <SRS0=SYip=X7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id DB254385840E
	for <cygwin-patches@cygwin.com>; Thu, 15 May 2025 05:50:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DB254385840E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DB254385840E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747288213; cv=none;
	b=ngdLnOB6LfhKdQVjqztSxb/qaLCcmhw7btIn3P0M0UrEwnmxV24oqSwhpIJEOjEG//7LFVXlf0vx+hpwBrMSoo3QUclZIt1E6k0IjLbBZ3fDd1b68925OpV3NslI5skDd6bkjg8vHDqYVudMn4j+agzOo7/Fx6HTSYMErMC0N3M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747288213; c=relaxed/simple;
	bh=OV7SD3LkdikNm/drBVM86/aGzZv6eB4/d5GGnOPFns8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=qOPhz+ZfcnXOf/+m/bE4QT331sD5nNbnTpMxsetZZmIVf1s2rfr+fjN2aBvvmUacv4TAM9mBABHPyyu/ikdLjs2zmEiLqYGGJcfv7kJZ7SG+OJvvxdFWXr09xosSjRhiGrjEhGXXqMyipmwXb1/ufRoMGhbJokXjZlJJHKa6D2o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DB254385840E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MRf2gD0j
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20250515055010665.NHSI.88147.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 15 May 2025 14:50:10 +0900
Date: Thu, 15 May 2025 14:50:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
Message-Id: <20250515145011.fe613a78fbf18f4c910cf5b3@nifty.ne.jp>
In-Reply-To: <51fef89a-15d0-7494-1906-4a8b3b05d391@t-online.de>
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
	<20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
	<4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
	<20250502203144.ca3ba0953ce5bb9f97267920@nifty.ne.jp>
	<1c5aa56e-63e0-c989-4f67-cd77f0c769d1@t-online.de>
	<20250503155357.178e47383611df1a76f784f9@nifty.ne.jp>
	<51fef89a-15d0-7494-1906-4a8b3b05d391@t-online.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1747288210;
 bh=2jF7r7v1bMmRJ7zM7h8ITm30CxM+V200jJY8Iml+NU8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=MRf2gD0jsCQF4xdKdQCHxE1GdcoNyRpqfNaLrHOPmgxCLDM0K7zgcjd0JR7K0xSzE7g27Xtx
 YIt0eEXhfII6GFeFQcJpju9Mgo3L5O42x38szg9qLVFl4d4y7MIliSd4KGcRuBP1Z1kKTt1+cC
 8nmGimwCqwssZosGN9Cog5wvhWeYfZh8uugVTOIFQqjVCF8Eext7wSUctKLlI8IqpPSXlOAOoD
 LwD/FOzhNSpdfL308NMa2kQotBSjk+Od1zA3dNnTxoOxCs4it6FFJ3q2SBtiyyQuEYR7i0Aukg
 jHW5epLN9nxDT4JLTPWkIm/umLcYYN042vawJ46Yos2nQvOA==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 14 May 2025 15:23:09 +0200
Christian Franke wrote:
> Hi Takashi,
> 
> sorry for the delay.

np

> On Sat, 3 May 2025 15:53:57 +0900, Takashi Yano wrote:
> > Hi Christian,
> >
> > On Fri, 2 May 2025 16:09:48 +0200
> > Christian Franke wrote:
> >> ...
> > I have a problem with
> > stress-ng --mprotect 1 -t 5 -v
> >
> > It sometimes hang due to a cause which does not seem to be a
> > cygwin bug.
> >
> > stress-ng seems to use SIGALRM to stop processes. In mprotect
> > case, SIGARLM is armed before stopping SIGSEGV. What I observed
> > is:
> >
> > 1. SIGARLM is armed.
> > 2. stress_handle_stop_stressing() is called.
> > 3. Just after stress_handle_stop_stressing() is called, SIGSEGV
> >     occurs inside the stress_handle_stop_stressing().
> > 4. SIGSEGV handler is called and longjmp() is executed.
> > 5. stress_handle_stop_stressing() can not continue because
> >     longjmp() does not return.
> >
> > Therefore, timeout (SIGARLM) processing in stress-ng fails.
> >
> > Please try
> > while true; do stress-ng --mprotect 1 -t 1 -v; done
> > with cygwin-3.7.0-0.88.gb7097ab39ed0 (Test). In my environment,
> > stress-ng hangs in dozens of minutes.
> >
> > Could you please have a look?
> 
> With many iterations, I could reproduce the hang. Your explanation is 
> likely correct.
> 
> SIGSEGV should be set in the sa_mask of SIGALRM (and other) handlers. I 
> could file an upstream issue if desired.

Thanks for checking!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
