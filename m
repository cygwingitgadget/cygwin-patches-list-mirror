Return-Path: <SRS0=cLwo=NB=gmail.com=noelgrandin@sourceware.org>
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by sourceware.org (Postfix) with ESMTPS id 52F5A3858C50
	for <cygwin-patches@cygwin.com>; Thu, 30 May 2024 08:36:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 52F5A3858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 52F5A3858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::330
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717058203; cv=none;
	b=PNyyoujFDy9XXUxaFwusKPOQX8c/EHPiAIh6jlAhZY+o7heWZr8VBwRcaW+J1K1zOP/Gb3T8AhDbONHzsSAH2LurBfy1LTv1vQ5SeicD+9RS/dcEM47WC/nMYot1HFxZpHyxZLJYL23fMkBzbn6r71pJIcXr9yGQH0/am3csKVc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717058203; c=relaxed/simple;
	bh=D/5X3edZcPx43OJpi6UE/CdPFKdMZQfXZgJTWmDt9eQ=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=w+oE7UgyhY1/Cfjs/u6dvxkjep2lFCbz3qAMNaVTOpkveMtMqlNFnpZObZvCIKnCf3idDuSUpEnUHPmBXpfOgttPbZ9eamuXPoaGbmh8WS7aiLUNFVJrCfre/fXC/Zg0t21fT8B499N6JDxqwnCV4jYRMmxXJN67NwXaIiS7wmY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso6139905e9.3
        for <cygwin-patches@cygwin.com>; Thu, 30 May 2024 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717058195; x=1717662995; darn=cygwin.com;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtU8Q5eJ5K0xbGU44AZXqmoCZ0bvNgUy4o/tL7qVGhQ=;
        b=iHlUcA2Zdvy4ZzuY41kfooGXNBa9fNF7mKeBmh9bgdASu4lwr7EGG+pfzhrqTxYEtn
         pfmLoCsVADtvO5xKMfMby4v2qLxCVucapjnEWWlEvSsOAwSTTwtM6aF0/aQIz3XAwUkt
         by8blVrJpktvulsCIeJMJJN2pETqWZG5qFB3CM+OIm1p8upeyDZAmG+9D4j5fZy1yKfq
         lXMmnUWJ7I59Ai3SxBqKbrjYANCT8T44wMmXMTwAhiBM2x4/dl7Cil8gaW7QyY5wgQCj
         +smsl90vl6wZNYGwp0s0KSf6Q7ORK9C90073iT7l99yaEGAEFmfKbO5fMAOErz2W75oC
         j5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058195; x=1717662995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtU8Q5eJ5K0xbGU44AZXqmoCZ0bvNgUy4o/tL7qVGhQ=;
        b=nv/Gv4hixPjubQVL1qt3uM0hpmFaFdHbew+JVtVfUKFBMWrq0daZ1mdwnl8IdtA14c
         TZPAaRGyr3ACao77dwp5mSKPmIe7spGdjvelAPAJUgc0MqCfVyEw5cS9bwtErLm1AsiV
         WroR4I9NjSG6zJ5H9MdavZQPbc6RMAiCma2wGmvC4zSlPSrACwAyHOYpfTeqcM3aMxse
         tyNNpqgNp3LCKsMBDVNXzitji9Zom57R+HcVxxhGU1dm9rJp1j6uG2HRJ2f4Z5SpVlOX
         REAPBi4ztQAtkSO8KheLanl4Nq/mYnRxNZ+ILlTwpBbe2PzweTQO4rXMH2jYF1GuEgt6
         hLVg==
X-Forwarded-Encrypted: i=1; AJvYcCXhiRbNmQoAJGPupQ1NR5fGDQB5r++j6PSC1XhXO98cScREB39qULBVcnAR5kkOI6MSC49r18lNYI764WsxTdpmgqQaMlPhFPbt
X-Gm-Message-State: AOJu0Yxk62OlZwBrcir9D4h2zDhiGxPv0qGActkmiPdgU/4RDz5RFRpt
	J08GNg+f9N6PGZ8n9zt4NOJVKW/+5AsXZCP0Rg7lPXnKtPDjEZWIIZSehw==
X-Google-Smtp-Source: AGHT+IGs5BO+HytF8jUDWkpz0EOsakg1g0ZmuDIMrWZh1+G6VBFChZalk2Eh6/2i2JPGxJ5+E/8Y2Q==
X-Received: by 2002:a05:600c:a50:b0:420:16b2:67f4 with SMTP id 5b1f17b1804b1-421278167b5mr12940375e9.12.1717058194773;
        Thu, 30 May 2024 01:36:34 -0700 (PDT)
Received: from [192.168.1.234] ([155.93.192.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127059a50sm18121045e9.1.2024.05.30.01.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 01:36:33 -0700 (PDT)
Message-ID: <0126a98a-3bdc-4303-a0d2-09f4c7009392@gmail.com>
Date: Thu, 30 May 2024 10:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: pthread: Fix a race issue introduced by the
 commit 2c5433e5da82
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Cc: Bruno Haible <bruno@clisp.org>
References: <20240530050538.53724-1-takashi.yano@nifty.ne.jp>
Content-Language: en-GB
From: Noel Grandin <noelgrandin@gmail.com>
In-Reply-To: <20240530050538.53724-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>



On 5/30/2024 7:05 AM, Takashi Yano wrote:
> +  /* Sign bit of once_control->state is used as done flag */
> +  if (once_control->state & INT_MIN)
>       return 0;

This piece does not look atomic.

>   
> +  /* The type of &once_control->state is int *, which is compatible with
> +     LONG * (the type of the first argument of InterlockedIncrement()). */
> +  InterlockedIncrement (&once_control->state);
>     pthread_mutex_lock (&once_control->mutex);

Which means a thread could easily end up here, while another thread is busy destroying once_control->mutex.

Pardon my ignorance, but why not rather use the Windows SRWLock functionality?
https://learn.microsoft.com/en-us/windows/win32/sync/slim-reader-writer--srw--locks

SRW locks are very fast, only require a single pointer-sized storage area, can be statically initialised, and do not 
need to be destroyed, so there is no possibibilty of memory leakage.

Then the implementation simply becomes

int pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
{
     AcquireSRWLockExclusive(once_control->lock);
     if (!once_control->state)
     {
         init_routine()
         once_control->state = 1;
     }
     ReleaseSRWLockExclusive(once_control->lock);
}
