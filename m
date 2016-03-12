Return-Path: <cygwin-patches-return-8394-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39765 invoked by alias); 12 Mar 2016 08:14:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39747 invoked by uid 89); 12 Mar 2016 08:14:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=guard, HTo:U*cygwin-patches
X-HELO: mail-wm0-f49.google.com
Received: from mail-wm0-f49.google.com (HELO mail-wm0-f49.google.com) (74.125.82.49) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 12 Mar 2016 08:14:03 +0000
Received: by mail-wm0-f49.google.com with SMTP id l68so43754573wml.1        for <cygwin-patches@cygwin.com>; Sat, 12 Mar 2016 00:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to;        bh=2GtXM6T2CDaV7yvdCMIGSEi1KbSTfBCV0HJkeyLKKBY=;        b=k53EWVfhude9VLKZ4V728cefCGaFFY/4SCmB9QGR+l6n9hnZCKAlQhxpbA2qzWXlsR         lLGvyLUTTZV7vicMmTBsWrp+wOFnimxwE1/PZf5r/so12VsjMAL00agqcjl+MSrR8sAy         kN+wr/TbnkmIrvmi4wpvR/EUatb8Q4eCb/ulD+Fr+1g7tyucKvAHYx41VfCzupc3OR68         qEOUGfxuvh+/Z+YVm+aOZH+ILJyLvFdaSaT3J6HxvGERQpXAaSsf7bPiFAYPihLGZsJV         4+s86xk9snPLedF3tmfq5sSeN5RwpBb7lRXbtE7xAW/z89wz3BTTMzo4Vdhtm89TpydG         FR1A==
X-Gm-Message-State: AD7BkJJbxKObNz+K2qQRsq71ebwmevsCtq/MfSMmZRmOKz3KAIXfa4k6dHsUt9iG95A8Tg==
X-Received: by 10.194.2.41 with SMTP id 9mr15003234wjr.10.1457770440961;        Sat, 12 Mar 2016 00:14:00 -0800 (PST)
Received: from [10.0.0.1] (27.228.broadband3.iol.cz. [85.70.228.27])        by smtp.googlemail.com with ESMTPSA id lh1sm11956175wjb.20.2016.03.12.00.13.59        (version=TLSv1/SSLv3 cipher=OTHER);        Sat, 12 Mar 2016 00:13:59 -0800 (PST)
Subject: Re: Fwd: [PATCH] spinlock spin with pause instruction
To: cygwin-patches@cygwin.com
References: <CAKw7uVgrjqZVznRMoCbsjyz4YXast5YtAAmpWQorOw7YXqbOhw@mail.gmail.com> <CAKw7uVg78t2V8KKLYfPyhb97XjU+aUb4KV-poz7i_wwDeJ6b=g@mail.gmail.com> <56E3B674.7020702@maxrnd.com>
From: =?UTF-8?Q?V=c3=a1clav_Haisman?= <vhaisman@gmail.com>
Message-ID: <56E3CFB1.5080906@gmail.com>
Date: Sat, 12 Mar 2016 08:14:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56E3B674.7020702@maxrnd.com>
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="qmGqXL1qIpkjdVAa1rmiWuO06vrjWcNG3"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00100.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qmGqXL1qIpkjdVAa1rmiWuO06vrjWcNG3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-length: 776

On 12.3.2016 07:25, Mark Geisert wrote:
> V=E1clav Haisman wrote:
>> Hi.
>>
>> I have noticed that Cygwin's spinlock goes into heavy sleeping code
>> for each spin. It seems it would be a good idea to actually try to
>> spin a bit first. There is this 'pause' instruction which let's the
>> CPU make such busy loops be less busy. Here is a patch to do this.
>=20
> I wanted to try out this patch but compilation is failing on the
> "unlikely" call.  Is that a macro that needs defining or something else?
> Thanks,
>=20
> ..mark
>=20

`unlikely()` is a macro defined in `miscfuncs.h`, right below header
guard:
<https://cygwin.com/git/gitweb.cgi?p=3Dnewlib-cygwin.git;a=3Dblob;f=3Dwinsu=
p/cygwin/miscfuncs.h;h=3D3a9f0258c6cbb62b8d51e96c0c5542b70659e17b;hb=3DHEAD>

--=20
VH


--qmGqXL1qIpkjdVAa1rmiWuO06vrjWcNG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 213

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREKAAYFAlbjz8YACgkQlv+b6dkC1zY92gEA5bprYS5t+7jnJ2bpCWMueEVC
eH+rFR+34OAJVppPpL4BAOXRlK0who9BMcUxeObupcpvTmYza2JX7UGISS8TNJJE
=DSxc
-----END PGP SIGNATURE-----

--qmGqXL1qIpkjdVAa1rmiWuO06vrjWcNG3--
