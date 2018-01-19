Return-Path: <cygwin-patches-return-9012-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118865 invoked by alias); 19 Jan 2018 19:04:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 118839 invoked by uid 89); 19 Jan 2018 19:04:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-106.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:2859
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 19:04:53 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id B423F721E280C	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 20:04:49 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 398FA5E0380	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 20:04:49 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 24557A807E5; Fri, 19 Jan 2018 20:04:49 +0100 (CET)
Date: Fri, 19 Jan 2018 19:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/3] catgets APIs, gencat tool
Message-ID: <20180119190449.GM18814@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180119055837.13016-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
Content-Disposition: inline
In-Reply-To: <20180119055837.13016-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00020.txt.bz2


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3052

On Jan 18 23:58, Yaakov Selkowitz wrote:
> This adds FreeBSD-derived implementations to replace the glibc-derived
> standalone implementation shipped in the catgets package. An integrated
> implementation avoids the need to remember to install libcatgets-devel and
> modify the build to link with -lcatgets.
>=20
> The easiest way to test this is:
>=20
> 1) Uninstall catgets and libcatgets-devel.
> 2) Install Cygwin rebuilt with this patch, particularly the DLL, nl_types=
.h,
> libcygwin.a, and gencat.exe
> 3) Rebuild tcsh.  The following should be seen during configure:
>=20
> checking for gencat... /usr/bin/gencat
> [snip]
> checking for library containing catgets... none required
>=20
> And the resulting binary should show catclose/catgets/catopen imports from
> cygwin1.dll, not cyggetcats1.dll.
> 4) Install this tcsh, then run an invalid command, e.g.:
>=20
> $ LANG=3Dfr_FR tcsh  -c '()'
> Commande nulle incorrecte.
>=20
> Yaakov Selkowitz (3):
>   Guard langinfo.h nl_item from multiple typedefs
>   cygwin: add catopen, catgets, catclose
>   cygwin: add gencat tool
>=20
>  newlib/libc/include/langinfo.h         |   3 +
>  winsup/cygwin/Makefile.in              |   1 +
>  winsup/cygwin/common.din               |   3 +
>  winsup/cygwin/include/cygwin/version.h |   3 +-
>  winsup/cygwin/include/nl_types.h       | 100 +++++
>  winsup/cygwin/libc/msgcat.c            | 478 ++++++++++++++++++++++
>  winsup/utils/Makefile.in               |   2 +-
>  winsup/utils/gencat.c                  | 696 +++++++++++++++++++++++++++=
++++++
>  8 files changed, 1284 insertions(+), 2 deletions(-)
>  create mode 100644 winsup/cygwin/include/nl_types.h
>  create mode 100644 winsup/cygwin/libc/msgcat.c
>  create mode 100644 winsup/utils/gencat.c
>=20
> --=20
> 2.15.1

Patch is fine, but I'd prefer if the whitespace problems are fixed
first, even if they are from upstream:

  Applying: Guard langinfo.h nl_item from multiple typedefs
  Applying: cygwin: add catopen, catgets, catclose
  .git/rebase-apply/patch:268: space before tab in indent.
					  np->name =3D strdup(n);			\
  .git/rebase-apply/patch:275: space before tab in indent.
					  SLIST_INSERT_HEAD(&cache, np, list);	\
  warning: 2 lines add whitespace errors.
  Applying: cygwin: add gencat tool
  .git/rebase-apply/patch:52: trailing whitespace.
   * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUT=
ORS
  .git/rebase-apply/patch:337: trailing whitespace.
	  }
  warning: 2 lines add whitespace errors.
  Applying: cygwin: update docs for 2.10.0
  .git/rebase-apply/patch:21: trailing whitespace.
  - Built-in implementation of _FORTIFY_SOURCE guards for functions in
  .git/rebase-apply/patch:74: trailing whitespace.
  Built-in implementation of _FORTIFY_SOURCE guards for functions in
  warning: 2 lines add whitespace errors.

Are you going to provide a catgets deprecation package?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlpiQVAACgkQ9TYGna5E
T6Cbfg//aL917qrBXJ/3AfuH/yvlwB08x4vk3U280PHbqjjT1BZbyeyjMJUaESlZ
sxOKJYJDjBcImCp5u6G3oa0SxjgKA+qwi5ndm3oTmjUhcFBessTOS+/S9CVe32D+
Bt7bjOQwKuYhKLUtGDmaW3fl/9Do+CkWHmohkaxKzOVc74GnQRQIdZhlJTcxTgRc
oh2zuMjAZTxeAqDeFnR3wS2lVaCbmAPEpvTrxd8cDs0ycX/ksfr6YE62f4l3VDpq
BOhTQsa4QBJUeliuZ1kldOkZ9zdKlZ7xJlKX47LOUWmK0yvLC6wMKBxiAasmxpfa
BWSAlZn6iBDtoqzVgTDNejxi4TnmYH3o1r9aRalmMFL/1YHamCkzNCp+3ElcxFqF
9qU5at5h+QXrCqfau53YEKAM/y+llWFWGvkxELCrGgV2+Atoupsux+av6xaJ652M
yM5glnWvxFm9BQtE9OPFDH6nqItnMbamvPX3Isegy3XI6xIpwydQm0jSJ2Ysk9Zr
XGVgXKGyLgg6XyXLQ7b9jcX1xFzsISxSVCKp0XHcUxCIh9Z1wBSo+8NVMikjn9n4
5CRrLTNPvWnDnYNB/krNWIYoTGIYwsXSv+6ycHYE6YVOM4kyvOgzSpk7Sx7g3p+h
N+uoH4OS4LEVxebRfBHOIWtJYM7Fdu63hOHxgncSouOWfxOFPrw=
=0ltf
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--
