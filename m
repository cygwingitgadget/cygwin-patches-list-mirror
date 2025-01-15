Return-Path: <SRS0=86Mz=UH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.178])
	by sourceware.org (Postfix) with ESMTPS id 5AB31385E00C
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 13:17:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5AB31385E00C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5AB31385E00C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736947054; cv=none;
	b=VQuWvRIxv4JhrbAo483fEzL1lfOJOpmKWQl7aG8kaiqN3nAX87ZDlVY4EOYhWzGvzq9zaQLxkksCyfT1u+M+j+KPilQ/BAazYsiXkmc3KfFl6lTXF2vHjGwmz9mC+WyYq16uWw4OPGBbqXkR5hOkhY5GnWh0ormmNyDzfnPuQlQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736947054; c=relaxed/simple;
	bh=g69ECP82k4/PHjXOsPfclAS4sLfCpvMK4rx07cRA1tw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LoRlz16LAeXoKq7HfYVylRL3uRkCTLKhmue29UT+y+r/ft0GaFo7GZmLicO98Tqzp7AvZmSNKK46PKFlgVaGHjlLVTm/ggxcstrG5uG7j/98aaOvZr+LCbzGYX1nQb1l8We/MsDgLzaS5O0njVzT68UTdgbNB/Tao0MvfxP5W4c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5AB31385E00C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UgxYvDaQ
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20250115131731151.UTOB.44461.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 22:17:31 +0900
Date: Wed, 15 Jan 2025 22:17:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
Message-Id: <20250115221730.4b1ce8becbd1060ffb0373da@nifty.ne.jp>
In-Reply-To: <Z4TzRLHGdvcxfT_y@calimero.vinschen.de>
References: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
	<Z4TzRLHGdvcxfT_y@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1736947051;
 bh=0i4vMpqss9vm/4NtriwHQaTwi73Kh7IkSBDk1GKMiww=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=UgxYvDaQdWRekV0BU5lDZWM7y3XIZHl6Wv28EEHqWmwvNQY8onvW3niqOVKTRoMQt/cA7UJ/
 t9qclrOF48S7NvN2F7I5cxNGPfKinK3UdU7+WIUZ7CvOg2HYkcZPnOocbBt4rVYNju39qmboCW
 imHQxSj0lSiVNaeULSHLYM4PJFD+YvzvEAgSpLms4JsL7s7/dRep/5v7tAP9qtJtOBGQVdBm/W
 krbxgIVO7BLQkZDRQKJhsebO12RXDmDtoehUCXIr+QCyL4voXQ/4YvLEQql9/7K67OydtePzEN
 I83NP/tMNZFYUp18SCEP01klIjZB+iSUJUWnjxTOHUtampyA==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 13 Jan 2025 12:04:36 +0100
Corinna Vinschen wrote:
> On Jan 10 16:18, Ken Brown wrote:
> > Patch attached.
> > 
> > This turned out to be completely trivial, unless I'm missing something. I
> > tested it with several programs that use mmap, and it seems OK.
> > 
> > Ken
> 
> > From 654e5c83da077b67683a1aefd79a414ed6067e51 Mon Sep 17 00:00:00 2001
> > From: Ken Brown <kbrown@cornell.edu>
> > Date: Fri, 10 Jan 2025 14:39:46 -0500
> > Subject: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
> > 
> > It was convenient to use pages of size 4K (Windows page size) for
> > bookkeeping when we were using filler pages.  But all references to
> > filler pages were removed in commit ceda26c9d35b ("Cygwin: mmap:
> > remove __PROT_FILLER and the associated methods"), so this is no
> > longer necessary.  Switch to using pages of size 64K (Windows
> > allocation granularity) for everything.
> > 
> > Signed-off-by: Ken Brown <kbrown@cornell.edu>
> > ---
> >  winsup/cygwin/mm/mmap.cc | 29 ++++++++++++++++-------------
> >  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> Sounds good to me.

With this patch, gdb no longer works in my environment:

$ gdb
Pre-boot error; key: system-error, args: ("load-thunk-from-memory" "~A" ("Invalid argument") (22))

Fatal signal: Aborted
----- Backtrace -----
---------------------
A fatal error internal to GDB has been detected, further
debugging is not possible.  GDB will now terminate.

This is a bug, please report it.  For instructions, see:
<https://www.gnu.org/software/gdb/bugs/>.

Abort
$

Any idea?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
