Return-Path: <SRS0=FsbT=ZI=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by sourceware.org (Postfix) with ESMTPS id 44DC63857400
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 21:08:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 44DC63857400
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 44DC63857400
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::52c
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750885701; cv=none;
	b=d9q39P2s4YvXLYCMkrNTfqKjk+bKgBYwNKVW7H5P+wBolvwxM9OaugvDcnLglC1dWtQQWoPbnzMZgCHKMGynEVm3iNXQIMMQHRzLDy6DdhHxNKCvY96Q5ZO7SjWWrXWWuFIMbd25GPCTY4foQ31SV9592m/u0pMWfW7DECfRYz4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750885701; c=relaxed/simple;
	bh=KdBoKcLFtLnD5bRAHMA4AvtozLfQei02TLYlC5SyXHQ=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=gGw7+okrq0Rylx50yF0MHo9DyscTdddw5FCiUDv2IDjYqFAztMqdN1NTVabRqMzTVfOTQYKidPI4bsJ8bO7ClPxE2LVXIfnS7H5PtqycN1YQDZJMtNNaoSgWwircqN+kJVh4DGKR1ZBDVTlXUv8/CXlr1yFy/VH/Rzz+CHS5Esc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 44DC63857400
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=W8ZZhRqW
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so437313a12.1
        for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750885700; x=1751490500; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KdBoKcLFtLnD5bRAHMA4AvtozLfQei02TLYlC5SyXHQ=;
        b=W8ZZhRqWBaF6wUnywki2Qa/Q5nITJCcENk+2vkJWAWdk8a6BwB3q57bcCR6/Vj8IPO
         CU1eL2vGxv+Ceg4z99Diw54h+hbY5Zjb1dZ0y8t07cJVubNVUw8IxFHNtzRWfqdeq7je
         zZjRGHZ2yzKNS2JwPBj0xWjGnPAXpB+mXHl3w6qbVwCwRIGTtievi9PCMWRxL0xpgf4g
         U8tk4Gzo2zw2ajcB4FlV5g1OpOFK+GXDlp9z2dsOs1DBhrulkuVG/Pr/8x8D6LhJdwdH
         aZjOVqerkFuItcnWqtKize7z3LLu2IY7BDykMSUgvBMKxhlI7OjHgdazTKSw9UdGBFTO
         UdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750885700; x=1751490500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdBoKcLFtLnD5bRAHMA4AvtozLfQei02TLYlC5SyXHQ=;
        b=lF6ZBe9UJqtGSHSc8peEsXAPc8j7qm7C05vHowlnGwi0iQl02ougYiYkLEfqaga6g/
         VAryJzYhUmRQH4p7Zs1Lc9ULM7PjZrQR5DCL0jkUKZbnM4Fzepi9WR1BYKHlCAzAZbOZ
         PqYES2a587hpuUsYTSVNFXILKXlAUdINAebMEf5x8LrggDh/bXxJdeGaln2Gak5847Z2
         8+Q8wLU6XJjlwoxiQs4xHrDmS257SpY+pCUUjiHSWZ4oEbajLMqmUmQxRsczQGq4Ps5C
         p60Q5uez5v/75iOvY7jlD7dGcg1ebeu/iJKLPX5SIULdxkFBHqrePdojIF/PtWm3brbk
         Uojw==
X-Gm-Message-State: AOJu0Yy1igjfoGmaigLnhPN0/dsIdFm442tGpPjwLWKhvy5cSIzI01mx
	+pQ3fpGlxL4cyxTvqd287w6zdqZsTEu3UyxWlQ8T+DKfGOhY1jjySS8DUADepMv6diqWBglry+q
	WMjnwEO2WnfNncdHn3ZdYQYec2SBcZEeqzg==
X-Gm-Gg: ASbGncuALmOAuRaTAF/wlY6k+JQOqj+sGC2sjXmhCCq//cEtxgwfNdXl6TCITv6zqRb
	v5lDEpO0m3RX3bGGiyAGcory0JCW6zuM//KvZsKYZjrU4WgzZIiQe/TRXYLn3mqFIHoSeFkY316
	H0JBFd4TJy0DLJMtVXr6eRXOZWCk84xOCRIlncDN6Vgr+heql0/BWdjW1K
X-Google-Smtp-Source: AGHT+IGtZEtUvBdkjaDdWiKyix9OIXVj6r3i0EbyqunPuSBwi+oo0XCUo2Zz+9Vb2q9FYRQou5QbsXM58RenzhcKF9M=
X-Received: by 2002:a05:6402:524c:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-60c4d277adbmr3938981a12.6.1750885699743; Wed, 25 Jun 2025
 14:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
 <20250622083213.1871-2-johnhaugabook@gmail.com> <7b04ae6a-836a-4c77-85de-7dd288331b3b@dronecode.org.uk>
In-Reply-To: <7b04ae6a-836a-4c77-85de-7dd288331b3b@dronecode.org.uk>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Wed, 25 Jun 2025 17:07:43 -0400
X-Gm-Features: Ac12FXyE-3fHIQlskH3fl_qJOvv39nQo0a78vrgDgWwL9J8emo7qf8i4pifEex4
Message-ID: <CAKrZaUvhZJBpeSO=7OitNg9P8LOvGAMq7uB54=wPdv_5koKPuQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] install.html: add -P option tip
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

> I know that the option parsing in setup can be picky and janky, but if
> there are some situations where it doesn't work as expected, I need to
> know about them before they can be fixed.

It worked. I just tested it again on three different computers using
Windows 10 (x2), and 11 (x1 - including a sandbox), and got consistent
results using aggregated packages. Either my syntax was incorrect
(probably should've kept history), or something else; but prior to today
I was getting inconsistent results.

With that said - I'm gonna scratch this one off. Thanks for looking at
it and the feedback though, and sorry for the sloppiness in regards to
this patch.

Take Care,

John Haugabook
