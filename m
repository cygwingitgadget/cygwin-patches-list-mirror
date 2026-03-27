Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id D17504BA2E0E
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 13:01:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D17504BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D17504BA2E0E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774616520; cv=none;
	b=miN923/ZAz7+aMCHBuOA+9gmr/gYIHVBBCkt62ocQJDlE5IhEv4Kz+pmgJqNWBzMolIB/R6NC9eBg+cbvaPUdMzR2/+jg46OfcpU19nZaWNeZ52UeNTOV1nsKK0pR1zUjyqHwbhStL68LVt4Cu5Zq8ohYr5wmgWWTEmAa3Upzj8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774616520; c=relaxed/simple;
	bh=SsiRtejX/5EvtaURaIW6Vd2gedCmR3YZ0welmQxRNkc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mZs4tWMsubFSShrP+hTLOZ3DVZeoYLDlrM6nrwkbjtJnRA2o+/jMvNCbbVDreq6B10CctptvL5Ua1Nsjmtp7bqsmT6G+gB2aZ46vY7SAT8HeOn5BjbTelHF3ddJZ2yVBjYbAWA1DjDoUaScBN74pRDXfgTKAKY68RGt3OegVpbM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D17504BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UXgQxPMy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774616512; x=1775221312;
	i=johannes.schindelin@gmx.de;
	bh=rcph2QYjiXSLXSRPCRMzzipwfz5QgJ4FthqhCzz7Jeg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UXgQxPMyZVA/2K+w8NesJBS4x1IvFmPIvHMfeaUpChNACqB1kjjRvDXSvUgozl6i
	 Xa25nwPWGwWV5jc7I/gZAD9PfaiVzo/ShXGFkpaAZTH8zf4DKicrB8qkjtJ/lTbPr
	 KJLnvlfx86tJ/0gRKfL+xRxl4tKfRKipNZZdtbdIkSvozWwpoYE2I/VA6vRoouPvo
	 LRbzzRYkKGblGDl1mRXYcJOoi+iKRGCKEJ+X2eUFInPDpExF1xq9Kt2StwI0hhaiy
	 cb8zQ/HOj0P6VjJa9/nkaVnd0pUood7TZ2nPlpC0iky17DjAd3Yvbrye73a+l+jnL
	 R1i31wI5krPmQdvvOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1w0Crn1k7L-00N6hr; Fri, 27
 Mar 2026 14:01:52 +0100
Date: Fri, 27 Mar 2026 14:01:50 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 1/7] Cygwin: console: Fix master thread
In-Reply-To: <20260325130453.62246-2-takashi.yano@nifty.ne.jp>
Message-ID: <6e4e7302-09f1-05d0-20f4-1805499e5df6@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HDpQe0y06FXWcdKp0xowd0FjZ9oT5w4by20DJzB/P/48XoQNoke
 ONYZUbebSZk/mePrMExlLwXdXrep/gCE++T/Bz+MdE5AjCooKRCEScI2oOfDJRiM1Nnn70a
 X+b6pbTRhUv3FR7Ql/IqCqrh9AnQWVaKpawOBnwzrW44r1W12JXW7ycJHa27jCsi7gzorPj
 c6MYvKVM4LjzyS+Er7W9Q==
UI-OutboundReport: notjunk:1;M01:P0:kE8c4bHX2Ic=;kNV1Bnr4Duw8AmjzOdtrKAq+jif
 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
 +9ZQSVsdZTSXQYfYQCNFHRPiqHaMVZriA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Mar 2026, Takashi Yano wrote:

> In Windows 11, key event with wRepeatCount =3D=3D 0 is fixed-up to
> wRepeatCount =3D=3D 1 in conhost.exe.

I can confirm this, it's in
https://github.com/microsoft/terminal/blob/v1.25.622.0/src/host/inputBuffe=
r.cpp#L406

> Due to this behaviour, inreq_eq() returns false even though the two
> event records are the same. This patch adds workaround for this
> behaviour in inrec_eq().

The commit message explains the conhost behavior but not why comparing
INPUT_RECORDs matters in the first place. A reader unfamiliar with the
write-then-verify pattern in `cons_master_thread` would have a hard time
understanding the impact.

Could you expand the commit message body along these lines?

    The console master thread (`cons_master_thread`) reads INPUT_RECORDs
    from the console input buffer, processes signal-generating events,
    and writes the remaining records back. After the writeback, it peeks
    the buffer and uses `inrec_eq()` to verify that conhost stored the
    records faithfully. On Windows 11, conhost normalizes `wRepeatCount`
    from 0 to 1 on readback, causing `inrec_eq()` to report a mismatch
    and triggering an unnecessary fixup path. Treat 0 and 1 as equivalent
    for comparison purposes.

Also feel free to add the reference to the conhost source code I provided
above.

>=20
> Addresses: https://github.com/git-for-windows/git/issues/5632
> Fixes: ff4440fcf768 ("Cygwin: console: Introduce new thread which handle=
s input signal.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 9fd3ff506..2f59f8f24 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -318,9 +318,16 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD=
 *b, DWORD n)
>  	     written event. Therefore they are ignored. */
>  	  const KEY_EVENT_RECORD *ak =3D &a[i].Event.KeyEvent;
>  	  const KEY_EVENT_RECORD *bk =3D &b[i].Event.KeyEvent;
> +	  /* Fixup repeat count */
> +	  WORD r1 =3D ak->wRepeatCount;
> +	  WORD r2 =3D bk->wRepeatCount;
> +	  if (r1 =3D=3D 0)
> +	    r1 =3D 1;
> +	  if (r2 =3D=3D 0)
> +	    r2 =3D 1;

The comment is adequate, but it could mention _why_ the fixup is needed,
matching the style of the existing comment right above it (which explains
why `wVirtualKeyCode`, `wVirtualScanCode`, and `dwControlKeyState` are
ignored). Something like:

    /* On Windows 11, conhost normalizes wRepeatCount from 0 to 1
       on readback. Treat them as equivalent for comparison. */

That way the rationale stays local to the code instead of requiring a
trip to `git log`.

With the commit message updated per the above (the comment tweak is
optional):

Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Thanks,
Johannes

>  	  if (ak->bKeyDown !=3D bk->bKeyDown
>  	      || ak->uChar.UnicodeChar !=3D bk->uChar.UnicodeChar
> -	      || ak->wRepeatCount !=3D bk->wRepeatCount)
> +	      || r1 !=3D r2)
>  	    return false;
>  	}
>        else if (a[i].EventType =3D=3D MOUSE_EVENT)
> --=20
> 2.51.0
>=20
>=20
