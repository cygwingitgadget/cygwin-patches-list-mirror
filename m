Return-Path: <SRS0=+0A2=CE=gmail.com=philcerf@sourceware.org>
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by sourceware.org (Postfix) with ESMTPS id 3D2FC3858296
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 19:52:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D2FC3858296
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25e8b4181easo749620a91.1
        for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686945134; x=1689537134;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxB1VXKjAYkEuqb6IBlKWxHKGH6mScJ1X3s1HVv9Pjc=;
        b=ZpPnY2xgZItg+MgFFIqQRbAyphTI7JHKdORGBOCqjxL/M5GZSnV7ztycr/LVqozcsE
         xrps0RrL4ZIZZe00ax7jF8tSpx4VwHSitvskn1cdU9o0tHCJBT+jy9EfDs4R7JV5G53m
         NnFCX3ZY2AZswBwaUgzg0CKJpaglHap93VcQ2p5bYeCe45OvfCSp1Hmo5mm8g0+aLyuJ
         vPgtWDE7IY1VwfMe6zD7++FuAwAWxij+o+BAPxypb+HybVVz1U7oae3pLvtH70xaAyLp
         eP6pNMSOQQ4T2unPm7tlxebZqDXvV8USaRpPbSKzykakfg9iHuLIe9BqLVBvtUFnbNkr
         L/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686945134; x=1689537134;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxB1VXKjAYkEuqb6IBlKWxHKGH6mScJ1X3s1HVv9Pjc=;
        b=C3+PcmIDb0kHpBz4vf9+RgbIG1ukSHEo/w9eVAPswuajTPjqbf1adyjEeYx6H0d85B
         zzVmizy16azEOsp9ufFYCZekTtnCEf1tol2G10cZLyrZQAqAhAOCuRkuX4Qz12haUBy8
         Kr/Tkz71ZBBRGvv+rhpZQwMMTJwCeTFHMzatBTIO0xgNLryh+5E8kEtfiJtmKSGkDYRN
         TTRCfc56lGDXiS5j4Z1QRgd7T7iBJu1SLt04CzkX5rgj3xW/jkhvrUApwb08lTI2dup5
         ENlBNddiXFSkXtGY4XL+oT1TZNllZpT7ePypDyDa5Dx4E1RUwqnlm/Os2EhcBkWfCa3Q
         vBvA==
X-Gm-Message-State: AC+VfDzTaXTy6IcaW4h3GG61ChgCUi6p+I91LLHgSe151MiWwo4l5ME/
	wpvbvDi2lKUBmrL7BxT/ZoyUWFtkRhEbYjgZ5B1+qQMD
X-Google-Smtp-Source: ACHHUZ4EttBtp+kOBy0PVNRXuhxbSv3PugzmmytaOmb31Fon8FyNk7yXkcajwg4YtH0485nTDeq/HUNROOmw+xL0Njk=
X-Received: by 2002:a17:90a:3d0d:b0:24e:2e86:5465 with SMTP id
 h13-20020a17090a3d0d00b0024e2e865465mr2386770pjc.31.1686945134126; Fri, 16
 Jun 2023 12:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca> <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
 <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com>
 <ZH80lgpsfWwCZp+R@calimero.vinschen.de> <CAN+za=NXXrn_atWyWi4zUgELkhvm5qecB-hQYFJ7Q4bdFHopFA@mail.gmail.com>
 <ZIBWqTEkn9c9GWfF@calimero.vinschen.de> <CAN+za=NjpooX1JrwbgDgX8yzHkn6AwtYH8yCOjzkUspMZd1W6g@mail.gmail.com>
 <ZIx55su+P5zInrqa@calimero.vinschen.de> <CAN+za=P4Ra6-4Hc6P1HVODT3B5JtrJvV7bFWt-PkOeiawr=4NQ@mail.gmail.com>
 <ZIy8x7cxIQhTmO9U@calimero.vinschen.de>
In-Reply-To: <ZIy8x7cxIQhTmO9U@calimero.vinschen.de>
From: Philippe Cerfon <philcerf@gmail.com>
Date: Fri, 16 Jun 2023 21:52:02 +0200
Message-ID: <CAN+za=M_UHnv4HTSNFL1sFESgBnoR_3omoj_-VH6jrRvp_7Lyw@mail.gmail.com>
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
To: cygwin-patches@cygwin.com, Philippe Cerfon <philcerf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, Jun 16, 2023 at 9:49=E2=80=AFPM Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Even a SSD has "disk" in it's name :)

That actually stands for drive :-)

> Let's keep it at that.  I pushed your patchset.

Thanks for merging! :-)

Any rough estimate when this will be in a live release?

Regards and best wishes,
Philippe
