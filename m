Return-Path: <SRS0=d6ad=WV=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id B61B13836EB6
	for <cygwin-patches@cygwin.com>; Thu,  3 Apr 2025 14:35:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B61B13836EB6
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B61B13836EB6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743690915; cv=none;
	b=Kf8m+CmKAcd7OSo90RpFhoV57t9vFzVvZt0L7m1sSRdmAVPTeyfXh7F1j0OiJLccVtl17wNxMcKbXO7+tr34GL1Kx489jWHCSZIeumQA91pMZ7v5yNoHsQYyg6JMV953SE+xDprzL0Bg1k17cJkVnJkilvMp4Ig9ZfAxJ6dUrBc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743690915; c=relaxed/simple;
	bh=WbMlMiHiDjAvb7ffqcY6leIAEDoEGlrEh8Y+Jt4vhY0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=xIg7mPugkeuBof2RR/gupZNKTlneyMeOw3H29K4zfoM+wLIu/noempWYtfYAwYJ+3jXKQnsthVSdzoWVFaRxJahKtF+Rp4YQUJEVbmjjyvd18jJ5Um5rPN50ljdntFvx2pQoGGO7vNg+ywrNPJQL4ghjiC6FMoPDjAh0zYk5aVw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B61B13836EB6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=td7EEk/4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743690908; x=1744295708;
	i=johannes.schindelin@gmx.de;
	bh=tqs81dua9aiY4hElV/t/6T4iiYK372c/WwmjDlwdevc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=td7EEk/4HPA+5TvTfMddmebYq8Opgv8WN/AYZhgCTi1Y4MCpzKy9z6uW18ypK9yb
	 wk5ULW8I4pumys63+1R49a+W1gy8kIegl30RafLkjwj+OCXYr/b4AesT4McuST6Up
	 NrI0FmiEdp2uBx8xAE4/m3J2lFuQsZetcOq0+p9gPF7gq/lUceZ/aBo+HX3vsAuhY
	 qWH39lJBYOd9AzWbIPGX0UNf6VmibjFShi+fMmRDx1GwlG2svHLvyJ0ZnBUHpQ0OB
	 AhIsGKA5W3ba7nB4w9wgquILw0QyNtNFNY9j3H+SRcTPknqUU7/MxBdy6l5Efl1/I
	 c9dREDVmUbSyoJmAFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1tYwv211Yi-00LqlI; Thu, 03
 Apr 2025 16:35:08 +0200
Date: Thu, 3 Apr 2025 16:35:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Christoph Reiter <reiter.christoph@gmail.com>
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other
 initializations
In-Reply-To: <20250403083756.31122-1-takashi.yano@nifty.ne.jp>
Message-ID: <969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bKTZ69V6UZrOxcOCeGjYNArJBOrGhb/zJnuVh+JEOtkHVmGx0+g
 bkj72mIKtzLLBsNo0j28x5EEQ0cZJpWI7gCuo+uBTq+5dFcFGcWG3eunkB4JK9Cxq4Ao7fC
 FoYqA6Ogu5guZvqODBZLGnBpZl13RAJ0BoVYrmrHQngURrBXpHlyqQnsZgol9GKyJf07Mqa
 zFI+KLJ2tnCojQ36p+aaA==
UI-OutboundReport: notjunk:1;M01:P0:cr+O58d0O+k=;xiuRNzkCLMRcvtC7apxkodFBY5q
 VXIsdT8hy+Yi2Qmxl87HH7YD3oIMG7t1HQZLsebBIVeqn0g+ERx4JZUnew932zF8YHdrLnQUI
 KPQ8xRzpeYvVgtzSZDmXoPlWlx4Gc47TyqtJGq+jQkJSmKPElhVvJW6rFOuiCTyIbrQ5pYADY
 H3F/urssLVFdQpMOWgjMsSNBQA2i15iPpEXwSremA2h4lnTDBTE2s2bQbShDCBjpuLHCVqnBL
 mW832G4QBh1hvKOnUyOrxc0XP8lOBb8k+3G4CWl4pMybfzFFtgy7Wo3wVzdwPxsvNxdpUCMMi
 WgkY8KrdkAROs9iSMG+1VNrm+3jGUVWRI4Ttrq1pYuFb5RrwaOgbz79qSP2Avj7udS8+hjB2K
 HJu8Dvg+ui/M/PzyUvonKXbmU5knpzd/P2e7gI63NPqVFPQiZa/FRgelK5jb86Gw9qZ9lOK81
 aSExI8Xj5R1BpRBRFxvuhra2ClXeO0+HSKvbJjP0OzEBaz5ytrbOsr9+EpXCKxncddX4ZHqKQ
 g2MtEmZsApJ/XEABarcz6r+Vb4DcAFA7Q5DQ0bN1ux5HI7PokZwl9zz/mHZgRMvKisvYndpDc
 BP1Y/rTPt2CvKOrca12pZQTsfdFbqafFaAg81gyGjpK6cIM13NHb7+ZLsbZxJA9jgwQUK6w9h
 IkghACHvXe72ZL+XMhWcu95usJC2sDXwnT1g9gbT+QXZ/53bJC24mcNAChF+i63f17FlVJAO9
 YYMyPoXWZrbWlsK4DTBEkbL5GpG+A3FDWfQeu38QFhet0YNXJeYut7bGdnVoYXJ0Pw8n4Lw9i
 Oqp46exn2rxsT/P+LwfLLDzyVQIezmhi+oAQUFGU8BEJKh1IgnedhCawVYNocn3oYOeBqGRe6
 QPZ2Vsdq1QRHUHxDhUanX5kDbsXku/KgFJfj3Xghev+lO/0GDxCSEtzzb+s0wdWhK498JTn1O
 cSCbQg1hUVO0XXC52JlJ5F/XCralDUvqoXKFr7/2wHtrqO1M8YP9censn46TAqqILh40kTZhy
 Y6i2yXx3/R6rRrIst4Wb2fq4d3v0vnzw3DC0c363v9gp0Quig/gHjYBBgHLOYtlq4P1uhGSAN
 +kDbAibGqXyTme5YB4HXkNVyEar4ihJ6eCTMbNwUNiHAIHlAhJJv62UmVPxztymkm69WxB08w
 u6BgLveMnZRwDsxzQBcOW4CLDlGMoa1JEuefjPlJQBQ85GT80ISu0myXA3IT7GvqXcmLda3/8
 gLYujH6F43375egGuFjb57INdHpHJxWdAyLzHQIUKepy4WqoZ94/iijvH2rjFB7P06uaNPl3h
 phljwX3Fe9x1+WYVMOPdXfoI4/F1z+OsMzrmD8T/MKPqLjfFNFEHRWt8gaKAXB20Qu1B0Vd1j
 3LaRYmoQQhfsHC2A2JrkgKuUHUSkPUn6McHSvA7o+ePU9vJWZZbX4UfUyIAdbF+UA/PbPVSGa
 ul5ZCF1fPL9YAe34RRKoQ4ZegIocsKHzBT5cXAQzFVMJGc26+aP3enCdYLYPHPqWJhRx3/G0Q
 cQcBPA1nskWTn1Up/tcnwd0a1Lf3xZxThbOYF4oa
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 3 Apr 2025, Takashi Yano wrote:

> Previously, the callback registered by pthread_atfork() is called
> before _my_tls.fixup_after_fork(). This causes misbehaviour if the
> callback uses tls related functions. Due to this problem, subprocess
> of cmake (> 3.29.x) sometimes fails after the commit 7ed9adb356df.
> The commit 7ed9adb356df triggers this issue, but it is not the issue
> of that patch. This patch moves the pthread::atforkchild() at the
> end of the fork::child().

That's a good initial draft. Let's expand this a bit with the information
you provided in
https://github.com/msys2/msys2-runtime/issues/272#issuecomment-2775398477:

	The event handle signal_arrived is initialized in
	_cygtls::fixup_after_fork() but pthread::atforkchild() calls user
	callbacks before _cygtls::fixup_after_fork(). This was the cause
	of invalid handle. cmake uses thread_atfork() and print something
	in the user callback. fhandler_fifo_pipe::raw_write() calls
	cygwait() which uses _cygtls::signal_arrived so
	pthread::atforkchild() should not be called before
	_cygtls::fixup_after_fork().

I still have a question that I would like to be answered in the commit
message, too:

If `signal_arrived` is only initialized in `fixup_after_fork()` but user
callbacks that use this are called by `atforkchild()`, why did this not
trigger _all the time_ before your reordering of the calls?

Ciao,
Johannes

>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257800.html
> Addresses: https://github.com/msys2/msys2-runtime/issues/272
> Fixes: f02b22dcee17 ("* fork.cc (frok::child): Change order of cleanup p=
rior to return.")
> Reported-by: Christoph Reiter <reiter.christoph@gmail.com>
> Reviewed-by: Jeremy Drake <cygwin@jdrake.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fork.cc       | 2 +-
>  winsup/cygwin/release/3.6.1 | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> index 783971b76..f88acdbbf 100644
> --- a/winsup/cygwin/fork.cc
> +++ b/winsup/cygwin/fork.cc
> @@ -187,7 +187,6 @@ frok::child (volatile char * volatile here)
>
>    ForceCloseHandle1 (fork_info->forker_finished, forker_finished);
>
> -  pthread::atforkchild ();
>    cygbench ("fork-child");
>    ld_preload ();
>    fixup_hooks_after_fork ();
> @@ -199,6 +198,7 @@ frok::child (volatile char * volatile here)
>    CloseHandle (hParent);
>    hParent =3D NULL;
>    cygwin_finished_initializing =3D true;
> +  pthread::atforkchild ();
>    return 0;
>  }
>
> diff --git a/winsup/cygwin/release/3.6.1 b/winsup/cygwin/release/3.6.1
> index 07a29ecce..5a15642b8 100644
> --- a/winsup/cygwin/release/3.6.1
> +++ b/winsup/cygwin/release/3.6.1
> @@ -31,3 +31,7 @@ Fixes:
>
>  - Return EMFILE when opening /dev/ptmx too many times.
>    Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257786.html
> +
> +- Move pthread::atforkchild() at the end of fork::child().
> +  Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257800.html
> +  Addresses: https://github.com/msys2/msys2-runtime/issues/272
> --
> 2.45.1
>
>
