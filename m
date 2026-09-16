Return-Path: <SRS0=siFy=HI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id C03C64BA79A8
	for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2026 00:41:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C03C64BA79A8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C03C64BA79A8
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789519308; cv=none;
	b=rAXqMps9KmKgO9l4NjfWPTMIxZUHwaNZZbOR5GJtYnk0Javx+kC3SgbJgwPDHEtkM7WetZWLfZKoo8estHrUxwmCHjLKwRNr92aiDHqghBM9vmj5GV8Gz7R5sREibkbCQd6zXS0ZrR5H0o6Nb9E/3Hu6JhAvvqJ/zJjqvjYp53Q=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789519308; c=relaxed/simple;
	bh=xVfttjWzAQoQhx3+sI/6H8F66Zns8zmEOViJgCEGW6Y=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=qOBG+QYtTRAT1wpyVqj0PCgKsVhWHzr6+jLBwK4PYhREYEflvStXrUn6OdCsGGkXsr8bTGjxXq52HV2jsKwd6XEHDH6GnjIl8H/V+TmkF8+Yv8L3v3JJQjDKk3E/EH9390PM5uy4BOqT7c2P3lyWGFamoU181oVkDbWBcBNz+n8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FQZALjqq
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C03C64BA79A8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FQZALjqq
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260916004144063.PDFD.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2026 09:41:44 +0900
Date: Wed, 16 Sep 2026 09:41:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: Fix compilation of c8rtomb with gcc 16
Message-Id: <20260916094143.4a692ca26a98c385910c30d4@nifty.ne.jp>
In-Reply-To: <20260601125055.1341979-3-jon.turney@dronecode.org.uk>
References: <20260601125055.1341979-1-jon.turney@dronecode.org.uk>
	<20260601125055.1341979-3-jon.turney@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789519304;
 bh=wBiQUTzukBWuBSWoh+l2t6NwV5D2XCPMfvBYP1sn0uo=;
 h=Date:From:To:Subject:In-Reply-To;
 b=FQZALjqqioB9bTrmTd9wlM4a8jxi1vkZdYMLhzrdSKG1VnelwoVj+JGAAvsjdDyNdSyHdEjR
 NaB1cZB9ih8ArmhWwLL/9PicCZlSUBRnmrl9a17KlI84q85qV+SAEFQGnw1i3FxQbB7P4t13aN
 5xzMxdU/cJ7GohDRDH2vRxKV8nNd/NJFZKJDsgM+4ltosS5UCaHCkJZy9E5USG52PsG9LxdNRm
 6nu6jUCwaiNG5SiOXi+Fuyz2m33JNGLo6N0AcXpNe3gtM90RacIINrZXweXwkH5JL4aQOuA7XB
 rPYOeCecTDESgdwUa1PmcFgnT28LVUCDfAmdYzrHaIZ+fK4A==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On Mon,  1 Jun 2026 13:50:54 +0100
Jon Turney wrote:
> ../../../../src/winsup/cygwin/strfuncs.cc: In function ‘size_t c8rtomb(char*, char8_t, mbstate_t*)’:
> ../../../../src/winsup/cygwin/strfuncs.cc:214:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
> ../../../../src/winsup/cygwin/strfuncs.cc:215:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
> ../../../../src/winsup/cygwin/strfuncs.cc:216:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
> ---
>  winsup/cygwin/strfuncs.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/strfuncs.cc b/winsup/cygwin/strfuncs.cc
> index 0cf41cefc..85427a0d1 100644
> --- a/winsup/cygwin/strfuncs.cc
> +++ b/winsup/cygwin/strfuncs.cc
> @@ -211,9 +211,9 @@ c8rtomb (char *s, char8_t c8, mbstate_t *ps)
>      {
>        /* We already collected something... */
>        int idx = ps->__count & 0x3;
> -      char8_t &c1 = ps->__value.__wchb[0];
> -      char8_t &c2 = ps->__value.__wchb[1];
> -      char8_t &c3 = ps->__value.__wchb[2];
> +      unsigned char &c1 = ps->__value.__wchb[0];
> +      unsigned char &c2 = ps->__value.__wchb[1];
> +      unsigned char &c3 = ps->__value.__wchb[2];
>  
>        switch (idx)
>  	{

_mbstate_t (*ps) is defined as follows in
libc/include/sys/_types.h:

#ifndef __machine_mbstate_t_defined
/* Conversion state information.  */
typedef struct
{
  int __count;
  union
  {
    wint_t __wch;
    unsigned char __wchb[4];
  } __value;        /* Value so far.  */
} _mbstate_t;
#endif

_wchb[] is `unsigned char`, therefore, c1, c2, c3 should be
`unsigned char`.

That is, your patch LGTM.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
