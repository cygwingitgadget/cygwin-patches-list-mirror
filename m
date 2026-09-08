Return-Path: <SRS0=IJIq=HA=gmail.com=thirumalaicse2020@sourceware.org>
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com [IPv6:2607:f8b0:4864:41::10])
	by sourceware.org (Postfix) with ESMTPS id 28E584C3182D
	for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2026 05:04:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 28E584C3182D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 28E584C3182D
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2607:f8b0:4864:41::10
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1788843846; cv=pass;
	b=cki4mbar3Xhb/511GLdcNQXpfPKfMVXcQ74ACTuxtUVobULukdCabJCTqzvQOAzhLVf38qJR+oMHhtc9kiBp3jbLwjcmXPEZ8XqE+fZ7E5V86P1Es5H4UZgnfPSc6VbfPh5mkbKDICl55S6l4h7zlKAZw8nz6sjtI5KaEUhf+ec=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788843846; c=relaxed/simple;
	bh=ZAczVxPECD/S6LZifLcf+wYYRTrazYgSdmNTsUcJRY0=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=UvR6OtFuoIf2qCAOO5Fk8z1PgKh85MokaypIpfpHgeyilmJa5cSqso4WECD8dfVQpRnRQeaEs+X7H/hjylCZV0NUMOJfHzqUjgeL1O4wmBYJ4hoOZyUldq/m572dkBPVZcMKORO+FI274o3to6D4/1PXRZMDnDw7eIkTj9op2Lg=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VmB/AF4g
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 28E584C3182D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VmB/AF4g
Received: by mail-yx2-x10.google.com with SMTP id 956f58d0204a3-66fb2f600e7so219718d50.2
        for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2026 22:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788843845; cv=none;
        d=google.com; s=arc-20260327;
        b=IKUBOCxlGE4kBsxH6K9mvHQzdl+Vuc6C1tqmMxqgTqhv4hYDmmXjboLNAFSf+KH7RU
         V/CbC6RAAOqiIkYnST8ybCRMLc5A80uxs9sUca1V403RquzO520LzuxTUoF9HdFvPnQ6
         vSszL7ahYapgrsa2RiadrcC5UPMSR5S1po8WehHX3qLfCcD9K8IWzGeKAcBZbuwADVP5
         7V1rP7BxApFviVV81ZI9UvRxhwO9v9huVasO/5k8RXe4v3WEy64iS+C9EHjbj2h2T5Mu
         XMpF2YErK1c0UorC9Qj3/zQrqnG5EfAqUP0hFnU95mCBnlMSwuCrQ99Pcvn6i3cSgrQ6
         wPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZAczVxPECD/S6LZifLcf+wYYRTrazYgSdmNTsUcJRY0=;
        fh=dnYhfB7TbtRg6DZLkE4O4OTHCWpcXl9Jdr7b8wFufac=;
        b=bfDl+CGeotuHgFjsSXJZWIyUuTbmENNO9LHVm903mSUIMvzwAZS0bWFMqiG7e8N9dt
         nPOQ5zufDOTcX4dEKgXMp350vesB9aolrNMPdThIfkDPhVKm5EoAWfFfYwsk777ikcrX
         CSxyEtXEgFOk8ZKsFU8GpvY4rsKjkP9KcqC/SoL3STDmJv/IXGiNL4f03Ru70ZIe/NYv
         nwexFakJvu5ApeH2ytDOt19u1XbtBVVXvxpnrLXH1ofKBMGD24ktj3QEUlxYEyeOTs15
         1V8+CFbYhDMIBk6HKVsuEHq/A1fScTBpVNzmXLnWG63kO8Z3grwU4xkYfPv7bRZZsOwU
         g7eA==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788843845; x=1789448645; darn=cygwin.com;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZAczVxPECD/S6LZifLcf+wYYRTrazYgSdmNTsUcJRY0=;
        b=VmB/AF4ghHJvA0mP0EQfRjoBhegEKGKvfj0XIfoXsgZLg+gKEHP+BmUMQDT7aAtW6l
         t3M6x6o5F7vLtlC5Hw83pR1DwiNGJXuHsLSuXUp78dJg30p2W2H9B2DmH7QQ+AYadURH
         qLqd3afs+DJG4m3mi9+l5z1GkxsQezPH6tZftRJZNlO8MGjCzAK7tGf/E109VipP3fVa
         ZXJV1il4AI4fls0K8jK53MTDlFQKJ7dsb1EXzEsyogmNERxNhJmMHyeleMKpwuv/R36b
         gnIU7d9Eo0iJ/fogra94NE31k3egyp3xQNSYCn6gyQYZLjmc7OsT0FXQKjE8D9c61BMh
         XF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788843845; x=1789448645;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZAczVxPECD/S6LZifLcf+wYYRTrazYgSdmNTsUcJRY0=;
        b=Lz3qd9ZVzR3tqMRyv+gqV9nIm5Yxb+9bydnxy6UkPigAghCVwnhv9eJr0T1ovCWuWo
         Gc8hFQvuuHrKB0DzRTWPMMuPPv50yh0ebHbLG1JMzJDAay/5qjyAynkgoATWYjp7cexq
         /8iBXfSw+4OI9DT6sHRPnwKHPSQd92+B1eo7TXBhfjdbuxF5oh01IHRsdUA9eibEJnfb
         6MFTB0cPTrBIwbexT6C9tbICGkBFS2JSTwiMvtDtq4HuIqi/M9A2LEsI5I0AUbB0m1i8
         4PCKIem0BskI5oyl9yRnNeVAq1J2MCe9brLqNrESXOOAO4H8wUHy33tpM//Hf+Hp8l3u
         gh3A==
X-Gm-Message-State: AFuF++k2fAa19WHG0i0Hw7rgQWLe1WbR2swH/PWfX2rGja1QLW47x+zy
	ACkRiaOJ6uJeEu9yoa13StEm2of1qgaRbIOkgNquDbek2KPRq1HybXksTxdkPHPFq/p/updbtYM
	h35JnL0g/5oTjHwE8MYjIFDd6eraPjnPJmg==
X-Gm-Gg: AYBFou0KFs8ecfTXS3hRTsVEohDPCoSFZrV7kiTENyOpAFmsPWqHvNO6XZuArcvuxfY
	aZ1ldVbRIljnLnVU/GCbjV7+FB5bvYcau6eQXPPZ+Mdrlx2WWpQNmSH8kFnFnEIQO7dtrfMVfXR
	i6UYyf+hdk923PoZTof1fwTc4c+XHQCGssX00wnUOCf0aoTcY4iQ4bt0XsWX24MFHT4/KJ7WQUl
	OPNOSnlA4y8DcfYS76ldpmZeRjdnSP2vE0pAa7/DNdYDG79c9XBq/pcv8wzzYN6h+Lop8ywSaEM
	t4sNdmL3ROSLEsLNsWJVw1o75qAn1AOKHmHYvjrHIY91p430wlHiQYtasNF4exfTI30BcXb4PhY
	eb3obUysY7N+RKzWlI2+urH22LyphSiJVw5JEra9Uu4U=
X-Received: by 2002:a53:c445:0:b0:66f:86e5:93e2 with SMTP id
 956f58d0204a3-66fc44fd329mr3562123d50.0.1788843845494; Mon, 07 Sep 2026
 22:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <MA0P287MB3082786039509EE4071456959F372@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <CADiGZiHEUYJ-+Acp4sGLFM3h-ggN_12ivDjCXAF6OcpvDPy0Cw@mail.gmail.com>
In-Reply-To: <CADiGZiHEUYJ-+Acp4sGLFM3h-ggN_12ivDjCXAF6OcpvDPy0Cw@mail.gmail.com>
From: Thirumalai Nagalingam <thirumalaicse2020@gmail.com>
Date: Tue, 8 Sep 2026 10:33:53 +0530
X-Gm-Features: AcwNN1Uw8-zNLEc2E0y1m8aXqTuDK2Js38-DYIlAkNrn1agp04vsx8csewu2Vec
Message-ID: <CADiGZiHqDLasNmGHie9iSCgkyWRjuXeWiLqC5YmtsZyXwBW21g@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: gendef: add_sigfe_maybe for TLS initialization
To: cygwin-patches@cygwin.com
Cc: jon.turney@dronecode.org.uk
Content-Type: multipart/alternative; boundary="000000000000f82ed7065af1a9b9"
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--000000000000f82ed7065af1a9b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending this email as when it was sent, I wasn't subscribed to the
mailing list.

Sorry for the spam, Jon. :(

--
Thanks
Thirumalai Nagalingam


On Tue, 8 Sept, 2026, 10:22=E2=80=AFam Thirumalai Nagalingam, <
thirumalaicse2020@gmail.com> wrote:

> Hi Jon,
>
> I saw your email regarding [PATCH] Cygwin: gendef: add_sigfe_maybe for TLS
> initialization on the mailing list.
>
> I realized that I had missed sharing the earlier context with everyone. To
> keep the mailing list informed, I'm forwarding below the email I sent to
> Corinna on April 28, 2026, while transitioning out of my previous role.
>
> Adding it here for reference.
>
> Thanks for your guidance & support always.
>
> Thanks,
> Thirumalai Nagalingam
>
>
>
> On Tue, 28 Apr, 2026, 3:54=E2=80=AFpm Thirumalai Nagalingam, <
> thirumalai.nagalingam@multicorewareinc.com> wrote:
>
>> Hi Corinna,
>>
>>
>>
>> quick heads-up that I=E2=80=99ll be moving on from my current role so my
>> colleague Chandru [chandru.kumaresan@multicorewareinc.com] from our team
>> will be taking over and will follow up on ongoing discussions and any
>> pending queries.
>>
>>
>>
>> Also, a few pieces of our extended work are nearing completion and
>> currently under internal review. These include patches around aarch64
>> support (autoload stubs, SSP enablement, exceptions.cc [make-context]) a=
nd
>> an initial CPU ID implementation.
>>
>> Patches will be sent upstream once it is ready.
>>
>>
>>
>> Thanks for the support so far :)
>>
>>
>>
>> Thanks & regards
>>
>> Thirumalai Nagalingam
>>
>

--000000000000f82ed7065af1a9b9--
