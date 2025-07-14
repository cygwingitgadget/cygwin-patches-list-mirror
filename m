Return-Path: <SRS0=cjZq=Z3=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by sourceware.org (Postfix) with ESMTPS id 90D633858C2F
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 00:04:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 90D633858C2F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 90D633858C2F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::531
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752451496; cv=none;
	b=GlYrBc4m4zVdJd9xPZi2AGmmFGi7rHTq9WOdecg/FR2F0NJCZo7RBStOIsnKTbmtOXeQRtqAm83/Dlz83ee/48V8FY7HfRTQST9SI+5Edk1u5RmdqWZQeyLcdMbyl6L3pv5+G+mZVdKO0n8sRZgLcxEBWw3ifNe38T8yhP9khGE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752451496; c=relaxed/simple;
	bh=5GwKA6RKWHIJcdmm+coSmT1cu6yWtRyKl+sWhErTKr4=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=I+08LOOGtpZx3gp/JnU0UZ32u7KL3zhgiwsjMVZFk/owvo5eBwmMiVFC4vfNkU+TWond1HZrnWyVe9aB1xu0Zvv1A0ZuuEtb6Ln+lrNhw8hZzEhVPvbBpAcnAjRSMX0Dl5e0Tvueyr1A5h3yh6OKV87D64QUBlv+PsR9EwHMei8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 90D633858C2F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WoU/tLoI
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso5149507a12.0
        for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2025 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752451495; x=1753056295; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5GwKA6RKWHIJcdmm+coSmT1cu6yWtRyKl+sWhErTKr4=;
        b=WoU/tLoIdQR5l/CK2uF9fhBtNxSpdlNRHtUOCQHgaEN1szaSRsdekURVVIw7Be5ZH5
         flnmUM1WNLz5On+6EUsFVTWSXbtnoSJlPCVelYqTfd5uLyQdlpnYpj7M/VtUGe7rKBVb
         9aEl6Z5q396U1yUTiYnQV7hnzpH8q497HMvDpeWMqlFuhmjRlwlJabW8VM9P6pElhTGT
         eTO5jcAhPXi7bMkqRnougHuSqIDrJm+Rb8mLXumW9DKdTi/fMPVtEkjEtSsm72QozLgB
         XImvKonqeM08gpe+spx76bCPi6X1wEiQYIM9jL1HXoK2m9bE38pBLXHiq56OcisWgWfN
         5L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752451495; x=1753056295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GwKA6RKWHIJcdmm+coSmT1cu6yWtRyKl+sWhErTKr4=;
        b=bKn69fNgujnfYkKglne84n/B/Vxv/l8WQKclP4GUw9DiFnlU59Rjt88XOI41ntb90I
         IDJt0H9xxfj6DXvWtvfJBT0cw/w8qRcgW50bGHd9meY9V6d9g5CoyYBQVC+ocqhsD303
         KPFYSzuIwERq4gPsU6Gduf6aWymA+qlL3CHVgZcFdev9pyEK0Q4bskN5VNyIg2v7i8ci
         d4lG69MB9aLIB4C1xuj9LNIGftUEIFyR7sUv93+Cweuhczp7BdXYYz5fvlPIq3ZI8HXk
         71QHi0lz5REKFduBnZidPL67UaPSDETMVUUcDXVJX1ty/1Elp88U2dEky14BeQ6fPRvD
         P9WQ==
X-Gm-Message-State: AOJu0YxNdI5RSHTs+jCyXDeC5+Wl3wzHGtGsNqyZkfmquHr3OrJeHCac
	0IaQHFkOoltgQ+Eq8YbvUjFeCGCKTuWO6h4TAqR+GTNzZYDdkMTu6HyVWFvThna8x9MYILvcF+Z
	KYKudysqVJL8bHSjWuIPRi66Dy1lnG0w=
X-Gm-Gg: ASbGnctYayAPVVRuSi4GNHMi+Eg+kt3ovdoVx+II0EYja+ClPTbktRSdAfOIVFJgjsx
	E0glXrHdSha04NH7Vv3mP3p+T81hK8fzJuWVnJ8Dml6WAyZsPiivex/Q3PhuVpjeW1z3/8gz8h7
	9bo25ZbKbbh946RVH/EZ6YQY064tYU+RiixU86AtpkTHmgG+tqI4b+MfHMr9XBKmiQPq/7XkgT3
	Ppt2eI=
X-Google-Smtp-Source: AGHT+IHCT89xaDTUoACa+S3yf8b038mmfTYXZiNZQpM93m7yJW8EjE+e6xy8uaTVxvA6+Q0KB/2G+UrFWYXnytVrEJE=
X-Received: by 2002:a05:6402:2794:b0:60c:4a96:423a with SMTP id
 4fb4d7f45d1cf-611e84799b4mr9622326a12.18.1752451494847; Sun, 13 Jul 2025
 17:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250625013908.628-1-johnhaugabook@gmail.com> <20250625013908.628-3-johnhaugabook@gmail.com>
 <c8836ea2-2a1f-4225-8b79-bbe43bcc186b@dronecode.org.uk>
In-Reply-To: <c8836ea2-2a1f-4225-8b79-bbe43bcc186b@dronecode.org.uk>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Sun, 13 Jul 2025 20:04:19 -0400
X-Gm-Features: Ac12FXylvHdgG_dEIiGSEZnJUIXC9p8pLqgWtH3kI21n5FMmHOUnmNUYwKpIamI
Message-ID: <CAKrZaUssLPAzDPBmFQ_iC2WN=o1uEnoGsfKitC045S4H6unDZA@mail.gmail.com>
Subject: Re: [PATCH 2/5] cygwin: faq-programming-6.21 ready-made download commands
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Yeah, but this seems like something I might be able to do. Like I'd
have to study setup for a day or two before even knowing where to
start, but as of now my guess is: if setup -q --some-option cygwin,
then cygwin installs packages.

So something like --build-tools, --dumper-utilities,
--cygwin-utilities, --documentation?
For example:
setup --build-tools cygwin
then setup would rerun, and make a call using:
`setup -q -P autoconf,automake,cocom,gcc-g++,git,libtool,make,patch,perl`
If so, then can I get a clue as to where to begin?

Take Care,

John Haugabook
