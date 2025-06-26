Return-Path: <SRS0=x/14=ZJ=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by sourceware.org (Postfix) with ESMTPS id 8FEE4385703B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 00:00:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8FEE4385703B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8FEE4385703B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::534
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750896049; cv=none;
	b=Zeosbzk2GOm3j3OnNOAPy9BS6MbzIYQffKdRPZ6jVQehpx77t+ZEoDokS1JhGPvKWAbdplpzKnGdgpFYJkUIswiGt3XGWiPCLhwf+3r1fghE1ikClcnbOKaecvbClhk27zgEUrtuobaIBsZjwzT5BOpKIfH7hBAJstTWxpklmXY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750896049; c=relaxed/simple;
	bh=KxiZnnUcpzeY229Ks0fkCMk6bO9g7Tg6UME6LCfz3TY=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=KAj5Z8MKnlnkrWcnLhdFJAZi34W4pNpqR5fp+bdbSzpn4V1i2XA+tVMIr1e0wKGra3cM3IKv56q+J1ZZTgcGmP4aIbQSNyIzhqdc5OHvfluhPdcD98rKTmZZEqHb4LHlJy63FCuzCuygpwAL+uNxOVV57T6QC/JNIx/77adWVI0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8FEE4385703B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OKn4sCd1
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so619656a12.3
        for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 17:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750896048; x=1751500848; darn=cygwin.com;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxiZnnUcpzeY229Ks0fkCMk6bO9g7Tg6UME6LCfz3TY=;
        b=OKn4sCd16es/Gy21rqh3IiL2PuJZQ9LtpbrgYlryjTG6KilySSZ+/Wr3j1llojIKVB
         QZblLXDTy+ocONgEaKqvl89RwQUsJKPea360r9DNsz2BfgEsJFjRJU+oOWh24vVdAQqQ
         V2p/t1l7A9Lx+E7O/VgODhn/+2OpnlSh91qvFr1sG3q3wZ2ufaUyAtRFWBnigC3LiZz1
         mzja0DrYsh9Z5TEUeodG1SlEmgvfwTjmTAcabqnW7+D4BEw3woLGzwJ4KNU4aDeSZ9Rj
         7RTT7LLUVb3HCHYGJr/Nbok7mzzS8yPZ+NcOlP8lpDp9zhE3w8FyC49yPqZzT0rFpLZ9
         hSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750896048; x=1751500848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxiZnnUcpzeY229Ks0fkCMk6bO9g7Tg6UME6LCfz3TY=;
        b=rpPz3Tl4gCeldVd7xQga9dhtq4NAYHZO4PjDsVA+ic0vaBuBoy+2BqtTPZcEplv8x+
         6YHfxYWwfZbtQ6KbiOaRtsaZmG+i2tS8+UEyk2zJo+Gg96qhoWEm9q7Nx9XxTttnc/W7
         QJVYPrGupGpqkyiu4Ra0U2+4XIa6v8/igg3IBViFAqeQjE7uW0VGtecJuAF0BDSEc5QJ
         +pjxjdJ6ZxPb2KDaFfHVGeGXePi+QmyTaFiPguxHRN38dcbkoLJ1JIYBrZ5p3fxNBFt/
         QrxijLDTytwxOHsVet4zWumpnSe85s64OK8fPO6vUrv36GRb+Ya7PQzUc+40Cc+mqL7C
         jXxg==
X-Gm-Message-State: AOJu0YyDwX0Y5vHUmaKwNSGqEty6Qx84Ah0q2b1mb/SpWtJTrqedr7SR
	3gZwELo6N1OtWzTqUY0ITKMQP6oZyPehZar4WkqkpKbsgLJbZ6dYuvXq3vapkrOV5xAB0dtht9X
	jlHJoVZtqxrfVj1TOeJY7GqJPWxWzxxA=
X-Gm-Gg: ASbGncvaD2Rwi6z2YyOurVHvsid1FBtCw+zGv3yFMTbVBWt7zlj+KHrGEGP6qa45pcA
	Fm9Wae4lOipvZSUZj/q9Vn42zcsfyA+n8J/sS2xPWkjrKYOzfIDQh7X189OHSRhC4CKzncU9hso
	bF8ba+E6AiJ5oaf2rzNpQvJ2IByva0adhKGIs24uoXlssX8A==
X-Google-Smtp-Source: AGHT+IHaEmhVkoNYeUgX8AgAwIh1c0L1elASuckxk8PrbsJI6BdulYrdqGe9cHxj8SC4GzTUI4bELMr3wWJ9GVHYcrk=
X-Received: by 2002:a05:6402:3487:b0:602:201:b46e with SMTP id
 4fb4d7f45d1cf-60c4de22870mr3718531a12.31.1750896048095; Wed, 25 Jun 2025
 17:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
 <20250622083213.1871-4-johnhaugabook@gmail.com> <77b5d5ea-5cea-4a7b-951f-17278f9411f6@dronecode.org.uk>
In-Reply-To: <77b5d5ea-5cea-4a7b-951f-17278f9411f6@dronecode.org.uk>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Wed, 25 Jun 2025 20:00:11 -0400
X-Gm-Features: Ac12FXyvN9CA8SnoCK8rnjmp_uHYrNb5GzZ-iEO4WWIeVe9d-JZzsn3FfL-K92c
Message-ID: <CAKrZaUsSvgcvMXkU1ur6LekJDe5yKRu8wCtWF+bGDj9rtFOeZw@mail.gmail.com>
Subject: Re: [PATCH 3/4] install.html: add tip on using setup-x86_64.exe from bin
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Ok, I=E2=80=99ll drop this one and consider the patch set finalized. Thanks
again for the review and feedback.

Take Care,

John Haugabook
