Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 24F594BA2E05
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:38:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 24F594BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 24F594BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766043519; cv=none;
	b=bPeE2KUAMDLD1bjZrsiLWI3rq/NZ5tKl2tNSHqP0kw8bcDAoIdRq63GmfKd/Pv8ZG12MfRFXgHVvU9s9rHy9m6N9Sp2meBwzCEc0PAinbdtwLojaWa6nkbzFX22+/K7MNa887n4OiYepdJyzRTsDR2TLSCNbD5AQm905phGF9ik=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766043519; c=relaxed/simple;
	bh=+hDCi3NTsz3UCetFUBd9JL0UqAamNqYCaNkk4wopgvg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=aO6OUCQ/449kMMfIlE1R1nC2sFKo5FaO7Yk2hxJanGtIq74xnN0qAG19lOYERwi8QA9GfU9oJGdTB+TUQDX5FCVlnH09UlsMsRghnMpfOF91hyQBThEbeAZfXmIKpOKrgBqN3Ydc7FPGQmEFZa2gcxGjwRvpwZ2UFO4QVOACOaQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 24F594BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Awohv3+t
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251218073837229.SXWJ.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 16:38:37 +0900
Date: Thu, 18 Dec 2025 16:38:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fix overriding primary group
Message-Id: <20251218163835.5d4025edb00001e28677398d@nifty.ne.jp>
In-Reply-To: <aUAn8aPCHHOWpEoO@calimero.vinschen.de>
References: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
	<aUAn8aPCHHOWpEoO@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766043517;
 bh=HbX8h/gTNqx+ZGR6NoJ7Ul/G6/P7SnOcNGA1w6YjU+o=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Awohv3+tLdHeywFj/LRfPf7VJmz1fIcwyznygIBMrzekFAHsn7tKrWch7/rDlC45BhPcIRkE
 5HPeGpsZf0VjDcPhzh2gcVOu3VkYMYYujK29GkPeq3ezHMAe6DP3qRO+v5PVS7E3x35VrpLO4G
 eOTZ/tW4g3JzSLbykSFAchmPLbdIZ+g7wACBkZCCwOIWz2rH3/D277iJV1XBs3m4rHM21JUYEm
 aYLca5O//66N1TuphJiPFdkyFPd0hqs63CVJl+eXCAIWvz9IQX/hIHRAuvlr6XDyzIr8UeMfYe
 HoflwKxz4AWSeTnma+4UJ5bCnMfgn+jr6XKGtzwOPGRamFUg==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 15 Dec 2025 16:23:29 +0100
Corinna Vinschen wrote:
> On Dec  5 17:38, Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > Fix broken code overriding primary group at process tree startup.  THis
> > is fallout frokm the newgrp(1) introduction which showed a problem with
> > this code.  The fix from commit dc7b67316d01 ("Cygwin: uinfo: prefer
> > token primary group") broke this differently, so here we go, trying to
> > fix the second problem without breaking the first again.
> > 
> > Corinna Vinschen (3):
> >   Cygwin: uinfo: correctly check and override primary group
> >   Cygwin: uinfo: allow to override user account as primary group
> >   Cygwin: add release note for primary group override fix
> 
> Ping?  Anybody willing to review?

I would like to review them for you, but I don’t understand what
the problem is or how these patches are supposed to solve it...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
