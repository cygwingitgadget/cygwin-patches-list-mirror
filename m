Return-Path: <SRS0=OUqM=E7=saaswiz.pro=andrey@sourceware.org>
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by sourceware.org (Postfix) with ESMTPS id B223A3858C54
	for <cygwin-patches@cygwin.com>; Fri, 15 Sep 2023 15:31:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B223A3858C54
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=saaswiz.pro
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=saaswiz.pro
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-770ef4d36f2so144446585a.0
        for <cygwin-patches@cygwin.com>; Fri, 15 Sep 2023 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saaswiz-pro.20230601.gappssmtp.com; s=20230601; t=1694791892; x=1695396692; darn=cygwin.com;
        h=mime-version:date:subject:to:from:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yZF+qYyTfrMwFg920iBrOsXrhoPKqKCn52okY1Xb04g=;
        b=Qo9Y8s4LHSWKFHf+v0uDJlhG6cQNFD6klFqqG9GfUSa9JMOgzu12vmpQTNmGqa80Hz
         cOz/t9PgQBfuUyoIzl4ME3jgyvdw09XG1X0w+g7KGFpJ+GwpnpnC9F4Hd7I5llSM/md5
         GUlZbXbA5OVFeWWGjM60XH4jwkc6SJJoda1DtZqocU96B0BmmSTtwV7d7pFz/CyVWnOe
         UkrlZrJBVKsp2qwKYBWRJu++1mPT4xWAW5hUoi6B+gaFcmld3InMep6ZaU4x+PHq6ZfK
         ap+bswT4xpy/SAWoXcY5Q2nMZn821FntUMsHHeypyFkEpLUkQTlVRuERASDJV57Qb/pf
         x16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791892; x=1695396692;
        h=mime-version:date:subject:to:from:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZF+qYyTfrMwFg920iBrOsXrhoPKqKCn52okY1Xb04g=;
        b=oERzkzU9/sFdHmFz+9wPZgXSbqa71NWP9cSlnsgUn1AeD7oFGSYtY0NPsae0ptqX1A
         GE1gvURd703YFsUPnSP/V60H+KH3PBE9nLGPNM7wHZLVICnBbkSpBc4ryKe4IUvhT2cW
         FkgxsInm+427tu0fBmoIfjOC5ejFzqIDxHCH6lMLAyizOLeVStobIytVZ4J98zElOeTJ
         4wtLwGSzojiEqEkhIjaZYa+9D6iIZAPMoXZVP2ecvU1hXeoUKqqSGm/KroZ7mFWCS0DD
         fMIhHXf6/+C7B2t+NY8/yB+FVDGBcKME2DGs/3tjoQV70SjVSH7rEPjbMbUW/2p0Q9pC
         eTvA==
X-Gm-Message-State: AOJu0YzfdPSn7ZMMOyGQNDBjx3GRCImaLLNAJr7XamrI+4wbIFKTnMwq
	RkuwhBPUddMRHbaPgug9qrVPTN6lByjRJjyevCw=
X-Google-Smtp-Source: AGHT+IHZyvVBZipaS06eB5My6zojeSUY9vJBK4pWHw9NHtD0BHWjwQcRbJsjRwoWYbWuprn8nt9wdA==
X-Received: by 2002:ae9:e515:0:b0:770:f2f6:e184 with SMTP id w21-20020ae9e515000000b00770f2f6e184mr1764212qkf.39.1694791891908;
        Fri, 15 Sep 2023 08:31:31 -0700 (PDT)
Received: from Mac-Pro.local (ec2-54-86-182-46.compute-1.amazonaws.com. [54.86.182.46])
        by smtp.gmail.com with ESMTPSA id o5-20020ac85545000000b004179e79069asm200547qtr.21.2023.09.15.08.31.31
        for <cygwin-patches@cygwin.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:31:31 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="--_NmP-2c2944f9a4243453-Part_1"
Message-ID: <fe63f211-a8bd-482e-9692-fb1da2f37375@saaswiz.pro>
From: Andrei Kholkin <andrey@saaswiz.pro>
To: cygwin-patches@cygwin.com
Subject: MVP development and cloud consulting
Date: Fri, 15 Sep 2023 15:31:31 +0000
MIME-Version: 1.0
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,HTML_IMAGE_ONLY_12,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_PDS_PRO_TLD,T_REMOTE_IMAGE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

----_NmP-2c2944f9a4243453-Part_1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello there,

I'm Andrey from BuildByte.

We have a track record in effective MVP development and robust cloud strate=
gies.

I think we can give important insights for Cygwin.

Are you available for a brief conversation soon?

Regards,

Andrey Kholkin
Technical Consultant
BuildByte.co //BuildByte.co
t: +1 (650) 529-7225

------------
Our Main Office:
Avenida Mendes Silva 15
3030-193
Coimbra, Portugal


picture [https://trc.saaswiz.pro/tmid_a/u5CCPOyZvgCJ0Jzw-iTnu] logo [https:=
//trc.saaswiz.pro/tmid_a/u5CCPOyZvgCJ0Jzw-iTnu]=

----_NmP-2c2944f9a4243453-Part_1--
