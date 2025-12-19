Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-w03.mail.nifty.com (mta-sp-w03.mail.nifty.com [106.153.228.35])
	by sourceware.org (Postfix) with ESMTPS id 4DA144BA2E1E
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 02:26:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4DA144BA2E1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4DA144BA2E1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766111186; cv=none;
	b=b+TilV9CRSDXhegGfEUdimWeZLn4rLhYmPXbQcK2azmUHvVU0wSG6Zyscw1sSwvVu3ySXhcMQAWJQnmd+8B+PsrsfXt1VQLHyBrQHJqpPOXoqrSbxgoqksFOSHd8zLzQ26d/isMIoHi7f+i/EhRLA/d67pBsi+t+7NEUmdvnIWs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766111186; c=relaxed/simple;
	bh=bTpVVXT+/5Ky1zHmeTBXAVQNGbj81wCsMesjhvmPTpc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=SXXyd0NrQw0JvQTRVE3nVWTOBmZQdl0a6bDjZo5b0MHXkYdpK5p8fXJHgpHKRuByLcpPlp8Wgny3AofKBbVdNlIYJwNezbV1kCezQUUpEYdLtIClRIfvuPmjpMGMCkC7K6ytTY+6mv3mI2eyoM9GKQ44Ht/SqTgM4OI9EMSHGc0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4DA144BA2E1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MKSrX8K7
Received: from mta-snd-w08.mail.nifty.com by mta-sp-w03.mail.nifty.com
          with ESMTP
          id <20251219022624482.RHAJ.1493.mta-snd-w08.mail.nifty.com@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 11:26:24 +0900
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20251219022624410.PMXG.125258.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 11:26:24 +0900
Date: Fri, 19 Dec 2025 11:26:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] Fix stdio with app execution aliases (Microsoft
 Store applications)
Message-Id: <20251219112622.2e3cc382e2eb9592c6d5d978@nifty.ne.jp>
In-Reply-To: <ce71152f-04cd-a2c0-c819-699ff091ea3a@gmx.de>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
	<ce71152f-04cd-a2c0-c819-699ff091ea3a@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766111184;
 bh=btAmyqdivHTFFpCvKk8Y6nh0fM9KXqarp5Ev5SiMsrs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=MKSrX8K78QDijHam2XwE95SyHz31jbPttMILF6RBIKF5RsRX9QOaTLx1OoNznLCvX7A+WxxN
 yzc3h6V9Aacejz0GU0IZu5NRMDCCVjUM/n2w2qrgeNcTtqFNr7vIarHdikPIb2rTb81g3DfyrB
 TDQesRkfUYGzVWpzKVcNDVbg8JcbdMN2c41vUeN24hhE3Fpjj9DUlB9SIBArubfqVM2dUBweME
 4kdYe09fUO/g9Efd4hj8AsDs49vn5+P1BJ2/WMWbg/9Pn9dHYg5YM9NTm3NvU71j2XHTl/7IC2
 So+mldERsNThGzmFTSWhRZ1D8Hp1YHI/Y9UxHGuilydaJqzQ==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 18 Dec 2025 09:28:42 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 18 Dec 2025, Takashi Yano wrote:
> 
> > When I introduced support
> 
> Heh... That's what _I_ wrote ;-) All good, though, I appreciate your
> effort to combine your and my patches.
> 
> > for executing Microsoft Store applications through their "app execution
> > aliases" (i.e. special reparse points installed into
> > %LOCALAPPDATA%\Microsoft\WindowsApps) in
> > https://inbox.sourceware.org/cygwin-patches/cover.1616428114.git.johannes.schindelin@gmx.de/,
> > I had missed that it failed to spawn the process with the correct
> > handles to the terminal, breaking interactive usage of, say, the Python
> > interpreter.
> > 
> > This was later reported in
> > https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=jUHL_pShff+aRv9P1Eiug@mail.gmail.com/t/#u,
> > and also in https://github.com/python/pymanager/issues/210 (which was then
> > re-reported in
> > https://github.com/msys2/MSYS2-packages/issues/1943#issuecomment-3467583078).
> > 
> > The root cause is that the is_console_app() function required quite a bit of
> > TLC, which this here patch series tries to provide.
> > 
> > Changes since v2: (v3 skipped)
> > 
> >  * Merge Takashi's v3 patch into Johaness's patch series.
> >  * is_conslle_app() returns true when error happens.
> >  * Implement new API path_conv::is_app_execution_alias().
> >  * To determine if the path is an app execution alias in is_console_app(),
> >    change argument of fhandler_termis::spawn_worker() and is_console_app()
> >    from const WCHAR * to path_conv &, so that is_app_execution_alias()
> >    can be called from is_console_app().
> >  * Resolve reparse point when the path is an app execution alias.
> 
> I have reviewed these patches, and in particular love that you changed the
> default return value of `is_console_app()` to true, in particular with the
> added explanation in the commit message that it actually does not hurt GUI
> apps much at all.
> 
> While I still think it would be better to split 5/5 into a patch that
> changes the function signature of `is_console_app()` and then a patch that
> adds special handling for app execution aliases, and while I still think
> that the commit message could be improved, at this point I do not want to
> force you to work on this even more than you already have, and therefore I
> would be okay with this patch series to be integrated as-is.

Thanks for reviewing. I'll submit v5 patch. Hopefully it can be GTG.

> I truly appreciate the effort you put into this.
> 
> Thank you,
> Johannes

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
