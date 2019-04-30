Return-Path: <cygwin-patches-return-9397-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65834 invoked by alias); 30 Apr 2019 16:38:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65819 invoked by uid 89); 30 Apr 2019 16:38:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, letter, fbi
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Apr 2019 16:38:16 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N0WwO-1gaGlW0s44-00wXCR for <cygwin-patches@cygwin.com>; Tue, 30 Apr 2019 18:38:14 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8847AA8078C; Tue, 30 Apr 2019 18:38:13 +0200 (CEST)
Date: Tue, 30 Apr 2019 16:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: dll_list: drop FILE_BASIC_INFORMATION
Message-ID: <20190430163813.GU3383@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6166ec52-cb38-cd01-8f76-5b3500c0f3a9@ssi-schaefer.com> <20190430161317.GN3383@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline
In-Reply-To: <20190430161317.GN3383@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00104.txt.bz2


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1436

On Apr 30 18:13, Corinna Vinschen wrote:
> On Apr 30 16:14, Michael Haubenwallner wrote:
> > Querying FILE_BASIC_INFORMATION is needless since using win pid+threadid
> > for forkables dirname rather than newest last write time.
> > ---
> >  winsup/cygwin/dll_init.cc | 1 -
> >  winsup/cygwin/dll_init.h  | 1 -
> >  winsup/cygwin/forkable.cc | 7 +++----
> >  3 files changed, 3 insertions(+), 6 deletions(-)
> > [...]
> > -  if (!dll_list::read_fii (fhandle, &d->fii) ||
> > -      !dll_list::read_fbi (fhandle, &d->fbi))
>=20
> Given this is the only place calling dll_list::read_fbi, the method
> and declaration should be removed, too.
>=20
> > +  if (!dll_list::read_fii (fhandle, &d->fii))
> >      system_printf ("WARNING: Unable to read real file attributes for %=
W",
> >  		   pmsi1->SectionFileName.Buffer);
> >=20=20
> >    NtClose (fhandle);
> > -  return d->fbi.FileAttributes !=3D INVALID_FILE_ATTRIBUTES;
> > +  return d->fii.IndexNumber.QuadPart !=3D -1LL;
> >  }
> >=20=20
> >  /* easy use of NtOpenFile */
> > --=20
> > 2.19.2

I pushed this patch series as is now, but I have two requests:

- Please send a followup patch to remove the unused method.

- When sending patchsets, would you mind to send them with cover letter
  per `git format-patch --cover-letter'?  It's not a hard requirement,
  but it makes discussing single patches vs. patchsets clearer.

Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlzIefUACgkQ9TYGna5E
T6Cegg//QIdxcm+PyLdjnvqEWxFpP6n0UJS19u/wWWUO+D442pU2rd4ACd9aE79O
smN66IpIffWoNRWrrEPR8qx29QarJvO7SvNW8Ae+TaPWGXIYWN3HBJIPvHQLCS2W
2hysl2gWbzUDXb1qrP6fETdqSIjw2rIiOBT+t7AlxHnozQEX3AqUO1QwYnSMiPM1
IERFjuiA3esUneqLMxBRT8hRYLqOBvtvuHylMiKuQi3GvPR2jWeMRAoHjiYba7vc
2fRxo1iYzeFW0PqVJ0LD7POPK7gvZ4Mn3L9NISXjpJehEqac6BCaUzekxLqs6Ifl
JzaQl5UkNnm47uskKdeIZ19E2H+stZAmkOByemKZgA+j+7NS0NEfPqqFYHSXaWRV
q1xKeBpewLEMqf5cN6uaWHyNWhPgxZtfkJHtnQqSI4+pg48ZXie8QUoNCmvXWmYK
mWrN3pQlyudA7DVpUIKy/RhCcasRcBB/x3IHhGPO6cegQSGfbfOuUkqsR4K+O/Ur
C2RVqq3a1rrkiO80ahGmTnzH3OFiI9jRsr/J/EBpWXyE25fN38iXXC8NK615wGQo
fTnXJHQzFdTaHaXBGGqJLB7BnhycmHwPuo7tD2CFVrRPtc4SeI6YIIP9Zp1WpLTx
2rAUSF/T5HZpRiTzW1lvm9dMYC9K4V2m5wzLRGWogetpsBNaErg=
=mvS9
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--
