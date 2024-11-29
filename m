Return-Path: <SRS0=zjkU=SY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id F314B3858D26
	for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 11:49:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F314B3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F314B3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732881000; cv=none;
	b=pjRVvecAQOEvLgK0BMVwXLDbeknuGLWAStPGNlwZ0kBe/srExqbkPqpW9FD14U9MqLla1rFrS2Dts2ze5hHEAr2G0VBxJUGG+NDHlK8nfbxNgQbcVVWsKGiRGzZJlJ7ebvtB4UThZjvhIfclqeVclGk5xmyIXAwrA8hEyqyz6WI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732881000; c=relaxed/simple;
	bh=qmkbLPCC5kypH9C9WPCHZZ+9G6Xwl42i0gA/ykiRtG8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=HvBp7UZuO6Zt5ftUdkwb89lU6gH7F6/Lj7Ti96RSQ1PVzc5e95o4hQly1zS/q9TIDzxiag9mh9CMZepESsFuHysqNQ0ha++UEjz+k4tURwqxdcBuhQj3y9RXYbCdj/LcHOj1ntCcZKo9TRBBQ5D9cGM3ok/yJTSoXK3gL6CLJL0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F314B3858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TarTZeBp
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20241129114958171.IZMT.81160.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 20:49:58 +0900
Date: Fri, 29 Nov 2024 20:49:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/7] Cygwin: signal: Cleanup signal queue after
 processing it
Message-Id: <20241129204957.1222ed5732188abb94d80699@nifty.ne.jp>
In-Reply-To: <Z0dK41-dW1BnMlqe@calimero.vinschen.de>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
	<20241126085521.49604-4-takashi.yano@nifty.ne.jp>
	<Z0dK41-dW1BnMlqe@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732880998;
 bh=Gt0Zl+WiAe+ikvtLKKM05lRlR4wvi2mGF0wXIgkThbU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=TarTZeBpjXqEfbfICvuLzH3wNEJ0x36/Rhvgubu97zrEbkbo9+lt6CoCOoi+YIbgZ/IW0w7A
 qIBSWC8bP3ht8VDdVQeG2Edc3DhwKWAfa7JbncPAkYyIJf4T/vYoqIVyTToxSJDwSqwRWvxhxv
 lSB1hG1gL7iqSl5rJPZdz4XWcyfdmd9sPkl2ekxmsIrfNBPxqs5cjowlrSVTPDICmXreTp1T6m
 rTQiM0V31oijO9szoyQVDZ/5rU8LoeSi+x0qTSJw/CGPm+snD2OixaHM1FNkwnc/hx6qDlY+eP
 gL500RP8eB0+zdQwhaS5K7+/z+LvzdPHIuUM55vvOFeFfPvQ==
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 27 Nov 2024 17:37:55 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Nov 26 17:55, Takashi Yano wrote:
> > The queue is once cleaned up, however, sigpacket::process() may set
> > si_signo in the queue to 0 by calling sig_clear(). This patch adds
> > another loop for cleanup after calling sigpacket::process().
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
> > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/sigproc.cc | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > index 8f46a80ab..b8d961a07 100644
> > --- a/winsup/cygwin/sigproc.cc
> > +++ b/winsup/cygwin/sigproc.cc
> > @@ -1463,6 +1463,17 @@ wait_sig (VOID *)
> >  		      qnext->si.si_signo = 0;
> >  		    }
> >  		}
> > +	      /* Cleanup sigq chain. Remove entries having si_signo == 0.
> > +		 There were once cleaned obeve, however sigpacket::process()
> > +		 may set si_signo to 0 using sig_clear(). */
> > +	      q = &sigq.start;
> > +	      while ((qnext = q->next))
> > +		{
> > +		  if (qnext->si.si_signo)
> > +		    q = qnext;
> > +		  else
> > +		    q->next = qnext->next;
> > +		}
> 
> I'm not quite sure, but wouldn't it make more sense to change
> sig_clear() so that it actually removes the entries from the queue
> immediately?  Using Interlocked functions on the queue may even
> avoid locking...

Yeah, indeed. I have submitted v3 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
