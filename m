Return-Path: <SRS0=kRW9=BC=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id C3DDA4BA23CD
	for <cygwin-patches@cygwin.com>; Mon,  2 Mar 2026 12:41:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C3DDA4BA23CD
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C3DDA4BA23CD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772455274; cv=none;
	b=LxwrmfqkqhDtJZz87vfQlxLzpQnJ8mpKCtzicQOdbbyjfB66jjbc6q8wqmEHq+w+X4e2GFwImRIv+IA5DbuRiMSTveTvxdQ3E+Uqtsl5yu6ihkkEzHz6/tdVKTcDhDAVdHDahlFLB7867qM8iE8wXHvb90mh6F3LqFn2j2fnvX0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772455274; c=relaxed/simple;
	bh=cY/Xou8E3mO+/ygBOqq4XLD7EZpEn6ViWj7V39oJ3zM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=YF+JgQ5v3c4rfeIv/gU5ACRqAzrQo80qrI2Pa8u/l33g48/6qMCo20JzYe8d/diYf8PU7HtaICZHk8zdrx87r4B+rXlxtGjxgjK/8zQRr+Y01P4F5eFRx27+RoJs4VgKVxDKRo6xPm61fiopUUkrMFr6aoRYtN7SNE6BVmvz6WM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C3DDA4BA23CD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=awPNi+GZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772455272; x=1773060072;
	i=johannes.schindelin@gmx.de;
	bh=ZnHSjMXnpGotPP3CEwkbCQqjsQeEefIzG3CXyeqGJoE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=awPNi+GZ5guHmCJZQUdjJByNTVJ+SZRb65pNXgX6D8seHJ1PQ2iP6nON0fbuP9fl
	 1mOyi9p/yPhuL16FX00QALyVUN1uuVqzOT67AbWiwnU51wMGeHmpad6bCbGPT2m1W
	 sbyGpygKJ8B100ylzRqOwZEFRVHmg6RGDFXZy/kGpu/KGbn0oSIa7sTwkFkTguIjj
	 gooqGzt8YqTrmZc4MvUoq4EKZQKceUOchbmSvPgujaBlh7SDXwaku5PEfFJUDYwpH
	 +PMlJFT92HdRWT9W087QEVGq6Lt3WZYRamNVnMiFONSWdJIpsAfnVbIVBVV64p4j+
	 E4mcFvN1JiQrYuJVkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1vvf0X1vsL-00BrpS; Mon, 02
 Mar 2026 13:41:12 +0100
Date: Mon, 2 Mar 2026 13:41:10 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Do not call empty WriteFile() to
 to_slave_nat
In-Reply-To: <20260228192538.1908-1-takashi.yano@nifty.ne.jp>
Message-ID: <969e7005-6e43-dbb2-8524-33995c6cde3f@gmx.de>
References: <20260228192538.1908-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UHSyPhgEKcZQAKtxb3cwgqBmVn+qhjlGNj3pY8SDPqy89fDJjBn
 /Ob4jVydlyjd5ZTu0REdAfdNdw1Uvymo8gvq75rnxPg7iuHbkPSrEltzchgr8sWKxfNGCiv
 O6cnBK0xcRfsN+tcOb5b1Mwhb+edrjHMeKns3sDB9v3ZQWmEHcQX52TeBNiYyijX7XNAlgL
 Jc8aEWjCo1eyZgld3sWiw==
UI-OutboundReport: notjunk:1;M01:P0:65665T1Y2mQ=;InvucFibPqXxPWZb9dwOXwGLolv
 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
 BLllpdgDibwXKCoodTGOgcvAZlcb5ufcq/Wjmd
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sun, 1 Mar 2026, Takashi Yano wrote:

> In Windows 11, it seems that conhost.exe crashes if WriteFile() of
> zero-length data to to_slave_nat. This patch skip WriteFile() if
> the data length is 0.

While it is surprising that this should crash, the patch does make sense
to me.

Thank you!
Johannes

>=20
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 50a1f5ffd..bacab3ad4 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2243,7 +2243,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	}
> =20
>        DWORD n;
> -      WriteFile (to_slave_nat, buf, nlen, &n, NULL);
> +      if (nlen)
> +	WriteFile (to_slave_nat, buf, nlen, &n, NULL);
>        ReleaseMutex (input_mutex);
> =20
>        return len;
> --=20
> 2.51.0
>=20
>=20
