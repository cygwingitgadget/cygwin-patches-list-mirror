Return-Path: <cygwin-patches-return-8444-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37381 invoked by alias); 21 Mar 2016 15:05:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37258 invoked by uid 89); 21 Mar 2016 15:05:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=earth, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 15:05:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E430AA8042F; Mon, 21 Mar 2016 16:05:14 +0100 (CET)
Date: Mon, 21 Mar 2016 15:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 05/11] A pointer to a pointer is nonnull.
Message-ID: <20160321150514.GB7179@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com> <20160320111558.GG25241@calimero.vinschen.de> <CAOFdcFPN1q8L6qmbORVogvxs5rsETjSs9_9_QnAfFm3YT++6Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <CAOFdcFPN1q8L6qmbORVogvxs5rsETjSs9_9_QnAfFm3YT++6Mw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00150.txt.bz2


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2014

On Mar 21 10:19, Peter Foley wrote:
> On Sun, Mar 20, 2016 at 7:15 AM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > Eh, what?!?  How on earth can gcc assert memptr is always non-NULL?
> > An application can call posix_memalign(NULL, 4096, 4096) just fine,
> > can't it?  If so, *memptr =3D res crashes.
> >
>=20
> So, it looks like what's happening is that gcc special-cases
> posix_memalign as a builtin function.
>=20
> See https://github.com/gcc-mirror/gcc/blob/master/gcc/builtins.def#L831
>=20
> This causes the below warning to be outputted for my testcase:
>=20
> a.cc:9:25: warning: null argument where non-null required (argument 1)
> [-Wnonnull]
>      posix_memalign(0,1,1);
>                          ^
> a.cc: In function =E2=80=98int posix_memalign(void**, long unsigned int, =
long
> unsigned int)=E2=80=99:
> a.cc:3:3: warning: nonnull argument =E2=80=98memptr=E2=80=99 compared to =
NULL
> [-Wnonnull-compare]
>    if (memptr)
>    ^~
>=20
> Testcase:
>=20
> extern "C" posix_memalign(void **memptr, unsigned long, unsigned long) {
>   void *a =3D 0;
>   if (memptr)
>     *memptr =3D a;
>   return 0;
> }
>=20
> int main() {
>     posix_memalign(0,1,1);
> }
>=20
> (Note that passing -fno-builtin causes the warning to go away, as
> posix_memalign is no-longer special-cased)
>=20
> In addition, both newlib and glibc appear to assume the memptr arg is non=
null.
> https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dmalloc/malloc.c#l5=
008
> https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dblob;f=3Dnewlib/lib=
c/sys/linux/malloc.c#l4938
>=20
> Hope that makes this more understandable.

Yes, but in glibc this is combined with a header disallowing a non-NULL
argument.  This is missing in newlib yet.  I guess this would make the
change acceptable.  Alternatively a __try/__except block in
posix_memalign.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8A2qAAoJEPU2Bp2uRE+gZ+sQAIqa+h2sI6M4Yz23DilYirVD
I7qWZQ4WKemeFDmPEp9MTOXtKCI7nB0Onk1YbbptVKwpi4JHKOZl85wwOUjxaX67
/99z11/NcxDUqX5QiZyg+XCwrC7jPYXMV5Zt2cZp8aEQdEiQ1bhRxp9xNS4rIJwE
UfKTT4zwIuSrlIpR8cuDhK2Mdz1h/+KqR9wUqhsK6mwBaTZ/8yCFWHgrZ+MP7IDj
9lv7QhRXkHe+TGEWKkLvTx+3Gijcxnj9fPtTAcGJvVzMH1M5s8VgR74116NBpyP7
pC39GPXf0iONbXP0LvUtadBl3yQufvHy9yedZ5XZFokPnfqjHK9zDE9fqQcJa9J9
siZUeIhU8VaQuvoSnQ6Ysc4i7VmH7x+bdjNhEcLvKhDtppBcBkaZfE9rCdbLGY0m
YDOhXc9j68sE/l2piFqD6ZL96qp2MrHG3SiqiKqd6r9MWJUjLFa5jjxOiE28iFEO
1ZafJ6EfhOLEN6BgIBsTWm5WKgkDIbLTFW9zyKRm/cGufefe/jFip02p8RGD8BDh
/Dm6titsQrVnYEUklo3yRFQAwPmtdK/2elAc6UE+djeNHv11qR+nAU3zNpYmmYJU
EvImTrH7t2klimbNKoyYNqPMjJ9qUqsgOWRfqNml2FEEkDyphZtNKvPWdbe/LKUs
QTOZ5KrUxYKVC7v0BOvH
=NYI5
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
