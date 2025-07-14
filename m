Return-Path: <SRS0=cjZq=Z3=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by sourceware.org (Postfix) with ESMTPS id D442A385840F
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 19:59:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D442A385840F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D442A385840F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::536
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752523187; cv=none;
	b=R5DuFZ0T6ZfPKNdonNy3Qbdv3A7tGynWswkHTWoAtQ63TE87jIYa9MbSpVG60vLx3abzgCmmvY/UZqlLgpsz8Ax/7PXLwil9SGlnnkVWQtaPF1Rktr5LVYIU8JLMS8aH5r3BzFJgcwaVQRLdzp4Wz9U4eoMSv9S3OC+OuvjQNhA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752523187; c=relaxed/simple;
	bh=smK3oGafeu/OFINPcLzFMPIObBGaYX11jsw1NdVB+4A=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=YRPcsrNZjIA9cbCEZmU1hWKZ8KGyZ5PiJli5YZVw/L9mnb2mBSdlSbXdaaD8CGB1uFEZZyek2e5Olchnx73Md9nKfj0TByEFcvrvf4mWs+zkHTKPpZEGl14i7DHoqam3FHT5ysHpTTwRkq1+B0tgjckj8JejGOxAEsI6R7b61J4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D442A385840F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z0Hd6ypm
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so9302407a12.3
        for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752523185; x=1753127985; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smK3oGafeu/OFINPcLzFMPIObBGaYX11jsw1NdVB+4A=;
        b=Z0Hd6ypmhFdKsCCOItJeRZ2hMCFAeHJg6aGO2H1+HT+7rQisUz/7GfJFKHh/zscA9E
         5/XOBXvK9FA/dcVsmM2ZOd0caVeA/PbNaY5ANF63K1FOuy82+xTD+zt6jXub2jrpYoqE
         jmjrgdztrQfNLTk0DEuWXQPNgT+ASfwxby9nk1p757CXU8kb78NziwOZqB7DDIM9ddlH
         MEmkJ/o3yg7DctLr3OGigS9ruLVXpoAPugKqY8y+qxL0lBHV/te/LKKkVTAuRYs6m2Vj
         QIK1VRZIKDq0qh7Ynjrdtx/rQ2jRMrTwtK5wqapY/oDE5aTcc49mhYjaYg8pVUOGXMax
         NcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752523185; x=1753127985;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smK3oGafeu/OFINPcLzFMPIObBGaYX11jsw1NdVB+4A=;
        b=hJW4PLJNHiaQBFQyaxVUgYvBjSE6PnqaKT7aE2XJxziwERprdwmrR+w+1+NXE7SrH5
         NMvw04JuSfbN5wma6jFVpQV/ZWmUDR9Ea3XqsBwTEiPnKE47g0hv+LUXR4c7wZZ1eMP2
         c3iNy7Da/gkkb1wjopIpNl44VVpcMUSNjlM5dtehr5/tMsoSHiBWOSRy9nRtjBNHZByf
         r97kKztwWLUzrO//ij6FPGrBrXhJ8Jbu7IdW0No95/pPCtF0bx47BpZMQA8nKrTUc1lz
         kX67Nzn/j9dB/3hIzSrRpWYh9uWWaQOnrKPMMVZ2KLF4L00n+RK2EF7Q3KJ1FJ0RKE6d
         bfnw==
X-Gm-Message-State: AOJu0Yyyg68BMffrGobG5HIQ8ARXhsOAU3ZDEsilbA8LinQNci7iPawW
	TaWfgy+pzeNGbi30j4sfsQmRPIbHldGDVdqPGtntzJO7cmph+ZqxfQ1HFjcE2SdjowdjBaZpEEF
	MSUZcRbw0UUTDniBPYZAJqsFOgYa20eH1hvPS
X-Gm-Gg: ASbGncuZH8SdZTWBG50AqSIBBaAUxEoQFe+EVDd8RbIJ08I9QFz7srNp+BgN4kNVdw1
	UI7sSP7KETeMuK2XM6mbUaBMNM8bF5iFWqNXdnDQ6vhvAk57brHSO9MVaV8oykSS1DoqrYKxMJw
	9ZQgZTzrwx7ugC9tVWs1h6pGFm0Q5hSGTBWZnDjp3/Bkt/1YwnWzZ0NcECZ+wmGazh5djMXUMZh
	ERNyQz1mBDjp3o6ZaTM
X-Google-Smtp-Source: AGHT+IGWJF2aDtLlZw/UU9FPXsowF3NG+SEZjXobKAO6h4zWmHbMWDfu34XlL9G123aIPfxkgkX4eS54w/y9B6/kA4M=
X-Received: by 2002:a05:6402:2794:b0:60c:3c23:2950 with SMTP id
 4fb4d7f45d1cf-611e76507d9mr13042003a12.8.1752523184928; Mon, 14 Jul 2025
 12:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250625013908.628-1-johnhaugabook@gmail.com> <20250625013908.628-3-johnhaugabook@gmail.com>
 <c8836ea2-2a1f-4225-8b79-bbe43bcc186b@dronecode.org.uk> <CAKrZaUssLPAzDPBmFQ_iC2WN=o1uEnoGsfKitC045S4H6unDZA@mail.gmail.com>
 <c2f6f66e-beb8-4a98-8365-ba19480d6a2a@SystematicSW.ab.ca>
In-Reply-To: <c2f6f66e-beb8-4a98-8365-ba19480d6a2a@SystematicSW.ab.ca>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Mon, 14 Jul 2025 15:59:07 -0400
X-Gm-Features: Ac12FXy8OEgdh2NE0QId2UCtCWBG6zSqxrSsAJPJ_JE3UmhKTA3DAjy3gDQ0yPc
Message-ID: <CAKrZaUtCXVRiW9Ski7LSZrZfPkLAF+cz1U6qJ6fXXi5z1VSiGA@mail.gmail.com>
Subject: Re: [PATCH 2/5] cygwin: faq-programming-6.21 ready-made download commands
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Thank you. I'll see what I can do.

Take Care,

John Haugabook
