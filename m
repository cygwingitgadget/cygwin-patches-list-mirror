Return-Path: <SRS0=IJIq=HA=gmail.com=thirumalaicse2020@sourceware.org>
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com [IPv6:2607:f8b0:4864:41::10])
	by sourceware.org (Postfix) with ESMTPS id 4BD4A4B920E9
	for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2026 04:44:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4BD4A4B920E9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4BD4A4B920E9
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2607:f8b0:4864:41::10
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1788842684; cv=pass;
	b=QPQ0PQgq4jie3rdPAyYo/lXMG4bV4LHqInELHZ2DTClPCW/SKe29CxXu6YxC68sQ3i1PPHBYg/vHUV67gs9Sm21CIHZnZciN8OW6tdigIZZc/Uw9L5dOH2XCcCqJo4cSub9VVbus1pWp7hc5WgIi3vgFghFbztMdrkV55xG8I+E=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788842684; c=relaxed/simple;
	bh=c2+SROvd3GwVpsvO0+UZXWfLpyJYgCqrI2MN0ir3KPQ=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=faxBKMlXFYxRqpNbfiEEn9+zO7sclvJZvlRW4daM1sHEqIsQ8PSZO6YK3wfPByuLoEk6kiCARjhQp1Jz8mkQA0dz54ehauF9ib/wJPTH1iPjiXGBOtAnFEtg2v/GWm+DFRcYRSfsFt/Pmq1wNCX/bkld0dDbxvFlNSPPS9KFiGs=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rgN2Eybs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4BD4A4B920E9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rgN2Eybs
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-858facc86feso281597b3.2
        for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2026 21:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788842683; cv=none;
        d=google.com; s=arc-20260327;
        b=CSRPEZgrLb9IQ8nQE46IWj7VTUppJ9+izYuZzCWcJoC7UzfQzBO17WeEiINuvqthcA
         4v6vVw4ac7eSEevDx+uOSJrjKhw+4Jf3zKOEwqN9CIDb9YEpjRLZBqPFu41jo38+tF80
         T5QZgCkMG6rJ4H45PCNdS3+kWJlvPrDwx3looa5nerS8vbYu5I1KDukWH1m0Tkd1wwaG
         wmErslm3kHxn+h/62bH3ypZuDXueNeUh6DFAG35SfF9q4HSfYgIsQKLovPKRLv7D+teb
         74b5T2YQhNgndobwQzosspgO15/SJdNiYy6THgkN4f4pGLcsUt9v7tFOcaJJ5geEHqk/
         B6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=c2+SROvd3GwVpsvO0+UZXWfLpyJYgCqrI2MN0ir3KPQ=;
        fh=0QKKDkzYjEnbwpzEUVkLTL8e0Bu2pr/udJnCSu5+gDQ=;
        b=OGMlUohtjapU91t9UJ6qx06Zk8DXTLsBbqthHyyhvCzpKl6IGOxIrBEtwJ+VWpuogV
         Sot5G67/0PxCKrbXN24LzMfMQJLKjYIdo73l65kYroc3JCF+cNuzk+ayjXSRAMFRDXGl
         8/owocgTmeXmqYRz5yCBZRbOJwRL/PxaVRwGUcEk3/C2dOfWlXvthUDTeMiX0FwijqB2
         4EKvZm3OZ6a2e0fSEis/Se9h32MN/y21cgICnnoJa5p41qhuZQvy98DJ2fWLvBqnSnuP
         PH9e8NogS0bf7GtGrWDCpWG/XJF6dC1ZzLaA5ddmGgxpFzSPaPW/HAXdfnHU0w7pqnmI
         /7Bg==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788842683; x=1789447483; darn=cygwin.com;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c2+SROvd3GwVpsvO0+UZXWfLpyJYgCqrI2MN0ir3KPQ=;
        b=rgN2EybsDFSD3FOUXxnoLQsDCAAU3RWE8neZpQLagAhN3MjvUbMVd9Dv0pkVZMyHZ1
         TAcuB+Lhj8hV5CgaMO0/YJ4RDOEDnJWdR9vpCi/OytAzzwJeZysqQcD4ozOplu9mOmgo
         OAIHz/DlPotMquXL4C+iVjywt+o0QqrBAkTD2IjqF8+BX7YbqxnDmLvlW5iP1zG7FSCX
         VlpX2l3XKEPTyRqlQOyEc/2BbjoHTcstLvC7bovbXpK5Am1Z6zk8hh5TdTFQMxwYpPmR
         rjXkFY0ZqYsJJxpp2O5cT69ckzbh+ZgZadZ4FLtkQ6Wy9sJiVGri5ALGk2CJo+GPsPgI
         UZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788842683; x=1789447483;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c2+SROvd3GwVpsvO0+UZXWfLpyJYgCqrI2MN0ir3KPQ=;
        b=DkSS5laTuouWX5SXhmLU2km9QElWBoJZj4GlnoBtH3LhrZeM5GPJf3/iIRZwHkdCcs
         OrEs3vG2znI5W0+TL9/zW9CoKojwpMKIn+uo3O3btsi4DZSy5HReDmg3dO4mGXptTiWn
         CXo2DCr09hwFDS/RcUjwHQJxJHbHGn49S0elWuTXRTm2UHEIuO+Sr7Fx+6LI8EiyteDd
         bKobPehO+SGcJI63Sou6WZHHm9w0m0fizxTyE5nwdYGcgi7MDPILej4lBTgxhOi3Ulbz
         alEjYcgM56WSUlQ6bp2rHedwZHxP3mrFozeQJs8Y9wIjSL61+LRmSPKrGvhfLNZU+wbP
         9CpA==
X-Forwarded-Encrypted: i=1; AKwUvBys00DCSvimY3it61CciUcerXwLNHBZzkuqp82XRMmzbv5yf/mmv262yi0WxSGgOGSZQrvtNnRccmSG2DkCuA==@cygwin.com
X-Gm-Message-State: AFuF++kQjq8H8s82EXmfwrfr2Vz4ZYey9Tu/gx8Wwoz5ixHqT/62tsvf
	EFo9Igm89D/hSEnJ7zT4jRqB0lckKnaXNA6Y1e2KX/Q+PKT/hkhJ0p3I8nuJi5oi+X7k3/32gB6
	Ra3sIWkrEIE+GO+6A1Mo693d5/GIwoJMbvA==
X-Gm-Gg: AYBFou2MiSs0Tqc687Kzh09yN6GEFIO+/LqlYr2pPikFhVdhjszy1lRaLJ7SsWYlEb/
	RapQ9KaivG+QbGL4mgBMhlMuVJfjh43Br/KJ2CJmpLg9Y/ru/N3QKENbzg7tUJKGdguSXHb757N
	GjUUFo5ErWhZiHpK1e8waWFqqBZYPQl4GLLGl+3mWC7x6bKYpDZdvCC7xX1FJ3VdaVrccf7xWYH
	QJXLPCk5RDZHHAI3BPklJ2LcjIsmOoIQ+kq/QWMUDJUO6J+gIip5numfY9LIFZA34Jny739EA+t
	lEYhwhruZLkImCpuUGYT9fuAQ9FkqSShmk79OBKsPt7HwH9QQc30O/tGV+g4U7yFrzy7iKPJnmz
	dn8hcLHJCbs7/ww3a6we2xiH6vdox1tFg
X-Received: by 2002:a05:690c:3582:b0:870:48aa:472e with SMTP id
 00721157ae682-87171651665mr100449957b3.0.1788842683036; Mon, 07 Sep 2026
 21:44:43 -0700 (PDT)
MIME-Version: 1.0
From: Thirumalai Nagalingam <thirumalaicse2020@gmail.com>
Date: Tue, 8 Sep 2026 10:14:42 +0530
X-Gm-Features: AcwNN1Vod2l-MswBbaSBflclByRNXKw0ECGkHtAfh9Rv1IuB_Lq7yvv_3HUz7Xs
Message-ID: <CADiGZiEemav5YcWESCqs=Bh2uxGKbpTLsnFxkAKAwS7EGfMnZw@mail.gmail.com>
Subject: [PATCH] Cygwin: gendef: add_sigfe_maybe for TLS initialization
To: jon.turney@dronecode.org.uk
Cc: Corinna Vinschen <corinna-cygwin@cygwin.com>, cygwin-patches@cygwin.com
Content-Type: multipart/alternative; boundary="000000000000ae77ea065af164f5"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--000000000000ae77ea065af164f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

++ Jon turney & other folks on mailing list

Hi Jon,

I saw your email regarding [PATCH] Cygwin: gendef: add_sigfe_maybe for TLS
initialization on the mailing list.

I realized that I had missed sharing the earlier context with everyone. To
keep the mailing list informed, I'm forwarding below the email I sent to
Corinna on April 28, 2026, while transitioning out of my previous role.

Adding it here for reference.

Thanks for your guidance & support always.

Thanks,
Thirumalai Nagalingam

On Tue, 28 Apr, 2026, 3:54=E2=80=AFpm Thirumalai Nagalingam, <
thirumalai.nagalingam@multicorewareinc.com> wrote:

> Hi Corinna,
>
>
>
> quick heads-up that I=E2=80=99ll be moving on from my current role so my =
colleague
> Chandru [chandru.kumaresan@multicorewareinc.com] from our team will be
> taking over and will follow up on ongoing discussions and any pending
> queries.
>
>
>
> Also, a few pieces of our extended work are nearing completion and
> currently under internal review. These include patches around aarch64
> support (autoload stubs, SSP enablement, exceptions.cc [make-context]) and
> an initial CPU ID implementation.
>
> Patches will be sent upstream once it is ready.
>
>
>
> Thanks for the support so far :)
>
>
>
> Thanks & regards
>
> Thirumalai Nagalingam
>

--000000000000ae77ea065af164f5--
