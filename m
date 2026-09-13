Return-Path: <SRS0=nquO=HF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 4404B4BB5926
	for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 10:50:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4404B4BB5926
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4404B4BB5926
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789296622; cv=none;
	b=qdQuxc/d595fJX3nb2DqqRmkMsoLBdwJhmrVXpbnDRAK/Da2fKJaYT4JVANpdQqP6IwubF5AVfv56PjDngRsipp/ajgve2P5zdCaGw43Ucws5vILfUJo4WH4SoUwiOWIGPF+dQmadUcuaK1UOBHf5ibLT+Z4UoAfWGOCzU1BXOs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789296622; c=relaxed/simple;
	bh=otvJf9+M9l/6kHJO2pdyIUit19ojKi6vEMd0ki9Q8LM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=YJ6OcVij8Jja05BqLaCKvP+/txDYVS5KgVW3mCmGXSjdWabZAKTFB9IXjE/N06eoawyw2zKpUIuImOO2juNjy8j+naXpDIqMcur/SPPmK/An/egRcHtgrmEN55IXaX2jZgbX0L313GKe/rJD9p/aBNhdGVqhlI4/4ySqOuw1BPM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HC1xmeS4
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4404B4BB5926
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HC1xmeS4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789296615; x=1789901415;
	i=johannes.schindelin@gmx.de;
	bh=C3qytgu7wJ+uCvAQIwHIbXzL7TaEIKYROKqPSzbWqls=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HC1xmeS4QKSYx/7MYgA3FVuBSLXSrocMPCN2M6wCbKowcYaboOr07nICZlvFe276
	 m94oM+0YWNA+GEX7ZrV/3tT6HaoFe5H6yK3nB/SIab4F8+KYsakImWwS8MidOiBmw
	 sq1NZBkd96tGrDI1/zF18qCar8Sj9uVvjvE2EZzSUaoN68K3bMqID+64g+1wl5T3V
	 5jg4LJD6X6LW/PwmBey2eEJ/EXFdV0RCKHjxCoVLgDw0VMyGp8KBEcgY03h9ZAdqM
	 XdLoHgiAJxkpquCWr5El+jmc1a/FWcXbI/Wm0jbIzpqFMlkKLv20bzbkUokScuAHz
	 l7Ii9Ye8cbS8MymtVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1wPivN3KtX-00nUvD; Sun, 13
 Sep 2026 12:50:14 +0200
Date: Sun, 13 Sep 2026 12:50:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Clear readahead buffer on
 tcflush()
In-Reply-To: <20260819051609.128310-1-takashi.yano@nifty.ne.jp>
Message-ID: <707a417a-2f2c-8116-bf3c-d1bc842f47e4@gmx.de>
References: <20260819051609.128310-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:OZatKb50dc58qWa7sCQCfWF5xuGCVjFcL8pJIn93u+ah7KjC4UH
 U7MKn6kBFCrToBYiEDZ+0ksT67OQkm5Ig29qi/oa9z3qAKJflr2T5PYAL725ItNBlh8vki7
 TqFEL1dND/p1z82oFkjN95DbNa0MDUvko+ysxRr8svt8Z7y68leO5uLnUVD2ZaMVaYE4HJW
 1FmFSM3AJYWilFxWxBOXg==
UI-OutboundReport: notjunk:1;M01:P0:A/NK0eQheu4=;Wf68fyK7vNh3X5SP9IoCEBi50Pl
 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
 7bCkaTlercQSWrbBVKBP6gOBAHlhr1M3rZg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

thank you for addressing my concerns. I have two more concerns, though:

On Wed, 19 Aug 2026, Takashi Yano wrote:

> Previously, tcflush(TCIFLUSH) only discarded the input events and
> did not clear the readahead buffer. Because of this bug, when user
> program called select() -> tcflush() -> read(), the last read()
> returned the contents of the readahead buffer instead of blocking
> as it should.
>=20
> Correctly, tcflush() must discard all pending input, so read()
> should block until new input arrives. With this patch, the read-
> ahead buffer and `rapoi` are also cleared as well as input events.
>=20
> Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Add input_mutex guard. Clear rapoi as well.
>=20
>  winsup/cygwin/fhandler/console.cc | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index ba35ca44c..a5887ca8d 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -2351,6 +2351,9 @@ fhandler_console::tcflush (int queue)
>    if (queue =3D=3D TCIFLUSH
>        || queue =3D=3D TCIOFLUSH)
>      {
> +      /* tcflush() may be called inside the input_mutex,
> +	 however, mutex of Win32 can be acquired recursively. */
> +      WaitForSingleObject (input_mutex, mutex_timeout);

The flush ioctl introduces an opposite lock order. The dangerous entry
point is specifically `ioctl(fd, TCFLSH, TCIFLUSH)` or its `TCIOFLUSH`
equivalent. Console `ioctl()` holds `output_mutex` before calling the
handler's `tcflush()`, which now waits for `input_mutex`. Concurrent
reading and echoing hold `input_mutex` and wait for `output_mutex`. Each
can therefore wait forever for the other.

Normal public `tcflush()` and signal-driven `sigflush()` call the handler
directly, without this ioctl output lock: they do not follow this
particular cycle. Any fix of the ioctl's lock scope/order needs to retain
the necessary input guard.

>        acquire_attach_mutex (mutex_timeout);
>        DWORD resume_pid =3D attach_console (con.owner);
>        BOOL r =3D FlushConsoleInputBuffer (get_handle ());
> @@ -2362,6 +2365,10 @@ fhandler_console::tcflush (int queue)
>  	  res =3D -1;
>  	}
>        con.num_processed =3D 0;
> +      eat_readahead (-1);
> +      input_ready =3D false;

Flushing a duplicate can manufacture apparent EOF. Two duplicated console
descriptors, A and B, share `con_ra` within their process, but each
handler has its own `input_ready` flag. Let `select(A)` buffer a complete
line and mark A ready, then call `tcflush(B, TCIFLUSH)`. V2 empties the
common buffer but clears only B's flag. Descriptor A remains falsely
ready; its next blocking canonical `read()` skips waiting, finds no bytes
and returns zero, which looks like EOF. No race or EOF keystroke is
required. Readiness must be shared or invalidated consistently with buffer
ownership; simply making every empty-ready read wait would break genuine
canonical `VEOF` handling.

I'm sorry that I cause more work for you!

Ciao,
Johannes

> +      con.cons_rapoi =3D NULL;
> +      ReleaseMutex(input_mutex);
>      }
>    return res;
>  }
> --=20
> 2.51.0
>=20
>=20
