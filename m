Return-Path: <SRS0=XFaT=S6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 157AD3858D21
	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2024 11:43:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 157AD3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 157AD3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733399011; cv=none;
	b=khdjt27v4hV2yMZq+D4Y/pI5MHg4uLDiqYOI9osVIVm1RFtDkdCoP7ly9ji7j/pxErMAn1DzXD14+OtQAMVr1uu/tyulv1fXNmIopUjW2VEVVuPmdqSOghvY+WLLtUGsBSBNz2syMo0QqMhha0Plpl8LfV3r+SM5vyvRrOE+ITM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733399011; c=relaxed/simple;
	bh=wHS5xuOcukcaaBjFUgGB6+4Jgeo5hnqjFsSbOn8OyyY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=pmWf94hFtsyE6wGe8IKrvONYiwal/HdJdfE3X75/RxpwIVd8/m15/L3wtfejAzrRhDrDPEavFeAEZewuCXPobvq6hOW0vzCo3am+Ycr94fvx/Beyv2olDBYkHx2R/4SmmWc3dBweLo4GmX/TBYzF6IhhW8vGVuXJgiNaNryQlzk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 157AD3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fL4asSec
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20241205114327852.TNXT.41146.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 5 Dec 2024 20:43:27 +0900
Date: Thu, 5 Dec 2024 20:43:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Introduce a lock for the signal
 queue
Message-Id: <20241205204327.8382aaccd89b00779ee2114c@nifty.ne.jp>
In-Reply-To: <Z1GFwzDzoLA88AI6@calimero.vinschen.de>
References: <20241205032548.29799-1-takashi.yano@nifty.ne.jp>
	<Z1GFwzDzoLA88AI6@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733399007;
 bh=QwQKPC4r+JD9IK98Os2j42VC3EADPVuOLyQ9Ukwgdzk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=fL4asSecXAqzC9U/0DBdyu7Ms73iwJKFojOvOSHvayp9PLZZr1y+wP/sB+oH3sBNUyEG0wzl
 ths19JLG3yJDKHPkq6E0NbCcMaeGOF726jMjYVk3bDOyAcgo5TLCu6lhwQ+LgWeU51LZ4+uT8N
 /9TJD1LUIs09gTZgZxvdxOKHUcHkzIq3GJAUNXOg72rdKKs0IyPukKptQwYjI9IAdYgFZ507Dk
 9/vUoVmZXMhxleCLMTZxUNnhN7Bn2JJKG2vuRHGjePcqz4o6wm7Je8o7QghLwERUnivTyD11nP
 VWlXGVs7q5+Dn3ygMBTaeJK0EzWPdKHiEakNhyR0ObdZS1wA==
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 5 Dec 2024 11:51:47 +0100
Corinna Vinschen wrote:
> On Dec  5 12:25, Takashi Yano wrote:
> > Currently, the signal queue is touched by the thread sig as well as
> > other threads that call sigaction_worker(). This potentially has
> > a possibility to destroy the signal queue chain. A possible worst
> > result may be a self-loop chain which causes infinite loop. With
> > this patch, lock()/unlock() are introduce to avoid such a situation.
> > 
> > Fixes: 474048c26edf ("* sigproc.cc (pending_signals::add): Just index directly into signal array rather than treating the array as a heap.")
> > Suggested-by: Corinna Vinschen <corinna@vinschen.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/exceptions.cc            | 12 +++++------
> >  winsup/cygwin/local_includes/sigproc.h |  2 +-
> >  winsup/cygwin/signal.cc                |  4 ++--
> >  winsup/cygwin/sigproc.cc               | 28 +++++++++++++++++++++-----
> >  4 files changed, 32 insertions(+), 14 deletions(-)
> 
> LGTM, please push.

With the patch
[PATCH v3 3/9] Cygwin: signal: Remove queue entry from the queue chain when cleared
?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
