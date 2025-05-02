Return-Path: <SRS0=mLRr=XS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 9C6763858D20
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 11:31:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9C6763858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9C6763858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746185507; cv=none;
	b=wQfgHIExz4x8vMwLAfft4ry2W1AvLGbhG7LrXIbZ2OisWCPHqg97pdzAfzNcoAmFdgXgAhzOwkOihZPO6Iv4zpZtDw/4Sd9S1DnyQruJ3RCvpY+9FxMI7j+uo7h2bJlWYi2ZVNMHww8xb9s5TpBTYDtPGJDkEwdAU/WllV1XefE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746185507; c=relaxed/simple;
	bh=erbXKRON4Fy1CteF3FpRr0mxKXOui5mvrfbZPqVZyH4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ASAd6PHziTA4ORkiacWKLoaLBMqyPDN6K67++SU6w3jBISRCKEjZ5twX0xnu0ps2pdFAR/o7KSBeKaNvH9eG+stN3G+y+xek3eEC6EN/qWfDmYcRBUy+zdOnoz8Q8Wpu0ESZSyBnSMaeizKPhHe8+mnprsSXPYRdCIsokWvfmEE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9C6763858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=O92fe9K0
Received: from HP-Z230 by mta-snd-w01.mail.nifty.com with ESMTP
          id <20250502113144573.LHH.91923.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 2 May 2025 20:31:44 +0900
Date: Fri, 2 May 2025 20:31:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
Message-Id: <20250502203144.ca3ba0953ce5bb9f97267920@nifty.ne.jp>
In-Reply-To: <4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
	<20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
	<4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746185504;
 bh=D3tHPOEqWRqBMezpT5lwAfRbB8iwb/rK8G5W0uXSZtA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=O92fe9K0DPfeKNtf21Uw5PaZDAqHXdQ9s6EMDtbUkSe+OPLVG4M55ODpLmd0cORcJ1Vuhf7D
 +0eBgOFbJvZsXZiN8u7i585Xt6vcr6bR9HiZDkgphLrMMmzQXIRAtdvGUAYeU9pGEEYDFlDLzj
 g/fRShFhhC+/8ffR9gJgd/eo9Q6xKtB+xENq1ttQSKamExeco1ICBNGlV6rbDV8IbdK0r5ke70
 48k1q3zNl7RR/X1f89o0umWvlrfrYR8Nagtq+WFqOcSXSt8N+gLlUklJ33eznEuV4+f4o03/VK
 Fu/Rk7OC3dwmoSTRJpVvxmvO1sLXyxWuBRRli6mAaboTUAhA==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 15 Apr 2025 11:02:37 +0200
Christian Franke wrote:
> Hi Takashi,
> 
> Takashi Yano wrote:
> > Hi Christian,
> >
> > On Fri, 11 Apr 2025 16:46:07 +0200
> > Christian Franke wrote:
> >> In rare cases, '/bin/kill -f PID' hangs because kill(2) is always tried
> >> first. With this patch, this could be prevented with '/bin/kill -f -s -
> >> PID'.
> > I wonder why kill(2) hangs. Do you have any idea?
> 
> Sorry no. I observed this in early (Cygwin 3.5.4) testing of stress-ng 
> for ITP, but could no longer reproduce it.
> 
> Here are tests which currently (3.7.0-0.51.gd35cc82b5ec1) ignore but not 
> hang kill(pid, SIGKILL):
> 
> stress-ng --mprotect 1 -t 5 -v
> stress-ng --priv-instr 1 -t 5 -v
> stress-ng --sigchld 1 -t 5 -v
> stress-ng --sigsegv 1 -t 5 -v
> 
> Run this in another window to see that child processes are left behind:
> 
> killall -v -9 stress-ng; sleep 4; taskkill /F /T /IM stress-ng.exe
> 
> For a minimal testcase regarding --priv-instr, see:
> https://sourceware.org/pipermail/cygwin/2025-March/257726.html

I could finally fix this issue. See:
https://cygwin.com/pipermail/cygwin-patches/2025q2/013696.html

> > If kill(2) hangs in some cases, shouldn't we fix that
> > rather than patching to kill(1)?
> 
> Of course. This feature was intended as a first step for an 'onboard' 
> tool for the CI tests suggested by Jon Turney. A second step could be an 
> --all option to replace 'taskill' or 'pskill'.

Do you think we still need this patch even though the issue
above has been fixed?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
