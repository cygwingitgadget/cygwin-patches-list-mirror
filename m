Return-Path: <cygwin-patches-return-9478-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79614 invoked by alias); 28 Jun 2019 15:17:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79604 invoked by uid 89); 28 Jun 2019 15:17:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Jun 2019 15:17:53 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N4yuK-1ifXly2Xcy-010x74 for <cygwin-patches@cygwin.com>; Fri, 28 Jun 2019 17:17:50 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E765EA8079E; Fri, 28 Jun 2019 17:17:49 +0200 (CEST)
Date: Fri, 28 Jun 2019 15:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: Fix return value of sched_getaffinity
Message-ID: <20190628151749.GH5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190626091641.GS5738@calimero.vinschen.de> <20190626094456.57224-1-mark@maxrnd.com> <20190627071305.GB5738@calimero.vinschen.de> <20190628151357.GG5738@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gpOboRovIPmaBszt"
Content-Disposition: inline
In-Reply-To: <20190628151357.GG5738@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00185.txt.bz2


--gpOboRovIPmaBszt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 877

On Jun 28 17:13, Corinna Vinschen wrote:
> On Jun 27 09:13, Corinna Vinschen wrote:
> > On Jun 26 02:44, Mark Geisert wrote:
> > > Have sched_getaffinity() interface like glibc's, and provide an
> > > undocumented internal interface __sched_getaffinity_sys() like the Li=
nux
> > > kernel's sched_getaffinity() for benefit of taskset(1).
> >=20
> > I put this patch on hold until the problems with using the
> > RTEMS headers are fixed.  Basically the patch is fine, but
> > *if* we introduce our own headers, it might be a good idea
> > to move the definition of __sched_getaffinity_sys into our
> > own headers.
>=20
> Patch pushed with a minor change.  I moved the dseclaration of
> __sched_getaffinity_sys into the new winsup/cygwin/include/sys/cpuset.h
> header.

...and created new devel snaps with the latest changes.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--gpOboRovIPmaBszt
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0WL50ACgkQ9TYGna5E
T6A8khAAojOc43c8teC6bWx562AkEoEyjgZdVUfqf+2OcKxUU8k2NYp29WIWtKtZ
FdoztaZ+BpcqIJdoCajYsegA7up8T1pjJijjx6ry+ee+VvKUtESP/H2oOBRc6Oha
5XXvmlpcH++wTtqgr7oTKb0of9CYm+KXQfdFpRGsv3DC3yaN0sDv47OAYQJD+Q3f
HtSm899qDrF0cqqfOqhR1RRarZwlaPS3c9BWHB6RjIGbSWh0dH70wjnvvCPsBZv1
ddgMui5WSvBoMMDHdBmk29No2IwiOj6NGvh+KwrSLDWhRFtQ66lvh6XmjT5W6cYt
GbzUjXS873T9yZtUo3u/NHWvdnMaRTUcRYpkBT2hZW+kNcucq38HhzIIkicsoDZi
aWtdJvH9KeXEAn3JSIrOuCApkixeX/GX4leUeJ9hSZgdsm/FC8JDYpAubTywPs9G
qqHNzrVC5rFA6a64hSpJ90+e2+N2BjSwbadfjBkjXazSl3VxD9zuuG5RZsZB1FaC
UvfUDVYh1egu/270A0G5wHNFYbjPOM867MtJQIXFbphfzrLSYceVi2EX4Oke4w6C
N9UNe6dEGVhqN/u4zndpMtDP5G0VYadajDYfup+AonycGcRzweuX7l0MHyWowQZK
FiPpraBvUd68jSJZN8RNhZytMo50QHnHKm9j4/SRqmyV+b07dF8=
=AtZF
-----END PGP SIGNATURE-----

--gpOboRovIPmaBszt--
