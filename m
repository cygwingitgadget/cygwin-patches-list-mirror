Return-Path: <SRS0=0Ecw=FJ=saaswiz.pro=andrey@sourceware.org>
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by sourceware.org (Postfix) with ESMTPS id B64E93857724
	for <cygwin-patches@cygwin.com>; Mon, 25 Sep 2023 13:20:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B64E93857724
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=saaswiz.pro
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=saaswiz.pro
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-774105e8c37so407279885a.3
        for <cygwin-patches@cygwin.com>; Mon, 25 Sep 2023 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saaswiz-pro.20230601.gappssmtp.com; s=20230601; t=1695648054; x=1696252854; darn=cygwin.com;
        h=mime-version:date:subject:to:from:references:in-reply-to:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rqg2+hHmzYbMTI3k3aHFY2/dH5nc5F6sAz5l8AQTaUw=;
        b=owKQwLQNAaeQZFMLRN3JIx9kDnRCfU7xXVtMxMb+txIkdfNsDLtc1yJd3oTTTCsCxQ
         QdJ/nzfQmOpMzvleJCBbcuTO3ndiaMerMYYpSwW1wB38m3GuIe6oFiCKvWQkV+2hpqjC
         m2VV6cvCTwfbl9QgnzdyTcvk5i0kvqbfYJP6LedpzEv1QYRYUvknRyUaTNlHm7FjzcKd
         rA1kmnW/uyRq6ILPKscZg0CaDHenBGqT5Wq0BtGaNVMpW7gZG6ruwPTnbp7W8ly+0wWt
         m0A4e8mgIyado8qt+nU4qt2A5wtcCk1/X/HT6kUIsRhOeI1Equ9g1d0msKDehgXbznIJ
         Sx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695648054; x=1696252854;
        h=mime-version:date:subject:to:from:references:in-reply-to:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rqg2+hHmzYbMTI3k3aHFY2/dH5nc5F6sAz5l8AQTaUw=;
        b=w5l2LeVe/89EDHgd5hQNr9E5GUlppL3tKqzBqnLmfILGFEweyc/7l+fVM6WxC9W0Kr
         WSZOqD7XSZfRJ4KOrKwIdor11UG7XH4WRBqeZusPy+yCxT0eagzbsrog7R5XQ54LI2Ti
         FFAx/eZSTQMYuwjtcpoXECFfJ5ZYtRLq7tIRQGVtDU7pxhSO48HNwFSG+K2/pP0h1ORY
         Wohye/q92rEcCsqZsW/EZfHBTzpTrTefpRp2vURHV4Z6MC5d/y9DVc6I0k+51D/mgvWX
         YIahRCFUyfsVJuh+8DRs/egqoAdkLys1jmVJhcB5OBxw3O86ZS9OEInyhdSwjJAhQNuf
         AeTA==
X-Gm-Message-State: AOJu0YyfFghteTkDcLLj44O7gwgZErDCeZt/534YnAhiDI4m9hPUqXCz
	dRuujRjXN6ja41+dzQzTO2TVWo/8zcNViCcPMn4=
X-Google-Smtp-Source: AGHT+IFrox37hEv76k3yYee2wo5jp/84Ib8e7BgCipn4jrWaLadVUmiHVyeqr3pldVgxbXVxVQemZg==
X-Received: by 2002:a05:6214:2584:b0:651:679b:d35f with SMTP id fq4-20020a056214258400b00651679bd35fmr9976734qvb.43.1695648053778;
        Mon, 25 Sep 2023 06:20:53 -0700 (PDT)
Received: from Mac-Pro.local (ec2-35-172-215-91.compute-1.amazonaws.com. [35.172.215.91])
        by smtp.gmail.com with ESMTPSA id r13-20020a0ce28d000000b0065afedf3aabsm1591127qvl.48.2023.09.25.06.20.52
        for <cygwin-patches@cygwin.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:20:53 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="--_NmP-97a5ff169b43eda7-Part_1"
Message-ID: <037e33ef-c9e6-4aff-a94c-85eef4224b2a@saaswiz.pro>
In-Reply-To: <0770c7b8-e2b3-4210-b931-d99e38ad1fe6@saaswiz.pro>
References: <0770c7b8-e2b3-4210-b931-d99e38ad1fe6@saaswiz.pro>
From: Andrei Kholkin <andrey@saaswiz.pro>
To: cygwin-patches@cygwin.com
Subject: Re: MVP development and cloud consulting
Date: Mon, 25 Sep 2023 13:20:52 +0000
MIME-Version: 1.0
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,HTML_IMAGE_ONLY_32,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_PDS_PRO_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

----_NmP-97a5ff169b43eda7-Part_1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good day there,

Contacting you one last time regarding our prospective collaboration.

If there's any inclination or any questions, please inform me.

Otherwise, I'll understand your schedule and won't follow up further.

Warm regards,

Andrey Kholkin
Technical Consultant
BuildByte.co
t: +1 (650) 529-7225

------------
Our Main Office:
Avenida Mendes Silva 15
3030-193
Coimbra, Portugal

On Wed, September 20, 2023 1:27 PM, Andrei Kholkin <andrey@saaswiz.pro>
[andrey@saaswiz.pro]> wrote:

> Good day there,
>=20
> I reached out last week about BuildByte and possible collaboration.
>=20
> Did you have a chance to consider it?
>=20
> I'd appreciate any feedback or thoughts.
>=20
> Regards,
>=20
> Andrey Kholkin
> Technical Consultant
> BuildByte.co
> t: +1 (650) 529-7225
>=20
> ------------
> Our Main Office:
> Avenida Mendes Silva 15
> 3030-193
> Coimbra, Portugal
> On Fri, September 15, 2023 3:31 PM, Andrei Kholkin <andrey@saaswiz.pro>
> [andrey@saaswiz.pro]> wrote:
>=20
> > Hello there,
> >=20
> > I'm Andrey from BuildByte.
> >=20
> > We have a track record in effective MVP development and robust cloud st=
rategies.
> >=20
> > I think we can give important insights for Cygwin.
> >=20
> > Are you available for a brief conversation soon?
> >=20
> > Regards,
> >=20
> > Andrey Kholkin
> > Technical Consultant
> > BuildByte.co //BuildByte.co
> > t: +1 (650) 529-7225
> >=20
> > ------------
> > Our Main Office:
> > Avenida Mendes Silva 15
> > 3030-193
> > Coimbra, Portugal
> >=20
> >

picture [https://trc.saaswiz.pro/tmid_a/l9IRr3_gxuxaYlawXhyTn] logo [https:=
//trc.saaswiz.pro/tmid_a/l9IRr3_gxuxaYlawXhyTn]=

----_NmP-97a5ff169b43eda7-Part_1--
