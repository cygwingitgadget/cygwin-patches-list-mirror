Return-Path: <SRS0=+fqX=DZ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 687D84BA540B
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 13:38:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 687D84BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 687D84BA540B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779975530; cv=none;
	b=SZ8hLtWKzTSkcKcB9sujOEwCB64UPGqut8fmIrjEcvdnWmAAr0+JQn9mFr01awiPdQJOv5gN39wN4SdHqYBF/HaP0jgnmugFnJ1kbq280tFW576mmxOpdzuoEAztjkLZjiDrpzLBlzz7YobtuNheXMEBgzZZXQvOzyIq3bv3KJE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779975530; c=relaxed/simple;
	bh=sTid6KVGR1Zue4uBwiP821Uv+D4rZC11NMR4Gkdpxj0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=P/A20DSEg6HpLb9+fvojJB5Q3KkXX50AmH/zafzEZabTrypqSOMhFAfYwnj219b+UfTmZAV5yyewu+lB2D27Qy2uG0JQjvrfL3yGYCFz7Ru9kWUmnZbGuyDUkoKKGq82f7kMa0pB3oijLX0i5UsWCELTlHhUFGptokplENxEMKM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=djJdIfnc
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 687D84BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=djJdIfnc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779975529; x=1780580329;
	i=johannes.schindelin@gmx.de;
	bh=RVxnEx7OfbditErB20qsJUPAUyQswHhVkVBUJ5VJn4Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=djJdIfnc4wzie8AjzJxc4H8F/gpvIuDEU4SVl0jcgspIbxQbTxpso/ThEq2cB4Cn
	 8eAgYa+TEDeaP/Rao1zB0SzbR9/Qx774z5Y+ytC2TtNHxJOJfppatz1zOLKNBK1rN
	 4xYICgxPFH6M8B35jEMNnZLWgSyLmNzbd/hO3TmGdOT+H0RxAzgbQogXY5Ubx/hkv
	 hR+rPVdAZukh37BDjdifG1ahDUrCqBKDG+RAk6xMcCkzbRNLMi2tfkuLDGuhIBu8i
	 UaID88yZL+0y0506SWYuBimonauX+Zga4fBmHRBxK2wCIIZq+MBAZjwX0ObirSzwP
	 q2ladblLL0eb9mNXzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1wOlSs3jd4-003DAZ; Thu, 28
 May 2026 15:38:48 +0200
Date: Thu, 28 May 2026 15:38:46 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix deadlock in console teardown that
 arises from pcon
In-Reply-To: <20260521212621.130760-1-takashi.yano@nifty.ne.jp>
Message-ID: <86c4329d-ee10-4c9a-be10-f8b8de78a6b5@gmx.de>
References: <20260521212621.130760-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hQJGd+btAJJHLeMyUM2dVazW63gXCqldV0j1XCiSuquqq9LWs8l
 bKF9eFQZcrNm5WRSliAI/gjmeMglJoRSrPMelyFaMnB+wVP73e/vYSLzgojeNtohmpJaC7a
 Fo8jp9SWl/jrmJbnk13sRHIdmMBzPPwvBUlzo4TFNSCa1Pl4zWRmeYOXuuglsdxYW6A7UCl
 TfR+ML48oEe6TCqlmWDJw==
UI-OutboundReport: notjunk:1;M01:P0:MGWu4awihuM=;FTyQSE3Djxovo76/ZXG3ktpopME
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 22 May 2026, Takashi Yano wrote:

> When a console process originating from a pseudo console exits, the
> current sequence is as follows:
>=20
>   1) atexit handlers (pcon_handover_proc) called. This also closes
>      parent_pty_input_mutex which is introduced by the commit
>      c4fb720afcf1.
>   2) close_all_files() is called via _exit(). This terminates
>      cons_master_thread.
>=20
> parent_pty_input_mutex is referenced in cons_master_thread, so
> cons_master_thread may still use the mutex after it has been closed.
> This can lead to undesired behaviour, including a deadlock. Instead
> of registering pcon_hand_over_proc() as an atexit handler, this
> patch calls pcon_handover_proc() at a point in fhandler_console::close
> where cons_master_thread has already terminated, ensuring that no
> other thread accesses the mutex.

Thank you so much for this excellent commit message, which motivates the
patch well and preempts all the questions I would have asked about the
code changes.

The entire patch looks good to me!

Thanks,
Johannes

>=20
> Addresses: https://github.com/msys2/msys2-runtime/issues/338
> Fixes: c4fb720afcf1 ("Cygwin: console: Use input_mutex in the parent PTY=
 in master thread")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index c76347f6f..6fd4cd965 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -2018,7 +2018,6 @@ fhandler_console::setup_pcon_hand_over ()
>  	if (get_console_process_id (owner, true, false, false, false))
>  	  {
>  	    inside_pcon =3D true;
> -	    atexit (fhandler_console::pcon_hand_over_proc);
>  	    parent_pty =3D i;
>  	    parent_pty_input_mutex =3D
>  	      cygwin_shared->tty[i]->open_input_mutex (MAXIMUM_ALLOWED);
> @@ -2157,6 +2156,8 @@ fhandler_console::close (int flag)
>    CloseHandle (output_mutex);
>    output_mutex =3D NULL;
> =20
> +  pcon_hand_over_proc ();
> +
>    WaitForSingleObject (shared_info_mutex, INFINITE);
>    if (--shared_info_state[unit] =3D=3D 0 && shared_console_info[unit])
>      {
> --=20
> 2.51.0
>=20
>=20
