Return-Path: <cygwin-patches-return-8056-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2941 invoked by alias); 27 Jan 2015 15:00:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2895 invoked by uid 89); 27 Jan 2015 15:00:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.0 required=5.0 tests=AWL autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 27 Jan 2015 15:00:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2D1078E13C0; Tue, 27 Jan 2015 16:00:17 +0100 (CET)
Date: Tue, 27 Jan 2015 15:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add-on to gethostbyname2
Message-ID: <20150127150017.GK14265@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0NIU00LKBC75HR00@vms173011.mailsrvcs.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="Ucgz5Oc/kKURWzXs"
Content-Disposition: inline
In-Reply-To: <0NIU00LKBC75HR00@vms173011.mailsrvcs.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00011.txt.bz2


--Ucgz5Oc/kKURWzXs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 816

On Jan 27 09:56, Pierre A. Humblet wrote:
>=20
> >-----Original Message-----
> >From: Pierre A Humblet
> >Sent: Friday, January 23, 2015 9:30 AM
> >
> >> From: Corinna Vinschen
> >> Sent: Friday, January 23, 2015 5:48 AM
> >>
> >> On Jan 22 21:05, Pierre A. Humblet wrote:
> >> > Add-on to gethostbyname2, as discussed previously on main list.
> >> > The diff is also attached.
> >> >
> >>
> >> Do you have some wording for the release info in the docs, please?
> >>
> >Make gethostbyname2 handle numerical host addresses as well as the
> >reserved domain names "localhost" and "invalid".
>=20
> Actually it should be "numeric host addresses"

Fixed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Ucgz5Oc/kKURWzXs
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUx6gBAAoJEPU2Bp2uRE+gABEP/jF4di1RjM9fVnahNaH4D3Ci
Q5bs+x2zoR9OCY/gpQk9lsEPgx7c5CwlIoJQ/VKOQULkj+lleg3/3ZQrBDqeZUzv
nT5iExLRlxfM/WjQw92iNzk6xun2epBT0/izSOSOW47VieaHTEpJQYOnblq3Dtzj
a8onPl3Ijkf+lwuiyP9cuim1v66FmODM3Kh71TWKCOimOZfVBlpiheiKXAAIWasG
JOJn+Aq8RtHvHnyZKKS7KXZu0wsOZsVTgwl4LVs1mVHuIZyCoNToi3s/DLJMkOmx
9ScWaN7fTvnPJYupCi/m7GnhP2XtmyLU2zCxKSz3uAxZZEVlqSgLfZ/nQ3oyELfk
Q6D0gbSNI6POBk66IJaJitzB6Z8iNZcVlO5M2532GDuGJZ7Bs/9kcSGNYgJYTQ/D
sTC3zKNqFbW5QpgoGYeR48+loEb+Yuomm/UeQqywcjjUnkQ2WHBvNRo7VHu3wfvv
AsnJBXg5F7r4QJyGwlE3b53A81Es++KCysonW/ZMHHkph7ou0VOb13e268kNuR7+
939kfVJ6A560nKqr3oymlSTo5+xNJpYbKg3TTaGS3wvNoemBLR/oHDB902sH9FPB
LC4vT3D3ihfu2zcqmSs5HA2VMo9uxPkdLTjzj+i894XJzQa8MvymXjAAmDTLvzeR
WqhWqUYH10/rgwiDVcp9
=1t3/
-----END PGP SIGNATURE-----

--Ucgz5Oc/kKURWzXs--
