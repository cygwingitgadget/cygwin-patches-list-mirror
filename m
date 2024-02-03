Return-Path: <SRS0=wrpf=JM=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 2670B3858418
	for <cygwin-patches@cygwin.com>; Sat,  3 Feb 2024 14:53:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2670B3858418
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2670B3858418
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706972023; cv=none;
	b=otvrG12UCe49sPjgKLyT+hda7y1+STUC81IGLjOY0GdJ5GucGKG/z8OhJ5S2nCuM+PgffL3aOGL1vfT1U8jdNqNN2FhtEIl2regTD8bKs7YqO0WbJ5CcXzk7gx2pwiBcGrHxfMrzkwQyyhLzC7dETCmLccLrYS/xgMJ4dmlLNms=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706972023; c=relaxed/simple;
	bh=Cq9vzWJTdDA0t2x5hWRLOh+bRMKhh7zjzcxwe7DYMCU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=K/kPE6KfuOzc+gzedEQSpMU7MWdtDbB/X6geBVUYK/9He/EYLXuZOA8rEVdemkkIaQnE766+lsjh2LyBQ3PHoaudc5qWd71F8ZxlbLbUq0O0da1fwVnAgSvHgLF/MQOREI+BULtXkYDOTyCEiK4LCr2slyX7tTvbcFAGz0+AXQs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706972011; x=1707576811; i=johannes.schindelin@gmx.de;
	bh=Cq9vzWJTdDA0t2x5hWRLOh+bRMKhh7zjzcxwe7DYMCU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=ruUYR104xiXPqLl1rbubExz7rjJI0TD2y6jdXXU4j5OHb0Zcbacm+zu1Nu4ashBV
	 nFbLU2ZC48YHXDUg684kIENdxBKkCt0sd162n+t4rvvEZcVkfq7Aau1PeLJy+Xe7o
	 SedIJw6bNWVQhaiya1vmlr42x8wzPcfpjsmeRdMAQcWkBRjdepAubirX4idLy+XR6
	 yEb5gkvhhdd8PB7xQCfJCPKTFg0jBZL+Dq3KJe0S+jwcWAA9/bsayUS8EZu4jOyVP
	 U4yL2qBWPwQxbeVQPBw2Q9ajSamz1fLLeJC7J1fEPkGliXhqyknGpyT13t8zlWaxq
	 6m1pZuU7Uwrbd0rA5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1rZX2727QS-00W0CK; Sat, 03
 Feb 2024 15:53:31 +0100
Date: Sat, 3 Feb 2024 15:53:29 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Avoid slipping past disable_master_thread
 check.
In-Reply-To: <20240202161827.1847-1-takashi.yano@nifty.ne.jp>
Message-ID: <c8c3a5c3-72b7-7e1b-3ddf-d399090b49a1@gmx.de>
References: <20240202161827.1847-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8GMdK5POAlHuYnDIdnnSs9LIkOlhDv8TYnn3pop3YpK+qVTgcJc
 fhYg9BCQ09oBXrX1YNBmtOSQmneM2ExcxzT5L/TMPeDMeHmlvot5iuKG5MG3O6kLAB3LRzc
 3GD0kvZghodk7ZJCkZm3gDsJGjdmKXtC7OWblJA/9R3eB2zUVyzfwJHWogKVICtovw1GF5G
 8JR2II3anVm/qJXhfpZ5A==
UI-OutboundReport: notjunk:1;M01:P0:nMybT8qFzQY=;uZbAU0SuKyB0NKh3tz7YfGCiHtU
 UFYmxO7SdvL5do69ci1QbesWdLSsHntiYc3bAIsciodYMIAZD+CHko8tbRsbtkjAmsDNOMxPm
 CbyC0CAVhlzxPJFxhMTDEa3jVqTfXC+pZGdT8wN84+J6RunB7BObpyNj03oEvxu9/yLLbvpMp
 SJogUnbWW86Rl+bIB7BZAlLfnXGSSHuU+I+w+dZhboE3ocaRq6aLd7PKC0T72aUZnIvnYwdgy
 S6Bb/wsOqVLXzgdN4o+33VtWg1UNv/oDUTAYwZHwRPHIcKXHtHmEn4si6vwTkCitirLrpfUHP
 85Z6UmPeNfsot/J+uSR1oVxCamDtkvyN2VBTVkeMhvYMDSiMKZDEBORbW0hq1MahsZ1jSNZmL
 Um8DRqS1iMptcNlzfRyUI2zVfpHMSLikxuu8iDof9Fu22+h9/5+q8OJ99VFSGu0SNDLSHjfP4
 +GADJjmn9imgEnmvkQaMZiAq15wBVGXKEG0jjG6tx7G7af4SMiMe/9nA5bBZpMO3IFfEc51Cj
 U70XHco/w0FqFPdcmZTinYubW5IC8iZRiCHzkbaBr2oPqxcwhcrrKNPOfFnn6RnIapgjTqBfE
 ZIqFP9kbLvxxsSTw/G46kzYkJFkVVE2+OtIs7XIjwvFIw1D2Puc6PkHtPC03IdOC9/TBZWGBm
 kW+J1m7vKZEthQJa+t1AeGYxE83ajBdshzEHwbgem8ZQExExEzc12DE4Lz5XYmXlo0i/IM/7c
 0bzk9XHKZQQhE11ch91W2krzYd/S1S6TU3F4cmkrlmVGc+W4/Kt1If6OpLPyRS0ntAsI0Q8kZ
 abiDnZdFvDvpk+NrDZXec2S2kn3lH9oETuiB1qjIrEBUk=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 3 Feb 2024, Takashi Yano wrote:

> If disable_master_thread flag is set between the code checking that
> flag not be set and the code acquiring input_mutex, input record is
> processed once after setting disable_master_thread flag. This patch
> prevents that.
>
> Fixes: d4aacd50e6cf ("Cygwin: console: Add missing input_mutex guard.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>

Thank you for double-checking this (and for finding and fixing the bug).

I wonder what could be a symptom of this bug. I ask because we have
noticed a couple of inexplicable hangs in GitHub workflow runs in the Git
for Windows and the MSYS2 projects, hangs that are almost certainly due to
the ConPTY code in Cygwin, and I hope to figure out what causes them, and
even more importantly, how to fix those. Maybe the bug you fixed in this
patch could explain this?

Concretely, the hangs occur typically when some `pacman` process (a
package manager using the MSYS2 runtime, i.e. the Cygwin runtime with
several dozen patches on top) calls a few non-Cygwin processes. Those
processes seem to succeed, but there is an extra `pacman` process left
hanging around (reported using the same command-line as its parent
process, indicating a `fork()`ed child process or maybe that
signal-handler that is spawned for every non-Cygwin child process) and at
that point the program hangs indefinitely (or at least until the GitHub
workflow run times out after 6 hours).

I was not able to obtain any helpful stacktraces, they all seem to make no
sense, I only vaguely remember that one thread was waiting for an object,
but that could be a false flag.

Stopping those hanging `pacman` processes via `wmic process ... delete`
counter-intuitively fails to result in `pacman` to exit with a non-zero
exit code. Instead, the program now runs to completion successfully!

Most recently, these hangs became almost reliably reproducible, when we
started changing a certain GitHub workflow that runs on a Windows/ARM64
build agent. I suspect that Windows/ARM64 just makes this much more
likely, but that the bug is also there on regular Windows/x86_64.

What changed in the GitHub workflow is a new PowerShell script that runs
`pacman` a couple of times, trying to update packages, and after that
force-reinstalls a certain package for the benefit of its post-install
script. This post-install script is run using the (MSYS) Bash, and it
calls among other things (non-MSYS) `git.exe`. And that's where it hangs
almost every time.

When I log into the build agent via RDP, I do not see any `git.exe`
process running, but the same type of hanging `pacman` process as
indicated above. Using the `wmic` command to stop the hanging process lets
the GitHub workflow continue without any indication of failure.

Running the PowerShell script manually succeeds every single time, so I
think the hang might be connected to running things headlessly.

Do you have any idea what the bug could be? Or how I could diagnose this
better? Attaching via `gdb` only produces unhelpful stacktraces (that may
even be bogus, by the looks of it). Or do you think that your patch that I
am replying to could potentially fix this problem? How could the code be
improved to avoid those hangs altogether, or at least to make them easier
to diagnose?

Ciao,
Johannes

> ---
>  winsup/cygwin/fhandler/console.cc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 6a42b4949..1c8d383cd 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -420,6 +420,12 @@ fhandler_console::cons_master_thread (handle_set_t =
*p, tty *ttyp)
>  	}
>
>        WaitForSingleObject (p->input_mutex, mutex_timeout);
> +      /* Ensure accessing input recored is not disabled. */
> +      if (con.disable_master_thread)
> +	{
> +	  ReleaseMutex (p->input_mutex);
> +	  continue;
> +	}
>        total_read =3D 0;
>        switch (cygwait (p->input_handle, (DWORD) 0))
>  	{
> @@ -4545,8 +4551,6 @@ fhandler_console::set_disable_master_thread (bool =
x, fhandler_console *cons)
>  	return;
>      }
>    const _minor_t unit =3D cons->get_minor ();
> -  if (con.disable_master_thread =3D=3D x)
> -    return;
>    cons->acquire_input_mutex (mutex_timeout);
>    con.disable_master_thread =3D x;
>    cons->release_input_mutex ();
> --
> 2.43.0
>
>
