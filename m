Return-Path: <SRS0=TGQK=R3=gmail.com=hbbroeker@sourceware.org>
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by sourceware.org (Postfix) with ESMTPS id 49C633857439
	for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 17:25:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 49C633857439
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 49C633857439
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::62e
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730395521; cv=none;
	b=GD6iQ8dCBo+Sy2vprWxKh2enbpOtADeDGEH/EBrMM2CI0g7Yvi5GvSt8MnlLMAPJv2LNSOoSllxA10OuBTsEfoeC6+a1Y9sdQJzd5wyFguGEgDSia0mTWBDNGHlcDU6ayfmDXOo+czRjhkg5L/nkbCrVQISohFDFPE7y9r4hbUE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730395521; c=relaxed/simple;
	bh=qLms7UScsOQO+3udBEeSiWvyjZxKUyni9z8WbU0sc7s=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=fJRMpyyaj9+Kqtk7g3YNGVQHjH+juSfQQK+L1vROGKcdPorDyjxqyUBRMGRjM3eGbAQwZhaGKVmFN/qdBSjOD8VjVf9pPNCcnJ3lYvfFdA8h87fKDZjYNr6F+kK6NIZHzZFa1A/wVTWZxW1kOZ67/07QW6PQkG9TbqydNkUp3Hc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso178842066b.1
        for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730395514; x=1731000314; darn=cygwin.com;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bm6xH15F9uG8pCxRgocX3TtWv3m5kMzXpgYytJ/Iro4=;
        b=D2x7cFMfc29EYdo5u/hB5AhujyFO6Zb0EGz6QRYiU8qnziuDNEQ2ijUFVVnv/Wplze
         8dc4dxCpHigXtN5kjz81Q9Iz7ig2gz3uX4ibkZdct7oR6H7LH/Hd73wmpnI8X4hDaqBY
         Jb5Y0QPNHP5AABeG17QJxwEKAPGIp3FO1xYR3p8kT42ZV2gLcxgVYXXENOlMFJeeHvNQ
         FBAiJo7XCdRRa0zgEh1Ye1F5wnMKOCBAWugO5bQgoD+Tn1t0yS2lONfVkKxzE0W9jZYV
         mjs+5LSMl3/BGYeqRuvM8QFx8oyFKv4h6jeNwxfouH70t4pQAzKwBIsye7KdUSQNxafA
         ygtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395514; x=1731000314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bm6xH15F9uG8pCxRgocX3TtWv3m5kMzXpgYytJ/Iro4=;
        b=sdqFjFR16Ea35zEglG0SpjouyB3KQdSR6tligEWwLtW1HssDOaquHsPZ59fSklEcDB
         NSNV8l2/eIJL0CUof3eZSUTvTs87SB4X7KoDD3tw4vo7yIoP2lHw27Fj3dREpDzLSciK
         7HgfK76ATDYA+RzKpvCSTK+LfCkQ/mrIlk3GXKcq7br03lSLhkRxnStR3ppG5jd/fsM3
         58G3ZHAzdUzje/Ons2C4RVXmKzzsdGVT/jsPUleZZjbI0QNtVjycCsvx5St1qV7p86iU
         qwgFIsAuYHZUjHZnrZC2f6NdBGlPbpuCb8a0l/5BU+hxfoXOU9MJ8CCjoOEJh1NU6+zK
         YGRw==
X-Gm-Message-State: AOJu0Yxvxa/HrbRcjbDYeWk5N5jbvsqjzrz/xApGuF+q9DCeHy/ZXZyK
	PjkKhBP1kAZJzafddtqRr4qssijULG10YcVz/FWk4EIXYPWXamL5Hy4PCA==
X-Google-Smtp-Source: AGHT+IE6ayXJbC5ZLs9mtJQ5/pDCcpUWC3+lzY1vRNjMO7aRB80iLTUnfWoa2JWGN05QB8+vbvegJw==
X-Received: by 2002:a17:907:7e8e:b0:a99:e939:d69e with SMTP id a640c23a62f3a-a9de61d1a8cmr1634554066b.51.1730395513792;
        Thu, 31 Oct 2024 10:25:13 -0700 (PDT)
Received: from ?IPV6:2a00:6020:4c33:8a00:f4ec:b042:c862:9fd8? ([2a00:6020:4c33:8a00:f4ec:b042:c862:9fd8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564942a4sm88490766b.24.2024.10.31.10.25.12
        for <cygwin-patches@cygwin.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:25:12 -0700 (PDT)
Message-ID: <f90ddf4b-7c5e-47d5-ac8d-2abbea02037a@gmail.com>
Date: Thu, 31 Oct 2024 18:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
To: cygwin-patches@cygwin.com
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
 <Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
 <20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
 <ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
 <20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
 <Zx9fk6yQ1etCVwek@calimero.vinschen.de>
 <20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
 <20241028202516.0dd4c86cb2efa9f7db8c856d@nifty.ne.jp>
 <Zx98ETE7E1DMGirF@calimero.vinschen.de>
 <20241031173642.34cf4980cea2276e7402c4d2@nifty.ne.jp>
 <ZyNY36rwRtAVglBP@calimero.vinschen.de>
 <20241101012506.e7279dbbace0480badd394b4@nifty.ne.jp>
Content-Language: de-DE, en-US, en-GB
From: =?UTF-8?Q?Hans-Bernhard_Br=C3=B6ker?= <hbbroeker@gmail.com>
In-Reply-To: <20241101012506.e7279dbbace0480badd394b4@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Am 31.10.2024 um 17:25 schrieb Takashi Yano:
> On Thu, 31 Oct 2024 11:15:59 +0100
> Corinna Vinschen wrote:
>> Yes, I will, but this is still puzzeling. While negative shift values
>> are undefined in C, there's this:

[...]

> I guess the compiler ommitted the undefined calculation.
>
Precisely. Using negative arguments on the right hand side of shift 
operators is undefined behaviour.  The compiler can do whatever tickles 
its fancy with that code.

For about a decade now, compilers like GCC have raised quite some ruckus 
by what some people view as an abuse of this "poetic license": they 
completely remove any provably undefined behaviour they discover, and 
from that point on may assume whichever outcome makes the following code 
the easiest to compile.  Their reasoning goes something like this: 
writing code with undefined behaviour means the user has relinquished 
any rights they ever had to get reasonable output. So instead the 
compiler writers decided to make life easy for the people who still 
mattered at that point: themselves.

What that means for us compiler users, even as we're implementing the 
runtime library, i.e. a substantial part of the C compiler toolchain 
itself, here, is relatively clear: we must not write such code.

Oh, and BTW, __builtin_clzl() is the wrong function to use on signed 
inputs, anyway :-)

