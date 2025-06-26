Return-Path: <SRS0=1xMm=ZJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.177])
	by sourceware.org (Postfix) with ESMTPS id 23EB4385703B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 05:37:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23EB4385703B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23EB4385703B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.177
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750916247; cv=none;
	b=dfN5sXqCdtqZJakkq4Fuyk8S3isLGhGlf35NnXC4FX7L4s2lCOCtKDXF8H4SJub+mvIfZhOZfVBd9WX/5rSlbpUF+B10W6PYaf4ONkMuLzJIBSGWSOVydsZTZNVvpmx/iWyeq4RCZHkmj7IZ5uhlpbgXSpNM3O9gM0tpF9lwfBE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750916247; c=relaxed/simple;
	bh=oEpjZILMAQeLCVPNGOS6ZNc/zrkm+/38Antm2bz7h8s=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=HYsNTVZp3gumAUgD1NhyZEHrFpNHeiw0Ac7ZVPZu8vBCHuDIERSgW7549Nqy64+fznjfDLrE/oO0cv0cfsQqkDdVEjXKOaTlN4mD/PGzcV+QxXpKiFqexTzwtgHSWNkbq7Qb/GE5v3LP6otnpvuWSkwUqlXxmIaveuMBAGn5NKo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23EB4385703B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ayby+Gb5
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20250626053725363.WDJJ.62593.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 14:37:25 +0900
Date: Thu, 26 Jun 2025 14:37:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pipe: Simplify raw_write() a bit (stop to
 use chunk)
Message-Id: <20250626143723.760e7bfdea7ca71e7f53faaf@nifty.ne.jp>
In-Reply-To: <db956baa-e4e1-68cb-e5b2-349a113c7654@gmx.de>
References: <20250625114202.927-1-takashi.yano@nifty.ne.jp>
	<db956baa-e4e1-68cb-e5b2-349a113c7654@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750916245;
 bh=vAKHEnhZMiI77Qbk9L0ycjWtdWWcPnKory2kqdDxV+s=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ayby+Gb57NY6WS5BlgAWr1TJYZi/VRAQCDdZNerRwtR6/o9JUC+1nYHoWciyKoEbDlw05+SJ
 wn7dinUy8b5znfZjI1TC+i97Q7C396N3Zre/SLtXsNh9Vg/r5j2iaV+43dFSDlKGJAofS/XtyV
 KnSP0SoiUL/qFIXV8jSVmdmbUEWeRE/MQ6i3869xKVMKaSPJf9Rqk2ANgG1qDeu1EL91h7WGPQ
 P+5H/yQyNNTgw6gJgT4O6FitvSmaA2vmHiQ/+ME7G/Hs158PiadMVrILcP6hFpQiX/zLp8C/lP
 5dhcgClWZccV2MBRAhKwoiEEp5mqZPbiP+bWR71HnOelfbUw==
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Jun 2025 14:55:35 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 25 Jun 2025, Takashi Yano wrote:
> 
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> 
> This is way too terse. There is a difference between being succinct and
> leaving things unsaid.
> 
> Also, please make sure that v2 is a reply to v1 of the patch. I almost
> commented on v1 by mistake.
> 
> > ---
> >  winsup/cygwin/fhandler/pipe.cc | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> > index e35d523bb..c35411abf 100644
> > --- a/winsup/cygwin/fhandler/pipe.cc
> > +++ b/winsup/cygwin/fhandler/pipe.cc
> > @@ -443,7 +443,6 @@ ssize_t
> >  fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> >  {
> >    size_t nbytes = 0;
> > -  ULONG chunk;
> 
> Okay, removing this local variable is a good indicator that this diff
> shows all the related logic, without having to resort to looking at the
> entire `pipe.cc` file that is not reproduced in this email.
> 
> >    NTSTATUS status = STATUS_SUCCESS;
> >    IO_STATUS_BLOCK io;
> >    HANDLE evt;
> > @@ -540,11 +539,6 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> >  	}
> >      }
> >  
> > -  if (len <= (size_t) avail)
> > -    chunk = len;
> > -  else
> > -    chunk = avail;
> > -
> >    if (!(evt = CreateEvent (NULL, false, false, NULL)))
> >      {
> >        __seterrno ();
> > @@ -561,8 +555,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> >        ULONG len1;
> >        DWORD waitret = WAIT_OBJECT_0;
> >  
> > -      if (left > chunk && !is_nonblocking ())
> > -	len1 = chunk;
> > +      if (left > (size_t) avail && !is_nonblocking ())
> > +	len1 = (ULONG) avail;
> >        else
> >  	len1 = (ULONG) left;
> 
> So there is a subtle change here, which _should_ result in the same
> behavior, but it is far from obvious.

Is that so? It seems abvious to me. Because...

chunk has len (< avail) or avail.
When left (= len - nbytes) > chunk, len > chunk.
If len > chunk, chunk == avail.

Isn't this obvious?

Anyway, I'll add commit message and submit v3 patch
after "SSH hang fix" is settled.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
