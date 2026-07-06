Return-Path: <SRS0=9IpD=FA=gmail.com=sebastian.n.feld@sourceware.org>
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by sourceware.org (Postfix) with ESMTPS id 8920C4BA543C
	for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2026 10:12:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8920C4BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8920C4BA543C
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::129
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1783332722; cv=pass;
	b=diqOytD8gMfqDdX73wMTzoS9UN4mGZSOYt9zFeP4Hnv7nrWq6qNj7qfDxAWSNWEHDcp+Y9etMgGLEfQvDeTomnT+/xqYxkMBO3Poc/YvxohtcwQtU0MukAUEtkcTbukUYaifUB/IxoGTUcYYaPgOI8lVbNmofDvqKgu0D6JtctQ=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783332722; c=relaxed/simple;
	bh=gm35RU0uI99uO6JsQRyNjo2phiU18JnLoJP7xPOhjSc=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=fTo/kw70LGVrUYHvSkiivo/MTApmUouFt4jJZU7OxQjkNlYXf/xFN+Jy+BEKmMLJFTrFvHbjhxP3maylNzuWy8aL2EDzS5dM7JhO3XawlNs3T1iT4UrHxcEK8gm8SrXPdcrH+SEaC5LNhvY75ofrsDWl4TW1UWm9qgPD9DmU5Fk=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DAnzkl/S
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8920C4BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DAnzkl/S
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5aebae2f310so2442898e87.3
        for <cygwin-patches@cygwin.com>; Mon, 06 Jul 2026 03:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783332721; cv=none;
        d=google.com; s=arc-20260327;
        b=DWfsPSPJbCXGH+vp8dXXqhEq9lHeDpS77KxMGblljW3DCnR+E6UY4AEECBq9JdVgLe
         /euVGk/jB9fGnOdnge2xesUfRdlrpwQ8hBw2POu9EgMh8QOG8828NoopSvNBOxdR/l7x
         CvEVPfce07WRnCLHAfpLyu04dsm8XJKv9YM7NHVQwHezNtttReFm0GQq6OgBD+AyhT/U
         pX9PENltwIc3vzgiqleHCU3F4bY2gcnF007h0N9QKSHnEfSxcZ+OTCNm3MCbY20fscyl
         yyh0udq2MCYhOPkasvyzlnUNNTOa4nlv6AeIu/VYEI6ryFqrP6X7VqPUOL9B4Nc9H6dF
         FRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gn9UJs6rgHjD1vwI5mESqaq6eZ0Kwwk53rTyOGmCWhQ=;
        fh=YLobnwiB6mlxg8mZw4jwzI5+9rNrzFWI954radGPi+I=;
        b=bPlGUTkGg8ElCpFS0TSZRcF/gdo4pPnVqs0FhNBdVlf3Kfxem9DZxcy3z9HXbY555k
         OgFSk6WVllkmRQH4Hww9w8uWkkrgXosaDICrHT4+ZNYXtVI9vA+58LvSRMTCLGyYYhRn
         yRdpznEwovSwUZD1H/7Rr35XyVi1HEtzjOKCYRhvmuQdlKKHEvkdkbsbtsMy4C7/bKF6
         EtizkiA3ubzLO4eUX1P9juvBagn4AadAWZ0a1gb/ifRaxGdDAAx+BQ2ROVT5en9V7nWl
         b0aExdZsVZHxKwjN0IbrdcC9gr5mXSl9Qt0SUn2FmZMtLCZXWIBdMCiYZexSrrxSkyLe
         Zo0w==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783332721; x=1783937521; darn=cygwin.com;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn9UJs6rgHjD1vwI5mESqaq6eZ0Kwwk53rTyOGmCWhQ=;
        b=DAnzkl/SGabTDN4c+g3hJrYprwYVfExRXlbWwaAdsrlDcDM4aWHvZwBoiGy3txRXzP
         OgJRkfGnZtIX9aLekusz36KQXo2JYZFe+/kfFBYhKerbuGZhhO059aDBTWTvNjyGkY5L
         QS/wFQXI6vyIqAF44sPhPhFw747tS+KfcazwAiSqtKG2Z5BCgeRQY4Q4RMh9gHtdxRlZ
         7nHCXcICl3LZvyHE0wMlUmxHsVqzaEi3/RqSHYDyPS3bnceic6NAQN07RPE203I0hxgu
         37bEEu4V1P6/2kxFDAeqsN23QEmdMtkATglpN/bmHZJaFwhUNGJYf9FcRu5z8O6nKRve
         OIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783332721; x=1783937521;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gn9UJs6rgHjD1vwI5mESqaq6eZ0Kwwk53rTyOGmCWhQ=;
        b=oco65seCX3Yz5W43QmtrhU2OlM/WTo4LZYa8Nf4eMWM8ZpHAIxs50KeS1oAgCfnnaK
         8QU1vBToKRq6jEp2S6QEd+/JTUSn1lB8vWOPk8T2dKqrGk7GRvPBHZ5OyBxwArWqSEkm
         9JIMvpWMSVGap6gNhZKyd5bE5+4G0Znt9aVZqKSQ7PhiOKYBFq4jpVec275EHIM2b6Bv
         qILyEok2qzgBLDHIh3iVbRj64fQ/xCXRNL/0oXO9cV/cCBA1ufhfAYJz+vzugdXwD0dk
         ujjTU4xw/kzI/dhBtqYBWiJfmdURq04Uu/4xu/w7T4YMxpP0kR7j+zyEJEICOVDwN9v9
         ZARg==
X-Gm-Message-State: AOJu0Yw9TH9F1+NUsD3NOeMPE481j9I4rh0Fyra7Z1g619eMjHeWIOh2
	Jwq2SdK+t3N/Vn4KbosEDeWzIeqQV5yaBHTdkvN3XMZA3/eKcal8vj6sm+nj/mtYDyfnAPiHU0p
	PNhpVs+95noASytmD6VuQPjG1sy1wAgw7YA==
X-Gm-Gg: AfdE7cm/h8pgCSQF/hPXsdMI87WiHrcQ9EBXgovo6WpezkPPuuQ2mCscnBfI7dVAhIU
	MeZi53POvgJHc0EhU/AkVpdmA2ynZFItwo60JfdtgYBSLnfa4975UY0/XdmtYTRPdFN4twsZvrV
	eJvy025Nud8sLiwomuP7t/zSX+NIvUQXzG4qiT1dsEAMHQEPFEUmh3MNZd/FRDuH743t/eaVwDr
	L4t/gSSbMGGICNMyKxzwO3cqbtN87dUI5J3OdLcNjbvYIxuvFKwJwzUomKdfMnPe6XXXCUjKZY=
X-Received: by 2002:a05:6512:3a3:b0:5ae:bbe4:f4b9 with SMTP id
 2adb3069b0e04-5aed50c137amr1198155e87.55.1783332720867; Mon, 06 Jul 2026
 03:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de> <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com> <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com> <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de> <aIJ2kbx6UOK6mAnG@calimero.vinschen.de>
 <b05a2798-ce6a-28cf-f8e2-3f0cd7bf165b@jdrake.com> <CAHnbEGJT8vKZjR8aXqB+aANZ8J9P8G5bnLO6gf860FzAeCCXMA@mail.gmail.com>
 <8fadabda-8d77-4751-86a2-c9741624b648@dronecode.org.uk> <CAHnbEGLjarFbKBA37b5medyqcFAMuVo-dQB0n_Gwu_zWoHL90A@mail.gmail.com>
 <Pine.BSF.4.63.2603132030250.5777@m0.truegem.net>
In-Reply-To: <Pine.BSF.4.63.2603132030250.5777@m0.truegem.net>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Mon, 6 Jul 2026 12:11:00 +0200
X-Gm-Features: AVVi8Ce_GATlbGuG0ChHgpJnDa3J3Bkh5uUfnFIWqNSpnAwWM1vV3U5tT2Hujik
Message-ID: <CAHnbEG+a=UMEctqStWq_3otqhvcw5U38Z=JaFnViM117LWCvbQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, Mar 14, 2026 at 4:30=E2=80=AFAM Mark Geisert <mark@maxrnd.com> wrot=
e:
>
> On Fri, 13 Mar 2026, Sebastian Feld wrote:
>
> > On Thu, Mar 12, 2026 at 3:45 PM Jon Turney <jon.turney@dronecode.org.uk=
>
> wrote:
> >>
> >> On 09/03/2026 09:54, Sebastian Feld wrote:
> >>> Was this work ever merged into Cygwin1.dll?
> >>
> >> Unfortunately, not.  And Jeremy seems to have moved on to other ways t=
o
> >> apply his talents.
> >>
> >> It would be ideal if someone else would pick up that work and get it
> >> finished off.
> >
> > That would require a cygwin.dll expert beyond my skill set.
> >
> > What about adding the current work as build option?
>
> If/when "someone" can be found for this work, it would be far better to
> finish the work so it can be tested and merged.
>
> I can't imagine providing a build option for an unfinished, unsupported,
> branch of the Cygwin DLL to "release" a lightning-rod feature to users wh=
o
> won't know how to make use of the incomplete code.  That just sounds like
> more future work for us, to be honest.
>
> You've reminded us of this unfinished work so it's again visible to us.
> Thank you for that.

Monthly reminder that the posix_spawn() work is still not finished.
but needed. because the fork(),exec() performance of Cygwin is very
very bad.

Sebi
--=20
Sebastian Feld - IT security consultant
