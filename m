Return-Path: <SRS0=NFKm=YV=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by sourceware.org (Postfix) with ESMTPS id E46883856DFD
	for <cygwin-patches@cygwin.com>; Fri,  6 Jun 2025 20:51:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E46883856DFD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E46883856DFD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::532
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749243091; cv=none;
	b=KuAnETB9g4e3mEH+L9xhaDkPcHfhNoEXK3tpyrX4pdcZxBjiVufqwFFddz1deyjq4bhLu9To53oHkE/50z4Zx/5BuFQXeQZbIDZdQVZMZlweIBRp+KF0+e1036k8a8Qa8DokKtd4us39aHyxm+FLbF+yVQHZ0M7wv73R5AzZCr0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749243091; c=relaxed/simple;
	bh=0z/i12jj8SGNYkMU0GN1LIpPvCUmyfhTEFCTu9Ww5Pg=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=vP9DZgtjCHJIPT+JMve+HuywsAiFeOPv4geJmlMtnhnzRCN9dYb0c3AK8cl2i3ShTAqDQntRcB2aNvmOzhi3+qXzvNCz6RN8sWpBB/SIe5bGg+RhYPxBQE+H+JuwxZmXfUPsg6Awhd0XAnFPv8UUWRTqmCouNV5p+s+3wYyOySw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E46883856DFD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GQW6Uvhg
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-60780d74bbaso1303724a12.0
        for <cygwin-patches@cygwin.com>; Fri, 06 Jun 2025 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243089; x=1749847889; darn=cygwin.com;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKV3etrEsDVgubjXu8U/Jz8TCHbYj+zlW43zueDYV2k=;
        b=GQW6UvhgnkNtOv2JSrWTizoRXXsn0USnk3mXmBQBGEj2huh3vl1rpATGYAIhycLuQx
         h9OoinvFVmG7AW0pRkXxWkuvnmtIPo9Fhdp2K1jsnVxTPp9ooiulSoeM+w9hE47OG5Vh
         rdb1AXKlwZY+bJUXj9R3vVDiW6xsF3MZdY9qsEqnoaJTPpoimEaROXh49BMCsqFR5H83
         lUd5O/CtmiKGyRpEtGOnCE03Gpk8I7rPYHwq+vwMs2mriy9rXVkNXqnzwIvl7XyDnqRb
         QvWneFK3WrSp2GiqoAPuzTGlIsK/VnyaGwYzAndAHJa+W/Rn0E8/5CWNvlB2A1DVeVk3
         PaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243089; x=1749847889;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKV3etrEsDVgubjXu8U/Jz8TCHbYj+zlW43zueDYV2k=;
        b=kLQrx8sbJfe+0sOaLRQRikuYet5GsCNpGY4sKukICv80hh2aDrHY3qZSzGTdZPeVUq
         k3jUlmaLeGXpU1/TNNgmkpD5KHIrz7GrhC61+uTkefhwVomFTdzxlf/3E1wQYvANN0i2
         6E53b441HZAVNwHhqCk5pw44SLCC8cv4AUDLxB44pgIOLD3jkcUt6RwrfdiWFNJak15H
         QsAWNQ5A744rbxIrFoddvsnX5rYB4tozu84zTU2xlz8WQJU1w45en2lXqDtXdmQjKaKJ
         mbnMqxBt8zU4c5hofc2rwVq5G//UXeqjD4bTh58ObAI/AyymaPQf20F+xfB/ReORsAN5
         BZPg==
X-Gm-Message-State: AOJu0YxG3Bt+gNy6sm04nHLk5EhjSJ7xj421eefe6091F1uyMkh4rN/R
	JugKHdUf3RNlfYNxQDinvn6Q7QRdR7so6JzSaD6/9+1owQwXmFa0nYaCZUy9k4yNC+mIK/ZYVZl
	RaSoufw4aXbSLICEJhH05FTxnldey93nBBpLO
X-Gm-Gg: ASbGncuwROiOuF1mB7elw1CBuJCNIHvcEBocwqsrGJ4PIIerqIe7L8EcmYObIyKVtAQ
	xNbKmv//Jo69VHsITWYXSgYbUyBOO3Jeh4OgQZ6BvYYQFp5lIeOnHDhgZ42dDNWcLDotO7/OkfF
	6eYkihhZfYYSsnw1sOiHS84R2TlR8hrqOeVGalJUAu8yrwaQ==
X-Google-Smtp-Source: AGHT+IFBFRBpm3oKcHYVdf5IT27+RpAJT0Ph+ELx+VX3KJz+l+cKr8jR30ei4hHh4uwzQo7r3MKOwYz+ReY/ttRS6XM=
X-Received: by 2002:a05:6402:40cd:b0:600:a694:7a23 with SMTP id
 4fb4d7f45d1cf-60721747bd6mr7722143a12.0.1749243088591; Fri, 06 Jun 2025
 13:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKrZaUst28O+9Z6TBbQU0Ha3o9ZSRPzGYbpb7NiQ+1cmsUiT2Q@mail.gmail.com>
 <79bde4c8-658b-438d-9c40-202e03ef23ba@SystematicSW.ab.ca>
In-Reply-To: <79bde4c8-658b-438d-9c40-202e03ef23ba@SystematicSW.ab.ca>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Fri, 6 Jun 2025 16:50:51 -0400
X-Gm-Features: AX0GCFuewOO-9VZxVJWe10qBwnt6et60YnbNR2W0zWhKmNN7mCxb2j5v455B3DA
Message-ID: <CAKrZaUuNGaC=kzDb-nRZmk3r4vm-3GM8W+AbbOgaWvoihQR7gw@mail.gmail.com>
Subject: Re: Website Suggestions
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, Jun 6, 2025 at 1:06=E2=80=AFPM Brian Inglis
<Brian.Inglis@systematicsw.ab.ca> wrote:
>
> On 2025-06-05 19:50, John Haugabook wrote:
> > I made a few small edits to the website, and included the patch as an
> > attachment. Below are the changes:
> >   - Changed links to template elements to absolute, using "/" before th=
e page.
> >   - Included template elements in nested pages.
> >   - Made an edit to "Install.html".
> >   - In style.css edited elements for better UX, and edited comment
> > markers for consistency, ending at col 78 for comments marking style
> > section.
> >
> > I wasn=E2=80=99t sure where website suggestions should be sent =E2=80=
=94 this list
> > seemed most appropriate, given its name. If there=E2=80=99s a better pl=
ace or
> > process to submit patches like this, please feel free to redirect me.
> Rather than the *generated* HTML you sent many of your patches against, y=
ou will
> have to redo many of your changes against the applicable source repos bel=
ow,
> build Cygwin and docs to check the appropriate contents are generated and
> appear, then format and send the patches from the commits against each of=
 the
> source repos, either as separate individual patches, or a series of *rela=
ted*
> patches against each repo.
>
> Send git-format-patch output against current:
>
>         https://cygwin.com/git/cygwin-htdocs.git
>
> sources using git-send-email so they can be reviewed and applied with git=
-am.
>
> Most other website and doc package contents are generated from DocBook XM=
L:
>
>         https://cygwin.com/git/?p=3Dnewlib-cygwin.git;f=3Dwinsup/doc;a=3D=
tree
>
> sources in the above repo: note all the includes of other, sometimes gene=
rated,
> XML files, most of which are generated from embedded API comments in func=
tion
> sources:
>
>         https://cygwin.com/git/?p=3Dnewlib-cygwin.git;f=3Dwinsup/cygwin;a=
=3Dtree
>
>         https://cygwin.com/git/?p=3Dnewlib-cygwin.git;f=3Dnewlib/libc;a=
=3Dtree
>
>         https://cygwin.com/git/?p=3Dnewlib-cygwin.git;f=3Dnewlib/libm;a=
=3Dtree
>
> in DocBook XML and other doc formats, and which should be sent using the =
same
> process; except all Newlib changes should be sent to the newlib sourcewar=
e
> mailing list rather than the cygwin patches mailing list.
>
> > Totally understand if the changes are rejected or revised. Thank you
> > for maintaining the project and reviewing contributions.
> To generate the API info and man pages, you can change into the newlib di=
rectory
> and:
>         $ make info man
>
>         $ make install-info install-man
>
> I have no idea what the process is to deploy the generated HTML files int=
o the
> cygwin-htdocs tree, unless it may just be the presence of a parallel repo=
 during
> the build, and/or scripts run from one or the other, or the infrastructur=
e.
>
> It would be useful if we could be pointed to docs on how to reproduce the=
 web
> site locally.
>
> --
> Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada
>
> La perfection est atteinte                   Perfection is achieved
> non pas lorsqu'il n'y a plus rien =C3=A0 ajouter  not when there is no mo=
re to add
> mais lorsqu'il n'y a plus rien =C3=A0 retrancher  but when there is no mo=
re to cut
>                                  -- Antoine de Saint-Exup=C3=A9ry

Thanks for getting back to me. I might not be able to work on this for
the next week, but in response.

> I have no idea what the process is to deploy the generated HTML files int=
o the
> cygwin-htdocs tree

I'm not able to find anything on that either. It doesn't seem like I
can do much without simulating the generated HTML. Is it built from a
cronjob, then uploaded to the site?

If so, then adding:

```
</title><link rel=3D"stylesheet" type=3D"text/css" href=3D"/style.css" />
and
<body><!--#include virtual=3D"/navbar.html" --><div
id=3D"main"><!--#include virtual=3D"/top.html" -->
```

to the file that generates the html should work - right?

> To generate the API info and man pages, you can change into the newlib di=
rectory
> and:
>        $ make info man
>
>        $ make install-info install-man

Didn't work for me. I can use the xml from:

 https://cygwin.com/git/?p=3Dnewlib-cygwin.git;f=3Dwinsup/doc;a=3Dtree

and do a makeshift build, but doing that doesn't really do any good
unless I can generate the html as it is done from however newlib
generates the html page from xml.
