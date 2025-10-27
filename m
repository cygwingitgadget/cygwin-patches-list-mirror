Return-Path: <SRS0=EjXX=5E=kmaps.co=evgeny@sourceware.org>
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by sourceware.org (Postfix) with ESMTPS id 2B1663858D20
	for <cygwin-patches@cygwin.com>; Mon, 27 Oct 2025 18:57:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2B1663858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2B1663858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::12e
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761591422; cv=none;
	b=Pwzj3Bbo/IX2Zrux1/ypcnv/pzULlbI7DzWXAHRNy8i/KQAV3TlL8uCdP5r6bXSqVnwPQY1e8s+KenYfzoOxH/+v5y4vf7PCFwrQtscEHsUB3dLcMeAZcG0W7mwcb3KOUB7nqz/xw5ekORKqffh7jBAfKv0bUzFfwQv8vsxu4sc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761591422; c=relaxed/simple;
	bh=ztKKPXKKHDqNPIE9EU1JHbZGfhwUjxudWy/wTlnwR/k=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=H2HlOgrJcvZnL2v4teWhGLYTyh/tJgHptDy7D9Ymn+LgRmSBwVci+z6sFsf4ZXg45xwXC5Z/5Axqmw5LIftbIys04oueDSrpiFjBjs+qSlFoyeVWBnHyCXVCuDIeFtjT1yjWXflW9TVS/B8ks+rSPhP8e1941ET6tR11vWR47aw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B1663858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=EA42B1pz
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-430c17e29d9so21193915ab.1
        for <cygwin-patches@cygwin.com>; Mon, 27 Oct 2025 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1761591421; x=1762196221; darn=cygwin.com;
        h=cc:to:subject:message-id:date:in-reply-to:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+a/bEzJrmIbxXwK1KsCz4ULwRhpknF9rDtCKIZuAdts=;
        b=EA42B1pzcBZTT0kECQukkk7v96XTL4Whf4mGTi0AjOLWhbjYS1mtjCVvwXVUd/AoHJ
         Uv+wlDDhbrbSHqLtpTMRJe88pQgPYUC4JBwpEFW4PSzKgESg9A8DoWlII0QbsqldPb+J
         tQiJS9vv0OB/zpRV6jf0dL8a9Lq/OzaJku+yjpTw3U4lN4igwHUph29enStRN1hglyD9
         MUCPmLZxgX65/EaOulu7vXTjwTe/IkQr5lHg9Nz0oqbJi3zEstcKHWP5LStpcmhNHIRJ
         aCksjCyushsQ310JR4tWCZFxrdYMA1znaX1VNa4ovusCfZpgPfCcgGy8V9pe/+0oeEyi
         4yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761591421; x=1762196221;
        h=cc:to:subject:message-id:date:in-reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+a/bEzJrmIbxXwK1KsCz4ULwRhpknF9rDtCKIZuAdts=;
        b=Gzh3KuUN9UU1eAO037KHkBaBknqgLBj5ssLma2JYahlqvIrgztKqC2NJsvlGDerzxF
         M3Vm9GudOXbVVMnaacE1x2vwWUoY1RElBVQDf+qvwybE0FImrIp/kMf1ygyGW+zxOzvT
         6N0HCu7p8b+S7LnIZwK1tCbKaKZtTtzIeHf81lRDZ/xkg8jmXC7p/AENLZPEMhyxnAsC
         Rob2+zctUPQt1I8KEyQ7To+KH4/D/howRep8gWVYY7ywsRz8p1BT9JMaUcmkldcgwIWa
         7Js33NnkeAqy+9nf3V+/caBDVk+kHYR77FSRJyBY5v2w1p+0stHiEMXOqtTsQgFUv3Xu
         zQzA==
X-Gm-Message-State: AOJu0YxuOoI8wgOT50ionxR+gqcJl2HIS/oGfbGtaxQ3+mcKtizgj7Co
	yq5KeUozCu2yZGQRSYt5Lw505IvKkRzrqFreYmFgYiu7zoMCDEHAhjBllrioPX9lgcuy5V8PVVE
	KCL4/uU05rXLMbrwXDCHWLp/aBbp/ckadWz33QNBLoyIJiViJ8RBd
X-Gm-Gg: ASbGncuSgicLPpPXn0NUJvSev6X9lWTXIzfuDUVdRNn8t98hvXaXHA+4hztqqT2r22a
	LffeNgSLJE8+kJEsyOE8dzna0xcLx89XYUK+UWIBFWjpFeYzFk07HyoFZWuJGIRBLI6MhFVxlDO
	CI09e18kerg3zDLNAVhwKnmKjxF/k8CfEAAWediyKupfPt2uuEAGZw5OhazUAClB6r6spJyaQwy
	S4zR6W5F/k9804zH0Pc2VvUojJAnkxAKaamF+rlSvAd3grGFL6a4HDauretoU045sIW3gMN
X-Google-Smtp-Source: AGHT+IFitjW9gKk50S2ysiiChCHhpAlcJTAB1Y1ZMOFp7E/vK+CxWjlEFX9KWc6EiLCK5wKBN6LwYy8AQaaf15u6izg=
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:430:adfa:e4f6 with SMTP id
 e9e14a558f8ab-4320f777dedmr13645265ab.20.1761591421071; Mon, 27 Oct 2025
 11:57:01 -0700 (PDT)
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Oct 2025 11:57:00 -0700
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Oct 2025 11:57:00 -0700
From: Evgeny Karpov <evgeny@kmaps.co>
In-Reply-To: <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 27 Oct 2025 11:57:00 -0700
X-Gm-Features: AWmQ_bmaVTrAlBrqGO0oOFt4YTNELWrTCT9jPx_7AFgP2nrRkvDP2x_aheBSgS8
Message-ID: <CABd5JDCuwH_TaT7pm=n9vG0-XoZPWF-bcOy=af3XAWrDSH+1KA@mail.gmail.com>
Subject: [PATCH] Cygwin: Testsuite: fixes for compatibility with GCC 15
To: cygwin-patches@cygwin.com
Cc: thirumalai.nagalingam@multicorewareinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,KAM_NUMSUBJECT,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mon Oct 27 2025
Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com> wrote:

> * This patch fixes function declarations in shmtest.c by converting definitions to

> -int
> -main(argc, argv)
> -   int argc;
> -   char *argv[];
> +int main(int argc, char **argv)

Why not use -std=gnu89?

Regards,
Evgeny
