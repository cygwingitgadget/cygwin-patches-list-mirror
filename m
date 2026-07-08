Return-Path: <SRS0=wCit=FC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id D293F4BA2E05
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 17:15:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D293F4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D293F4BA2E05
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783530910; cv=none;
	b=gyHiPgbQCJTvktHuGIjcXhvwd5vATfQXk5+as4LaUBkzRD3NRa+urue1Yyrg/dImHEbR2lcf9dDoCwAs/MhFoRPleYDh8vVxp/nOBw9Dv7q967XPMpqb/bElyNYj1YPS5+SqaL/vdIZN/CDxbL3sIoVm+F5OkQhQhWyufY5iSjg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783530910; c=relaxed/simple;
	bh=3QlxBlG+pbCl+Fz46MG8R6t1PliLTsz5J2q8dksQzE0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=E9iqbZylpo74gbNDBIN//udWbdR3O4jfxw8MPIxXn+hLTTjFsbMKHAnPypKNY9wA3gWmfFWGlJgiDGaw9zAIA3zJlH0hxY9U1j6fCsHkrZzK6b6g4PuV/LAsj9UomFRH3/12bPmtvIouJEbsugW/VIDfW1TX6J51Ry8BCiR0Emk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tBSY9xSl
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D293F4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tBSY9xSl
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260708171507920.CDUM.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 9 Jul 2026 02:15:07 +0900
Date: Thu, 9 Jul 2026 02:15:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pty: Do not transfer input to nat-pipe while
 masked
Message-Id: <20260709021507.b2aa10a8ed01dd5bfa7d2d8d@nifty.ne.jp>
In-Reply-To: <b55b9478-261d-a63f-de53-c2618295c5b7@gmx.de>
References: <20260708045412.945-1-takashi.yano@nifty.ne.jp>
	<b55b9478-261d-a63f-de53-c2618295c5b7@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783530907;
 bh=4ZP3ZqUlK9Dj5qdsYK+o60Zmpt0NsLe8IHaTLKY6SR0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=tBSY9xSlC62+ypttEhjjFAYbBm0v18sj4llCQZ7DNrqh+uSmWHQWNJhRuz4rvpGCHvBn2Zcu
 g6YfrA4iricNhK4ufOwvH+j99vFH30gehHTWK5eR/jSl/+UASz528o1/esQzQ9ME7++2ScTjNp
 kpRd9lI9K41Gy0qr5SD93xHr920Z59d2JnvJfh5SUCzAsZzbzY0s295mCVHoI0QdY7Mxej4axN
 K5jCidv18CasR8BFaqMJOzZeaLuPwkbJB4KsFT5pEyp1cftUtwR0pTqplEsFq8aMsNUVejzPGn
 H89SozBYyGrzZjmPUM0oj1ADTEn3Du/X2uTQ8BREHpyPcAOQ==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Wed, 8 Jul 2026 17:01:47 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 8 Jul 2026, Takashi Yano wrote:
> 
> > On the command "cat | non-cygwin-app", `cat` sometimes fails to read
> > key input. This happens when `cat` starts to read input before `non-
> > cygwin-app` configures pseudo console. This is because pipe state is
> > switched to nat-pipe when pseudo console is configured.
> > 
> > This patch prevent the pipe state from changing to nat-pipe state if
> > some cygwin process is reading input from the cyg-pipe.
> > 
> > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Release all masks owned by myself on cleanup()
> > v3: Reverts the change that made num_reader and slave_reading shared
> > v4: Correct what mutex shoud be acquired in mask_switch_to_nat_pipe()
> 
> v4 is the right shape. Taking `input_mutex` at the top matches the
> ordering used elsewhere in the file, and because it is a named mutex the
> race is closed across processes attaching to the same tty, not just across
> threads.
> 
> One non-blocking suggestion: As far as I can tell, the new guard is
> correct only because every caller holds `input_mutex`. That is a non-local
> invariant, and a short comment above the guard would help future refactors
> preserve it.

Thanks!

I'll add the comment you suggested and push this patch to master and
cygwin-3_6-branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
