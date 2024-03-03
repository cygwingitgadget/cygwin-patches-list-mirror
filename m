Return-Path: <SRS0=daNV=KJ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id CBE783858C55
	for <cygwin-patches@cygwin.com>; Sun,  3 Mar 2024 09:34:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CBE783858C55
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CBE783858C55
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709458499; cv=none;
	b=s01vTatFJpCGGGTYm+zxlUof3xjL98PiI2YsgT1S+bbDwbcTSOn7KQSDfR7MZNwkYxb7GGHReypf+NMUF3MUhGKT2TQcoZad4eCmkXgLYtYfqw9smJB9JnFWXOj5Lu6Aai1MoGb6U1Sqj75Qeju5rvyEiBxn1VmcDvCye8jh0jU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709458499; c=relaxed/simple;
	bh=DJd94nZfLGYPZhjqnMkc1Fo467Ou7Ps4yRSFgQliGJk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=BOqhmW36YxO2iidIeNQF6/IvToFu/Rpu2ih6xQpeKa0cZZNg6ivHTA+yjXx06SfbpAHRaPw0trNa80+/ECzyvRWXnbfiEn75hYwcdwft2iB3LibGL2cyvvV/xD0xqzt8Ov/Q7vRPgxRzm9lMUmcq4ipIZKTtW9dcJBozugjHGuE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709458487; x=1710063287; i=johannes.schindelin@gmx.de;
	bh=DJd94nZfLGYPZhjqnMkc1Fo467Ou7Ps4yRSFgQliGJk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=RndwZEyq/7rAHSeJTbJNwP3J1j5Ht0frXwNss+0sjZ7IJDkZERDE5FXLoABlPtiH
	 hs9bz5zXVAtAlq+ErRbvU7vAT0NLHw2TuMsD3NldmcRnnhno97LJ214nPEg+sMDLE
	 jgW3utlarnwYF6HgpW2FgVBrcHBogenC/QN+mroVflmejSRkWMW3qc/zNpv9zLwzZ
	 wB+Vn+mghmzuuVyC8MTAzjjZ8ykGFMBGGUleBN+P4SsQF14aiCRnd7p5aX3CLO04G
	 TBcyNJjMhkSAqOzcI+NLXXKzBS6o0n3ew4cAxG43ca/i7gkKxicJitIITzlBX3HL9
	 0kwYOyea6zGBHd4QhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.33]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1rSMFP18Lc-00N9U0; Sun, 03
 Mar 2024 10:34:47 +0100
Date: Sun, 3 Mar 2024 10:34:44 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Takashi Yano <takashi.yano@nifty.ne.jp>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
In-Reply-To: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
Message-ID: <b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iFRPYQiKsBVRuAl6KuQTjQw+AI29DGLwlqcdqa4thGrTfMX/kIT
 r4XcWV7AbSxj/q7Udcc4IhBMXXxzP0t/lWjMBo9IDF0q9ITgXsNIG4ZmykVQCOynBqCjT8q
 0jN7qwIL46H6tud2kiGgGrOlBR91jFXiobhnd2Swf3qr5TWtgRzeqDttaMZVnCn8rXgR0qr
 EI/5HKtBgouT3dEddVsGQ==
UI-OutboundReport: notjunk:1;M01:P0:7CI3SV8EHxM=;jscapXriieMA41xpMOIdYrpvc7c
 +gU2y08MdZlYv6/pkeNRyhXCowTrY5S+1SgBG8eSQYeH1qOkNApaZANtvs3O535Txd0GKwo8O
 9A6p9MHwNbrOxr9tMdAZChNgsWdijlf4NZQ2Iv1niLI6hAA22m7o8TMLbWhB5naEJ74xmJbDk
 /jndVZIPxJa87UGPGVJ7NRGp47RW/lGonKkxqkR8wfFyp8WTkrLbC+knInH2MUoKG+Dg43YQ0
 IS+/sTLxQzb6fP19cuq/U5FI7Yi6XlgL1bW1nR8+21hdafdOfBYkLWmgDKoXsBDjPlL/JOFZf
 ZouEBFjdgCgJ/sXg/p7lBdw/OFKjHBI0xESXYDY+ZB6JWd/5nJN3mPtKMtuLlsysdBCdzmH24
 ICXN2Oyb+X5cmyNF6BXGozB9Oe/i5zYkXtRE/TMDGtyu6Wj1yWW0Pe0PBMCVSbl66GBwx46L4
 tet7dHTa2YAQpTU3XyYp8KBZ7QEoBejSG7MT3xKi6llY4Qa1JOh3fmzJqQcqc/LoCcGaNhi9d
 0HqDQ9oycLxnR5UhMixlg7mu2pkpEb/Rdgc7HSsiMA8qQSrAnFG/oytBk9Wdfo2YoizzgBE59
 /Ix21CmgJob5naLa+BsCF9OLpZjmJqs3x9rIozCjUnHjRI0qx+bu+nWPMQRfLv5+WjutwN6U/
 neSHBJSHSslm+cuNGOomLLFXw0KnScTo+vK3TRtC/0usPe6+DHh5LgcFmO9NiP1S/CYahbU4I
 iWUEjWmAElZgBZ72ZmQ+eUavA1AtV3aEtpdo4fHDOztSyL6W13JFFp7SQOWl6g6hcFmjnhOIO
 1DoTFICaQgo628uyAIJnErJfO3wcSugasuKBdIZIrWbb4=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

thank you for the fix! I can confirm that it addresses the problem
demonstrated by the reproducer in that MSYS2-runtime ticket.

After noticing that we enumerate all the processes (which is an expensive
operation) just to skip all of the non-Cygwin ones anyway, I wonder if it
wouldn't be smarter to go through the internal list of cygpids and take it
from there, skipping the `SystemProcessInformation` calls altogether.

Ciao,
Johannes

On Sun, 3 Mar 2024, Takashi Yano wrote:

> Non-cygwin app may call ReadFile() which makes NtQueryObject() for
> ObjectNameInformation block in fhandler_pipe::get_query_hdl_per_process.
> Therefore, stop to try to get query_hdl for non-cygwin apps.
>
> Addresses: https://github.com/msys2/msys2-runtime/issues/202
>
> Fixes: b531d6b06eeb ("Cygwin: pipe: Introduce temporary query_hdl.")
> Reported-by: Alisa Sireneva, Johannes Schindelin <Johannes.Schindelin@gm=
x.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc | 10 ++++++++++
>  winsup/cygwin/release/3.5.2    |  4 ++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index 1a97108b5..95c2f843a 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -1241,6 +1241,16 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *=
name,
>
>    for (LONG i =3D (LONG) n_process - 1; i >=3D 0; i--)
>      {
> +      /* Non-cygwin app may call ReadFile() which makes NtQueryObject()
> +	for ObjectNameInformation block. Therefore, stop to try to get
> +	query_hdl for non-cygwin apps. */
> +      pid_t cygpid;
> +      if (!(cygpid =3D cygwin_pid (proc_pids[i])))
> +	continue;
> +      pinfo p (cygpid);
> +      if (p && ISSTATE (p, PID_NOTCYGWIN))
> +	continue;
> +
>        HANDLE proc =3D OpenProcess (PROCESS_DUP_HANDLE
>  				 | PROCESS_QUERY_INFORMATION,
>  				 0, proc_pids[i]);
> diff --git a/winsup/cygwin/release/3.5.2 b/winsup/cygwin/release/3.5.2
> index 7d8df9489..efd30b64a 100644
> --- a/winsup/cygwin/release/3.5.2
> +++ b/winsup/cygwin/release/3.5.2
> @@ -5,3 +5,7 @@ Fixes:
>    is already unmapped due to race condition. To avoid this issue,
>    shared console memory will be kept mapped if it belongs to CTTY.
>    Addresses:  https://cygwin.com/pipermail/cygwin/2024-February/255561.=
html
> +
> +- Fix a problem that select() call for write-side of a pipe possibly
> +  hangs with non-cygwin reader.
> +  Addresses: https://github.com/msys2/msys2-runtime/issues/202
> --
> 2.43.0
>
>
