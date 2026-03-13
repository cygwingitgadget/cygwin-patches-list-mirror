Return-Path: <SRS0=7bOH=BN=gmail.com=sebastian.n.feld@sourceware.org>
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by sourceware.org (Postfix) with ESMTPS id DD8974BBCDA0
	for <cygwin-patches@cygwin.com>; Fri, 13 Mar 2026 09:16:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DD8974BBCDA0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DD8974BBCDA0
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::236
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1773393400; cv=pass;
	b=t+W35ldssFnX6rapr0KMfnlLYQvFIIgVA1dUwQMdEf7OPPK4FRPcNJBYn7+XNBPnOJAFRgpBaRD+nH3xeV/t2k3nsTt6ywe3WMgC906m8vLHZMKHwPfsy1jaiOx2yLe469z9HjG0gKYuATmPSsKtz7NBHLOPynxrJvYgfwSc/fw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773393400; c=relaxed/simple;
	bh=w8ujeSr9TQOaYWVC+za+ICbQfeSe/ZuhqOO24evZ4EQ=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=d3K4wEoEbEGPrKEMGXZesHKsJ1VZbhgl1uRL7t8GsJ0OXpqIcKX6sJx5SAOtaL0VXzZPJRI2aSWSQSyzENvhE8xUxLKMzSd68B8wOfDY5nHHE2xSxY5hgggSV09vzBD3g2c+ZWw/0DE8gHtLiVUMLRFFzI1suHC07nOdYss9NlU=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DD8974BBCDA0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ldlm47Rp
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-38a3066b68bso18265701fa.3
        for <cygwin-patches@cygwin.com>; Fri, 13 Mar 2026 02:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773393398; cv=none;
        d=google.com; s=arc-20240605;
        b=G05XDZH0H6rLguNetz7CrUvDqOQNb0kyVrv8sdrXlemHDxi6fsmaLLM4jhN1jmkova
         gS3fFPgZLwzTn/6BoYC40HDjQpGh/uTsZMggyY51ETZSs+zHYYw6GUW75miNYu2b9Lmo
         0Qc+s/MhML2GFuSEzBdWoJTJtth1MlVDz1BM+n6PW+96kjk8fiTSwUX1C7rOAhHR+0Oh
         iXtDsq8Y6lNCdrGVd/Xzyx4z2HEx/r6BuAFzRysNtqY6IOg9IQeSRDGxeK9s2gh+IpEq
         5s+samaGLKttJWhpQrewodIR6Hu7g1N/GZhw6q0EcRoqul5LSfiytRXiBs4pwVHnjQba
         /V5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVl/2fuDPsYRgJHshWHCXMn6KBtRjoRG3CULzXFAuVI=;
        fh=YLobnwiB6mlxg8mZw4jwzI5+9rNrzFWI954radGPi+I=;
        b=VUWoEXGiTlB8sYYsNwigzWIMK423qZkKMkLis8HDwe9Uz0fDBzV7Zl7+ykzjLUF3df
         OouS86mYSJ32bSMt/0p2c2rfrKiVJptQ6gr/XrjviLwqJylV5q1jlwkklv7T+3oYa0WT
         TDuAgGEfZr1CxhGkYYE3qyqNw8Q2DxR10xK7j65o5ODrpBhSAeiWA4BRR0IZkG8J0VJN
         bS8WOcXbZlU2eP9qxF6im4mW+7ktb9EKs16itGLFyapXotNuAR/BnCN3WjlWeQcIA5Qe
         G2Z85avzZCVaDc63TBj4VEZaFAK4TrKThM1ydvPze+iKBAj7LbxK3TVh6YR9ljRwcXrF
         i6Fg==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773393398; x=1773998198; darn=cygwin.com;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVl/2fuDPsYRgJHshWHCXMn6KBtRjoRG3CULzXFAuVI=;
        b=ldlm47RpH11OQqZeYjeP0Z/vpEV+yqrv+yd5WQOAs5Z4zAjd1plPHlYPbXQUCHSQ4G
         0R4dQaqjMOdAGtpUFeJ9x6kHHvzJIaHvSqmB3HbqbrqM0K8kG0mEM9szkkxP+0SJGw/b
         lKIpIm8qc8hvmUuJW65BDDEcWFqNMFrM7ZRe0CoXVbk7yWrg382aPX87saXTn5AeNDl6
         Q0z/3pbjG/brrlPzpE634XpvNqSJf5jkic0CVRQUDAwXz4uH26akZC9cZypmCsb8RofR
         KIeRT74l4QSMGeVCl+rX7gl6RzYTlT5Ma0XB1USdvzC1l7SzYeY79GVPGFAWeKst4j6T
         1Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773393398; x=1773998198;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVl/2fuDPsYRgJHshWHCXMn6KBtRjoRG3CULzXFAuVI=;
        b=iqvViEBRhV0brLsbZvaqKRex3MeUZbhKZ+piWe4LOOxa3UWpSsqD61aomSWjPJInvL
         ArWf7c99ewrK5flKG8Mdwdnc9hE2VRqo0DRGq4+4V8QyY+A/PPM8Tn0uIvfA17tRWLVB
         vxffjdX9J+4zPG+GY1ujQla+n3xjJNthMVPPZ/KzhdGZG991MuEv1v5zxEd9T5ANY/X8
         6sPM4rFmBnWypEe+4RbYBysufXblgLF6oHRxlICFZEAvvtwCaZgtzBmzFFveULeQFHFY
         eaBCvacL/UjwKtm76ohbY9N+qF+zns9sqdALL13dbpKwb7FxGJHfTx+hdJQC7Ww2iBHk
         KEUA==
X-Gm-Message-State: AOJu0YwzbsggbPQ718c2frnQXNJEtxff2yMyEknozswPApOL0GOw0V9x
	IIr2BJhWc4xJXcgqEvfnyTyyFkBRS6jzcF8Z6BsJVbe14oA+yfTkP42W5cl4pNud4zeWMoQAjlZ
	gydU5bnQsJ02MEvUH40lfccgNG+iPM5aN3A==
X-Gm-Gg: ATEYQzwysxB6DbEzJ3YHFgtHvRMJqBgpkx9tScdX5MiEDI6mxHrXJCVc9KPPgvi7ns9
	DEMMZAgwVxYAxOMJ3P7NogpJXW+AwhNfwIrfWXhyBOK7rkZvRZzF6JN8vOSU/2Z+ewu19D9S10w
	kIj7f9yjS+Cj6CviQbMtJ3NUTbPIKrMWPBcZi51Pom1g31KTMaPKj4nED8GWhxN/V4a9hO1FdPg
	Eu2R86OLvE/Y9jN5UQmwBr5xPyw3YaFgKXijkbqRndIhpruqT4UGlwJERZWbcdnTSpAejY+lTUO
	C6c38x4mGNFqcePQihnLt4AACEDsZkgysrY1Ig==
X-Received: by 2002:a2e:9a0e:0:b0:38a:6acb:e5f5 with SMTP id
 38308e7fff4ca-38a897d3822mr7354671fa.29.1773393397620; Fri, 13 Mar 2026
 02:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de> <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com> <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com> <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de> <aIJ2kbx6UOK6mAnG@calimero.vinschen.de>
 <b05a2798-ce6a-28cf-f8e2-3f0cd7bf165b@jdrake.com> <CAHnbEGJT8vKZjR8aXqB+aANZ8J9P8G5bnLO6gf860FzAeCCXMA@mail.gmail.com>
 <8fadabda-8d77-4751-86a2-c9741624b648@dronecode.org.uk>
In-Reply-To: <8fadabda-8d77-4751-86a2-c9741624b648@dronecode.org.uk>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Fri, 13 Mar 2026 10:15:59 +0100
X-Gm-Features: AaiRm53K8I7gyyaJnQY6JXH3DXMfZ1u6kt7yZy3grrKa4UdjTdcY5NXI2E47T1A
Message-ID: <CAHnbEGLjarFbKBA37b5medyqcFAMuVo-dQB0n_Gwu_zWoHL90A@mail.gmail.com>
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, Mar 12, 2026 at 3:45=E2=80=AFPM Jon Turney <jon.turney@dronecode.or=
g.uk> wrote:
>
> On 09/03/2026 09:54, Sebastian Feld wrote:
> > Was this work ever merged into Cygwin1.dll?
>
> Unfortunately, not.  And Jeremy seems to have moved on to other ways to
> apply his talents.
>
> It would be ideal if someone else would pick up that work and get it
> finished off.

That would require a cygwin.dll expert beyond my skill set.

What about adding the current work as build option?

Sebi
--=20
Sebastian Feld - IT security consultant
