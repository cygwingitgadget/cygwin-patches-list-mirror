Return-Path: <SRS0=U/MS=ZG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by sourceware.org (Postfix) with ESMTPS id A8BD3385B53E
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 22:47:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A8BD3385B53E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A8BD3385B53E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::529
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750718872; cv=none;
	b=MkGCBOUhBxhxsLOgtiBvw9w3VfV9yxLS1AddH5J/1PLZzfD+3zEZudei5Aw8py1AHZpcSXeKhxvdfOPUpBYVDTEXLwzIle+vP1mDjbPrAOO965hcguWjhyPsFKUjNi9L7qqv8k2u73yTABJoPsdqRtdrwphsoNvIvPBihTl77vo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750718872; c=relaxed/simple;
	bh=9+cUU2BCRYIzGDN5xQZ6ujjZbIp/RhWCRsVFCr5Zndc=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=PHMFf98H+e5bsjA+70m5FgtAEJ/E1JisdoTOPpEfn37nhvUJFxGdTD7tSudXFMq5nPPGpF4/v8d33rJMC3KYeygRrzJFnM/N13iIWm0NLc8KIR/rCiylgGih1TSm7J2eBUgk3Mq/KVtudObiRkG0wIQ+4D1tAvLbSYsWv1P6cfU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A8BD3385B53E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=apJbzGoF
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so8210801a12.2
        for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 15:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750718870; x=1751323670; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+cUU2BCRYIzGDN5xQZ6ujjZbIp/RhWCRsVFCr5Zndc=;
        b=apJbzGoFTVS8RbUwcH3emloAnhDdp+xZRKc0OF1Hr51HJ+qW520HsJkkTfgEENyhGU
         n089G/jy9HTjaWWYSAlh+SZrv+1PBnySPTyrUklAe6F1rkoWwEyMz2hG63Sr+Wo0+3Wb
         1Gmn8j1wFrW23UXKIRCHfum14OOcZkGJHzf4thm5U2U8syfH/GysXBacNGY64eznQJfZ
         bAQ6ldBEs2Zg/BEoicyk5dD9yVd8xC8Tfmi/IlnzTocTz6dCBEaYJ9XVry0+6OJ0oLqn
         RJQn+47clzjDaiIGURvfvv5QJMkhZTF7LwiYxKz/RFt8Rsi5xz1rwy2xCFTHsunEeYpc
         /ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750718870; x=1751323670;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+cUU2BCRYIzGDN5xQZ6ujjZbIp/RhWCRsVFCr5Zndc=;
        b=vIsZE3RNbApyVu1vNbJ2pkf0H7OlOb5cf49DxuH1PWMShwVwnFydtl1mv6hD/q1Ksp
         X5h9p81FOMXJ8jwqrdU2AiNFpbU1K5cRiNykQQIPw58nfgEyMg34YYZUkVVceoCA/+IU
         sYxfLKfHPUZSjuTAabciC0ldWta9SAb7MKHx2iJqQXchpY9Kv6gc2H+/C3weImKsHJHA
         42opHosaj/pC5grJhobAZOHPrfZUZYxvTX7MxxSWs83Bjb07qrwB8i8k1ZA5N3yEV+IH
         TK3uvulyOcdTyX+FjFxasaO7A7MNBRLOSAMurXY1JbVYNSjAzvAUelXDgYKwf6b8YJ90
         XmwA==
X-Gm-Message-State: AOJu0YwVwy1g4397GKFkrgWxu3UG4W1T3H1n6RWqVoc1xaCQalGVzjnf
	ApQ+zP0DC4qM8b/MAwjYQzKDIt1KCg9zxWG1ChvI5tASvXrhEtyVN9Q3O5SulQoP8+XsNFljMt5
	oyh+MjFUFqVSNoAzKw3QDDefDZMqq64k86w==
X-Gm-Gg: ASbGncsl+LqZ/t+Ssy+RADhiKEBpexUuTvGBiaWJYMHZW1KtxYli0udFOQhKAm+2J5J
	UDeroXk7j/R9D7hNPOpIbW+4eMJT2bZ2XeUKItDVF5BepludRF7pYxaHCCkTtzfSMDhlrR3FO1r
	AeZ6mc3REWop3QkdeHsebpcG60eNqlAHddkz0zsCbX457hCw==
X-Google-Smtp-Source: AGHT+IEUYrYaBMUWbypUbCNNbWwwdX6myemJMx8sV+ORpCsEXg90liBD78C0SUgyaTic6z6C+6e9ZmhfkRD2ovnHWcE=
X-Received: by 2002:a05:6402:2354:b0:5ff:ef06:1c52 with SMTP id
 4fb4d7f45d1cf-60a1cd1a062mr13830644a12.3.1750718869771; Mon, 23 Jun 2025
 15:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250622082003.1685-1-johnhaugabook@gmail.com> <aFmzX4CARCb0810R@calimero.vinschen.de>
In-Reply-To: <aFmzX4CARCb0810R@calimero.vinschen.de>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Mon, 23 Jun 2025 18:47:12 -0400
X-Gm-Features: Ac12FXwVMqLFdqTUX2gWQkuomQA94y5a5G-dUg7jRqmSyLl4xnjZPXH0lAF7Cjg
Message-ID: <CAKrZaUsZc+_JBsY1dRhwx9xhOind3yZLt-pMcoi1hu5GSEiU8w@mail.gmail.com>
Subject: Re: [PATCH 0/4] cygwin-htdocs: faq.html edits
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Thanks for your reply and feedback. I will make changes to the
relevant files, improve commit messages and summaries, and send a new
patch to newlib-cygwin.

Take Care,

John Haugabook
