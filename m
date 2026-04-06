Return-Path: <SRS0=dvnW=CF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 9D7834BA23F0
	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2026 08:14:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9D7834BA23F0
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9D7834BA23F0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775463284; cv=none;
	b=Ua3/vv1WyV20kJKUtZvrvr2kFNJHRwqzoBThVOFGVqAy4i78W5tGylnoNcfyhq3lsXvGp+0DEKm9G4PKxGu8hZFFfZT869+fn+p04T9R95hUSOi3O6BPd2GTramXdEm2ePAb0LpbaAUix5Bmri49+fyovvs7pRH/KUyWQ/0ti6w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775463284; c=relaxed/simple;
	bh=jZcdSqZST6Ld6gtTzrDbF9D6gCjdQO6Cm3UPCITxip8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=e/59WeQIDibrX/xhSzpsmbbDwxwz5epgL4VIldlIcZ3INYoQBQ85aMMDIAvnqgEAo+lnnSmmyxatitJwI0dJkvlabjc9UqThMCm34ljJiGLVj3WT3vULr1aoRG/W+EiwrgyYcxjQrFAV22+LVCpnZZ7SiM6Jc2eWJN8exNZDAZI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9D7834BA23F0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=WVR8Ew+Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775463277; x=1776068077;
	i=johannes.schindelin@gmx.de;
	bh=J3oOsUlrmRziuIP80zm/roZpdDXwKWm5tpMhJxiTtjY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WVR8Ew+QRmZVNBZIzqGe94RrfQDOTL8F7tiytKXZCoYYsnNYV1PH3OHAo4WqBCW8
	 WluaTvu/akx980x0AW0XNJBEQvzygShcVxSNf+j0v5ooqSSMM5pG6rVfLqKsJB6lH
	 oynSEbdVtCkERh4IMZNuL0gut9E36Z5dZ/4Lrh6O2+KtyUGf94/HLYKR8YZrnkOd4
	 Xhx4t3IFWMQuEMcui9fw0PZTazBXtoB7/SAU9+NhpYNA7LUEue3Okv74Wi6bwek5q
	 lG0YaMyBqI6GMNUvrtl7Etk7ZDgUY1yY1KuxoN1cUBxaJ8gHbS6s5/kCP/3KmWOr2
	 My0H3lYtnc2WyUCnDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1w9wDa04nP-004Sp4; Mon, 06
 Apr 2026 10:14:37 +0200
Date: Mon, 6 Apr 2026 10:14:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix write data handling in pcon_start
 phase
In-Reply-To: <20260325130842.67319-1-takashi.yano@nifty.ne.jp>
Message-ID: <d1cd3f72-1c1a-6b43-c6a2-f442a5ac447e@gmx.de>
References: <20260325130842.67319-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5adob3e3yCx3z/tFtGsxgIkoGaVNGFT2sp7XRfSszvavjwQYFPR
 jO0qKIa3PJeuhIe6wG6XAzREMAKIZOzJcmuEnMWUu2ndsQkz5pvNDlZdIJjBkMmy2z7/L/p
 QuhY5jHFjQRfILXRtGFLHDaL5HLFsw1YM+G8BheUXnia3w2C7aC+q3fy+WeB9n1B/SeQ/6Q
 GHKvcDWCvSXolWWedEMug==
UI-OutboundReport: notjunk:1;M01:P0:6bzw1h3eSHY=;pqDFN0EwWtI1gDbt2jRnoeApgXv
 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
 r9Ye62gnE+X
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 6 Apr 2026, Takashi Yano wrote:

> If the 'for' loop in pcon_start handling in master write() does not
> break, 'ptr' and 'len' loose the chance to fixup the value. In this
> case, all data in 'ptr' are processed, so the 'len' should be 0.
> 1 byte is consistently consumed in each iteration in the 'for' loop,
> so this patch fixups 'ptr' and 'len' in every iterations instead of
> fixing-up at break.

This commit message explains the problem well, and the fix looks good to
me.

Thank you!
Johannes

>=20
> Fixes: 9d7440036580 ("Cygwin: pty: Fix handling of data after CSI6n resp=
onse")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 098c72f72..8e6fb9c23 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2257,6 +2257,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	    }
>  	  else
>  	    line_edit (p + i, 1, ti, &ret);
> +	  len =3D orig_len - i - 1;
> +	  ptr =3D p + i + 1;
>  	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
>  	    state =3D 2;
>  	  if (state =3D=3D 2)
> @@ -2266,8 +2268,6 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  		 the response sequence should not be written. */
>  	      if (!get_ttyp ()->req_xfer_input)
>  		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> -	      len =3D orig_len - i - 1;
> -	      ptr =3D p + i + 1;
>  	      ixput =3D 0;
>  	      state =3D 0;
>  	      get_ttyp ()->req_xfer_input =3D false;
> --=20
> 2.51.0
>=20
>=20
>=20
