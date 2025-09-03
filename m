Return-Path: <SRS0=dZKr=3O=kmaps.co=evgeny@sourceware.org>
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by sourceware.org (Postfix) with ESMTPS id 5F0D53858D1E
	for <cygwin-patches@cygwin.com>; Wed,  3 Sep 2025 17:05:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F0D53858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F0D53858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::12a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1756919116; cv=none;
	b=ESxFkUmVyjLmCepuWrFYqAkqF2ygGEvdIkSkJFvsQT/iva/9Z+cPpeE1Qwi9FP1y4EAj1vY4SRraq8jlP794KHIwFBDvZe/Iju+G6H/uGxkPUpbuvJnYnie5WUFJSvsbXNB3hy//OEsTTKdWCQoS+sNzHS3uVl9EfRhYiKDnGKA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1756919116; c=relaxed/simple;
	bh=pFkKczSG/4CSUKumGWoRBtAA12oiBNGf5F+In955VgM=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=UNAS78MMxQwobvJuQJPzV3a95ME8+/NAzwNTYvnLVxUd0iMv/Fl8+6YbnISbW1E0RrWhVGg5bq5h4XZ5nFl3EDvr9yLLIQpsnPBHpy9HYBUoIAuAiBFomLw7Nha6lySPQPqPy/EO5Em055RtH8cPiO9OAZABNoFsasb4Z943d/U=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3ecbe06f849so324395ab.2
        for <cygwin-patches@cygwin.com>; Wed, 03 Sep 2025 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1756919085; x=1757523885; darn=cygwin.com;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pFkKczSG/4CSUKumGWoRBtAA12oiBNGf5F+In955VgM=;
        b=Fg2PUNW/z/S+WrmR5eUqhQE4sGfB/7dUIX3pxwtKFsPG+YVF/4rYGaxtg5xmCDeQdL
         M2u4fhoNcjRYYFKrHgL3aIue3kq7+3MbXgMs1/lP1d8xrxyFWcMA67lGEPeZ7JoQF5VF
         qecTmETbbDOvRB+84+eqganTKfcbJHHgJ+YxUTCnb5K6vDR7Upv0GT1f8Z9W2Sz4GDQv
         B0j3XBSzBqn9GPBDOPUcQ/Eo6SGXsP7IAF3ZvC0S0YAX5aXsu5eV+wUE+Jy+UMp9hNTE
         wBPBJhCABPCkXZI0e5OD1eLmoMTvWZaChHjOYe9afIONSNt25sGZXmgBRY6Rz6wDfjkx
         M7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919085; x=1757523885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFkKczSG/4CSUKumGWoRBtAA12oiBNGf5F+In955VgM=;
        b=aKKMPLHTOMpuKqlQ3Dqt2g+rvkTf9zuf4Oj8cz9Tr+387EC6aUA3lPBf/wYM6QqMb9
         u8cGC0N6UIrBtS8TfJ1zgpWHQzf9jPxSH1SZjQmTWYcJYXW8B8qO/jvnjGiiTtG/WmTd
         ItRUhICFXJrMn53joKvaypzBQC3k1oMPk99NGVqC7C/8FksstHmTIbRMEajXwWb0AwFQ
         CGIOQ10m0Uj8d5SMd/BZYtmzVsNi/MXrWmFCJ1NqcLY2nYs+u1teHCTf07yI6p8FUd7O
         dNOFUJAkeXcaJDVe+HkI3++zj6aF7uqAi6r/kHg8Pvze5duSEQUEkzXA4nPzP3iJuMZn
         sMoA==
X-Gm-Message-State: AOJu0Yx6A9W+0wJZYcaKXce7o8Mgk5UMKcRj9ur2ZbqIElJaUAsFhjbH
	SZPw37jDVeMRa5QSahxoxQQ1SDPPvhxZY+wpbFsP4vpQ2BeQINivkCcTXo0d5zmO0iYBM9tnRiX
	AK2vHKUqqDKwrVZebZyEquNgYGeJSOnrBXSOy9UUw03qqFhdPhcwxQoY=
X-Gm-Gg: ASbGncvJMv6waj7iJxK1F2ERCKA97RIF25zFV3zZT+EZfLx+yZK0H4psIhiwmRvnyuG
	1gQ9TQnJRSdHUmp0gvGszVUwj2/srQW42YWdrNZ8lSI59tYE97epjOGF219J7qrKv+ySxalPM+6
	eiNZJma4an7WMJFC8Dp8Dx3CjA8a+0FYF3JXY13+8KYoMDVAql36zx2ZoQYF2myXz6FVVPwVgYx
	QXo
X-Google-Smtp-Source: AGHT+IGaNT/z3SSAYjVrGUb9SJfQGNqJT9bEomXg5k9nB0a5Sc2vhnDW8sk7xWcNuCgX9vJd6KefskzzPShwr87miRs=
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c06:b0:3f1:dd7:24a7 with SMTP id
 e9e14a558f8ab-3f4026bd93cmr310216595ab.29.1756919085166; Wed, 03 Sep 2025
 10:04:45 -0700 (PDT)
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Sep 2025 10:04:44 -0700
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Sep 2025 10:04:44 -0700
From: Evgeny Karpov <evgeny@kmaps.co>
In-Reply-To: <MA0P287MB308276F1ACA00942D9BEAE6D9F22A%40MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 3 Sep 2025 10:04:44 -0700
X-Gm-Features: Ac12FXx_dQzM9TqOw5P0FSNqaUtcJfr-r1r4POQ_8RnmSn8kS-UBclbjEzL1eKs
Message-ID: <CABd5JDAtDMmYZZ-GKnnkaRtem1wJN3P=m9c4CKw0RQE2agDn5A@mail.gmail.com>
Subject: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
To: cygwin-patches@cygwin.com
Cc: thirumalai.nagalingam@multicorewareinc.com, cygwin@jdrake.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Tue Aug 26 2025
Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com> wrote:
> -sqrtl NOSIGFE
> +# On AArch64, long double =3D=3D double, so aliasing sqrtl =E2=86=92 sqr=
t
> +[aarch64] sqrtl =3D sqrt NOSIGFE
> +[!aarch64] sqrtl NOSIGFE

Support for overwrites can provide better flexibility for more advanced
conditions when needed and improve readability.

Changing to ...

sqrtl NOSIGFE
+# On AArch64, long double =3D=3D double, so aliasing sqrtl =E2=86=92 sqrt
+[aarch64] sqrtl =3D sqrt NOSIGFE

Regards,
Evgeny
