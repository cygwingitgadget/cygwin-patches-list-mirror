Return-Path: <SRS0=WkfY=HQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 132944BB3BC7
	for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 20:27:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 132944BB3BC7
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 132944BB3BC7
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790281678; cv=none;
	b=tjMRubJvkF6hlpROHDmhkrn6fKwHAEVdsqd9CrWkwGngtZ7e8RI+NgE6MAQ/g2n+N1TfBk1uaWhwqTII3qQSHeqn4W9XCPEQUMPL5A1+TfbT+hK1n0/95GQw9E62M1otjD61VzCN77UnJAjtCzGNYuJSBDb2LwjRq0x3i4gwzYM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790281678; c=relaxed/simple;
	bh=WiF8Od/xwrtnSErK8tUBOGYwM0Jr2aPOxMWJU0TqusU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Kva0s0+DkxQ7oe8myfAHIDgkQ5dk6w41kmiWAOqTyxQ+hIpttKW7b1mZbKotFEaM26M+lkwWw4lxdX1HAUfgvFvDstikbxLBCCtLJ7bEpxMD8QTEpwZrKNYXZgAJ5iMa++Nk6fpHRS6BzJUYOzufaF1h9dReFEFxy7enCJ/Tupk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=MKQLwxkF
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 132944BB3BC7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=MKQLwxkF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790281676; x=1790886476;
	i=johannes.schindelin@gmx.de;
	bh=ZUd/JstVwjwMksvboNbcaEfJ4+Keo4U4ZtswIu2bqiQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MKQLwxkFm0opof7qECwqGEzZdGUnlhkSltKONquexWgvdZKG9hDojYPRUnNsqIyY
	 zriD+teXDVcZhaZokORf1TRV0vq7uCXCpFVSlGlMGtgBl5d7AD6iPQF/4FrL6OTX+
	 uPcj8C3vAkNU9kDJmNIESNu+AeZFiFtR9QE42HpmqiPljhABwqkMsi1vOMPqc49CA
	 QizyFqK9MKg+4zi/+xPUMFjkuIQNkfqZoWYPk1BW8ySwRVk3MFQuYm5i0HVKY5k01
	 MsvuvEX8P7y/GuFtxj2c3K8yQg/tn2CDPLWMnyfvv87MoUBNtmFp8L1OzscN9+clx
	 8etIVBz3arAVcqmGag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGeB-1xJ0qV1zMZ-00KUSC; Thu, 24
 Sep 2026 22:27:56 +0200
Date: Thu, 24 Sep 2026 22:27:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <20260915095532.531-1-takashi.yano@nifty.ne.jp>
Message-ID: <f2c176e8-657e-1592-3b32-347ea0fddf14@gmx.de>
References: <20260915095532.531-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:Vj4XuPPnD7iIKQH0zPjh0B/2UAymvacIoNByPq1Cp4TJn27QDbN
 HhuYS4eDETxweyG8HltWFwWd/cjmULiscUZlPdl3UTtOfIplqNpfD+39OJWNERvdJPioRB6
 hTR2zdsElbJZR1oFG1J4PChCi46notpbyR+RipjhPYKWDlasQskPJQ+xvDeH948Mwpx7O5m
 ThuBKFZZfRHLT8JgCkktQ==
UI-OutboundReport: notjunk:1;M01:P0:CjWmiWwmes0=;vHSxhiUf7figLdq6A+eSmtQcx12
 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
 b4aJlFPcK9rck3lOg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 15 Sep 2026, Takashi Yano wrote:

> Previously, peek_console() used PeekConsoleInput() to confirm whether
> the console input buffer has some input records. However, this need
> attaching to the console if the process does not attach to the console.
> To reduce that overhead, this patch uses WaitForSingleObject() with
> console input handle instead. WaitForSingleObject() works without
> attaching to the console, so this simplifies the peek_console()
> code.
>=20
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Do not remove PeekConsoleInputW() call.
> v3: Revert to v1 and check empty buffer in process_input_message()
>=20
>  winsup/cygwin/fhandler/console.cc       |  3 +++
>  winsup/cygwin/local_includes/fhandler.h |  3 ++-
>  winsup/cygwin/select.cc                 | 34 +++++++++++++++----------
>  3 files changed, 26 insertions(+), 14 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 0b0f11ee6..660fd3c41 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1494,6 +1494,9 @@ fhandler_console::process_input_message (size_t le=
n)
>    if (::input_ready && (len =3D=3D 0 || (get_ttyp ()->ti.c_lflag & ICAN=
ON)))
>      return input_ok;
> =20
> +  if (total_read =3D=3D 0)
> +    return input_empty;
> +

This change affects both callers, `peek_console()` and
`fhandler_console::read()`. Does the latter also need to be adjusted (it
would treat `input_empty` as an error, right)?

>    for (i =3D 0; i < total_read; i ++)
>      {
>        DWORD nread =3D 1;
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 392864ac4..341a326a6 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2193,7 +2193,8 @@ public:
>      input_processing =3D 0,
>      input_ok =3D 1,
>      input_signalled =3D 2,
> -    input_winch =3D 3
> +    input_winch =3D 3,
> +    input_empty =3D 4,
>    };
>    typedef cons_handle_set_t handle_set_t;
>    HANDLE thread_sync_event;
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index 48f66c954..212fd7127 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
>        return 1;
>      }
> =20
> -  INPUT_RECORD irec;
> -  DWORD events_read;
>    HANDLE h;
>    set_handle_or_return_if_not_open (h, me);
> =20
> @@ -1161,29 +1159,39 @@ peek_console (select_record *me, bool)
>        else
>  	{
>  	  fh->acquire_input_mutex (mutex_timeout);
> -	  acquire_attach_mutex (mutex_timeout);
> -	  DWORD resume_pid =3D fh->attach_console (fh->get_owner ());
> -	  BOOL r =3D PeekConsoleInputW (h, &irec, 1, &events_read);
> -	  fh->detach_console (resume_pid, fh->get_owner ());
> -	  release_attach_mutex ();
> -	  if (!r || !events_read)
> +	  if (WaitForSingleObject (h, 0) !=3D WAIT_OBJECT_0)
>  	    {
>  	      fh->release_input_mutex ();
>  	      break;
>  	    }
>  	}
> -      if (fhandler_console::input_winch =3D=3D fh->process_input_messag=
e (0)
> -	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> -	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
> +      switch (fh->process_input_message (0))

Here, `input_mutex` is held while `process_input_message()` is called. And
then...

>  	{
> +	case fhandler_console::input_processing:
> +	case fhandler_console::input_ok:
> +	  fh->fix_input_mode_if_necessary (); /* for win32_input_mode */

... this call waits for `cons_mode_mutex`.

Another process can concurrently enter `tcsetattr()`, acquire
`cons_mode_mutex`, and call `set_input_mode()`, which waits for
`input_mutex`.

These processes now dead-lock.

Maybe `input_mutex` should be released before calling
`fix_input_mode_if_necessary()`?

> +	  break;
> +	case fhandler_console::input_winch:
> +	  if (global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> +	      && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
> +	    {
> +	      set_sig_errno (EINTR);
> +	      fh->release_input_mutex ();
> +	      return -1;
> +	    }
> +	  break;
> +	case fhandler_console::input_signalled:
>  	  set_sig_errno (EINTR);
>  	  fh->release_input_mutex ();
>  	  return -1;
> +	case fhandler_console::input_error:
> +	case fhandler_console::input_empty:
> +	  fh->release_input_mutex ();
> +	  goto out;

This treats `input_error` in the same way as `input_empty`; Would this not
let `select()` swallow errors? Should `input_error` not rather release the
mutex and then return -1?

Thank you,
Johannes

>  	}
>        fh->release_input_mutex ();
> -
> -      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
>      }
> +out:
>    if (fh->input_ready () || fh->get_cons_readahead_valid ())
>      return me->read_ready =3D true;
> =20
> --=20
> 2.51.0
>=20
>=20
