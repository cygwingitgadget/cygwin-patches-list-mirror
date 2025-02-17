Return-Path: <SRS0=ONb7=VI=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by sourceware.org (Postfix) with ESMTPS id 8C4B73858C78;
	Mon, 17 Feb 2025 18:07:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C4B73858C78
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C4B73858C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::635
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739815641; cv=none;
	b=Q2uyzUBdaDuvYCZuQ5i/lMyVDzUh4FAlVFaW46obgzGkpH+M5sS1zn9068MqsKwdHp6/0g3/NAviVfV/OTVisdjfgYc01Fb5EhLbUr4yc13QRazqlAb7EtiYx6R63ddTmFonGpCks1/6rUWGh7rJsj/+FFxfE1WdNMqpHkp28f8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739815641; c=relaxed/simple;
	bh=T4S7HygrCkMrwflmiT0vqqBkier8J1a1B7roEUoY1tI=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=U1bsQHHUg8t08qSx3RbAOD9LxZdIZK72E+1T1QxydIO/ZBO+SbYIZ8WgfShcpy0FYRblRPdkTSI33wJGK3cgv8RQw3xwbSBgn4JXc4P7vByKRGN5oMT3w8D4Qcx9aleOyqH/CGEBtKW6/WNcdOOQfwemU44Xo66CUz4a1b1QlnA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C4B73858C78
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OzBowoTU
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-abbac134a19so112925266b.0;
        Mon, 17 Feb 2025 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739815640; x=1740420440; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k35Do8WCZAMLoa/h4EbievV16HfR92e6HRbOPq5LVAg=;
        b=OzBowoTU4QjEJLvUt5rlyT1T/FTqakmXVQyvMZI4Ph0vgumJUr73JbLSSkFmr8N//B
         8Bzo+h8q1UE6j+Eo+wF+aRKEaqZX5EG4EBbbV1gPZu4d4EqTBy02Gr2ykE1cRX0v2WxG
         LFC4rzwzF8u3+TEDjViZGhdgMnCAgLQnyh8HlQv2Ein8OmSB+XSuM6NrKyAuCVKYjhCb
         UF9YTNl053KSQ9VNjpHbaWZ6oNX9jgMRRenqQDMj0Q/8JlV5+TYJ5J3ZJ0AT7QMpATxS
         prWXAuyPfDnkIQXaqmB2ndbAVn7BtsxlmisSGTMFz9DEYnNsgYnlVkO8ojl5cifuwo+V
         2diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739815640; x=1740420440;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k35Do8WCZAMLoa/h4EbievV16HfR92e6HRbOPq5LVAg=;
        b=U4/8JX7NYfod+9p0ukCvY744dDXqoShriYYw9BLJXntxJK++l1etzN1kgbuhcP37rS
         MI0OyeaznFSYzB1grLE4bWDyRL77jZjr8goubxkeKxSUuoF0MKbFkcUPk0DYymqI6SaH
         Z6sZnj2CAqjhhc/GORnxO+t4A6TezI46x/BFpPkdlZsmfvthamTRk8GdPacJQXgMwYt+
         fmw/zWd4IPKXXh353Ztz2hHgvNtdQDRGrAQhod4QZw1P8OUJP3TcDOMgAjdcyH0vXjYb
         Kf/DDH3nuzmaW1iU329EDcSgcWrCDR2JYcneelWGQNdjQ7aGPs3Qwtz2luQ/MnG6D3EN
         4ULg==
X-Forwarded-Encrypted: i=1; AJvYcCWVBN9eiXyJpOMOTUUhReZ9ctmDS2YGoIrj96Wv7Qaj0Yer5jaEmdSSQiQ6KN7O2GRowL0+797T0xJA1gM1mQ==@cygwin.com
X-Gm-Message-State: AOJu0YxXsRvjVbitM36WMeE5OhUBlSlmltznac+bIAUNZem4jLvMZg6H
	6Vi7fKK2ZxkEpfmifQhrC+qXOWcJHBDvZhjCPqNQDpN+gRzmtwlBI7wGxo2DV4YpPiEOqlv+WuQ
	yiho0OknOtubyd6JOWtAa7fi8GUOgVw==
X-Gm-Gg: ASbGncv24sUlSm5/Wtf9MzAPZXRexeaJVxdiB4Few3ZItfYZ4x5Pzytgc7ibVdwI1fY
	1+FZ9TlITqLN3Oh5C4b9GV7v2j4sm7h8Jz4jf+s3ZkKst619iawlMv0BDrA3x9Ri4379Vw7VU
X-Google-Smtp-Source: AGHT+IHZcST/iKMnz4RmN9Ne9FGTrSSD97Q+AA7/PtOEF4rcWWuPebqLwGcC5356O4fXMe4OrAvCg7/PgCtdyR8+rDc=
X-Received: by 2002:a17:907:7f27:b0:ab6:53fb:9683 with SMTP id
 a640c23a62f3a-abb711c3735mr1038431566b.54.1739815639576; Mon, 17 Feb 2025
 10:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20250216214657.2303-1-mark@maxrnd.com> <CAPJSo4VH0MufLhpgPiD1GV1gFsbTLdtOKrP82eaA_Yv_DHPXEQ@mail.gmail.com>
 <Z7MKkIbgMh0C5snl@calimero.vinschen.de>
In-Reply-To: <Z7MKkIbgMh0C5snl@calimero.vinschen.de>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 17 Feb 2025 19:06:42 +0100
X-Gm-Features: AWEUYZkkLpRHNpFHufcoeKppJWs_H_YYymAWRvb0lleodt_tJj0FCZM8udDHXsw
Message-ID: <CAPJSo4WedM5V8uJD=j-XG6Rxueof2Wph6vUncqwa7XrX_iSkow@mail.gmail.com>
Subject: Re: WinAPI spawn() not used by Cygwin posix_spawn()? Re: [PATCH]
 Cygwin: Add spawn family of functions to docs
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,KAM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 17 Feb 2025 at 11:08, Corinna Vinschen via Cygwin
<cygwin@cygwin.com> wrote:
>
> On Feb 16 23:33, Lionel Cons via Cygwin wrote:
> > On Sun, 16 Feb 2025 at 22:47, Mark Geisert <mark@maxrnd.com> wrote:
> > >
> > > In the doc tree, change the title of section "Other UNIX system
> > > interfaces..." to "Other system interfaces...".  Add the spawn family of
> > > functions noting their origin as Windows.
> >
> > re spawn() family: Cygwin posix_spawn() seems to rely on the rather
> > inefficient vfork(), while Opengroup intended it to be an API to
> > Windows spawn().
> >
> > Is there a technical limitation why Cygwin posix_spawn() cannot use
> > WinAPI spawn() directly?
>
> The requirements of posix_spawn and their helper functions are so
> that we can't easily fulfill them without doing the fork/exec
> twist.

How did UWIN do that? I did ask around - Glenn Fowler of AT&T Research
demonstrated a prototype of UWIN posix_spawn() before posix_spawn()
was finalised by the Austin Group as Opengroup POSIX standard. So this
IS possible, and because non fork() or page cloning has to be done it
should be significantly faster than the
fork()-and-throw-copied-data-away-at-exec() approach.

> See https://man7.org/linux/man-pages/man3/posix_spawn.3.html.> Windows CreateProcess() is not quite the same as Linux clone().

Here might be the misunderstanding:
posix_spawn() is intended NOT to copy anything except the file
descriptors and requested attributes, no memory pages and no
whatsoever. Everything should be done on the caller's process side,
nothing in the child process.

Lionel
