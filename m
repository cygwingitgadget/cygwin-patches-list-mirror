Return-Path: <SRS0=WuzO=FE=saaswiz.pro=andrey@sourceware.org>
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by sourceware.org (Postfix) with ESMTPS id EE4E43858C27
	for <cygwin-patches@cygwin.com>; Wed, 20 Sep 2023 13:27:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE4E43858C27
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=saaswiz.pro
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=saaswiz.pro
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-64cca551ae2so39615326d6.0
        for <cygwin-patches@cygwin.com>; Wed, 20 Sep 2023 06:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saaswiz-pro.20230601.gappssmtp.com; s=20230601; t=1695216469; x=1695821269; darn=cygwin.com;
        h=mime-version:date:subject:to:from:references:in-reply-to:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V70fwoeh3SlaesnoONYL2xe0OSXRL3FY/8Mu5/fQiu8=;
        b=rPGE4+7N1L1jRrBmK+OB+8PAqWeMjoby1o9noinGcA1LlYSNutiLeEDdfgnYrzNOFq
         2Ca3drQ+JX6iyvW5d/avJhnebuR6C48RyCcoG0BLIMjkTw6TXAQVTe5Nndff9sPl3UWY
         /Idj7TwHIxVGVRpnRvmsGf26HcqcGgJ8LyXibYvEhoYYoIMmddjuFS4ZFmHEf/mR+APq
         HEpzPRf0Npnzm+6e6oeyWedi4iHzteJW5FZexMmQ5HpekbDKtzJtkgoiO8u7F+w7Lr50
         UoE2qK+g49xVkfEl/jNJ7Shxd9D456kBkcRwTjs2aUkxemm3oroq1kEj086/JobgD4e9
         s93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216469; x=1695821269;
        h=mime-version:date:subject:to:from:references:in-reply-to:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V70fwoeh3SlaesnoONYL2xe0OSXRL3FY/8Mu5/fQiu8=;
        b=QSxPNdiJl3Jv8Ta2iAmMxsyWoueuwtNnPPQDkf7rQEd1UrJYCm61gs1Bk0krP4ZHj3
         TJlPKniws5/xEQIeFobb8MxcT5ZEWup6TjD2j6x4I2IM94U5x/xEY9XEeipOtqsDzk7q
         /uXClglqG+bmnJNYVf3ZuE49oWWOiX0jJBZ/WBa10koiZ/wPxVaVXC/9kBAJ4wLIHjor
         5MJGx0T9Trjondr8Adi0xhHV0W/M3Hu2xTDvlIhwmZEOdue+vyrgreigJEWFQBtvTYTL
         uQh7CGFtkoEyafZGvDiBRSu7H3pQZ5laZjMtvZIKe1WbedV6JkaSu/BgG8ysDIMdbMN2
         vpvg==
X-Gm-Message-State: AOJu0YyknWHFalMnvagLTphM/q9BTbt7L79csIZt7OO/X35sDeyFRyyn
	WopvVSMgltNT7lak+eNHM/0aKLj96AwH1dffShA=
X-Google-Smtp-Source: AGHT+IGLwKjAJXCoPW9HA7b+bivDbkx4uY0NT1ZBidekeQa6oaCxvuJc3+fl3zxOu6BfrGMQeu/1zA==
X-Received: by 2002:ad4:57ac:0:b0:655:e265:22c8 with SMTP id g12-20020ad457ac000000b00655e26522c8mr2020206qvx.16.1695216468932;
        Wed, 20 Sep 2023 06:27:48 -0700 (PDT)
Received: from Mac-Pro.local (ec2-35-170-192-244.compute-1.amazonaws.com. [35.170.192.244])
        by smtp.gmail.com with ESMTPSA id d13-20020a0ce44d000000b0064f49d13fe3sm2183299qvm.95.2023.09.20.06.27.48
        for <cygwin-patches@cygwin.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:27:48 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="--_NmP-66b2f27a679eda59-Part_1"
Message-ID: <0770c7b8-e2b3-4210-b931-d99e38ad1fe6@saaswiz.pro>
In-Reply-To: <fe63f211-a8bd-482e-9692-fb1da2f37375@saaswiz.pro>
References: <fe63f211-a8bd-482e-9692-fb1da2f37375@saaswiz.pro>
From: Andrei Kholkin <andrey@saaswiz.pro>
To: cygwin-patches@cygwin.com
Subject: Re: MVP development and cloud consulting
Date: Wed, 20 Sep 2023 13:27:47 +0000
MIME-Version: 1.0
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,HTML_IMAGE_ONLY_20,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_PDS_PRO_TLD,T_REMOTE_IMAGE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

----_NmP-66b2f27a679eda59-Part_1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good day there,

I reached out last week about BuildByte and possible collaboration.

Did you have a chance to consider it?

I'd appreciate any feedback or thoughts.

Regards,

Andrey Kholkin
Technical Consultant
BuildByte.co
t: +1 (650) 529-7225

------------
Our Main Office:
Avenida Mendes Silva 15
3030-193
Coimbra, Portugal

On Fri, September 15, 2023 3:31 PM, Andrei Kholkin <andrey@saaswiz.pro>
[andrey@saaswiz.pro]> wrote:

> Hello there,
>=20
> I'm Andrey from BuildByte.
>=20
> We have a track record in effective MVP development and robust cloud stra=
tegies.
>=20
> I think we can give important insights for Cygwin.
>=20
> Are you available for a brief conversation soon?
>=20
> Regards,
>=20
> Andrey Kholkin
> Technical Consultant
> BuildByte.co //BuildByte.co
> t: +1 (650) 529-7225
>=20
> ------------
> Our Main Office:
> Avenida Mendes Silva 15
> 3030-193
> Coimbra, Portugal
>=20
>

picture [https://trc.saaswiz.pro/tmid_a/mChF0yI-Cd67C4NiMz0iD] logo [https:=
//trc.saaswiz.pro/tmid_a/mChF0yI-Cd67C4NiMz0iD]=

----_NmP-66b2f27a679eda59-Part_1--
