Return-Path: <SRS0=IQe/=EP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 279DB4B9DB6A
	for <cygwin-patches@cygwin.com>; Fri, 19 Jun 2026 05:05:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 279DB4B9DB6A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 279DB4B9DB6A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781845548; cv=none;
	b=UKxvtYABZbJUzMkACmLvELkBVGFzNnzPF3gneHZUPKyzPmUQCnzOFqKPxGlNkezk2a5dMWxz12+t1SeNibvMQPznzFsg2FFo/XwejlQwEfpqzF0D+Y1ULZuQwcnDLB+FxvFoRnJ5j3gP9Zr9bBZuhDbc4ONjAoDab23jheLxJbg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781845548; c=relaxed/simple;
	bh=s2My9H9oPewh6KjeUwXGdClLhdUd4lNW3iN6HlE6emc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=FTmO2xj9xh6VvkGqxRnFgZdzF+HL/YfPVv5cXClOuS+PQg6Lz90UL529m92d+PIY8jutCl1bsqT0ANfqBRVW0QL8yTyDguoKcJ1k0oli9Ma4tE4ExgYuZwCFx2vbZLeysDYvGOwpDTOlo2ndQkds3msWeWD3YqbkInqDrhdYSNE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=egv9XZ58
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 279DB4B9DB6A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=egv9XZ58
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260619050543872.LKZ.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 19 Jun 2026 14:05:43 +0900
Date: Fri, 19 Jun 2026 14:05:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Status of patches I proposed recently
Message-Id: <20260619140542.158c4f34e9083169a1882b9c@nifty.ne.jp>
In-Reply-To: <20260613232444.d4bf8f3d8d33908d8be14e74@nifty.ne.jp>
References: <20260612224229.a1b848b8a14bb84a471fc958@nifty.ne.jp>
	<20260613232444.d4bf8f3d8d33908d8be14e74@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781845543;
 bh=sGtKK0bIUH6nwGbsCuEBRYD5qxQ6dzQTEg7AjbIjYFU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=egv9XZ58Vbja32bpA9nkULW/RATpURs2DyNRqhtXwqfOFqWDOWIX04yk1sqi/v+6sN+VAdVz
 i4a74163s5CM3S8ERwbyEhO3ZG1jpXOcPFCASizCnKOYCn79v6tt7chG15h94Xft9CV8zV3RX0
 6G8mMGWz7tzeNaR09s7bjEnY1/zAg+UfhcdBlt5wL7WtCvTSQycc83xD8Lt5tKj/aX3Dm+pt4H
 bFHg35x3aPnKbjPMziVQ6+9EPfm+ZSNwVUpsY4obur2w+a2w6QAr1a74sJ9Io4TP8ax47vUF57
 9BvPvShI3lGOXAhhc5L+3bh/F8Xe8NO1UMUZWTNYojXh+cag==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi,

Is anyone willing to review these pty/console patches?

On Sat, 13 Jun 2026 23:24:44 +0900
Takashi Yano wrote:
> All pty/console patches are not reviewed yet. Three patches are tested by Koichi.
> 
> * pty patches [New feature]:
> [PATCH v2 2/3] Cygwin: pty: Discard pcon input buffer when discard_input is called.      +     [13 Jun]
> [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app exits                     +     [13 Jun]
> (These two patches require following pty bug fix patches.)
> 
> * pty/console pathces [Bug fix]:
> [PATCH] Cygwin: pty: Do not set input_available_event when applying line_edit()          (T)   [ 8 Jun]
> [PATCH v3 1/2] Cygwin: pty: Introduce a helper function get_handle_from_process()        (T)+  [ 8 Jun]
> [PATCH v3 2/2] Cygwin: pty: Prevent unintended conversion for cursor position report     (T)+  [ 8 Jun]
> [PATCH v5] Cygwin: pty: Fix race issue between starting and exiting non-cygwin app       +     [11 Jun]
> [PATCH 1/3] Cygwin: console: Ensure the master thread runs only when it is supposed to         [11 Jun]
> [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little                                          [11 Jun]
> [PATCH 3/3] Cygwin: console: Fix typeahead input for bash                                      [11 Jun]
> [PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in transfer_input()             [12 Jun]
> 
> * Others [ALl done]
> [PATCH v3] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN                (R)+(P)
> 
> + Patch revised after the last report
> (T) Tested
> (R) Under review
> (P) Pushed


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
