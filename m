Return-Path: <cygwin-patches-return-8496-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100333 invoked by alias); 29 Mar 2016 10:16:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100310 invoked by uid 89); 29 Mar 2016 10:16:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 29 Mar 2016 10:16:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 955E6A803A0; Tue, 29 Mar 2016 12:16:36 +0200 (CEST)
Date: Tue, 29 Mar 2016 10:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: export __getpagesize
Message-ID: <20160329101636.GA3793@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459187300-8800-1-git-send-email-yselkowi@redhat.com> <20160329081122.GA4043@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20160329081122.GA4043@calimero.vinschen.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00202.txt.bz2


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1093

On Mar 29 10:11, Corinna Vinschen wrote:
> On Mar 28 12:48, Yaakov Selkowitz wrote:
> > The inclusion of <sys/cygwin.h> by <sys/shm.h>, besides causing namespa=
ce
> > pollution, also makes it very difficult to get the WINVER-dependent par=
ts
> > of the former.  This affects code (such as x11vnc -unixpw_nis) which use
> > both SysV shared memory (e.g. the X11 MIT-SHM extension) and user passw=
ord
> > authentication.
> >=20
> > getpagesize is the simplest function to retreive this information, but =
it
> > is a legacy function and would also pollute the global namespace. The L=
SB
> > lists another form which is in the implementation-reserved namespace:
> >=20
> > http://refspecs.linuxfoundation.org/LSB_3.1.0/LSB-Core-generic/LSB-Core=
-generic/baselib---getpagesize.html
> >=20
> > Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
>=20
> Looks good, please apply.

I pushed it myself to avoid a collision in version.h.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW+lYEAAoJEPU2Bp2uRE+ghdYP/R2tktgCSfWQMAvokMdJSDYn
eicuJtQbv9zwfkCJQT4JLDJQr4roMMLBGUH59x3SCEk4CBT0lfwr/Z7mksw07Vf+
x7e8tfuLmyu4xDwR/QvgvDPpFEwG8dVWOES4ssnHx06WpMwKNhFQglCFGENs92UO
a54Vz7Oj8y6x+lp+KaDUF6wLD7QPmjoQ6oXeoI/a5oEIzYWeBOR4VOQ34WeqC7EM
PD1vhikqmRHEnKGS0s/U3nlI3C/z6IxZpDrKcVU8dI7+g55kf/kgWueGduiZupC4
DwB00mzl5RyehxtCgF2VuzX61qfhoG95cMzOEWUz0UR1Yb5Z6aELgWenlKOPoq/g
iC2uga+6eY+uXZYJt3jEgBbMc34n0i0UyvI1D04TWSNj/FvzSH6NbWKE7DH7PDfk
7CBvmHUz5JGydN11/b1rq2aAmuLGxlQEWGvFodpoWsNz4YAzAE+QmwhbZdNvP30D
Hc7bAV9CX2EW8tFD9C+7anK1WPv4vuDsYA+0JVroX2G9cu7WNwiDURiWn2dM7rd1
ZfSSBnG0N+CNDFdZziC67/R1szvwNd6KETEI0A1DmfM4nXsIcDjokfYLvWpiEkag
w3V9TAWtPVpgoP7JhUd0wK2pdljh/8RsMlCTCK43Ed6049uKgm0NJHZ//rUTBo2c
on7xYsglva2NTXXh4uhx
=MFmn
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
