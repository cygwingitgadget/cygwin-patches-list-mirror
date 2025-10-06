Return-Path: <SRS0=tPou=4P=kmaps.co=evgeny@sourceware.org>
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by sourceware.org (Postfix) with ESMTPS id B6A7D3858D1E
	for <cygwin-patches@cygwin.com>; Mon,  6 Oct 2025 17:50:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B6A7D3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B6A7D3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::12d
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1759773033; cv=none;
	b=wv/EfCRs76D07NjFShHRf/GgaR2QZl05EAX2wAN/rJZLpkpqxd7TXjf9ZKGRIuGEGm/LLydyKGEtKtOy4glqhxhyoe4ZpK1QxmnAxynJFoNAT41osropuI1kyLHmAGh0nsI6DhLLjztJ5xzz162ID5lLpkrtrjysgijadYufLIU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1759773033; c=relaxed/simple;
	bh=ExkjfhAkhRit3vzFd+8s7lwPtp+O/xnRtowFVJPgpTI=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=aHmLj3CYLuB7egAoL+M5cCP7EWw4V2D3dVB6W50HBoN7CgKsmDjtSQClV2EGeTun1KJL4jmJHYY3R0SeW1QGANoWWM1bjqBiHIzHN6R81/P2lpS3mNDlLRa7Acl3TJvt/Xxymt0CPerh1Na+rpfV1Y88edYLZgfvXOaWeJe77fg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B6A7D3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=O0dtET30
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-42f5f2d238fso12846425ab.0
        for <cygwin-patches@cygwin.com>; Mon, 06 Oct 2025 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1759773032; x=1760377832; darn=cygwin.com;
        h=to:subject:message-id:date:in-reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExkjfhAkhRit3vzFd+8s7lwPtp+O/xnRtowFVJPgpTI=;
        b=O0dtET30zOh0ou/jF016DQnazUDo3fuR/+sBcWsSD2xOp0Q6Zm5qL4I6d7AaHptK5/
         gOWJlLlw6DHlHRPvJhPAuIhyQL/Kewhml9XjcGLhu91vaYcgWgDDw14c2sG481V2bksz
         4+6L6ruBScUloebMlYrRw9pnGMB9DWlwwiWTR8Jy/zTjUv05uGLyVLwLWOdsFCktS/Qs
         48QFUyFrfRmucRKKzeMRPwRYBMBVzHatUaQykOe6ayqIHWyxMJ+kQ6R6Ay1t8zjETcyh
         HgI1NhvAOoRzxVls0Nrm2Iiug+xAws/y/ErUKlOrQK7u0IT82sZ3XpAshEHwBgxVPFoB
         c4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773032; x=1760377832;
        h=to:subject:message-id:date:in-reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExkjfhAkhRit3vzFd+8s7lwPtp+O/xnRtowFVJPgpTI=;
        b=Vtuxhq/eacpv/Q/C7Xr3uOyrBd4kCmMRzNO7Cq9Xg7rCs82ZRj1kVjTRgVssjh/wje
         QlkGpfO+JMNxpmo5/CXUrONvAarFDnGp6dV8XkXQipmek6FQ+uvZilvOVs9NAzXrrPTb
         1RSYd76+Lhs3tH/lCK+Y0VWs528WCkRAlDyOqzpGKqUZNFGG0PeanU4j/7It9sVwtkJx
         9ruo+1g+E2HM+ViW2LzKLKf3O8uNHlvrDos8KmSyYSJwPtM6sb3rbDqJOp4t5akK+sG1
         6FcjKFMWvMR8CJV0bXElhytIo2NtvkwGdIC1Xp8kU1PmN7ZhnLHb5mK5Zv/dJ6b+aH5I
         ooRQ==
X-Gm-Message-State: AOJu0YxRmm1pOYm/jtp8z45CX6tlOyHS9VY4m4y8GlrFD8Xs28Qj7ZPC
	T5xedEQE4w5smV6+5I48C3OdwzwTUvrZ6MU4gV4F7kHVetE2JToKLmlNre64vGGP7XFaAPXMsy0
	Wfx501F4LdNElEkrIC805tdDEvFq5WG/y9dqKMdCQGiPsvHfQBKoheS4=
X-Gm-Gg: ASbGncuZ6xWDcohy+XFisxdOJL+xZwcCicJu7kzIGZzFWUU9VusjKTsTv/9hL4+rC1j
	vP39ArZVTw6zYNFni4/daH3X5Fyx+NE/1Fx6dRlpkxGAj8isNn9HTkD/HX3fEW4L3XN8v9oykuf
	BogA8MbpOkCYckoN+tmeMDYpt9EMEC4MKkkAMQCiyWbs0/QdoxjP6MCTyqvErb5dCy+9YiAm7Tu
	ihG5/NXhNq5ALY0ijUqc5DTl091R6dbdEv07C4o
X-Google-Smtp-Source: AGHT+IFSDJM5PPtFLkxTp81Vn8OUox5YU2GJxrHBdZJxkm+63uv5sxyQEQ0X2WedcPEBMu+66mI7Vw3jLiEcbkYiGzI=
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:42d:8a3f:eca4 with SMTP id
 e9e14a558f8ab-42e7ad2e15fmr192406935ab.14.1759773031503; Mon, 06 Oct 2025
 10:50:31 -0700 (PDT)
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 13:50:30 -0400
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 13:50:30 -0400
From: Evgeny Karpov <evgeny@kmaps.co>
In-Reply-To: <CABd5JDA8ftx5958KRzqGJH8yhO7bPU23RB5a10XqdJX4VWBgpg@mail.gmail.com>
Date: Mon, 6 Oct 2025 13:50:30 -0400
X-Gm-Features: AS18NWB74FZyAwQk6DH1xoTHNnEk3PfprnHD2DWIxQ8M1k5yZgJVHO96_9kE1yU
Message-ID: <CABd5JDD5zgqLG7yD6_gomaKKNABWEnh8pRjobPd43X4b=cz6bw@mail.gmail.com>
Subject: [PING][PATCH] Check if gawk is available in gentls_offsets script
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

A gentle reminder to review the patch.
https://cygwin.com/pipermail/cygwin-patches/2025q3/014306.html

Regards,
Evgeny
