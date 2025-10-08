Return-Path: <SRS0=swra=4R=gmail.com=rashworld261@sourceware.org>
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
	by sourceware.org (Postfix) with ESMTPS id B3CAB3858C83
	for <cygwin-patches@cygwin.com>; Wed,  8 Oct 2025 03:20:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B3CAB3858C83
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B3CAB3858C83
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::142
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1759893656; cv=none;
	b=C2J+7P6fTN/wKRjI2a0ze+GeUORHnY5Klv3us9OFu8e+L4/bJRJVHpAveePTgnosV9kttkJlR4OR5OJla/C/oXZKtMShoQM3xe6zilJVzrYGRbYh9l7lh6ADbroBCxzvmbZ3VasLQBJfw7dxaG4y/vTmZjpIqSc8OoouWI/5Um4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1759893656; c=relaxed/simple;
	bh=gNWu1C4TpZPFxaqf/CxrtGKMuufqb0ehIOdL5318zKA=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=PGHBg7ffIOgTyHF2HNN1vHCFCj2tJcRPWAFDcWsmStqt+/lhFrTAsxYYzL8q1i1P52vSzVgXDhseE7S0sOt0h5d3z8e7u5rkO8OegCz0HIGPJDxRl7l1f6KJoQ4wZPP2O3CD6RSV2FN7i/wZRBzWrRZyNCiRYAhMmEKyFc0wY7I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B3CAB3858C83
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=A+VtNySX
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-57b35e176dbso8892856e87.1
        for <cygwin-patches@cygwin.com>; Tue, 07 Oct 2025 20:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759893654; x=1760498454; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNWu1C4TpZPFxaqf/CxrtGKMuufqb0ehIOdL5318zKA=;
        b=A+VtNySX/pva1QdVMijlAMhLCsDwIZpfLObRsrWKPWjKNHLGrVWYEdIi7p+iIykym/
         6YoLoQzhPU1R2iAf+fhEHRYdE7Z4JCPkviZmwOyHFmjYHahZ5kWftAPJGGA17HyPISsh
         Logip8jKtnGZPGw3qBY3S8CQz/gWdXORVBTXdliYNZgRjEwO7llM26wI2qAeMEy9rkN8
         V8luZXRS13PemfNyabRwSryj7ZkdjuVD/GeYwXYu89dQfX9eab0DGLfkIgwHxQth/g78
         xWcnPzl6NFlFK12So25pPc63PTQpl+acIRiMWGTGrThRCw4mWCX6Ail4liPhAB3bpFIv
         O/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759893654; x=1760498454;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNWu1C4TpZPFxaqf/CxrtGKMuufqb0ehIOdL5318zKA=;
        b=SxVHAMjcSMJQdoVwxR1SYouzCsdkD0TviQI81Bhw05YatWbo6GXNIpuiZnE8KVPi7w
         G9XpCoTSWywSHR/fGE6i73VZdkCbke5D0ZSsEfOhkrUjfjoyf6UVoUI8jZsU3ze/ZJxi
         kMF3+d0ofpUyrbjKvtY/jmWGVkj9oELkXmxhj3INJUs9SltIVl4cX9RXcdSMV5vNLQHn
         QrraUYwjX0NE70SG81hIdXjhP1w5WHRL/QxMWlOyYJX2tdv76kcaCXA4/+/C9t9SP/ni
         hQHbnaRFIqdUug9gvHfljx9UndlSpXjwtyhSSiKTJljMfRj6XeAXJIDDg4eezlZofctU
         k/Ng==
X-Gm-Message-State: AOJu0Yw+qlGJL2610i4EfSxrMX+uiKUNqVH+joaZ7qNbtrUhR6849eH/
	sUdbZBAXiBfk4Djhm+4N7g1ACcrcioYpaeMq4GScuFMqnHAkgX0BPRD1J2ifscuiOBkYC/8v68Z
	btZKUInCRislSlB03mOJ23/Oj5Lm7XNQ=
X-Gm-Gg: ASbGncsQHTD4d2Do6HnlQ+gSfK9uTVnWF0RGPTPydhLfp+fqeqo/Dbpo+FEvu1ed4EP
	duJbq+4xct6Q97XVqbpQ1DYoLve/KrCLRxHT03UbjRjxKRUsbyZ/0gAy5vJhSoxprZ8vhDwxBVh
	XUhKx+3KILEw1wd+xPbnYKbYoUOffe4GD1c6ySrrrJJbVe58oe6aZ+rjAH/tKqh1p0lmaeiM9Fz
	bPQqU9HASecNAepX0JpODq5Ha7z
X-Google-Smtp-Source: AGHT+IF/Qgm8s4AxDDx/TUqT7cVCE4E9Uz+EssYiU8YWAsAwlchA+SZxiVL/60Xh6vwdzaTAQjAorBng/Rhr1MSpP80=
X-Received: by 2002:a05:6512:138a:b0:578:6ccf:d031 with SMTP id
 2adb3069b0e04-5906d8e5c31mr476288e87.35.1759893653599; Tue, 07 Oct 2025
 20:20:53 -0700 (PDT)
MIME-Version: 1.0
From: rashworld <rashworld261@gmail.com>
Date: Wed, 8 Oct 2025 08:50:42 +0530
X-Gm-Features: AS18NWBMjh5Z8jm8HRu-dux115IciT8kjSwrLVc8AoLiPt1x_wGCrbrRaB8pTv8
Message-ID: <CAJEDL1qA4RP2iJeRcRQn1tzC5=5-3daZ5t+u_RDJ2jf31KEWVQ@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: fix fcntl F_GETLK
To: takashi.yano@nifty.ne.jp
Cc: cygwin-patches@cygwin.com
Content-Type: multipart/alternative; boundary="00000000000010b8a906409d2c29"
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GB_FREEMAIL_NUM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--00000000000010b8a906409d2c29
Content-Type: text/plain; charset="UTF-8"

It's me rashworld

ishan

--00000000000010b8a906409d2c29--
