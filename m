Return-Path: <SRS0=czsM=XS=gmail.com=collin.funk1@sourceware.org>
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by sourceware.org (Postfix) with ESMTPS id BFB443858D34
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 05:33:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BFB443858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BFB443858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::62b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746164022; cv=none;
	b=MaEMPfCh/8uarUkA+jNb8GxTftd9IEu8b4IElFsP3UaDEuOtwJ+KOLnTbsW/p8CjHAeebZGN7DEMF/K9QgrG6HP4vfu0jkav5jfVc6YA+ysWCUkPz4xxbbe6YnWsKPM9mGUnK6svuEfw3JflqM07a9RRBRjwjCHOXM7iuAclZww=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746164022; c=relaxed/simple;
	bh=R2TVmDuhyk4Gn3N8M1RKTEWOfF5xb/EXRqV8IAwNW+Y=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=I55u68y9nqIR4jBENtkP5pyp+GKlLGJlPMwbOq9h6SPA59W+kRCc+5rJByZzkuqF8m5qGm8LrRzk02ZtXqQmEvYK3z9hMcPIgNU7z3dEuO5U4vXITZM3232H1kDxr+UKKM0QUOhR/aRcAzBIdVHxx4oZIPsRf1LN3KrDbnKUgdQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BFB443858D34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EFb/J5Wh
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-227b828de00so16900025ad.1
        for <cygwin-patches@cygwin.com>; Thu, 01 May 2025 22:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746164021; x=1746768821; darn=cygwin.com;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UkQPYDdLIeeXHsOA3m66J83dJmNMXMO93BSLyZl4uU=;
        b=EFb/J5WhKV3nNIp6uYG8WQ0tZj9XkWNbXfd5MTUnQc7UXT/eru436Tza2PqVlG8O0d
         QnPS6vEFbJ+NiPOEdHtenS4v1xpV4QkRibqgypSU6Ypvb+Ehk2z17aGmnBqWyIkKjQP7
         ZPpQ4AtvdgbMIw1yx7PhZyG1n4/MBW7uDphboyaJhH1PeUJFNXmmfT5JBuh6MuZDy0EO
         tCl7bCAjtobaI3djM50F23HBvn4ztJdSa79iRzWigZBeYIU0xau/8MWTlpe7s1zGIXMi
         e9UJ4D3GL4EdjdNwFyoc8Q8Zp773kCjSi3qEuCUDDU4lKh7fTKbr7uoXOMZreKiTAhtx
         +NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746164021; x=1746768821;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UkQPYDdLIeeXHsOA3m66J83dJmNMXMO93BSLyZl4uU=;
        b=ARURhLZ5xmg+ddk8Lt62YUqVfbSsmJ0okm5ZUuoVfy0ToeL4OOPAIFYYRh4tcZHtv5
         VQPVeAxtJasMr7Lgv+gn6NGueoyyvOQo0StUg5Flhd5JWBEYctFqe0kmw8d07htcPred
         +N/3dd7lS4bI8LXIlbeztv2qncetBKvP6NUOIzu1RGvNjfXdnnePHEe44XpWBhRoX0/4
         RaHKrN6S59toMuBriXVhUduKlqokTUXZLK9xpDOgpothQ7mbe95Vw14GGspgsgtHwjE2
         ipxRM80M8Oize5RUZGSxLp1bz8/y3mB8SKIWQiNadrfSRe/mkQSaKy1RnTUtNbgoSaJc
         Ab3g==
X-Gm-Message-State: AOJu0YxdRRf9nlQzJsrOOrGl/yQHhVKfPRTuwEfTAj7M7PCKEWdlT0+G
	U94Vbd2AiZrka5qCuCzNPqHYgskhz8N0tbiwWBoD8NuUsTTqDJILkxTeWXba
X-Gm-Gg: ASbGncuvPnKOVQGDarEL/Hj2eafebY57YEKvKQo24P4N3saLy3LJbkqkfP+pfo1kasB
	E/y5uab7ZTXTUt6TWeRCTG6oGq8krfec+zNZ59bKlDArIa3dC20G39tzmf6c+wCWZITS5xv7ewv
	isV96vvn6Q9xgBYFOSBdNI+MrDRgDA5Ml1wmp5j004D4vetBjdh3c5yJGbJUTm7U8K6MMlGviRp
	4c6hRCdbhDx0qguFyMyw2m/eRZ9hN7BJJ570orNkze3Rf/9NyyqqhMlsTuvcOzdIE2FSj/HSFQ3
	CKLSpa3xSw3HLU+xCJ4BqRc7YyV2TsxxuoXa0mUe6FResbymp0kYDqCUXE9Ydexu1G+1FpGCP/X
	uew==
X-Google-Smtp-Source: AGHT+IHtY4m9P8O72FqJnuXo9nlDAl0IV1GuLqJErAVfW9WnH/DNPu6FIIrPtltiIduPE+9ZjUDQ8A==
X-Received: by 2002:a17:903:4404:b0:223:fb3a:8647 with SMTP id d9443c01a7336-22e1033c81fmr23829475ad.41.1746164021580;
        Thu, 01 May 2025 22:33:41 -0700 (PDT)
Received: from fedora (static-198-54-134-143.cust.tzulo.com. [198.54.134.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1091505bsm5739385ad.189.2025.05.01.22.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 22:33:41 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Update search.h functions for POSIX.1-2024
In-Reply-To: <20250502045656.833-1-mark@maxrnd.com>
References: <20250502045656.833-1-mark@maxrnd.com>
Date: Thu, 01 May 2025 22:33:40 -0700
Message-ID: <87a57vy3t7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mark Geisert <mark@maxrnd.com> writes:

> Add type posix_tnode.  Change certain uses of "void" to "posix_tnode" in
> both the prototypes and definitions of functions associated with <search.h>.
>
> (Necessary changes to Newlib's /libc/include/search.h have already been
> submitted in a patch sent to newlib@sourceware.org.)

Thanks for the patch and forwarding everything to the right places for
me!

Collin
