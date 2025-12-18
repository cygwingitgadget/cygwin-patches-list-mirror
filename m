Return-Path: <SRS0=Z/EC=6Y=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 479464BA2E24
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 08:56:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 479464BA2E24
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 479464BA2E24
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766048202; cv=none;
	b=jsZPnDDU7LCHwqi3Q7vCxEOIxR0OhWJYVUcCKIcl2UgqFHqeJ1F0Suyw0XYR0NDUJcLEipUaoz1+ZkaJCTXXiMRBV4YFi8mGPsyo8S4Sx3yeM9rb7mXBzvDpSJJLgGLArEonIMooG3Rtc2p/JmMxdxbdca3KZu9ZAYljZL4Mjts=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766048202; c=relaxed/simple;
	bh=ICrbVX6P5qbTH42FqCUUSPXrkZ7onFef+856yfqjC2s=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=nRV1LYZxL5/TTPRYgtcbD9ylpfOU+Wz8fLB8QhMg+e5z6TI95BNB0WsPW1xcN0zVRDL9leZmScpFDdc86jEbmhq9IB57+WuSSrSE1GPVxyQxqrMDObq/hREc3x2v/uqaCIfHU+jiyWw1meVWQ5UfTbNm329IqJyTCykf/c2VqNw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 479464BA2E24
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Q49Jr76W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766048196; x=1766652996;
	i=johannes.schindelin@gmx.de;
	bh=X68Zimb5Yw+T4KjEx19xcziXl+QySrPnlHw0wI33pkE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q49Jr76Wn1tn1F7XtkCtQtnSOj6dqGcwYYEIew4zMxE6+xfGHknDtzZ63hgFRIV4
	 QDjwT+puaU8mWG/A9sZ13EL7rsJ6Q0NsVXvQWgqCiRn4SVhuT4lUpC5ly0kq73Zfg
	 Zullj+ZIHRIlrtYAbgXu4HQMmyQmv59mMa/S8aTwfiWbBTpiuwogZQOd7JSafhgfm
	 /sDEY+mHEk7L6+iCUHFfFMnN8kJvd625OW0+7OQd9tF27YurdiBKrG3cBe9JqZi9T
	 yUyDKBRXjXo7jhi6ib8q+9aC8mu6wfhYoakGlow7rEvVgBYiJAl4QkCA7KSswc9Bx
	 2ORazc5j4NBJSVPkfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBm1e-1viIu01L7k-00EqKP; Thu, 18
 Dec 2025 09:56:36 +0100
Date: Thu, 18 Dec 2025 09:56:34 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Corinna Vinschen <corinna@vinschen.de>
Subject: Re: [PATCH v2 1/2] Cygwin: pty: Fix ESC sequence parsing in
 pty_master_fwd_thread
In-Reply-To: <20251218072722.1634-2-takashi.yano@nifty.ne.jp>
Message-ID: <54cf8d06-cc75-9fde-34c3-c49389e931e3@gmx.de>
References: <20251218072722.1634-1-takashi.yano@nifty.ne.jp> <20251218072722.1634-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cqEOq6eWyx8YjcaEFan7PBc0JZrsByWDG4m7P63tFQMrrg+29F3
 iI7qq7Yk0UpJxDoJlSu9GIyBptHfqVR3JcPh10ALZo24md7haXG3NRrhC/V21k4ysLNpk+2
 5x5vF+IclVS4Q5Hy06gtJ5U9F5pSC8Frw3XcvMsZO48yGg/lpAEvqpLAiEckKylewISuAW+
 claBeztgrz6rCy7qbV3bQ==
UI-OutboundReport: notjunk:1;M01:P0:WQ73RgZtSKE=;otSp+3XicTIClZ48O2DqzxsXsIz
 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
 mqHatWfQZzZo3yU8MFet
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 18 Dec 2025, Takashi Yano wrote:

> This patch fixes the bug in ESC sequence parser used when pseudo
> console is enabled in pty_master_fwd_thread(). Previously, if
> multiple ESC sequences exist in a fowarding chunk, the later one
> might not be processed appropriately. In addition, the termination
> ST (ESC \) was not supported, that is, only BEL was supported.
>=20
> Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two in=
put pipes.")
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pty.cc | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 679068ea2..3b0b4f073 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2680,7 +2680,7 @@ fhandler_pty_master::pty_master_fwd_thread (const =
master_fwd_thread_param_t *p)
>  	  int state =3D 0;
>  	  int start_at =3D 0;
>  	  for (DWORD i=3D0; i<rlen; i++)

I wonder whether the other `for ()` loops in `pty_master_fwd_thread()`
also need changes:

- https://github.com/cygwin/cygwin/blob/cygwin-3.6.5/winsup/cygwin/fhandle=
r/pty.cc#L2693-L2720

- https://github.com/cygwin/cygwin/blob/cygwin-3.6.5/winsup/cygwin/fhandle=
r/pty.cc#L2722-L2750

> -	    if (outbuf[i] =3D=3D '\033')
> +	    if (state =3D=3D 0 && outbuf[i] =3D=3D '\033')
>  	      {
>  		start_at =3D i;
>  		state =3D 1;

The diff context is unfortunately not wide enough to show that there is
only this line before the next hunk:

                continue;

> @@ -2688,12 +2688,14 @@ fhandler_pty_master::pty_master_fwd_thread (cons=
t master_fwd_thread_param_t *p)
>  	      }
>  	    else if ((state =3D=3D 1 && outbuf[i] =3D=3D ']') ||
>  		     (state =3D=3D 2 && outbuf[i] =3D=3D '0') ||
> -		     (state =3D=3D 3 && outbuf[i] =3D=3D ';'))
> +		     (state =3D=3D 3 && outbuf[i] =3D=3D ';') ||
> +		     (state =3D=3D 4 && outbuf[i] =3D=3D '\033'))
>  	      {
>  		state ++;
>  		continue;

So if we encounter an ESC when the state is 1, 2 or 3, we no longer reset
`state =3D 0`... That does not sound correct.

And if we encounter an ESC _just_ after `ESC ] 0 ;`, we set `state =3D 5`
which is then not handled other than by resetting `state =3D 0` at the nex=
t
character?

>  	      }
> -	    else if (state =3D=3D 4 && outbuf[i] =3D=3D '\a')
> +	    else if ((state =3D=3D 4 && outbuf[i] =3D=3D '\a')
> +		     || (state =3D=3D 5 && outbuf[i] =3D=3D '\\'))
>  	      {
>  		const char *helper_str =3D "\\bin\\cygwin-console-helper.exe";
>  		if (memmem (&outbuf[start_at], i + 1 - start_at,
> @@ -2701,11 +2703,14 @@ fhandler_pty_master::pty_master_fwd_thread (cons=
t master_fwd_thread_param_t *p)
>  		  {
>  		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
>  		    rlen =3D wlen =3D start_at + rlen - i - 1;
> +		    i =3D start_at - 1;

I have a suspicion that _this_ is the actual bug fix necessary. Could this
be true? If you remove the remainded of this patch and only reset `i`
appropriately, does it fix the problem?

Ciao,
Johannes

>  		  }
>  		state =3D 0;
>  		continue;
>  	      }
> -	    else if (outbuf[i] =3D=3D '\a')
> +	    else if (state =3D=3D 4)
> +	      continue;
> +	    else
>  	      {
>  		state =3D 0;
>  		continue;
> --=20
> 2.51.0
>=20
>=20
