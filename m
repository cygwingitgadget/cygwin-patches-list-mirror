Return-Path: <SRS0=WMQF=ZG=gmail.com=sebastian.n.feld@sourceware.org>
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by sourceware.org (Postfix) with ESMTPS id 635CC383E52A;
	Mon, 23 Jun 2025 18:22:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 635CC383E52A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 635CC383E52A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::534
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750702978; cv=none;
	b=JOeSuorPMzVBSUpuAmw0tG0OLGZHv4dQMG7aQhuGp8Urqyy88TOj3oXR0L5vNflWhDXQAZ8yayA9ibKVoHuwNwAlBgavJA+SyaQfYyuuyhAMoZP/lPUiW68fEZlMlHNnIpisxWK8TZdOJg2vES8FfV9SkprjJ5aj0FiWVjPESx8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750702978; c=relaxed/simple;
	bh=eAKrWu+KhbILe6aCgRoyBPrt654vJMKxrYLcT/ISCqM=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=UfpXbDyr3pqngzTJU7LZz+c6aNn9TyRZZh18ckw09A1bBoA8fcEESkSfIX6Bc56+CAfx//g3JatFn/liRQSnQnrZQzkP/r5LXVCshCLq9VT33s8mIQMWeixE6zUmcVRg5U7+gp685bBqnRbJf3+ruZf90M1rC7DCt8NB+0UhW3g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 635CC383E52A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DnYoxmOl
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so6680053a12.0;
        Mon, 23 Jun 2025 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750702977; x=1751307777; darn=cygwin.com;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D/50benrJZh9vt6Wwouq9sVxHZEYxNHE1delJWbRSM=;
        b=DnYoxmOlj9NR6PFRZVznv+zxqCQoM8ZJBdCKaEmhbiVgk7Usit50PD+ltNLXcEBb1A
         sYDn6/nCho5a9NjElrLLPx937Ojj9jdtgU9tzj+Mu4vHvBQyUI9P99lVTqm6cUCYj6pY
         d8ha9xrufWIpz+i7hAl5YpvlZXiAXE6oKtC0e9xLit9NPgCoAxTTKDgVLFvlZXsGXUW2
         lSzWpiUDga00TwvYUOv0dnlqcfCK5yCQAA6TztDNikvi4bgpMjOSkQUV1FySbmbjoh3u
         MiEG1cpq44j9+BembzdD0hXAwVq57gPCTeXDR40Faxa/nS7aO47UsnSt2cj+cW/O/kqE
         sYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750702977; x=1751307777;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D/50benrJZh9vt6Wwouq9sVxHZEYxNHE1delJWbRSM=;
        b=kcNFWWAzkE4nJFrksS3US+NrT9E8++p2nODeYcqebfjVVO7HN9KIQFmU1s7GWeqqqX
         j9lE50hxW4C5bFl5AysW4wHbpodZfWXOKIdYCX86FbU7oBeAB7mphu6ibq3ssqUctjg3
         MsT9W8cX+syETvAMk0mLBNOUTybf6zdITeWT/Tr2jEVcAuUHwB+AGl3poVVjOFP+mtwm
         T5rfIxqwV8PwG/uX5m0KXCmoTNj1+z5ZNhFbkSartbcvW7PI4JeeBBCGg775E8cL53V0
         ifDb9rMIlWVYu5Pk2p8SFdP0t28jMXP9uvPTNn0XkM4xavv7RV353R//31JowZH2yBgQ
         cFXw==
X-Forwarded-Encrypted: i=1; AJvYcCX/OtMKL5Pju7RSASVWbITHdfgf4HbYF5t2ugcDBYvEbW2Fapj/Qs2O+klILCAs2m6PoZupkO4=@cygwin.com
X-Gm-Message-State: AOJu0YxAEg0VZsUfYvyY8o4vXvAh0SpOwYrES0iYXOogDxJOkzuXerwZ
	PKOLH7HHalm7p1611HK1er873tE+pqaed/64UWg3EYg1lnhTDArNGGd3+jCTL4MfzpU42b/sPVg
	hkL4QSUOmK82thBP0kTV3xOj8EiYkVO6OnU7N+4Q=
X-Gm-Gg: ASbGncvYsXtjSjScBqHaAd1YCFYsxbj+Vwn1lhuk5YgnemWF39NGB7rkaOO2Td+5IUE
	buBCWuIZMPOwdDoLG2O2n90hPxJbwq8MMFqnhsLLXZzmy0m+dRavaRUhmszUq7NoYQRahw5uMZk
	hDrH+cEHG6I7JJp3tX+RW3K88puY7sPq2SOEk62+h8a0Y=
X-Google-Smtp-Source: AGHT+IGSt27Qi9XJszL9xXgTlNBA5t/p71hjx0vPRtOWJHUplX0Y56rfLdayOA3aMq06NXVsPBrPkRxCVCBOyPNCdEI=
X-Received: by 2002:a05:6402:34c3:b0:605:2da5:8483 with SMTP id
 4fb4d7f45d1cf-60a1cd30f0emr12964252a12.13.1750702976362; Mon, 23 Jun 2025
 11:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <6058889e2ae8c9c827a8d6678f09b3b1741e2fcf.1750413578.git.johannes.schindelin@gmx.de>
 <CAHnbEGLjsy4MZD+oqjGbd=JrX+q8an3mhT38xndEgjmTpWyOnw@mail.gmail.com> <aFkPUI22HlYnYhZh@calimero.vinschen.de>
In-Reply-To: <aFkPUI22HlYnYhZh@calimero.vinschen.de>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Mon, 23 Jun 2025 20:22:19 +0200
X-Gm-Features: AX0GCFvbZInMsiV9SiQH_S6hTGZjQLwuq4YxVYfwDkkKZkchfdO3PhUfx8gjUR8
Message-ID: <CAHnbEG+7T8K50WkDN4=xBA_ir8N3M32=ZGJnYvCFSpH7UquZ=Q@mail.gmail.com>
Subject: Re: symlink_native() bug with case-sensitive file-systems Re: [PATCH]
 symlink_native: allow linking to `..`
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, Jun 23, 2025 at 10:52=E2=80=AFAM Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
>
> On Jun 20 13:33, Sebastian Feld wrote:
> > On Fri, Jun 20, 2025 at 12:03=E2=80=AFPM Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> > >  winsup/cygwin/path.cc | 21 ++++++++++++++++-----
> > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> > > index 42919a7cf5..ed08398930 100644
> > > --- a/winsup/cygwin/path.cc
> > > +++ b/winsup/cygwin/path.cc
> > > @@ -1855,9 +1855,18 @@ symlink_native (const char *oldpath, path_conv=
 &win32_newpath)
> > >        while (towupper (*++c_old) =3D=3D towupper (*++c_new))
> >
> > 1 unrelated issue:
> > I think this towupper() code is WRONG if the filesystem (e.g. WSL) is
> > case-sensitive!
>
> The preceding comment tries to explain why we always compare case
> insensitive.  There's a high probability that the symlink will be used
> by native (non-Cygwin) processes which are insensitive.

OK, but this is at least bad for performance.

Some stats from a profiling tool I am working on:
German language, multibyte locale, codepage 65001:
Each towupper() traverses 11 functions, covering between 8002 and
11722 instructions, and between 260 and 469 branches, on 64bit.
If the code could just use the per-volume case sensitive flag, then
this could be reduced to 20-30 instructions just to do the indirect
load (2 times) and compare.

> > How can code in cygwin.dll test whether the current path is on a
> > case-sensitive volume, or not?
>
> There's a twist here.  NTFS or ReFS or other filesystems (but not FAT)
> are usually case sensitive.  It's the OS which makes them case insensitve
> by using a specific flag at open time, combined with a kernel registry
> key.  So apart from FAT, the creator of a file decides if it's created
> sensitive or insensitive, and the one searching for and opening a file
> is deciding if the search/open is sensitive or insensitive.
>
> Also, we're creating the symlink via CreateSymbolicLinkW, which is
> probably acting case insensitive anyway...
>
> What if the perr-dir case-sensitive
> > feature is ON, should that be probed and handled too?
>
> ...unless the symlink is created in a case sensitive dir, I assume.
>
> Right now we don't handle case sensitive dirs in the path_conv code.  We
> only check for the kernel registry key and the FILE_CASE_SENSITIVE_SEARCH
> filesystem flag.
>
> To add the sensitive dirs to the picture, path_conv() would have to
> check every directory on NTFS for
> NtQueryInformationFile(FileCaseSensitiveInformation). It would then
> set the path_conv::caseinsensitive flag accordingly.

Yikes. Does Windows cache this per-dir info somewhere?

Sebi
--=20
Sebastian Feld - IT security consultant
