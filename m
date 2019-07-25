Return-Path: <cygwin-patches-return-9525-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23516 invoked by alias); 25 Jul 2019 13:37:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23506 invoked by uid 89); 25 Jul 2019 13:37:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-113.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:22d165b, H*i:sk:22d165b
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 25 Jul 2019 13:37:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mspu2-1ifBBb0bPc-00tCds; Thu, 25 Jul 2019 15:37:31 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EAF30A8090E; Thu, 25 Jul 2019 15:37:29 +0200 (CEST)
Date: Thu, 25 Jul 2019 13:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>,	Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Fix the address of myself
Message-ID: <20190725133729.GB11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	Jon Turney <jon.turney@dronecode.org.uk>, cygwin-patches@cygwin.com
References: <20190724162524.5604-1-corinna-cygwin@cygwin.com> <20190724165447.28339-1-corinna-cygwin@cygwin.com> <22d165b6-2b4b-4e94-7bbf-77449b662e8a@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <22d165b6-2b4b-4e94-7bbf-77449b662e8a@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00045.txt.bz2


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2265

On Jul 24 19:11, Ken Brown wrote:
> On 7/24/2019 12:54 PM, Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> >=20
> > v2: rephrase commit message
> >=20
> > Introducing an independent Cygwin PID introduced a regression:
> >=20
> > The expectation is that the myself pinfo pointer always points to a
> > specific address right in front of the loaded Cygwin DLL.
> >=20
> > However, the independent Cygwin PID changes broke this.  To create
> > myself at the right address requires to call init with h0 set to
> > INVALID_HANDLE_VALUE or an existing address:
> >=20
> > void
> > pinfo::init (pid_t n, DWORD flag, HANDLE h0)
> > {
> >    [...]
> >    if (!h0 || myself.h)
> >      [...]
> >    else
> >      {
> >        shloc =3D SH_MYSELF;
> >        if (h0 =3D=3D INVALID_HANDLE_VALUE)       <-- !!!
> >          h0 =3D NULL;
> >      }
> >=20
> > The aforementioned commits changed that so h0 was always NULL, this way
> > creating myself at an arbitrary address.
> >=20
> > This patch makes sure to set the handle to INVALID_HANDLE_VALUE again
> > when creating a new process, so init knows that myself has to be created
> > in the right spot.  While at it, fix a potential uninitialized handle
> > value in child_info_spawn::handle_spawn.
> >=20
> > Fixes: b5e1003722cb ("Cygwin: processes: use dedicated Cygwin PID rathe=
r than Windows PID")
> > Fixes: 88605243a19b ("Cygwin: fix child getting another pid after spawn=
ve")
> > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> > ---
> >   winsup/cygwin/dcrt0.cc | 2 +-
> >   winsup/cygwin/pinfo.cc | 3 +--
> >   2 files changed, 2 insertions(+), 3 deletions(-)
> > [...]
>=20
> I'll be glad to take a close look at this as you asked.  But I'm not fami=
liar=20
> with this part of the code, so it will take me a little time.
>=20
> Ken

Thanks!  I accidentally pushed the patch a few minutes ago when I
was actually just planning to push the ndbm.h patch.  Anyway, I
took the opportunity to create new snapshots with all patches from
yesterday and today, so the getpgrp problems in GDB 8.1.1 and 8.2.1
should both be fixed there as well.

I'd still be glad if the two of you could check if my patch makes
sense as is.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl05sJkACgkQ9TYGna5E
T6Cw1g/9Gbo4pH6B7k8DGGsGsA4NwwPT5GXk8UkT/T+S3FKOzYHigeI7DTveM9se
SxxW9hH0x7sb30ZhdFbqik1pbDuch7zNjMYawp7R4XaiHlCjvOku3pF9Dxxk4y6U
nPFZ7fgEi19CG2SeFCdeoTe3kaE99/emcebUmA+UXgAElaG8WIYrPrS7SQnAtg4c
ZyuCjw5Ku1V15mHmaatT0CeTq/fFMpEe5rUO3mc90uTSPvDAfwNOk4pqHmjGIiaV
fc1Cd43I2gDfcZ8aKe2Vx5QWZQ9t1GBvA6JquhETTELup7RDT+agRRFov5JvAAyT
JpjowMUzgJ9B8GHUpzXw/y2fdfFSeE96/Yu3d0uOJMK9WnBebSlguhyiE5Nk8/Le
cKM5+IAcZgKuG6A3JnbSQ9SFm/333Z470RMBxAe7fg7F/ZyUoBhuHPk+DM5yH/PE
xIIltl0cZwMiPDQwl77ur8k2YFNf2BGOBCB2iYRZ3si0OWn95aKBJkhjH1XgdO23
O81Qg4PJbySzWofi4gMG72LjlyeOVbnRnAnD6x8dlpcgmnyJv2ds16VJPSVmtrzJ
XmoB+3URr4VdWt0QpTmPhW1UoVWAwVCd6ePZGhGgZeXJRGpXaaPISHjVMzdsX4QU
oEkbFc4yet9l6PTOYMb8quX7AWWvegNYquOroYUUhY/LEHffBJQ=
=0Fx6
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
