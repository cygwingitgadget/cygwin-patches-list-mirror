Return-Path: <SRS0=YuU3=ZD=gmail.com=sebastian.n.feld@sourceware.org>
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by sourceware.org (Postfix) with ESMTPS id A806F3858427;
	Fri, 20 Jun 2025 11:34:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A806F3858427
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A806F3858427
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::62b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750419261; cv=none;
	b=XVOBr7yDHhvVNRHAn8r07FH6uaMoS8nZzMKCI1+vU6dDgr/4J6reCY3YXzqySFaX4XBXlAbGhkY/eCTDQ158NcCq5b9EL2hRIsRcUDU5WKR9v9BD7E3GHywOqwHOnZjd6oX/fkIHNzqsgggwmQp0o8ak2++zGn92HU3N0t2WE4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750419261; c=relaxed/simple;
	bh=tu55N9Lq+nVGMd5a/mnM6fWmIatUv0+5hXliEpk0o24=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=MNy9sjk7ZfQQ89CXCeCd0Okxkw4ALydZg2H9EU8tJAIngcbQMdXneEbQdTyHS+NgnNwe6NLhYqPwUZSRvJImXdema8GoGz0lWQDCu556sZhDurcYuzWQYfrUyc6lwK3FooPh/io83/lE0CCKKNs/K/wvTF+lQQYIl+pcFLOZodk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A806F3858427
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AmwNfwBN
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-addda47ebeaso363564966b.1;
        Fri, 20 Jun 2025 04:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750419259; x=1751024059; darn=cygwin.com;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFvnh0tS86b/ileM/Vkt5toXPr4evlAEVtYszbnOup0=;
        b=AmwNfwBNQERqWjfp44Qx/haFaLtD5/tSEG6Nkqj+tO0u6z3fRn7GCxtQeDVZwT9tmf
         Hemw1njLqVNUZQSPkHeucqeDMY9xa/FQzCP/wFoazJY31nCVB46KuqbNjf5E2sn0kVJ9
         MRou2YpNmiyOJxdMrpt3LZzEXpn/cMNhflKGnrBGGGmwhFv4S6wF5JF9a7fiXMVHZRqI
         a00ubymugVlehHL1ZpvYGnnxgilLThe/itLo5mv/a/IcbpsGuUUT332r0GsXbtVy0IoE
         FBJTPVKDo2EzEpcZ6dvHy694uxK/h1P+p34jvK7rpREn1QyLp1ntR2bs9495pbSF6rrI
         EPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750419259; x=1751024059;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFvnh0tS86b/ileM/Vkt5toXPr4evlAEVtYszbnOup0=;
        b=BoTKzTdxYqvFipnufc6CJ7E6zvzSgXYyOGiE6RuQFfyQRAz+IHMpXyTiFUMeG3VMiY
         V9IGv0h31HEQR2ozd850KPHKXnLJsnVtCQ62CyWfqrL2sCvZS8NqBagzJ2SHtJZH3BbD
         +7HzUGzdzR/kMTUfqjdg2p+wHCycszZKNct9C/gUf4lBMfO+mizRvSlxCUWp8AdRbJl+
         GCaH5+4qI2LxPGi2+iYk8ZxOPL8kfsfAM54XVvTaJJw69vrUvnxv21PjdPFEYVlJl87t
         iD8TPGO5jC9LU4phk1bYfppLO5TBbXIvEXZgeIWk6eo3/XeGCyAo6mmEcBu6Y8UoBi2J
         ehYg==
X-Forwarded-Encrypted: i=1; AJvYcCXduE4O2Q1vFcCJu9vrHrn4219jxB2JfQfjJCjr66/u6Y3rrD8pCrh1Bt5ehvJe0zjlikfdipU=@cygwin.com
X-Gm-Message-State: AOJu0Ywd79n4NALanz2T/hqfIsh5I2Qd/YMmRCTR1KyvdKdpP2frGI+V
	b6A5Xu9U0s5YqKo4ADscnibuphNM19h30Kt7pJ2s6kIyyJt2wjxL7VFyNJ4tHIdYOUlmrZGFez4
	byT552k1d8C7YZP3J3btIJig79iRfVR7TnQ==
X-Gm-Gg: ASbGncvBHIPQ3kkfxEFHYZAJdEan1TdaNRK+ruRbuGjJKvE9CUK+3hsoBBcNA+VixtE
	ysnbgwIyNIRTf3jk5m/uY2CHu6o6pKTMQ3DG8vGXTNsyRuy2Bh93rjUJiHhCHrAizMCPaH5tM/X
	NteaGsjtcKLCpZ9ksHAtRAepZpab5iZ3U4KY+HtUxkVTA=
X-Google-Smtp-Source: AGHT+IGZREjEpvqK36TLCSFWtGCKOFdQyU1YDONgu15NpEnQpKUNCz7Tq+MDnZjmUC5eCSuqcgVrOhDs4x12SKBr1YU=
X-Received: by 2002:a17:906:478d:b0:ae0:4757:96dd with SMTP id
 a640c23a62f3a-ae0578d5da9mr255674866b.3.1750419258590; Fri, 20 Jun 2025
 04:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <6058889e2ae8c9c827a8d6678f09b3b1741e2fcf.1750413578.git.johannes.schindelin@gmx.de>
In-Reply-To: <6058889e2ae8c9c827a8d6678f09b3b1741e2fcf.1750413578.git.johannes.schindelin@gmx.de>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Fri, 20 Jun 2025 13:33:41 +0200
X-Gm-Features: AX0GCFsRmy6awzI0s96L9UxGXvGSWUdsvXiWeJgDwWqr5kGij_EtEK2oJxqMTRM
Message-ID: <CAHnbEGLjsy4MZD+oqjGbd=JrX+q8an3mhT38xndEgjmTpWyOnw@mail.gmail.com>
Subject: symlink_native() bug with case-sensitive file-systems Re: [PATCH]
 symlink_native: allow linking to `..`
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, Jun 20, 2025 at 12:03=E2=80=AFPM Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>
> When running
>
>         CYGWIN=3Dwinsymlinks:nativestrict ln -s .. abc
>
> the counter-intuitive result is _not_ a symbolic link to `..`, but
> instead to `../../$(basename "$PWD")`.
>
> The reason for this is that the search for the longest common prefix
> assumes that the link target is not a strict prefix of the parent
> directory of the link itself.
>
> Let's fix that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-dot=
dot-native_symlink-v1
> Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-dotdot=
-native_symlink-v1
>
>
>         I investigated a failure in the Git test suite and was quite
>         surprised that `ln -s .. dir/link-git` resulted in this:
>
>                 link-dir -> ../../trash\ directory.t1006-cat-file
>
>         instead of this:
>
>                 link-dir -> ..
>
>  winsup/cygwin/path.cc | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 42919a7cf5..ed08398930 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -1855,9 +1855,18 @@ symlink_native (const char *oldpath, path_conv &wi=
n32_newpath)
>        while (towupper (*++c_old) =3D=3D towupper (*++c_new))

1 unrelated issue:
I think this towupper() code is WRONG if the filesystem (e.g. WSL) is
case-sensitive!

How can code in cygwin.dll test whether the current path is on a
case-sensitive volume, or not? What if the perr-dir case-sensitive
feature is ON, should that be probed and handled too?

Sebi
--=20
Sebastian Feld - IT security consultant
