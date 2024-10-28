Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4CF313858D38; Mon, 28 Oct 2024 11:57:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4CF313858D38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730116627;
	bh=Rop5n/SnPb6qczj+PYsUXsSpiaPFMG1/ORA7EhKKWWc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Ox5+KDi19ZNMpME/djMfGmwbN1tWTio+73WSShkkfHhOOdPfjIHCgg9iI3/sJhDOQ
	 rO+rrt14gmqXQg77uyJtN6FZqKLTrJH+BKTo62xuzxMU0r46+fXYinKxGVvx0Y8qrv
	 PPKlNJTDLA57tL0j8bPd3sn/El+hAULOXoEYmw/I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2D1D6A80A36; Mon, 28 Oct 2024 12:57:05 +0100 (CET)
Date: Mon, 28 Oct 2024 12:57:05 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-ID: <Zx98ETE7E1DMGirF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
 <Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
 <20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
 <ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
 <20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
 <Zx9fk6yQ1etCVwek@calimero.vinschen.de>
 <20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
 <20241028202516.0dd4c86cb2efa9f7db8c856d@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028202516.0dd4c86cb2efa9f7db8c856d@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Oct 28 20:25, Takashi Yano wrote:
> Is the test case I used different from yours? Without the 2nd arg,
> $ ./a.exe 40000
> pipe capacity: 65536
> write: writable 1, 40000 25536
> write: writable 1, SIGALRM 24576 960
> write: writable 0, SIGALRM -1 / Interrupted system call

This is the same testcase I pasted last week:

  $ ./x 40000
  pipe capacity: 65536
  write: writable 1, 40000 25536
  write: writable 1, SIGALRM 24576 960
  write: writable 0, SIGALRM 512 448
  write: writable 0, SIGALRM 256 192
  write: writable 0, SIGALRM 128 64
  write: writable 0, SIGALRM 64 0
  write: writable 0, SIGALRM -1 / Interrupted system call

So why does it not get into the last else case after calling
pipe_data_available()?  Do you get a different return value
from pipe_data_available()? If so, what and why?


Corinna
