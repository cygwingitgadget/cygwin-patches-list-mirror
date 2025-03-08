Return-Path: <SRS0=6X0C=V3=gmail.com=marco.atzeri@sourceware.org>
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by sourceware.org (Postfix) with ESMTPS id C89FF3858D1E
	for <cygwin-patches@cygwin.com>; Sat,  8 Mar 2025 11:38:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C89FF3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C89FF3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::531
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741433931; cv=none;
	b=PNXL+wx2/bL+vRPuHewhMqO6nRuauUi3FnSsmpEM/oZiS5JWhB8KOmtAyKXSORziNBTB2QnodF9bYPKSIj0YHVgMkJnywpaJqxMjPhUWoJPl/CaTi3qaga9Lj3FzmvhFDTLXxesHSaP3GqBzB5Jacjm37Hlx79Do1O1nGJ9JtcE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741433931; c=relaxed/simple;
	bh=qN7Q1AW56GUBWgrn6U06aFUYZGwvLT/Xuodq9hpXPCk=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=LplQF2nuCdaV0qu+QlgbSD/fZ8m0+nmvMJMsgiqABoVmJWuff8yOg1pHlDZRSLYAja/+lhaj+n6LMzZ5gq0USiAd5FGZIjW/Sc9+vw65STHAlLqn0Nn4IlxrjroftoCTQOuc6pIYh+mz2X+rgoJspvO6cjTbeBdQ44XOlzx0MrY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C89FF3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LG8BzXw6
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so3153088a12.1
        for <cygwin-patches@cygwin.com>; Sat, 08 Mar 2025 03:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741433929; x=1742038729; darn=cygwin.com;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+X7JpaI7lkCO8MLhn/LJwpeu1YL+Qij4L8jPANFkss=;
        b=LG8BzXw65bBCjbbgKjZ3iBArkOXzDRrxgONXUFVzKzyhGFrkvGrt+E7zw7XheWj5TL
         nyyKYRCSLho44TIAhryr5Pn+3lSVAsUaeF70yjCcV7G42Dn0QOXiEP3vocifcW6X+lby
         OJoFDaqunCDtyi7QHv3GwRToW2dFodG/7U8uN6zaGfz1G/bZ4gy1ZY/SIE6IrAcKZtvs
         /WgNVfZaGhfEkfxxlx3KQz4BYIsPlUJreIafKPxpjjM3pKwQlEzO4aqHYEZmnoPxk3Wk
         0QU9a23UwPRH6vqc9sAHRG7lLhPuQCAmGTc0gs8bKqQsnKMr0EWjnPpXMckxCUQsepwG
         j+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741433929; x=1742038729;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+X7JpaI7lkCO8MLhn/LJwpeu1YL+Qij4L8jPANFkss=;
        b=cimM18nJ9ITgzvjsbkUzDFYXQUynrlIt4o5jLcXp/NFy+8YwP3t+c03tC3092a0AWF
         iqKmq2GdLJseqKXQU3kLQnIHaDDUhHyqod7tBYDnrcXXUo4cdAcwfTK+AiJKcC2LJrgT
         PCLvJ4bmPWtvwTPGl3jxxB0B5aKtzE7ZegQQ3Rtvvkz82J/J+oKLOc12waHPfBn3qBZt
         7DN/zf7obpSZC/ezUouJ2rylf0VA/yWu1brUrakX/0lTTQW2FEsk/r8NxxBOK+c8Z5Xe
         WdmvPGeC7OCkXr5QpqTeoq5T9mEgRTRXlEQwF3VQx4PB8HnVnuhJ/ipcTpwNeJyhl9pX
         K4Ug==
X-Gm-Message-State: AOJu0Yy2bzO5OUryZIlmOuvp+KnHs0FED5gtfA+uBsVV6shdYOMUVqTK
	To/BBB18iwiGHoUVNZo2NCIIRJ6KjqoxyeW9VN0tK6qr5fXf6zFSoDCz5A==
X-Gm-Gg: ASbGncvlsgYZmQQoM0/KxXUbxi0UemLx1Jemh+D4ShuBvi39OiGglamKEQi8Z2Aopcp
	xVWHwUTCKIZ5APTPbhF1QfRK6AJLRhruHthE6xE1PB0TVmp4+5rCJn1fzbH9UehKvY3HMKaAZvr
	Nbb5YtWq7CbF52OqfGlKDGUMAJhy3E21cwaoOsFkiSo85PyS07TUWFiVCtDqfL/IgTjZrON1Y7w
	PNrw1ef/9uoIJXjtw/VWixHobrgWEGRsgSfqOC1lGIRqUz7ZvO9Uh1fBiis1cofNpdVtYazQf2N
	lhvV+KP9VypvioPu7FMBoB1BTHcYsHtxVfYFJ3YW2anYdYVoKEiB9g6GUJl+Bp7N4ezpN9KASfF
	nkY6QnXJzw5DAP3vSRmYgR/RIOps=
X-Google-Smtp-Source: AGHT+IFaEDstfxsjLrAvHxoKh45pEHBf1S3XvAaOxqB7Vj3UI9gB1wzon8qHCDi/j6+Rh+3GngLj7g==
X-Received: by 2002:a05:6402:4020:b0:5e5:ea02:1230 with SMTP id 4fb4d7f45d1cf-5e5ea021550mr7751882a12.28.1741433929195;
        Sat, 08 Mar 2025 03:38:49 -0800 (PST)
Received: from ?IPV6:2001:a61:12ee:ed01:e090:615a:1559:326b? ([2001:a61:12ee:ed01:e090:615a:1559:326b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a8608sm3823074a12.38.2025.03.08.03.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 03:38:48 -0800 (PST)
Message-ID: <79e2e9a1-f7e3-43a8-b1fd-1a1bdd477158@gmail.com>
Date: Sat, 8 Mar 2025 12:38:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GOLDSTAR][PLUSHHIPPO] Re: [PATCH v3 2/3] Cygwin: signal: Fix a
 race issue on modifying _pinfo::process_state
To: cygwin-patches@cygwin.com
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
 <20250228233406.950-3-takashi.yano@nifty.ne.jp>
 <Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
 <20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp>
 <Z8WoFOXWxwC8AJNx@calimero.vinschen.de>
 <20250303233919.4f463d642c88623f9c520f74@nifty.ne.jp>
 <Z8X6uJJwhVA7i7lk@calimero.vinschen.de>
 <74c86bc5-ba6c-4ea2-b39f-d41ef538c5f9@dronecode.org.uk>
 <Z8nvhKqPZ6k7DgIs@calimero.vinschen.de>
Content-Language: en-US
Cc: andrex.e.schulman@gmail.com
From: Marco Atzeri <marco.atzeri@gmail.com>
In-Reply-To: <Z8nvhKqPZ6k7DgIs@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 06/03/2025 19:55, Corinna Vinschen wrote:
> On Mar  6 14:55, Jon Turney wrote:
>> On 03/03/2025 18:53, Corinna Vinschen wrote:
>>> On Mar  3 23:39, Takashi Yano wrote:
>>>> On Mon, 3 Mar 2025 14:01:08 +0100
>>>> Corinna Vinschen wrote:

>>>
>>> Great.  Feel free to push the patch without sending another patch
>>> submission to cygwin-patches.
>>
>> I think Takashi-san must be about due another gold star, as he's been doing
>> some sterling work recently, fixing complex and difficult to reproduce bugs!
> 
> Absolutely!  Yesterday I was even mulling over a pink plush hippo, but
> Takashi already has one over his fireplace and I wasn't sure if a second
> one isn't taking too much space.
> 
> 
> Corinna

An hippo is well deserved IMHO

Regards
Marco

