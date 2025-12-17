Return-Path: <SRS0=Q41O=6X=gmail.com=richard.u.campbell@sourceware.org>
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	by sourceware.org (Postfix) with ESMTPS id A170F4BA2E1C
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 21:03:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A170F4BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A170F4BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766005396; cv=none;
	b=Yen2/wLpNN6i5DQXfuLCrGv/zEBoTstr0raMYErETDESaTtqXx2FuWl7rS+Cx+sDUAgVBmZERDRLaoFFs02UP9x2CVtXwdQfHlukj4UjlYIWgwSOT25GekS8BpweauVkpJlc1bQjLMvaNhSiiamQLNvpFyOXDy/ikH+RhMCOIIw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766005396; c=relaxed/simple;
	bh=wF4ahPe+jbYmfbdsARm26a5po7t9w0hUkVWcanz536w=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=Utw3LvWIfTYDA+WQnAOCWTlCFuZtG2EgjxC2i+VcQZ1BM1Z7TAeL++tRb6QimpvUFnbxHYnE85Yo8S+TbUwbXsTVnkvQ8ZbNdhDNKCWU+9SNBhpYKwgFk07pv70b5PS8ktbMhKq/BpD7kawr07U4/BtBfxuEE7gEaSaAUEbF6JQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A170F4BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JRUBd6Wl
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64470c64c1bso1581803d50.1
        for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 13:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766005396; x=1766610196; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wF4ahPe+jbYmfbdsARm26a5po7t9w0hUkVWcanz536w=;
        b=JRUBd6WlYqhAYF1QtmM3r6TnKASON16gI50v7ZwigQDQJbSPCNzojhP8ftLxoVjT6v
         BoR9lbW4RRi+sfo7cbNXshtkCyr63kMoUBnssXMcsRodsnAWqEB7eWW7CJ4p8KK83TAt
         WphcaDhudx9SS5GJsGCZ7qcu5mYGSdKB4Rr1D8TzBCmB27f0j+MKoFzYiA+mxBBsFkFI
         nRo+zxfP35l87e1NHhsn7tfdhfbyktRZLhDiukXhXUBtIOExq7ZPMF2ScXd3KJgpOr27
         ngstJGNpFDxW8VJY1IJ487BQeX0L2e+SXXdf0HnXGUp9ihJAliYWH5LhPIpqL9/i3NR2
         yWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766005396; x=1766610196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wF4ahPe+jbYmfbdsARm26a5po7t9w0hUkVWcanz536w=;
        b=uTwnh3Dmfup0PoQsPH/d+4Lyb7Dwr1RwF3FTEkYsGqD2MoC/IDkwpmzSjJOqmSLszA
         Vmf8FwLQ4GwSYvcUnRekJbZeD65yRXmfM9UoTu3ueOx4brhGytzC868/PmmPnhc4kLOZ
         aEHtZNtWR4Ehq20bVL9Wjkg6nITSzMReSPIfLAbtIJWFrJdzOLsfDGPP37TVo1pZNBG9
         7nCDMBo0FwuCkvV5yxYA+9d4YZ2AavNHZ6YaChXZbtZ+Io3jr/QjWXCEmrT/zFkA6L21
         QpNUnc9wHx+6QOHtPW84UqyFFb0Svbt0GWDTVpSSzXhmcdCnuLxnEjVNW42wFt84Sg+s
         vGDQ==
X-Gm-Message-State: AOJu0YzHyFPD7r+q/M3RWnHSPUblzUl1rBnui5+PwbPSBY9QTuHCRekA
	jIhT/AstVk0wFvCbw3ILxAAgIYhjhSgJwUBHb2GVoIBRTxFr98juMZArZBjzwAL9oIgm84BSq3J
	AmskliAIs79OAO73iEzn/ly4ZjmV6c0E=
X-Gm-Gg: AY/fxX4bnOh81oGh3GIsSckejqFMC10bM7Dd0wUpbH1HFGQV5cAYRP9uVK/Bn6+IeY0
	G7pp8POq0w9CEZ6ISXiWy6rX/9L+DJCet8tvxNs+FLPNxSVE2hc7d1uhkyJD5esvszCq77Mi4SN
	9MD9btJ6OoXYc4dJGUs1PhW2sVcKyihwQB0EYgv1oOuXU2hUELmtRhcJtYbmc+BKk51YvFbExY2
	0Ha10LDr+DwCCa1bQHQgHek858nkCD30LNA3E72L7PnuPtOMBAP4vloB2aXM3p5pYjwu64GBK7b
	ZSc1cn1nYaXpU/ByTjXbtfQ0Q5Y3yhGp0hdr61akZWLR0LQJuZtZgvLhiIN60A==
X-Google-Smtp-Source: AGHT+IGTYzbQV9SFV+BvcVG4SFFIDKCvQg7KcXEtc+EJzNiiS7/weZbW8bFqMpLHDHzcWCcAhYQFfcgKBwh9toD1tGU=
X-Received: by 2002:a05:690e:16c1:b0:645:5207:10ef with SMTP id
 956f58d0204a3-64663253c12mr516679d50.18.1766005395942; Wed, 17 Dec 2025
 13:03:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
 <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
 <aUAoxVEKMpj6xNjM@calimero.vinschen.de> <18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
 <aUAxwTZcfZ9qecW2@calimero.vinschen.de> <f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de>
 <20251216173957.fa9571466a8bced55924884f@nifty.ne.jp> <4ac88404-a8c3-3d21-6460-6941fb8dff4a@gmx.de>
 <20251217182931.c4dd8a2ea1569fc11b9a675e@nifty.ne.jp> <7c03a948-c8fb-079c-a2e1-99e8626366a7@gmx.de>
In-Reply-To: <7c03a948-c8fb-079c-a2e1-99e8626366a7@gmx.de>
From: Richard Campbell <richard.u.campbell@gmail.com>
Date: Wed, 17 Dec 2025 15:03:05 -0600
X-Gm-Features: AQt7F2qP6vz8eIeIPBvTUzDyAbbO1WrDTPdixqJMMsS65PZ6ZPPJu5dYh9bBLYU
Message-ID: <CALwydEu3G6UAYSGLVGXureeHRRWDaBJUuV+18cAmLVDWdA6Yqg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution aliases
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Content-Type: multipart/alternative; boundary="0000000000004bf02a06462c2c1c"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--0000000000004bf02a06462c2c1c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 9:50=E2=80=AFAM Johannes Schindelin <
Johannes.Schindelin@gmx.de> wrote:

>
> I see that you dislike the idea of working with me, and want to go with
> your approach instead. I also see that you're not necessarily interested
> in conversing with me, otherwise you would spend many more words on
> talking to me rather than less so.
>
> That's something I can accept, although I would have preferred it to be
> spelled out clearly.
>

Johannes,

In the interest of clear communication, I would like to note:

1. You habitually come across as an asshole on this mailing list.
2. I've never tried to work with you, but I never want to after reading
your emails.
3. I doubt this is an isolated opinion.

Best regards,

--0000000000004bf02a06462c2c1c--
