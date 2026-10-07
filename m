Return-Path: <SRS0=b9Qj=H5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id CEF8F4BA2E17
	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2026 16:25:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CEF8F4BA2E17
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CEF8F4BA2E17
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791390344; cv=none;
	b=xML/81a0uKzEXYZtQDg2lC1wUxAaxKxoFVCxC4okdx0zv31EPS2wCidIZq9P3ojO16Uqt1+tkvr5jZ7+2IDpdvVc2U83QrQc1T4Az5GTGKWCSk5Q0SLM5FKZq6RZVxe1m2J/5i0io62oVEP9hVdQABzHhJer0AtbG4nsDoqCmEI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791390344; c=relaxed/simple;
	bh=FNeBOaBj+yMFL2QlIoFnLHXfD7e3wbDmCqJfquhsPSc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=p7sPZCRVe/xAA1r+txDYgDQMiLpxza+AEM4TNFZ+nFs4gQKiNYfiRMQ0jtOoT9t37p7qUSxA5BPX24NMJZ5KCfdz9n8bX1NsRW2JEHOqZvM12qHJaKSk9hjMWyHYW3fAH5KfLt1bW4yNEzmTreRx9x+B0dqOPSHtgTyBlfpM9s8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aBSa1O5P
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CEF8F4BA2E17
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aBSa1O5P
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20261007162541304.VINH.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 8 Oct 2026 01:25:41 +0900
Date: Thu, 8 Oct 2026 01:25:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: devices: Fix the code for device number
 handling
Message-Id: <20261008012541.6bbc7cb223cc8cf561c2e5ca@nifty.ne.jp>
In-Reply-To: <4b5c229a-b527-4ffc-82a7-69cb3f5008e4@dronecode.org.uk>
References: <20261007000050.100799-1-takashi.yano@nifty.ne.jp>
	<4b5c229a-b527-4ffc-82a7-69cb3f5008e4@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1791390341;
 bh=m7wZA6UnL6Rr+EufSwZ+G92u5k98m5XaazNzCYQmZIw=;
 h=Date:From:To:Subject:In-Reply-To;
 b=aBSa1O5P39E8BhcvKDUuZpBuiHT/+rAKbqbc2pxOtyiQfvtVYVw/cnTL4yP+oO2jFruZzcMu
 oXqRZqARHIkIw34+Gj8+8TNkY401ACCw892I9wslDC9Qgj6fibHoC0QJDmEuV7C1mKslrq5u75
 NCoIQUSoAUl3DWnUEvU0ulvPQHpgyaVwSqkflxVHmQmYmikMvZ4eimgrN8IyGfAUl/qRbG+800
 z4lk8lTea933v66F195yixztaHmAPo0YFRqSeILDBnr4gUMrnO2IzR6nvpeNt71Ml27LsqZDOG
 DW6g2dgzulLOdM6BAYAHzrVwZ5Ps1Lv2I2MzLbzGSvWDnb0Q==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 7 Oct 2026 12:41:39 +0100
Jon Turney wrote:
> On 07/10/2026 01:00, Takashi Yano wrote:
> > Currently, the code handling the device number is not match with
> > the expected code intent. The shift width for the major device
> > number should be the size of _minor_t, rather than that of
> > _major_t.
> > 
> > Fixes: 7ac6173643b1 ("* devices.h: Renumber devices based on more Linux-like major/minor numbers.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >   winsup/cygwin/local_includes/devices.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/local_includes/devices.h b/winsup/cygwin/local_includes/devices.h
> > index 10a46150e..8e02f60bc 100644
> > --- a/winsup/cygwin/local_includes/devices.h
> > +++ b/winsup/cygwin/local_includes/devices.h
> > @@ -11,9 +11,9 @@ details. */
> >   typedef unsigned short _major_t;
> >   typedef unsigned short _minor_t;
> >   
> > -#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_major_t) * 8)) | (unsigned) (min))
> > +#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_minor_t) * 8)) | (unsigned) (min))
> >   #define _minor(dev) ((dev) & ((1 << (sizeof (_minor_t) * 8)) - 1))
> > -#define _major(dev) ((dev) >> (sizeof (_major_t) * 8))
> > +#define _major(dev) ((dev) >> (sizeof (_minor_t) * 8))
> >   
> >   #include <dirent.h>
> >   #include "cygheap_malloc.h"
> 
> Ha!
> 
> Just so I'm understanding this correctly, this isn't a functional change 
> because sizeof(_minor_t) == sizeof(_major_t), it's just clarifying the 
> intent, right?

You are right. There is no practical problem.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
