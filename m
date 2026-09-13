Return-Path: <SRS0=nquO=HF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 881404BB3B9C
	for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 11:56:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 881404BB3B9C
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 881404BB3B9C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789300608; cv=none;
	b=qfTfx2BIMA8/U3I+jowjj732b5XWPt32RcWd/L2WLyYmTZYjnlUFWEkl6A25NFRyayf3WARt7dWxtuyCGt84yBvAuHpjqmp1d0D/y3Zwc7v7Cz2J+lKA0DQONqMw12Z/88j8C9E+PBWASv3t7P3656KZBlOJ+7fGL9UwNuuk5s0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789300608; c=relaxed/simple;
	bh=ewwil1/XGqufTAmj2GSYXXYE8kFQ87bLG1MPc+DpfWM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ihNL9/Ch+GqODY6E/TjLLnvw15tl5EQkt2D8UhMF1lKrbiL/a8IhntpeXCnX4sO1TUVsUY5aVX1eXmaBdZIjBZpJFQ4oxO2uZg+TpGqYl4p8tbDdS2FzMsESffg2Y/cyKpykZ9i6ZPSYKGlkS1rMmIVJmokHl7F4Dedt4bCToGg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=hyCav1Cm
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 881404BB3B9C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=hyCav1Cm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789300600; x=1789905400;
	i=johannes.schindelin@gmx.de;
	bh=8K4eBU6TKj4DbH/urnBe9yTzhhcIooVJnpvBWY8shbg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hyCav1CmnogO0mcRSCd/Ky4hzJSzY1nB5P7A9qSrPbMZI8445m7CqQzAaevre+4c
	 l8ow4ySPevSYfwyRmuF07oLVd+lhQqqJO1ues/JVFhPOtIhQ7tcI6E9Y13vpxEQcs
	 PXI8L6Qi8FP44uZHDLnifcCjVUW0eOZakuiI3Ww2/oK5tuKO+1S5tI2WFDzyHAN23
	 d+9dKP/YUG18uMUptrpUjc/YEmQHTSoolE1n/sMKUE/wXwjKmmJg8SRiiK/B84MT0
	 VtFmqpXThzlBwafw8A4LIyBNbCC7NKatsKJTrCPvDHzV1+xkH/VELvUA2mYF93hXL
	 +bU8gxdrRWc2wQ0uiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1xOkZp0Oar-00Jrmc; Sun, 13
 Sep 2026 13:56:40 +0200
Date: Sun, 13 Sep 2026 13:56:38 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <20260903234859.344934-1-takashi.yano@nifty.ne.jp>
Message-ID: <cbb2e74c-ae66-7c47-808a-a9b68d954655@gmx.de>
References: <20260903234859.344934-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:KySgORclPLtbxm7Sa4jqryqto9CXbAfBocowbhKGJ1LKLwICJxA
 TA1qh0RQguRWdCoCZc/ngkHiHcPqiwzzoMcM/iy249ZWdxrQV4w2fwx6T5pCjGwisnjtRqz
 4SUHiVka0lRBMUicdsUUAwqqBcDGSPasjcL+QlKg9hsQd0dTM2IKE0k410Wwz+STCQVYbSF
 Airsu6NTRLgrmGQkBj17Q==
UI-OutboundReport: notjunk:1;M01:P0:BBntXtFSYQQ=;7kRcWiy/lDsJm++PFdbwUodHtaX
 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
 czxCq8J/5kcAakrkJPJAXfNgYGCDYUF7Ckg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 4 Sep 2026, Takashi Yano wrote:

> Previously, peek_console() used PeekConsoleInput() to confirm whether
> the console input buffer has some input records. However, this need
> attaching to the console if the process does not attach to the console.
> To reduce that overhead, this patch uses WaitForSingleObject() with
> console input handle instead. WaitForSingleObject() works without
> attaching to the console, so this simplifies the peek_console()
> code.

Great! I like when Cygwin's code is taught to avoid expensive operations.

One issue, though:

>=20
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/select.cc | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index 592f6d14d..d565f4d5b 100644
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
> @@ -1161,12 +1159,7 @@ peek_console (select_record *me, bool)
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

With this change, a host can report readiness without leaving any records
to process. Here is a concrete source counterexample in released
OpenConsole `v1.24.11911.0`:

1. `SetConsoleActiveScreenBufferImpl()`
   (https://github.com/microsoft/terminal/blob/v1.24.11911.0/src/host/gets=
et.cpp#L474-L498)
   calls `SetActiveScreenBuffer()`
   (https://github.com/microsoft/terminal/blob/v1.24.11911.0/src/host/outp=
ut.cpp#L446-L476),
   which invokes `FlushAllButKeys()`.
2. If the queue contained only non-key records, it becomes empty while the
   input-available event remains signaled.
3. An empty subsequent peek returns before the event-reset code
   (https://github.com/microsoft/terminal/blob/v1.24.11911.0/src/host/inpu=
tBuffer.cpp#L460-L470).
   With no other input activity repairing that state, Cygwin's new loop
   can repeatedly see "signaled handle" followed by "zero records."

In other words: changing active screen buffers can discard the remaining
non-key records without resetting the input-available event. The queue is
then empty but the handle remains signaled; an empty peek does not repair
the event. The new preliminary wait consequently succeeds repeatedly,
while `process_input_message(0)` finds zero records and returns
`input_processing` without changing readiness. `peek_console()` loops
without progress, so even a zero-timeout `select()` can hang. The old
preliminary peek explicitly broke out when its record count was zero.

This is not merely the normal distinction between a keypress and a
complete line. It is a stale host notification paired with an actually
empty queue. The source counterexample keeps Cygwin's worker paused
through Win32 input mode, with no new input or other reader repairing the
state.

I think we can keep the cheap `WaitForSingleObject()` check, but could we
let `process_input_message()` report an empty queue separately from
`input_processing`? If its `PeekConsoleInputW()` call finds no records,
`peek_console()` needs to stop retrying rather than spin on a handle that
stays signaled. Simply breaking on `input_processing` would also stop when
we consumed input but hadn't yet completed a canonical line, so we need to
keep those cases separate. Please handle input errors explicitly, too.

Ciao,
Johannes

>  	    {
>  	      fh->release_input_mutex ();
>  	      break;
> --=20
> 2.51.0
>=20
>=20
