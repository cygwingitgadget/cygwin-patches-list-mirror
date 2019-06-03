Return-Path: <cygwin-patches-return-9427-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48885 invoked by alias); 3 Jun 2019 19:35:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48870 invoked by uid 89); 3 Jun 2019 19:35:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-102.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 19:34:59 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MkHEH-1grvG22UcD-00khSq; Mon, 03 Jun 2019 21:34:15 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CEF89A80612; Mon,  3 Jun 2019 21:34:14 +0200 (CEST)
Date: Mon, 03 Jun 2019 19:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ben <cygwin@wijen.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkdir: alway check-for-existence
Message-ID: <20190603193414.GO3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ben <cygwin@wijen.net>, cygwin-patches@cygwin.com
References: <60c1e83d-59f1-6b7a-80e8-05bf41cc6947@wijen.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Content-Disposition: inline
In-Reply-To: <60c1e83d-59f1-6b7a-80e8-05bf41cc6947@wijen.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00134.txt.bz2


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1401

Hi Ben,

I'm fine with the patch, and it's short enough not to require an entry
in the CONTRIBUTORS file, but the commit msg needs some rephrasing:

On Jun  3 20:31, Ben wrote:
> When using either CreateDirectory or NtCreateFile when creating a directo=
ry
> that already exists, these functions return: ERROR_ALREADY_EXISTS

The Win32 and NT error codes don't match, so I'd prefer to drop
CreateDirectory from the text and use the NT status code names,
STATUS_OBJECT_NAME_COLLISION and STATUS_ACCESS_DENIED.

> However when using these function to create a directory (and all its
> parents)
> a normal use would be to start with mkdir(=E2=80=98/c=E2=80=99) which tra=
nslates to =E2=80=98C:\=E2=80=99

mkdir('/c') has no meaning by default.  The text should refer to the
default path "/cygdrive/c".

> for which both of these functions return =E2=80=98ERROR_ACCESS_DENIED=E2=
=80=99
>=20
> We could call NtCreateFile with 'FILE_OPEN_IF' instead of 'FILE_CREATE' b=
ut
> since that's an internal function we better always check for existence
> ourselves.

Not sure what you're trying to say here.  In how far would using
FILE_OPEN_IF help?  AFAICS it would just erroneously return
STATUS_SUCCESS, so fhandler_disk_file::mkdir would have to check
io.Information for FILE_OPENED or something like that.  Maybe this
paragraph can just go away?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz1djYACgkQ9TYGna5E
T6CAYw//fR0M0N2YIOrPNSHgweG5s0IDZGr0B4mM6pecTaeyHhoDsWUMOcK6QTn7
Gd2nGsL3llSMSDGZXfbBFbS9rO5FcIDuKXDuZ/km6++QmJvKgJNhxkIK/KcJ1EmM
pglnoa9RszhA7/8BqKmd4oZCnBq53gmilU3UB8Mb3Wxv9JotMdz9tkWC0amjby9u
kMdb1OAuB77yyXEGr7E/FF5B1gnhoYTi3feU36pm2iDULGXj0xnzCoSzVPQ8xyN3
GmaDu/7lP770Qa4wFXQ6lpzAjimPzzkjUYZmjpVWL5ic9NAnmHzJr/OkOgxLGMpd
KxQWeO1Ce84hzXZibo7vgwq7NK9BS3xmtwVzKYgwKXVDW6NxnuKdF13/TlL5S2Ur
1DHFUIXdQ7EAJCbJAeildEbW796OXgLg5gwQdYXbCLJlMW6n9Ptzi/f1r0kQ/DJp
9rJBTvh6DMtu0+b4xcmpC29WMoDBWfxJN0TGIxOeGj9KbYM/+zdEhiPP0EDTHmVM
hFFQNp6mvGnLPfj2vziHQcCPeGnnCqIX8i4N7CuQpSzg6amHUrSOFCGj97nd/jKJ
6cLEk0i05/9rOwEEQwgyLkKbo93YgnVc8P3BhnsFIyqvb1BMHsHSx4rJ0BZAdpDm
QjcovMwmQhz0cp/xAWyPLUWKrjlbsQ7NoydUU+l/kYWaV9bbWrU=
=6zSD
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--
