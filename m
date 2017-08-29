Return-Path: <cygwin-patches-return-8841-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 41062 invoked by alias); 25 Aug 2017 09:41:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40537 invoked by uid 89); 25 Aug 2017 09:41:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-110.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Attached, H*R:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 25 Aug 2017 09:41:27 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 220EA721E281A	for <cygwin-patches@cygwin.com>; Fri, 25 Aug 2017 11:41:24 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id F26B85E0359	for <cygwin-patches@cygwin.com>; Fri, 25 Aug 2017 11:41:22 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D203DA80522; Fri, 25 Aug 2017 11:41:22 +0200 (CEST)
Date: Tue, 29 Aug 2017 19:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) add strptime %s
Message-ID: <20170825094122.GM7469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <20170824092535.GH7469@calimero.vinschen.de> <3d046e98-13f6-8cd6-97e7-2ce611946350@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
In-Reply-To: <3d046e98-13f6-8cd6-97e7-2ce611946350@SystematicSw.ab.ca>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00043.txt.bz2


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1709

On Aug 24 14:00, Brian Inglis wrote:
> On 2017-08-24 03:25, Corinna Vinschen wrote:
> > On Aug 23 12:51, Brian Inglis wrote:
> >> Attached patch to support %s in Cygwin winsup libc strptime.cc __strpt=
ime().
> >> This also enables support for %s in dateutils package strptime(1).
> >> In case the issue comes up, if the user wants to support %s as in date=
(1) with a
> >> preceding @ flag, they just have to include that verbatim before the f=
ormat as
> >> in "@%s".
> >> Testing revealed a separate issue with %F format which I will follow u=
p on in a
> >> different thread.
> >> Similar patch coming for newlib.
> > Funny enough, in other places in Cygwin we call this temp variable
> > "save_errno" :)
> > Alternatively, since you're in C++ code, you can use the save_errno
> > class, like this:
> >   {
> >     save_errno save;
> >=20
> >     [do your thing]
> >   }
> > The destructor of save_errno will restore errno.
> > Since the code as such is fine, it's your choice if you want to stick
> > to it or use one of the above.  Just give the word.
>=20
> Changed to use that.
>=20
> --=20
> Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
>=20

> From 16855e2e241673e5cb98368a696114e38f62a4dc Mon Sep 17 00:00:00 2001
> From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> Date: Thu, 24 Aug 2017 13:24:28 -0600
> Subject: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) add %s suppor=
t to
>  strptime
>=20
> ---
>  winsup/cygwin/libc/strptime.cc | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Pushed.


Thanks,
Corinna


--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZn/DCAAoJEPU2Bp2uRE+g/hsQAJ5ydCPwmMk+u8sXmxun8Apw
kd24WBUOxxXCb/xR0TQDE94uFX9tpQx1kJV1GdvmfnHjnfLyKHQpHpoGSHpZty95
QPsbGiF5lXy1NgsVSlu8Uq2ee+wr7oYyQQwhoQB4cNOGy30wlgVD8Mh08kOXT03P
qwzV7NhLkqXVEIBPRaq2BCuy8CFPlFuHoObu5PA+5oM6ktll9A2sQjfBLXyRX6GR
U15rhLXtgNJ6+eeTWw2aRzZS87syb4XOnqnw624OXz3KZdUi1kpmZ4fpJAd2pgpn
T7TrmXGzZ1uBvOzDDgdH+Ad09CFaJ99pIP3F/rLi4Grw3p8QWYeqPoHGclRofJVO
bwnfZQJWc/r6kcCb9Pwqkp64ha3+ui8JsVxJQ7E9AqpqwNSsqLirqAwF9VBoGQib
51JmX8aR/DQ4br3VOhsHq3nFsqnhEjQJvTZyTe82g1xgYHwOIMweNm31ZQ4BjWk7
H5Mh4gE9TPplaAR2qNHxW81mQf9HyDblBU0i1y7pTdd9Vv04bv+sOf+LIv+VMezv
NIsRTQ5ruqvdt3+9QfjSYEYHIY5YYvGvO81IM2yuUB8mJZilMjhNOZf8sIjFH3yk
uD8fmYab2sgiW4udd02QG5ZHwI7J5iHY8HgbsM2AlonGQAm2koNOjzJnvt/BuUfL
4nKGuF9k9RPkuLm0mtiX
=c4/8
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
