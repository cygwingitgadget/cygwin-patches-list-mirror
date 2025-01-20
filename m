Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 0E01E3858CD1
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 17:16:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0E01E3858CD1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0E01E3858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737393401; cv=none;
	b=YQBgnU9dzr7D7kszP6ayMdOoqTXtIwJ5sQVJTuwEpqKMW+n8Lt8KWvxFsWa5Fpfoy9QJJP/uInYia+41wnfIWlPMuZ1OjkL9MpZgQa8F7Qy5Qm/4HXpd5KVhaOOZmfARvZTHB2D+9XiqcTRT4JKcHhj8nQE56htGRCb1tZfyAhk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737393401; c=relaxed/simple;
	bh=mU+1iASaFBRK0JgRtVxYSgEFK+/sK/uO6D6fa3+hNvY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ZbIndSu/obWrbkhbTGRvJdWTM3+xmeKRj+b6io1fZt86h/vRwg6P8SLh5CPfVCvJtiyc+3rPJYCu8kU5DeqjQxfi3dmn9sBbpgGSzcRzosVGDZXwETKJkNCaUKGsiJIQ7FAu3f2eNwR4/SpyyLLV4tNc7MMd2tU2x8xBwzAgLHw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0E01E3858CD1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nLyFc5Ft
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20250120171638943.PTIC.84424.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 02:16:38 +0900
Date: Tue, 21 Jan 2025 02:16:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 2/3] Cygwin: cygwait: Make cygwait() reentrant
Message-Id: <20250121021637.18c1323c15e81b368613228d@nifty.ne.jp>
In-Reply-To: <b90010f4-cb87-4193-50db-91c8ee93ba05@jdrake.com>
References: <20250120154627.107642-1-takashi.yano@nifty.ne.jp>
	<20250120154627.107642-3-takashi.yano@nifty.ne.jp>
	<b90010f4-cb87-4193-50db-91c8ee93ba05@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737393399;
 bh=xE6SKlZH1PYiqyPHiCWDtTg3KwMQpPBc8EUFUZmuMJQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=nLyFc5FtR9JgaPfnFeC+49jK+oCQgua4T/7wUa6v6pChJKsQpEgtHZ3miBbUq8cyB/wB/+7B
 6N0zACXdzWqDw1S5H1XnKqpGfED5OiM27yQaSAECVeK3NWeLVHQzcoKYyNs0PcWHNBNCeUqjWF
 7/a6R3Z7yC3y1t08V5HcF2eZb1U+H30WTKGK35aKy8ZY/eiPCmcLyBCgrzRhnQrqkcu0d2ugWy
 +HUQa0ryrQNO5esax/6a8of8hr0ve/6NiWTvOl2A7gM3iw7TendAjYz/2kO0PEDcV5v1nSPo6C
 9R9EM1OEz8MWKH7TjtkWsHGdSATMtcdRzdYdN8RMUpSFeFWw==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 20 Jan 2025 09:03:01 -0800 (PST)
Jeremy Drake wrote:
> On Tue, 21 Jan 2025, Takashi Yano wrote:
> 
> > diff --git a/winsup/cygwin/cygwait.cc b/winsup/cygwin/cygwait.cc
> > index 80c0e971c..8613638f6 100644
> > --- a/winsup/cygwin/cygwait.cc
> > +++ b/winsup/cygwin/cygwait.cc
> > @@ -58,16 +58,22 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
> >      }
> >
> >    DWORD timeout_n;
> > +  HANDLE &wait_timer = _my_tls.locals.cw_timer;
> > +  HANDLE local_wait_timer = NULL;
> >    if (!timeout)
> >      timeout_n = WAIT_TIMEOUT + 1;
> >    else
> >      {
> > +      if (_my_tls.locals.cw_timer_inuse)
> > +	wait_timer = local_wait_timer;
> 
> Since wait_timer is a handle reference, won't assigning it here overwrite
> _my_tls.locals.cw_timer ?  I think you might have to use a pointer here
> instead.

Thanks! I'll submit v5 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
