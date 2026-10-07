Return-Path: <SRS0=b9Qj=H5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id E3AD54BA2E1C
	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2026 18:01:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E3AD54BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E3AD54BA2E1C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791396096; cv=none;
	b=OyJJbJ+FavI/UOHhfcem7HWZkv5/ZkrG9ryLZRBjUuXK/ZKdU7ZwVcEoTlCaIRKtxxMASJv3M+vJi1j2n3bSYcRKwapk4uKdyfDxMBjW49Q0yp95TPqnHBKGAZssOfDZT987/Slen+MEkrOR05oRNWD73894D67E5UVGy1Qa6O4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791396096; c=relaxed/simple;
	bh=Q0Ng4qE1BGEB4+65CQDiSRWoqZlcpGwCYjT1YtGJQMw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=dvoyjdP4fvAehJUNYfxA4PxqczcUZHIh6QK+Ug3A4nGAoOEjKodJCxpKrz4gH09Hmje6EaiYyMrU+gGtU4OjX+wtus3S3LbvXL4goWyHyW99ozcxFkwXhx9XBUAvVYG4EnJxiIuDnlOgS+aLcHPI7bpDJntRZxBAkAiM//0ZSk0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XB84+RqD
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E3AD54BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XB84+RqD
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20261007180133619.NQJP.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 8 Oct 2026 03:01:33 +0900
Date: Thu, 8 Oct 2026 03:01:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: devices: Fix the code for device number
 handling
Message-Id: <20261008030133.163eb36c5ce8aaf34e7e06c7@nifty.ne.jp>
In-Reply-To: <f2a0c0c8-6a47-4955-9add-eafc90cee1cf@SystematicSW.ab.ca>
References: <20261007000050.100799-1-takashi.yano@nifty.ne.jp>
	<4b5c229a-b527-4ffc-82a7-69cb3f5008e4@dronecode.org.uk>
	<20261008012541.6bbc7cb223cc8cf561c2e5ca@nifty.ne.jp>
	<f2a0c0c8-6a47-4955-9add-eafc90cee1cf@SystematicSW.ab.ca>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1791396093;
 bh=zJv76db/cuvtTKpsw5/r0NoHJVJ5eS8BTRqeRY4R46s=;
 h=Date:From:To:Subject:In-Reply-To;
 b=XB84+RqDBQqY8xAjdZY66i4EDIkcAjR+e6POVaH8XNZI//u07zYAsMI2sk8sxiZHedusO7Cw
 kdle/kqE4dc/Wc6+W3eZS+41NI/x8BFPC2Ujnziq5puIagKKzHl++/vALg5qsx6rWCd8SWoQgG
 /nk3irlvyP9mK4uZqJl3s489vsM0dtiF80OF1zpBjk88+wcI0XtuOrmsrI5d6qHuF82G4BctZR
 TQ1jpWOLJ0paIfJ1U+3Q/pnzteYgeb7ns5nCDM5SdOu2nYgxN5myaJA5PZ6e3IINxN/XCzJeYP
 iZh0O068o3ALdDSwclk5db/NqTdaKF99eWPqJW9LSYGzjLwA==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 7 Oct 2026 11:25:43 -0600
Brian Inglis wrote:
> On 2026-10-07 10:25, Takashi Yano wrote:
> > On Wed, 7 Oct 2026 12:41:39 +0100
> > Jon Turney wrote:
> >> On 07/10/2026 01:00, Takashi Yano wrote:
> >>> Currently, the code handling the device number is not match with
> >>> the expected code intent. The shift width for the major device
> >>> number should be the size of _minor_t, rather than that of
> >>> _major_t.
> >>>
> >>> Fixes: 7ac6173643b1 ("* devices.h: Renumber devices based on more Linux-like major/minor numbers.")
> >>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> >>> ---
> >>>    winsup/cygwin/local_includes/devices.h | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/winsup/cygwin/local_includes/devices.h b/winsup/cygwin/local_includes/devices.h
> >>> index 10a46150e..8e02f60bc 100644
> >>> --- a/winsup/cygwin/local_includes/devices.h
> >>> +++ b/winsup/cygwin/local_includes/devices.h
> >>> @@ -11,9 +11,9 @@ details. */
> >>>    typedef unsigned short _major_t;
> >>>    typedef unsigned short _minor_t;
> >>>    
> >>> -#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_major_t) * 8)) | (unsigned) (min))
> >>> +#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_minor_t) * 8)) | (unsigned) (min))
> >>>    #define _minor(dev) ((dev) & ((1 << (sizeof (_minor_t) * 8)) - 1))
> >>> -#define _major(dev) ((dev) >> (sizeof (_major_t) * 8))
> >>> +#define _major(dev) ((dev) >> (sizeof (_minor_t) * 8))
> >>>    
> >>>    #include <dirent.h>
> >>>    #include "cygheap_malloc.h"
> >>
> >> Ha!
> >>
> >> Just so I'm understanding this correctly, this isn't a functional change
> >> because sizeof(_minor_t) == sizeof(_major_t), it's just clarifying the
> >> intent, right?
> > 
> > You are right. There is no practical problem.
> 
> To be strictly compliant, you should #include <limits.h> if not already done and 
> replace explicit constants '8' by `CHAR_BIT`:
> 
> /usr/include/limits.h:#define CHAR_BIT __CHAR_BIT__
> 
> and could then define and use the conventional SHIFT and MASK constants:
> 
> +#define DEV_SHIFT	(sizeof (_minor_t) * CHAR_BIT))
> +#define DEV_MASK	((1 << DEV_SHIFT) - 1)
> +#define FHDEV(maj, min) ((((unsigned) (maj)) << DEV_SHIFT) | \
> 				(((unsigned) (min)) & DEV_MASK))
> +#define _minor(dev)	((dev) &  DEV_MASK)
> +#define _major(dev)	((dev) >> DEV_SHIFT)
> 
> which might have prevented the original issue.

Thanks for the advice. I've revised the patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
