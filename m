Return-Path: <SRS0=FZO5=CJ=gmail.com=joel.sherrill@sourceware.org>
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	by sourceware.org (Postfix) with ESMTPS id 96FB34BA2E05
	for <cygwin-patches@cygwin.com>; Fri, 10 Apr 2026 19:13:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 96FB34BA2E05
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=rtems.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 96FB34BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775848406; cv=none;
	b=V9e668vqrfIRARW5KxkFY/lP3gyMaIaaqv0wWUc7OK+g26BhjSZD0VHT7VfE0cieeOuN+L4zvpp6N0XMxJdDFFHdypAnQlX0eqCR6+tAVFbg/IrE81kCfMvENvImsnzakpj4tWtZ7tHODtfHfNG5camvDgwOhj6R0bCUj420Dp0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775848406; c=relaxed/simple;
	bh=9tDCgAg6Qxf6ri0d0l0kNrwkmuhcKd6/Rw7blX7DHDw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To; b=BoLXyU/V1vgQLNVZSZtrg2UFW6GntnoRYEXvuVPyGy0bOC9Vv5T5ZCLdMTboI2T56w4F7XATiZREJLfDupdmTpvZBBt+EepHqYgAL+SWpDYwtZMRKhWd0TvB0rUcsKj+MsByNupDvdsnr2RNesvvLDIIGd/K9y1scLdfXZ95MkE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 96FB34BA2E05
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-605159dd396so798992137.3
        for <cygwin-patches@cygwin.com>; Fri, 10 Apr 2026 12:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775848406; x=1776453206;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ns7M5N1EcIEh5c4yV0xCji6hzvoUkU1pMG1wK07h9M=;
        b=itAr/dcojxijgDXbNtkwH3EbuRy+sHXU5JXlGaFFAMIXPAQTSqbNIfgjPGIXWJVFlG
         qikm2pZX29axSBC9/VzMqwczJ1M9RRB5SMe146AbADlc188Hz3nT28+zLipVBIGaQcSh
         A4E8mhpC+VZQoeWvyDpr7KjiEpkbap8GEdpnvNlSpZQoCKQE6YubZEPYzaYMDrhMQi3n
         bY8P8okF+DOMzh3YXYM5l08k4Uioxw6i83VMYSfk+B4z8xIqUTMQjfjkJ8ruaCYqDIsj
         HsRRcwaszXqdXeehBqwg8XSXS+PrMtkURt/gH1WtDI3CURAISjSu4cKmUaDUbcFVed+t
         wkSw==
X-Gm-Message-State: AOJu0YwgpSvvSeTZLbvOweJcfxyi2eVm9eZDC3hSswd3Ie/q4h9qw2uZ
	JX2ZGyu6zTlXL63GQvL6c04/EeOfmmJIfCSLJnkHcv11cBb4XFbissg15AkjUA==
X-Gm-Gg: AeBDietwLa7onsvobW3W9DTRg2nkuAAoH6q1R/+VLJkFt08aayo+Ph+keaoogWd+/k/
	/jHCJiJljd3Sdd0h4/CdpKZot0arVnB8iFX9/QuGiVaHzeSq3+2yCGlbUkyc6Ws7XnFK1fhg0SL
	axnivT/oFGMY/oDym0KcOvZLe2Ovw8beyPa0zEO5CiqmLHl6PPohpbW4qq8E2R74m1EXiYOxGmc
	GxukyIrpfJB8A6pijQBoVc85xu4i7JXl2TP9pToMlv/2sCmdS6bJ1dWgHZXvbI1zjiv5IR88p61
	ZreJd1vHPKqoXaRc/b9XKvb7u/ZT2/XCMg0bgJutGmCw/qldjduhRtSFwUxIZLC9s1hIBBCNf51
	ZxHk+l2DTbsG/wLvNWvRhp6Z4N/6YGeArVgsfgh4/VE6tiZ+/YjEXWvd+FAR0zTqlgaXf6L/Q6Y
	20A9OyKfAmRnORdyKsdiDRURM3VRCgNR3MwMkzH3ifrYleGyLNk4A6iGan
X-Received: by 2002:a05:6102:94d:b0:5ff:2426:94ed with SMTP id ada2fe7eead31-60a00e43078mr2350424137.28.1775848405712;
        Fri, 10 Apr 2026 12:13:25 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-955f9c602acsm1691738241.2.2026.04.10.12.13.25
        for <cygwin-patches@cygwin.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 12:13:25 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56f44072569so312777e0c.3
        for <cygwin-patches@cygwin.com>; Fri, 10 Apr 2026 12:13:25 -0700 (PDT)
X-Received: by 2002:a05:6102:5045:b0:5ff:17bd:9e83 with SMTP id
 ada2fe7eead31-609fefc059bmr2242864137.14.1775848405062; Fri, 10 Apr 2026
 12:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260408151902.2022129-1-joel@rtems.org> <20260408151902.2022129-2-joel@rtems.org>
 <adfjbpR0weBVzkWS@calimero.vinschen.de>
In-Reply-To: <adfjbpR0weBVzkWS@calimero.vinschen.de>
Reply-To: joel@rtems.org
From: Joel Sherrill <joel@rtems.org>
Date: Fri, 10 Apr 2026 14:13:11 -0500
X-Gmail-Original-Message-ID: <CAF9ehCWM2Rii5=7484ZRSOOjmY_jqnvauHjGX8NQ=z5q_2EvTQ@mail.gmail.com>
X-Gm-Features: AQROBzDo0EjuPBAHjgd4zNuuVxprhhSqf7lgruDaCTE98nL6tWoMDRtxnLYDWiA
Message-ID: <CAF9ehCWM2Rii5=7484ZRSOOjmY_jqnvauHjGX8NQ=z5q_2EvTQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Cygwin: winsup/cygwin/include/limits.h: Add C23
 ..._WIDTH definitions
To: cygwin-patches@cygwin.com, Joel Sherrill <joel@rtems.org>
Content-Type: multipart/alternative; boundary="0000000000005bdb48064f1fed37"
X-Spam-Status: No, score=-3028.5 required=5.0 tests=BAYES_00,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--0000000000005bdb48064f1fed37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 12:35=E2=80=AFPM Corinna Vinschen <corinna-cygwin@cy=
gwin.com>
wrote:

> On Apr  8 10:19, Joel Sherrill wrote:
> > C23 adds the following constants to reflect the bit width of various
> > types: CHAR_WIDTH, SCHAR_WIDTH, UCHAR_WIDTH, SHRT_WIDTH, USHRT_WIDTH,
> > INT_WIDTH, UINT_WIDTH, LONG_WIDTH, ULONG_WIDTH, LLONG_WIDTH, and
> > ULLONG_WIDTH.
> > ---
> >  winsup/cygwin/include/limits.h | 56 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
>
> Pushed.
>
> Thanks,
>

Thank you. I'm happy it was OK enough. :)

--joel

> Corinna
>

--0000000000005bdb48064f1fed37--
