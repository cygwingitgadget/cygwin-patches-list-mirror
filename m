Return-Path: <SRS0=eczl=BK=gmail.com=takeshi.nishimura.linux@sourceware.org>
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by sourceware.org (Postfix) with ESMTPS id 0F3FC4BA23D0
	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 09:39:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0F3FC4BA23D0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0F3FC4BA23D0
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::62f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1773135586; cv=pass;
	b=MJLnyQ+EfFRDsaBQadmbn8A8FeuwUgbMQ2wLwpAfDH1JCx5RBrWauexm2L2fI2sr1T2oWAdV6S8V3gg7diGI4thoUuLr4TholvnqbZSYsYCd+nVDoI+Pxi1754kiAbpWbQaYkx4t5fgNvgtqpxWyikhfRDJb8BUmgKLcPupiir4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773135586; c=relaxed/simple;
	bh=GAnd7ria1v+sZX8OPeKhS6ggurYm89xvvpXxKpJGepc=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=MDbdbfBgiGr/01F1mYvxTcR86+zcwJNhUbksUGFBvLU5RVbDp78b5gpdOGHeVVgiNltn9KhwZKhA1qyC73w5tW5EOyaeXyNOTEiA+Lzpueoh7x800g5oOS41MSjwf0a9Hr9ClBVQhs2hGuieJSRbQWnHKPf1RT2kIcxI2VVCmBY=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0F3FC4BA23D0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JNfH9coP
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b886fc047d5so2054788066b.3
        for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 02:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773135585; cv=none;
        d=google.com; s=arc-20240605;
        b=TbJuvANPDdd/JvFjbq9odVgdnBwwefJG3m+vRdpq/g6oMR3IfB808T19w/HbimPrt6
         di4QglcYF+1r29i/VxFtUCwpii5eX+Fy8wAdq72jWeI3TctkvDbfiXpqxzpp7nN44dzk
         u+n6RLsf5HS5kcmqLrMKuQaq2EwoYWbq1qri2IkzVa4xywEcAWo7v/F24cYfZnJcy9tF
         89rw/rBSMaHc5qKYWsF7Wopjr0pJM3SsBf9Ip6v3k+XYPyEbX8j7uaTxFMQx+xgL6Jf7
         h2Sc0Wnv5Yn/vFy9225x9omc9kEpdANWzKxor18V7SxnH9D2UP22Ip8/+vHTOvyKV58a
         sZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQOWh40d/nnZmtlxq0M914DAroUiw8MNKtpYHYH9+oQ=;
        fh=N+TkVz5UX20zGxAi+zL59HO6q0Qui51rYgs+hcmR7cU=;
        b=cnQ9j5Zo2BFpjMbUSyPpFMaTGlTqjU0gTFyrj/nmA8rp5TyKECbRAv6/43CUZTTWWO
         2vJU19fETD2jttw5Wxmt3gBcJLZ7yhNkRDKtecUfmwc+BaTCZO6I8yvWBpSUQ3P4+ALC
         VTPtRHpoS1d0Ho/puuo6sHGg1M2GNCAViheyT4Np5aZPNTOsOOswbauqZ5GDhXEXMZx1
         7DkqUByD4UuOLftRq8PYq5ysHN2vuf5HKAOhila9FRJbLUDipuhhY0+zBoS+mW5sTdeF
         BnpHsf90anv41uvyrulDJee03pHTiImFcsCkqZGFkvAfrmdwhLamW+eLSggmRJLAycpT
         XBfg==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773135585; x=1773740385; darn=cygwin.com;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQOWh40d/nnZmtlxq0M914DAroUiw8MNKtpYHYH9+oQ=;
        b=JNfH9coP6CsBM0WjqjnJFwicsF0r5WA4dtJefgu8931nlKr532qo2ON2tj+hMkqVyS
         w5hTEpDvjJ6jnBr10tmYv5+qqu4U+7cPYKyk+cfnGn4ILcZdeKJyCgR3tc881PWNRYAa
         L7ae2RcrNa5zLxLIxzPq3sVZu70OuJapR7A08M7D8JtRq7eWuvNuGw3TT+1bbz1V4Kyv
         MlsHcc1UCSBv4wxZSbYBRd1WWBmJUqEpg+EofGEitQJYgjeKgl8lIkxq3DtF+j1TpMP8
         ex6FTSHqZOtaApRTXaiR2AG3VX8byVNjl5QEvP4kMTxDqOMHCpM7WW06plwn0QtETDoH
         t/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773135585; x=1773740385;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQOWh40d/nnZmtlxq0M914DAroUiw8MNKtpYHYH9+oQ=;
        b=PVQghMiZnEv81IMAFI60XWvOy70likpGvlaGMgjf2EOSVroeOUTgA15ix1ZztCe6LV
         MyYKquBi7UKSgwM7QbWAHjWa27aOyyCpam1ONtnY6zC1W4HfRCHZ9NOCi8tiePL6iR4n
         HBDN5FCYBy+TIY7JrHhwe+ghm94smRkl+fJdCTFJ3fUcgq0OnFLDqTGrBGxOEKbpFQru
         NGm8qN5TCL2pMQgvfQxk88udWDAkkCtvYDdd3VtybPYZnysW4eYiWWM3g5pLN6od11EO
         Cyis/L6VJRjG55wiWCs/PV6cYbDqogrqfae4cc/zHMV5yKboZWsYQChu1wsWj/EQ6qoE
         Pe9w==
X-Gm-Message-State: AOJu0Yzj4dg6MwTkcrb3+d+B+C/Q+ctaP/d+uv34IR1j9rCAJYOeGS1m
	P+vHTSTzw4a+cbmfKlTLs0p1xxW1/V/sc+tDD4O38FmNIu7po4JOhtlpJHIlno+UGY95FQNYHhM
	hXwOnxYZHhL3h7cYuzLFop+fvJqiiSHooCS8k
X-Gm-Gg: ATEYQzz92EE6Im7yXQDd+BzQMvJNv7f2VyQIrBSK6mKSlZGr73+nrb4+ihYrREylTj+
	cZ2nrHfPZD+DD+2mL+LKbOK76XuBMIiS8vgAUN0fP1NdC2oT2bQXNYjJvynDAOkkiSw2VPtQMdf
	qDQoLHXA7BQv/QEDGtm56kqKCETk51bfrQZ/2gpHDHKmwAUrr5lsZ/MF/eIdX1tMitNAnFIjI8n
	tJ4kcNxN3JNg7K59YG4mdvAmUfDkKz1Ac77iNUJpXSnDAyivrI5QaoLYs0/Kb0TY0/2N29Sa5cz
	DjuAHuWlooTkKRS00Xm1fTdqz6YijqSfft7ly7mS3bOSkFA+
X-Received: by 2002:a17:906:ee88:b0:b8e:8874:8367 with SMTP id
 a640c23a62f3a-b942dbcece2mr739570066b.8.1773135584259; Tue, 10 Mar 2026
 02:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Tue, 10 Mar 2026 10:39:05 +0100
X-Gm-Features: AaiRm507UrqFtYfTq6T9yCTYlrVCuQf6WsQGfPZsTPxuASCgmWRBRyfS0k4Itvw
Message-ID: <CALWcw=EXF-MgsJ+=GYuVwUeQdAdKsxsSPu=J_KNvavCm6mGnKQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] A few fixes for signal
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, Mar 10, 2026 at 9:51=E2=80=AFAM Takashi Yano <takashi.yano@nifty.ne=
.jp> wrote:
>
> Takashi Yano (3):
>   Cygwin: signal: Wait for `sendsig` for a sufficient amount of time
>   Cygwin: signal: Do not wait for sendsig for non-cygwin process
>   Cygwin: signal: Implement fake stop/cont for non-cygwin process
>
>  winsup/cygwin/exceptions.cc | 19 ++++++++++++++++++-
>  winsup/cygwin/sigproc.cc    |  8 ++++++--
>  winsup/cygwin/spawn.cc      |  2 +-
>  3 files changed, 25 insertions(+), 4 deletions(-)

What if the non-Cygwin process is MSYS2, or UWIN?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
