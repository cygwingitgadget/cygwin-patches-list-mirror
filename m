Return-Path: <SRS0=J3gq=XT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.226.35])
	by sourceware.org (Postfix) with ESMTPS id 4A6433858D35
	for <cygwin-patches@cygwin.com>; Sat,  3 May 2025 06:54:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A6433858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A6433858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746255240; cv=none;
	b=UeXiPyTJBNaUJBdVlXejsW0j7eBpicYrEX3fR/HRiwzdniI/yoOiYeOpB3ZQfeYXModejbx6WXSFJAcvnnUUdPgggsom56GcdAtnnseelFWlrn+W/JAeXs1ZKtJJW8p3rj6ita2ykIsZJI5dUCx7t0WgrzN6PUYGIXjq+/PPIfE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746255240; c=relaxed/simple;
	bh=UgU3TcVzh9uPvbC26u2FcBL1YnJkgZUAaXBvvd636rw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=RMlU5pZb01NRnYFSme38KvNpidvXP0aZ20hzJtBARxxDdSs24fxv8cxjEjU7i37DU+zspNfiJYQoWNkUR2E2glEf/aG51bSzctquqbAuMQictPVg3GS7sBmfV+6SBo5gqhV6Go9pXGAsV0dptZq1U4AlpWy2MU++5IB8jKoIUPQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A6433858D35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cSNkGIhF
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20250503065358661.RJVD.47114.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 3 May 2025 15:53:58 +0900
Date: Sat, 3 May 2025 15:53:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
Message-Id: <20250503155357.178e47383611df1a76f784f9@nifty.ne.jp>
In-Reply-To: <1c5aa56e-63e0-c989-4f67-cd77f0c769d1@t-online.de>
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
	<20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
	<4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
	<20250502203144.ca3ba0953ce5bb9f97267920@nifty.ne.jp>
	<1c5aa56e-63e0-c989-4f67-cd77f0c769d1@t-online.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746255238;
 bh=6+phe+q9sjWdPsJIbbWSvwSibe/kkkZy/ZHuj5jK+ec=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=cSNkGIhFx3ZlmeD2ZaUeEGdOyP/OQFQdk/E+xLkPgbbv/069ItgQj+hGqXsslpTJ5bgGl+De
 yrOkXKokpctgXnBlK/I0Zmp3KgsQmnZ6i/qt+jakJM8ILSXMuIh03ZTI6ZwbLS2UOmEHwWjUa4
 6zLJpmcoTnQslIWP47tTd3gQhnK2m9EEY8ZbckSQkEJbYJ/GwgueYpD3b8ZhbvPric2DpbajN8
 e/EUO13LiMDUY/QHypLC5W2o5tD0tUD+9hOMhJ2PNxTg0DXHrtsEh7hozueGt8nJbu3EcZ3pU7
 TsUQT4juHKlKDpO4HCIxX/qaVlXwnHOFoW4+21sQiMAZiYuw==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Fri, 2 May 2025 16:09:48 +0200
Christian Franke wrote:
> Takashi Yano wrote:
> > On Tue, 15 Apr 2025 11:02:37 +0200
> > Christian Franke wrote:
> >> Hi Takashi,
> >>
> >> Takashi Yano wrote:
> >>> Hi Christian,
> >>>
> >>> On Fri, 11 Apr 2025 16:46:07 +0200
> >>> Christian Franke wrote:
> >>>> In rare cases, '/bin/kill -f PID' hangs because kill(2) is always tried
> >>>> first. With this patch, this could be prevented with '/bin/kill -f -s -
> >>>> PID'.
> >>> I wonder why kill(2) hangs. Do you have any idea?
> >> Sorry no. I observed this in early (Cygwin 3.5.4) testing of stress-ng
> >> for ITP, but could no longer reproduce it.
> >>
> >> Here are tests which currently (3.7.0-0.51.gd35cc82b5ec1) ignore but not
> >> hang kill(pid, SIGKILL):
> >>
> >> stress-ng --mprotect 1 -t 5 -v
> >> stress-ng --priv-instr 1 -t 5 -v
> >> stress-ng --sigchld 1 -t 5 -v
> >> stress-ng --sigsegv 1 -t 5 -v
> >>
> >> Run this in another window to see that child processes are left behind:
> >>
> >> killall -v -9 stress-ng; sleep 4; taskkill /F /T /IM stress-ng.exe
> >>
> >> For a minimal testcase regarding --priv-instr, see:
> >> https://sourceware.org/pipermail/cygwin/2025-March/257726.html
> > I could finally fix this issue. See:
> > https://cygwin.com/pipermail/cygwin-patches/2025q2/013696.html
> 
> Thanks - I will test it soon.

I have a problem with
stress-ng --mprotect 1 -t 5 -v

It sometimes hang due to a cause which does not seem to be a
cygwin bug.

stress-ng seems to use SIGALRM to stop processes. In mprotect
case, SIGARLM is armed before stopping SIGSEGV. What I observed
is:

1. SIGARLM is armed.
2. stress_handle_stop_stressing() is called.
3. Just after stress_handle_stop_stressing() is called, SIGSEGV
   occurs inside the stress_handle_stop_stressing().
4. SIGSEGV handler is called and longjmp() is executed.
5. stress_handle_stop_stressing() can not continue because
   longjmp() does not return.

Therefore, timeout (SIGARLM) processing in stress-ng fails.

Please try
while true; do stress-ng --mprotect 1 -t 1 -v; done
with cygwin-3.7.0-0.88.gb7097ab39ed0 (Test). In my environment,
stress-ng hangs in dozens of minutes.

Could you please have a look?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
