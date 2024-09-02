Return-Path: <SRS0=co2e=QA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 16B9B3858401
	for <cygwin-patches@cygwin.com>; Mon,  2 Sep 2024 11:49:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 16B9B3858401
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 16B9B3858401
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725277776; cv=none;
	b=DpnA/o0BHFO0QSTsgmX45JTg3vb/Qq4CtA/afP2bXaxL8AvsoccYRYS9HBsYO+WkyE+sktkLU/xUkQTihRSmAO7VsBPEHonTSotRpA2PPP6j4zOYO5wOouTmzmSMZ1BNRMKPBecxNQ/EwCp/aYQgoI6SsIo4HA8pECz9l05IYTw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725277776; c=relaxed/simple;
	bh=V3AhX+PRssh/2miInltxRXh6w1so8frS2owhdxNP+B4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=s8n4IoGNTeF7M8N/YpB7gVW3hB3h39e9poLYsqZkmg3GE/1+B/XjPyqTwJt+anijmoWUtSVR0b9BSrtxUn+KiLE5AEE63jSyNGWOAg7Wv2AvkUEDNKzGtl4ZvAnAQL8PDfuGC0O94cLYqQ2qU3nCkvsXiZrEzVjnldyXbV86OgQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20240902114929801.XFSE.12429.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 2 Sep 2024 20:49:29 +0900
Date: Mon, 2 Sep 2024 20:49:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-Id: <20240902204928.66b3d6ff60f8fd420c488bc2@nifty.ne.jp>
In-Reply-To: <ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
	<ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725277769;
 bh=TLtEXHwLociQl7BDCAD7NGszgz1P0sSPyWDaFH7RGm4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=tJL+MLcv1W0eOfYA3NkTVDzfjzBjxVNEB1cNqGM/BJogdf5hjGeqpvll3j2RniTUJc0KfAL1
 //Ih78hyhsTn2QE7dk7QnP4mPhMPwHUQzFl7SX/BsuYQJW8lZ+yXZT0ZCeIhG64o7xZTxdu872
 We7j3X8aVzZvh2MEpRdZ6TM+iH2Z6fyGNMmDWpm2n1A0kwzIQKNbFGLtyOXlPNzSeX9iNoiDEv
 tcSN442Zd/dAn0IvVS6RtjW50Hc9Xawsw06GKhxcJC1yrs/JmWAU4qP5zAph55lpXShPo2Ua4v
 sLaoN6ApEbjXLOUpw4adFElJ6cRSevrUYudUgQOrwYY4Wp/g==
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Sep 2024 13:10:31 +0200
Corinna Vinschen wrote:
> On Aug 30 23:15, Takashi Yano wrote:
> > If a cygwin app is executed from a non-cygwin app and the cygwin
> > app exits, read pipe remains on non-blocking mode because of the
> > commit fc691d0246b9. Due to this behaviour, the non-cygwin app
> > cannot read the pipe correctly after that. With this patch, the
> > blocking mode of the read pipe is stored into was_blocking_read_pipe
> > on set_pipe_non_blocking() when the cygwin app starts and restored
> > on close().
> 
> Looks ok to me, but it would be helpful if Johannes could test this as
> well.
> 
> I just wonder if the whole code could be simplified, if we set
> the pipe to non-blocking only temporarily while reading or writing,
> while the pipe is blocking all the time otherwise:
> 
> - Create pipe blocking
> 
> - set_pipe_non_blocking(true);
>   NtReadFile() or NtWriteFile();
>   set_pipe_non_blocking(false)
> 
> How costly is it to call NtSetInformationFile(FilePipeInformation)
> for each read/write?

Good point. I'll try performance test for that idea.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
