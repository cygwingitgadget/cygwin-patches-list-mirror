Return-Path: <SRS0=Wi/b=GE=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 44F904BA23C1
	for <cygwin-patches@cygwin.com>; Tue, 11 Aug 2026 10:14:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 44F904BA23C1
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 44F904BA23C1
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786443257; cv=none;
	b=IIdSJ1izC/hcKkptX/SYEry9JCgMNgOsRN2JFSc0qAkq1FlwpNiwQscxkxlv+zYSYV+dmi+vxVqUEnxrwOJqQQzXrlK4HuLQOxo46VEi86J58mxK5SdJCIEpFrNQDuiZAt+23778kaQNWuGtWe7s7V82Rle1+Arxc0AGWGC5V5U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786443257; c=relaxed/simple;
	bh=pATNojzftSiWKCZICXoXhGmVeGzEL18+/zq7O3nvIBU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Z53I4Mlvnu2H1c1l8VwMex0tHrzFukYQjso0M3iVQWI3E1dhyceUDTCToIJM01+4HaoFZkyfMaslRXNWfSJIiNu2qqYRccaqtY+PTq006sejYpPeHlhgRU4XkDzmCH3YiL5mGMFG/3fNAP1kT8kY2U3d5cjiO1ilYLJbCS5Fp18=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=X8A5mDVn
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 44F904BA23C1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=X8A5mDVn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786443256; x=1787048056;
	i=johannes.schindelin@gmx.de;
	bh=0xfqP6ae0yRHEIAQPF/NxDp+jMce/modiDXipQ1vQpc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X8A5mDVnR2LXA/uvFxfgtDLrrcv6ZYVlNP+jJM2AIoHeXP1IADHgRA7Ua2TXWhFR
	 12g4EcsC09P7/M1WIlMdxUOWhd7+9b/B3rBt7JLe3XlZp/mywMjAQgX4TVwEMOTAl
	 k1eHWQlfLVyDc/l6nGM10WP/9z6W5ywENFcz6RVzXynXyuC3W7/RahJu6CDde467T
	 vog1OF6tR8Pl6QzUmSA/zpXVh3nVP0iKiu4RaWi6iHhWUjil0bEhQRbuo8qF9JJa7
	 4iTG9+2mGQU5djYkhg6MybNGvvaE8CmEktYoH2xl+EujeO6d2RBHotF5+ttNokd1F
	 0QhpDK5KO33RbyA8Fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1wa9D70GT3-00UyMO; Tue, 11
 Aug 2026 12:14:16 +0200
Date: Tue, 11 Aug 2026 12:14:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Clear readahead buffer on tcflush()
In-Reply-To: <20260807111245.2139-1-takashi.yano@nifty.ne.jp>
Message-ID: <954fb6e8-851d-d19c-e9e7-e93a029890cf@gmx.de>
References: <20260807111245.2139-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:KbhXb141BCzz5wzDjkr1ndRsBsbutlH8QmwJ2lNZIN32KU7dVHs
 qY0kUGiTZvluw9FbyGqvuSTCzVQ+absuVUnwwUC16r11L4FBQ/vXk3O/Xrqj9gVzB1pf1uN
 E3bQ8gPRuZGzvevIPYkgdwbMok782c3vbMkCqd2+YXIGrSEWB4Xe8z4+heukyqL7lQHSpim
 7ZaQZh2XG0aS/pF5mAcmw==
UI-OutboundReport: notjunk:1;M01:P0:oYse0kXwUE0=;lyP9ohQFrpf2dqJOjktwQgrcI+7
 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
 =
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPAM_BODY,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 7 Aug 2026, Takashi Yano wrote:

> Previously, tcflush(TCIFLUSH) only discarded the input events and
> did not clear the readahead buffer. Because of this bug, when user
> program called select() -> tcflush() -> read(), the last read()
> returned the contents of the readahead buffer instead of blocking
> as it should.
>=20
> Correctly, tcflush() must discard all pending input, so read()
> should block until new input arrives. With this patch, the read-
> ahead buffer is also cleared as well as input events.
>=20
> Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index ba35ca44c..d3fb2fcbd 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -2362,6 +2362,8 @@ fhandler_console::tcflush (int queue)
>  	  res =3D -1;
>  	}
>        con.num_processed =3D 0;
> +      eat_readahead (-1);
> +      input_ready =3D false;

The core fix is right: with `con_ra` drained and `input_ready` cleared,
`read()` keeps waiting (its loop gates on `input_ready` and
`get_cons_readahead_valid()`), so the select() -> tcflush() -> read() path
no longer hands back the stale readahead. I confirmed it fires only for
`TCIFLUSH`/`TCIOFLUSH`, not `TCOFLUSH`, and that clearing `input_ready`
cannot drop a window-resize or signal event, since those travel via
`input_winch` and `input_signalled`.

Two things should change before this lands, though, I think.

First, this input flush is not serialized against `input_mutex`.
`tcflush()` here runs holding only `output_mutex` (taken by `ioctl()`) and
`attach_mutex`, not `input_mutex`, yet `con_ra` and `input_ready` are
otherwise mutated only under `input_mutex`: `process_input_message()`
fills them, `read()` clears `input_ready`, and `peek_console()` reads
them. So a concurrent `read()`/`select()` on the same console can, right
after this flush empties the buffer, line-edit already-drained events back
into `con_ra`, and the pre-flush input reappears once `tcflush()` returns.
Please take `input_mutex` around the flush body.

One caveat there: the signal path (`sigflush()` -> `tcflush(TCIFLUSH)`)
may already hold `input_mutex`, so it is worth confirming there is no
self-deadlock. Windows mutexes are recursive per-thread, and
`process_sigs` releases `input_mutex` around `kill_pgrp`, so it is
probably fine, but that should be checked rather than assumed.

Second, `get_cons_readahead_valid()` gates on `con.cons_rapoi`, which is a
separate buffer holding terminal query responses (the cursor-position and
device-attribute reports that `char_command()` queues), not `con_ra`. The
patch leaves `con.cons_rapoi` untouched, so if such a response is pending,
`read()` after `tcflush(TCIFLUSH)` still returns it instead of blocking.
That is arguably the POSIX "data received but not read" that the flush is
meant to discard. Either clear `con.cons_rapoi` as part of the same
(locked) flush, or, if leaving the query-response buffer intact is
intentional, say so in the commit message so the exemption is on record.

Ciao,
Johannes

>      }
>    return res;
>  }
> --=20
> 2.51.0
>=20
>=20
