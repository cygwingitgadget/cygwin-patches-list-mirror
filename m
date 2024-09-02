Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2102E385DDD3; Mon,  2 Sep 2024 11:10:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2102E385DDD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1725275434;
	bh=TOcgFUphCr8chgHeKsOtw45gBz/qOi1cJOWCj+jpcew=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UiPb3iSfuB4DLlqXlAY0o4izZMWGrpnnCtQ8R7aZjk768RhiZ6Id/LrqGvlprZ6ez
	 8DuAej7IVanPJRFB5TgQevhRqjeeeM2+R3G99AgKMxro4NFiYGlEjtGVBBKU7/pVK9
	 K9C1/sBAwqLkj+gVU315q4sBdFRwMeJUtfK5mwOE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D2AAFA80B9C; Mon,  2 Sep 2024 13:10:31 +0200 (CEST)
Date: Mon, 2 Sep 2024 13:10:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-ID: <ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Aug 30 23:15, Takashi Yano wrote:
> If a cygwin app is executed from a non-cygwin app and the cygwin
> app exits, read pipe remains on non-blocking mode because of the
> commit fc691d0246b9. Due to this behaviour, the non-cygwin app
> cannot read the pipe correctly after that. With this patch, the
> blocking mode of the read pipe is stored into was_blocking_read_pipe
> on set_pipe_non_blocking() when the cygwin app starts and restored
> on close().

Looks ok to me, but it would be helpful if Johannes could test this as
well.

I just wonder if the whole code could be simplified, if we set
the pipe to non-blocking only temporarily while reading or writing,
while the pipe is blocking all the time otherwise:

- Create pipe blocking

- set_pipe_non_blocking(true);
  NtReadFile() or NtWriteFile();
  set_pipe_non_blocking(false)

How costly is it to call NtSetInformationFile(FilePipeInformation)
for each read/write?

Thanks,
Corinna
