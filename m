Return-Path: <SRS0=STBq=SO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 356E33858D21
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 08:39:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 356E33858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 356E33858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732005585; cv=none;
	b=emEOLafTQzlGczU3BRYOX4PYAWZVp5kJfIIxfThi7Ptj+WySoz7SFgc3wlZk+g8Uk9BjHLq1ajAES2hJ0WpljjN3NzdCtuUazLRbOfs7NSiOrQOTWgJeJzQihyJ8Try//SpPqHhSViSKXw6o5GafUAwjmXDyKpAqzD33co3Ye6I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732005585; c=relaxed/simple;
	bh=R7QatbcDt3kq8CVUFsDH8y6vZ8fAqNYkfCZUnTgdnRg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uT7AQHhqUkc3rIq8RJjAMismIZ8A3GUYWohON70g0TaBy2Ip9wllBWlBcqo71kjHirvy0gtMUFoT7ftoFuI0j6E5UiK0n2Qrjvy7QnebWNUk6S/Yo+VA3RneNh5/Elh2+BjI+ddHLCXTbAjxGQNHOiwsLV3b9FUrNZV/Rhc0uNg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 356E33858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OIeuTOkc
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20241119083941790.MCLI.41146.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 17:39:41 +0900
Date: Tue, 19 Nov 2024 17:39:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: lockf: Fix access violation in
 lf_clearlock().
Message-Id: <20241119173939.5ba0cb14459b3da22d226262@nifty.ne.jp>
In-Reply-To: <ZztjYs4Cu28xZgtl@calimero.vinschen.de>
References: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
	<20241115131422.2066-2-takashi.yano@nifty.ne.jp>
	<ZztjYs4Cu28xZgtl@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732005581;
 bh=RvrB4nCJf0NmWa5/4tykkPq8daD8170B2zm9D/m6NfE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=OIeuTOkcdUK/QmmRloGXJ0GFpv3rOVTnX7wUaYlDb5w61vmyICK6KEcPciDQcvgrY32y6Nqf
 CQ5v+PksFyjHLelEsT9eI/06Tn2NCfRYTqiKYKqE5rpyMsSgM+eGoa4lP3X9mP+tTZHLzh5SrI
 pLlmfOwTJtKRv+jsXc+TtWrRabt6k3MMlrNkVaenl4yGshfU+SYlDroZXHOO5UhTTp4AO4gsqD
 QHbfFfvHq6q99w7vaal7y5sRc3vfIAZ06+2FJGoKecvs/PhQrTPtn8JnsdctMcPexffGZ6xkgD
 jdyUWc7QNMr+IwcA7hFp4SG2ZtXB70wL22VEyXD0QjjXbbqA==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 18 Nov 2024 16:55:14 +0100
Corinna Vinschen wrote:
> On Nov 15 22:14, Takashi Yano wrote:
> > The commit ae181b0ff122 has a bug that the pointer is referred bofore
> > NULL check in the function lf_clearlock(). This patch fixes that.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256750.html
> > Fixes: ae181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too many locks")
> > Reported-by: Sebastian Feld <sebastian.n.feld@gmail.com>
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/flock.cc | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> > index 3821bddd6..794e66bd7 100644
> > --- a/winsup/cygwin/flock.cc
> > +++ b/winsup/cygwin/flock.cc
> > @@ -1524,6 +1524,10 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
> >    lockf_t *lf = *head;
> >    lockf_t *overlap, **prev;
> >    int ovcase;
> > +
> > +  if (lf == NOLOCKF)
> > +    return 0;
> > +
> >    inode_t *node = lf->lf_inode;
> >    tmp_pathbuf tp;
> >    node->i_all_lf = (lockf_t *) tp.w_get ();
> > @@ -1531,8 +1535,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
> >    uint32_t lock_cnt = node->get_lock_count ();
> >    bool first_loop = true;
> >  
> > -  if (lf == NOLOCKF)
> > -    return 0;
> >    prev = head;
> >    while ((ovcase = lf_findoverlap (lf, unlock, SELF, &prev, &overlap)))
> >      {
> > -- 
> > 2.45.1
> 
> LGTM, please push.

Thanks for reviewing this patch. Could you please review
 [PATCH v2] Cygwin: flock: Fix overlap handling in lf_setlock() and lf_clearlock()
as well?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
