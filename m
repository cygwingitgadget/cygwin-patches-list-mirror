Return-Path: <SRS0=FsbT=ZI=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by sourceware.org (Postfix) with ESMTPS id 9A71B385B50B
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 23:57:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9A71B385B50B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9A71B385B50B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::52e
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750895835; cv=none;
	b=kgkFFJVHVlETTkk89xZygldSUGrnFcCoS+TjGXHPwwu1mBSQ1TQ1Yg7VLk8Z7shXhVxxR2OF++mHusZL+a5d+MYjQ9/8+F4mT/1D4lBITJ5zG5/MWcPYvaWhtqqrlHdb5UpMcPi8D73S+C45m/Yv2xSE5vxynRooPnJPG73KwFg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750895835; c=relaxed/simple;
	bh=3YzL1uKHbm70tBhVJ4wIdkkgIMc8kXx+nUREIi2Yw6E=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=PAz72q2R36kjefYwOZkmcX7JYGSZ/WUbXNX9sWSSQRXmImOpVXh10oEtHit5ryj0tWjf9VmRtJmP2uUxaFR9jzHrunbIBr28Kpc8dpTIM4UHTxopXpNt1wu0l9bKiQzICQw0gXTj8Bg+Kfi0y9vwZDAbYxMh/xe7TNVK3r4f78k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9A71B385B50B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=esehaucP
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso614723a12.1
        for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 16:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750895834; x=1751500634; darn=cygwin.com;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YzL1uKHbm70tBhVJ4wIdkkgIMc8kXx+nUREIi2Yw6E=;
        b=esehaucPjJ6/4l+nz96Qop0DH0ltO9BaWEiK9DMriHm8gsBenhEkoME0CblS6ilrFM
         z0B2uG0ScrWuYOIQfHTKLdZpFx9xBFH1nE5VM16OvhrQoJiT6ZVW+Hjjgyn0GbqNSl+W
         H2su528kch6ADxPxuTSdR1p7wI3GAfUfw+lkqLHalVUNKmxrAMGL5vhnaOzJJh2lPRdR
         SpA+aEa9zZJiem2Bx4DCPwJedHL/zNMNJEEGQ5h0yVZQdHi6KPFrzQpaYE2WShhAfYBW
         miCMF03C2Jk5V7WVgsbX8PIyrQdm+OKXrCxzSunhzVkg2rQkhm/GQuH2lTu4w2RHxAjg
         v+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750895834; x=1751500634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YzL1uKHbm70tBhVJ4wIdkkgIMc8kXx+nUREIi2Yw6E=;
        b=jq5zhUDBMlK4KDdYdbtXfeLJY8Pm8Jt9sM2OW1CjfGABFxExXgD7swdhCunzX0dyzz
         54EhS4j267GfGFojZzrujiHq5vET0Cd8qKbNpHJzm4EGHLV34u2A598wbhjfWi0iykLj
         PJzUD9QknMt9+oh6Cw6fYIEd5ME4loycVCmZVwPv1S7XnTWeqJtwk/OoMIlqu4I+i6bk
         PcieHwyjuVbDOdX5ebt/6DUMc/WxJ6qGl/R96z8wYvjkjlHvEi03ChgaXvMQUN9FfTje
         DkZrBOXlvWBfsu4YydV5eEdxEH+pqs7A1b9tBFZjq0yZVAzF3BEeWF9REQKozLMPButK
         2Fyg==
X-Gm-Message-State: AOJu0YwtvuBMmyr2loKSYKgezgbJycCdM3x5zzN8Nhi6TqIHcuU1OvCL
	zpKcHnep8kO0sgSL8Q45/A6zYYqifaFOQNUllYE4K52qh27oHTFGtp6LdFRuAkVvKhk6mke/v7B
	oRi4Pc10eGNhFkOHc7ldYbT7nbY1uI/XOAjGm
X-Gm-Gg: ASbGncufd3zFmBBqfh7LLvZYU5sQV05lCYkKC6ULC4BJ47aIMcEkKTotFa+u6QdAMNt
	KZYVlMnbhOdgI4cKxIhrbOnKOwnjyvoOdWyUjRSEF5fzk11qCk43mNs0DNNg9PSlJ3qY9KSt7B0
	6ReF6TIikDteoHRz+N2tVeArWtqS39qUKysYSOPLtP83BWKVNoXXnnoYHp
X-Google-Smtp-Source: AGHT+IH8vaQSbPkEYBfrD4GDnNwdp1x3fl7Nzd+8IgNF+5cw1uRyZyWjBCOgBx1N+iFJVJz1XNYmp9SMyH1pchUI9+U=
X-Received: by 2002:a05:6402:5191:b0:604:e6fb:e2e1 with SMTP id
 4fb4d7f45d1cf-60c4de9b3f8mr4415044a12.33.1750895834085; Wed, 25 Jun 2025
 16:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
 <20250622083213.1871-3-johnhaugabook@gmail.com> <90d4d80b-bdcb-4fc8-81da-7b4e49fbd4b3@dronecode.org.uk>
In-Reply-To: <90d4d80b-bdcb-4fc8-81da-7b4e49fbd4b3@dronecode.org.uk>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Wed, 25 Jun 2025 19:56:37 -0400
X-Gm-Features: Ac12FXyGgWK7f9uoE65a8tc5QsDpB6Bgtr1kYBDi7iVCoUfHLhdwZ2J0zncVPYI
Message-ID: <CAKrZaUver3At1_0YMUgjOp7COfQp8Mb21HYWq4x=EK3y3MWqgg@mail.gmail.com>
Subject: Re: [PATCH 2/4] install.html: add tip for -P as preliminary search
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

(Resending to the list=E2=80=94accidentally replied off-list.)

> Maybe what's needed here is another Q&A: "What packages are available?
> How can I find out what package contains X?" which links to
> https://cygwin.com/packages/?

Sounds good. I will make a new patch for this.

> (and maybe mentions various appropriate cygcheck options like -e/-p)?

Yes.

Take Care,

John Haugabook
