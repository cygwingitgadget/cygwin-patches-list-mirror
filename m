Return-Path: <SRS0=AOnd=ZP=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by sourceware.org (Postfix) with ESMTPS id 9FBC6385695B
	for <cygwin-patches@cygwin.com>; Wed,  2 Jul 2025 17:33:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9FBC6385695B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9FBC6385695B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::52d
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751477614; cv=none;
	b=cqdNuSV+//HcIn9LeInk+qm3FbJ4BQNCd3fw+0FpV/FwpRj9bV4yQjmz4o+GSR91zicXXOK2mSRVHS+kfCJn1DdHKffW7dzc6fUw31+cdE3wh6kR2N79T27aSFvpWsATvjs6tlI4v7m0BlJs1cNojmXcDxf3GyYb3FCBGvEPnKM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751477614; c=relaxed/simple;
	bh=4rqM6KkXH0DDjB6KhEFLjK5a59Pa4ZZ8GQuhAEYfLZ8=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=Dl3Wuc/JYXqqkXkXImgLMfCR4zVR2EDWnQQ5LngScbdx3UuEj5ciPXc7OCDFgkVMqE4GiUBZREFXjEx0XIFLNTw25XHJ5f58kDLtMm7HymN51qqIXghw1Hty+GZqGG5n2Aw2xYQbJl8T60u5RHdbgt5WTc98c70YWO3rmidAWqA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9FBC6385695B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=II/DyCv+
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so7521787a12.3
        for <cygwin-patches@cygwin.com>; Wed, 02 Jul 2025 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477612; x=1752082412; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7GlyTx0Ef9ubpLky+qT6U/b722GhiCG2D+7x6zTTXc=;
        b=II/DyCv+e30NlQlzmNH/EK6FOMp9jMGYvcQsZCPNkU4JNQE7DGZGo5nJbuYlikMxIm
         /xKtwjqmUAgfKHU2xNFOMWtyewWjNL337G2y85/YjIn/vxVHf/nVF0Std9Vc/gXQhbDR
         p7tq+kVPoXzsT/7xXKM47Kgz0F/zAiOv7mL/5xlLUB7f7QrBZhvN6+YfzSZ0DhSkpmTL
         s26YNRHZelmmWoIBv1v3ZuuRLyLUeO9L6B8VzJWON0xXcg2zI85auBC4JYEYGMvJEfps
         /tjIePeYKic/ODju/prKnW/VUqFBN2YSLNGbvQyiQd6LKbLnGI/bvTTuxE/NMRIAfUfU
         NNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477612; x=1752082412;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7GlyTx0Ef9ubpLky+qT6U/b722GhiCG2D+7x6zTTXc=;
        b=JjUQFFi1VtQJh6vt19Iauq5lkzzmWOIOmO/66PjjbLFlF91BS+g2nRwKS+gp1xh0Uv
         e5XqaPTYEHpPyTTsaPHd1F3tXFgiheWgxf+qkDV27g7wGWdPjbSjlRDXOxml+Pk2NWmQ
         R72YTfi97+enhizAhdHmVwqmAsAJ/pqTiQ2iCXIF7iARbCnzeuy76SLH3ucjdXsXwCRO
         r357DLSiroZ7e7y0WM8ETgCc5yVln7Bo7kV5VaG1KgfGWdMrDzut2HAv7Dy2jn8d1qZG
         K3v9jK1IcCBa5IlUfyQkkJr8+rwYTK+V8S3xg49Gbx6tdM5qvE1rrsGpT7U9tL3NmV02
         H8fg==
X-Gm-Message-State: AOJu0Yy3QtmQ+tXaYG4ZA28OqB1TILw0BnReCVUKO77jY2NDL9KOdn/6
	6HY2aywJ2EoxBmUGqr/7N0wvENZkZ+9oi1qgTQUhU4HQ9kGRS8gak63Ojmy+86J1fc86BuZGxpn
	qjv4ggbDiSVWrMQ2AUep7BFVPKx8+tBDN+5vL
X-Gm-Gg: ASbGnctOso/MGqEeOJiu9VGC2Xqcz6RYA2dseOz9tK5LZQQ/LuFPHk3yKSm2Ay2Tv6g
	9wleEzLsRAvdYwhAUqGmAg1/3Xwcn25l7xQjFgGVmYMFdzS5Szmd0Y3Y2R08CUgMLrW3fyu/LsB
	1GEiRGBIgXDn1YeJtwYex5Ioo0zaElyUK8KjzqiroEqVhWm+D04Rd26QJb
X-Google-Smtp-Source: AGHT+IHcUnfhIguZWqIou4iqwxCQEw98SeUHWHHa26DLBSi0ZPsL5/hlN+0Mrzb0Q2S/hx6z0twqd0Zk2S5/N5MFnwQ=
X-Received: by 2002:a05:6402:268c:b0:60c:403c:ab77 with SMTP id
 4fb4d7f45d1cf-60e52e2a54bmr3608731a12.19.1751477611519; Wed, 02 Jul 2025
 10:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250630213205.988-1-johnhaugabook@gmail.com> <aGU0wPpBMULD3N6p@calimero.vinschen.de>
In-Reply-To: <aGU0wPpBMULD3N6p@calimero.vinschen.de>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Wed, 2 Jul 2025 13:32:54 -0400
X-Gm-Features: Ac12FXySKzMRmhaHDGznu6iOS0_bTLqD5FXTxCSbIm2QiC4FeWvlWFITRIPrExs
Message-ID: <CAKrZaUs5ABKn8r1hSbN2KnLod5-MigGL-SPX_sqYK2joV5EW3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cygwin: 6.21 faq-programming.xml edits
To: cygwin-patches@cygwin.com, johnhaugabook@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

> I pushed patches 1, 2, and 4.  I'm not sure about patch 3.  I don't
> think it's necessary for people who are willing to build Cygwin itself.
> To the contrary, I think it's rather puzzeling in a FAQ about building
> Cygwin to talk about a two-step installation, which is only preliminary
> for the actual Cygwin build process.

Sounds good. I'll mark this off my to-do list, and get started on redoing an
earlier patch "[PATCH 4/4] faq.html: add 3.4 run cloned site locally", making
it a patchset on reproducing the website locally from the cygwin-htdocs repo.

Thanks for the feedback, and reviewing.

Take Care,

John Haugabook
