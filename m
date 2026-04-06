Return-Path: <SRS0=dvnW=CF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id CED4A4BA2E21
	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2026 08:14:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CED4A4BA2E21
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CED4A4BA2E21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775463273; cv=none;
	b=mo9lYW8jBUl8gnIy/ZpXhmlYwmVheqF51S7Q1MXfq74GzHKDSm/zW9gGRqZ2YWJd1pI40PxXcI8qX/efRuB0AqpmbtCPL1b1gBDD4gV4W80eEA31FSli59lBciz2oSKbXaJg0rrg8X6CC0fNdNuJdRO2qTSQSLeI3wHBjCdlQYI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775463273; c=relaxed/simple;
	bh=1ixVOsZP8yj/Lp91imEcYlXQOi5e8begPkB85ZI7MkY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=V+sj1aHgS3KJAIv6ilCIieFvJfTVU+Qb72y9vlqLM+2Bw+O9kMu4L0o+bk7kRR2LfiGD4ZRAUGBIxyrMo00EWWpXBcZEd5vOfMYwgTAC223vBbQ5q6ih1+UZMK17I2XCIqrAmz/aWazFS92TWADEDwNeyTHXqqmf8A+mKz/f7uQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CED4A4BA2E21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=LK1ZZYeU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775463271; x=1776068071;
	i=johannes.schindelin@gmx.de;
	bh=TpOip+gWgKZTueHxWeeAYNmg0V+AR7CB9nb2S5qtEh0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LK1ZZYeUPbmAYFCgEwDNF7geYQl2V/QHyJLWBweUqYv5H3oOlhk1rWXk7lmCxqWU
	 HgATPizoZ8e24L/HAmyvLsOq/MSRCru2FuoVJy7j27+omGneMlAg+RzZEdJGPxdo4
	 jB9dQ4Kh9urwCf1JPACpDV3zLh5yBX692HBgK0cux4FozUtuOg06ZL9nE3mJ5ATDx
	 2wef+O+ai2KGYvRbWPlAKwKFiVHTNHEZxZUN8xTAk84ji7ejogrTDirmWzuc4FAS4
	 zCXlFGyPtUqfW/AauraKQPT/rPLB75+s1jbMIF1mIhY1zXmFnFCBlbKTqWOLhYxAW
	 43kPiafO7eL+Qfzzzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1vXK9D20RQ-00bVt3; Mon, 06
 Apr 2026 10:14:31 +0200
Date: Mon, 6 Apr 2026 10:14:30 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 3/3] Cygwin: console: Fix master thread for
 OpenConsole.exe
In-Reply-To: <20260325131056.69116-4-takashi.yano@nifty.ne.jp>
Message-ID: <fa6ac2e9-1eec-ffde-5fe8-17bc957f3528@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp> <20260325131056.69116-1-takashi.yano@nifty.ne.jp> <20260325131056.69116-4-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P5ERP6/TwC0wPoh+/Es90ft33BAFKqKB6httEk4yVsgMRjJNmLg
 bXHXI2nb4yK6dmh/d6aB2HUcL5AAfei5G7nesXEVCpyUIKU6ciPabD+qWfj5AcsavXOAWQR
 cgwIwjStcKYNSOdB2pU1VdB9zxtGn80goeHytCrhtJuaySqqMGtJ402c4Unp7r38CEfY+m6
 utngd9CZZ5d59prtvT7Bw==
UI-OutboundReport: notjunk:1;M01:P0:/y2sGHZKbD8=;35PHXQPrUT4ryM/0bzYhrbeZto1
 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
 vUIacocGn4w
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for the new patch. A few observations:

On Mon, 6 Apr 2026, Takashi Yano wrote:

> If the console is originating from a pseudo console, current master
> thread code does not work as expected. This is because the pseudo
> console does not keep all the event as is. All bKeyDown =3D=3D 0 events
> will be omitted from the input record written by WriteConsoleInput().
>
> [...]

The commit message describes this as general pseudo console behavior, but
the code comment in `strip_inrec()` is more specific:

> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 1dd5dfa1d..1693a5be7 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -305,6 +305,23 @@ cons_master_thread (VOID *arg)
>    return 0;
>  }
> =20
> +static inline DWORD
> +strip_inrec (INPUT_RECORD *r, DWORD n)
> +{
> +  /* Pseudo console with OpenConsole.exe removes the events
> +     whose bKeyDown is 0 as well as ones whose charcode is 0. */

And the patch title itself says "Fix master thread for OpenConsole.exe".

Can you help me understand: does legacy conhost.exe _also_ strip these
events when used as a pseudo console host? If it does, the commit message
is fine but the code comment should drop the "with OpenConsole.exe" part.
If it does _not_, then guarding with `inside_pcon` is too broad: when the
user sets `use_legacy_pcon` (introduced in patch 1/3 of this series),
`strip_inrec()` would discard events on the Cygwin side that conhost.exe
actually preserves in its input buffer. Those stripped records would then
not be written back at lines 579-584, and the `inrec_eq()` comparison
against the peeked buffer would also see a mismatch.

In that case, could the guard be tightened to `inside_pcon &&
!use_legacy_pcon` (or a dedicated flag) so that stripping only happens
when OpenConsole.exe is the actual host?

> +  DWORD j =3D 0;
> +  for (DWORD i =3D 0; i < n; i++)
> +    {
> +      if (r[i].EventType !=3D KEY_EVENT)
> +	r[j++] =3D r[i];
> +      else if (r[i].Event.KeyEvent.bKeyDown
> +	       && r[i].Event.KeyEvent.uChar.UnicodeChar)
> +	r[j++] =3D r[i];

Note: this strips not only key-up events (`bKeyDown =3D=3D 0`) but also
KEY_EVENTs where `UnicodeChar =3D=3D 0`, which includes arrow keys and
function keys. For signal processing that is harmless because the existing
loop already skips exactly those events.

However, it means those events are permanently removed from
`input_rec`/`input_tmp` before writeback, so any downstream code that
reads raw INPUT_RECORDs from the console input buffer (e.g. via
`ReadConsoleInput()`) will never see them.

Is that the intended behavior with OpenConsole.exe? I.e., does
OpenConsole.exe _also_ strip those events when it processes
`WriteConsoleInput()`, so the records would be lost regardless? If so, the
commit message should say so explicitly (it currently only mentions
`bKeyDown =3D=3D 0` events, not the `UnicodeChar =3D=3D 0` case). If not, =
we might
be discarding more than necessary.

Ciao,
Johannes

> +    }
> +  return j;
> +}
> +
>  /* Compare two INPUT_RECORD sequences */
>  static inline bool
>  inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
> @@ -482,6 +499,8 @@ fhandler_console::cons_master_thread (handle_set_t *=
p, tty *ttyp)
>  	      total_read +=3D len;
>  	    }
>  	  release_attach_mutex ();
> +	  if (inside_pcon)
> +	    total_read =3D strip_inrec (input_rec, total_read);
>  	  break;
>  	case WAIT_TIMEOUT:
>  	  con.num_processed =3D 0;
> @@ -606,6 +625,8 @@ remove_record:
>  	      acquire_attach_mutex (mutex_timeout);
>  	      PeekConsoleInputW (p->input_handle, input_tmp, inrec_size, &n);
>  	      release_attach_mutex ();
> +	      if (inside_pcon)
> +		n =3D strip_inrec (input_tmp, n);
>  	      if (n < min (total_read, inrec_size))
>  		break; /* Someone has read input without acquiring
>  			  input_mutex. ConEmu cygwin-connector? */
> @@ -624,6 +645,8 @@ remove_record:
>  		  n +=3D len;
>  		}
>  	      release_attach_mutex ();
> +	      if (inside_pcon)
> +		n =3D strip_inrec (input_tmp, n);
>  	      bool fixed =3D false;
>  	      for (DWORD ofs =3D n - total_read; ofs > 0; ofs--)
>  		{
> --=20
> 2.51.0
>=20
>=20
>=20
