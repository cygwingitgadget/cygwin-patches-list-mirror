Return-Path: <SRS0=nquO=HF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 08E474BB5926
	for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 10:53:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 08E474BB5926
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 08E474BB5926
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789296824; cv=none;
	b=i4XNyYsztvOrTP9R7fvROqDOBNM50Q5fNRbi+fVivYC/BHLmCa2d1z1POCGJH8bvanPZwpaOZXH6pA7PZhIYH4k49yfPJEFueX/Lba1WEVxA2OQ1r4yfBvDwBxWP42QkvaV+u1wrwA95NxuOLaK7lMKTjnXzDFj3aNOlcaRWiko=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789296824; c=relaxed/simple;
	bh=oul7xJ2SwNALPZeslPxoj/XJkqYtqF03ClFQNDTXdfc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=i0IiQFZwZ5SOrWzclVmz7fMaFkfD0j+VTx2+TuAtvtsdxN+JLYKpvKAOnqCYLSuhIvSGUJq6QA9D1HuGBunS8uwVpjA49y+pkV8JK7gBzjgvzCoes5kmzFlxVdc2AxHvSBpQc034AQmYRPQ2RN9vCyV/4+IFOnKsduEsSE7kq1s=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dgNesikP
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 08E474BB5926
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dgNesikP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789296822; x=1789901622;
	i=johannes.schindelin@gmx.de;
	bh=qDABqTsFNjuPnzJkBip+lrYLWEK8YyBF9KDwQuWbLk8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dgNesikPnHJHJhO8ETMLKqDzK6ZLul5XYahwDGwTTUOjlLmYpE2rEJe0kNzSUT6Q
	 BlMcHtydMfMQswqwYVNKwLrhUeVi74CyzgKXcRasXlVCLndaxnzJ7yG4Ych2qp+kh
	 r6HYoxlYP7Gj89g/Eao0aGgmBO+rCkiJczcnu29UoIkpdJTpWQhTxo0S7qtpO2Iz/
	 pnyi2wOWAIx50XUkxTWeToTQRQk3PrGr8ISc8CGm4k5IEB0B7Br2Y91PhpSDIDmW4
	 Z8YkmyCnx8u3nFwvMY1qlsyVdM5p7cQDj7P2qOgLMQS5yDCRYFtHCneGa697Sanzn
	 rKIsy5gzFOMSTXfNzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeQr-1xIknl1GoV-00WZWd; Sun, 13
 Sep 2026 12:53:42 +0200
Date: Sun, 13 Sep 2026 12:53:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix argument of process_input_message()
 in read()
In-Reply-To: <20260819064404.128384-1-takashi.yano@nifty.ne.jp>
Message-ID: <8cc1a17d-1626-54f7-58ef-d7ad4d9f5e81@gmx.de>
References: <20260819064404.128384-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:PbDLPa6b4H3zij2KOfxmPcG7cytYbTLuHp9e1FKcjLxJLxg08/c
 +Wj59tYJTaBvZZOzCSB9SL1Po9vnP/63cmxHLuh2L9ToPmucdr5QFOLydm6Zb12gYzzE48O
 oteXTaz6s3BnnXCLCBRJHVWiMzNPVJNGjDsnOm/BwsDcN/8JFATLDmnQQqk9k1q/uidwCLL
 ykyJjafs7ywbQxeCD3zQA==
UI-OutboundReport: notjunk:1;M01:P0:xlwsNZmXj4U=;eZ92cg+BoVM2uWV1eOS4LBFqMMB
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 19 Aug 2026, Takashi Yano wrote:

> The commit fac73911f5a0 ("Cygwin: console: Fix typeahead input for
> bash") introduced an argument to process_input_message() to restict
> the maximum length to be processed by this function. However, the
> commit failed to account for the number of chars already copied into
> the buffer.  This patch corrects the argument to process_input_message()
> to address this issue.

Thank you so much! From my side, this patch is ready to go.

Ciao,
Johannes

>=20
> Fixes: fac73911f5a0 ("Cygwin: console: Fix typeahead input for bash")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index e349afe9c..f04cb1b48 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1367,7 +1367,7 @@ wait_retry:
> =20
>        int ret;
>        acquire_input_mutex (mutex_timeout);
> -      ret =3D process_input_message (buflen);
> +      ret =3D process_input_message (buflen - copied_chars);
>        switch (ret)
>  	{
>  	case input_error:
> --=20
> 2.51.0
>=20
>=20
