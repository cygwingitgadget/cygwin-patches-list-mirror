Return-Path: <cygwin-patches-return-4377-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31890 invoked by alias); 14 Nov 2003 13:17:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31871 invoked from network); 14 Nov 2003 13:17:19 -0000
Subject: Re: thunk createDirectory and createFile calls
From: Robert Collins <rbcollins@cygwin.com>
To: Max Bowsher <maxb@ukf.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <050601c3aaaf$cbe72df0$78d96f83@starfruit>
References: <3FB4A341.5070101@cygwin.com>
	 <20031114101815.GU18706@cygbert.vinschen.de> <3FB4AE07.6010101@cygwin.com>
	 <041701c3aaa4$db725ed0$78d96f83@starfruit> <3FB4C321.6030507@cygwin.com>
	 <04e701c3aaad$b42fee10$78d96f83@starfruit> <3FB4D118.8030802@cygwin.com>
	 <050601c3aaaf$cbe72df0$78d96f83@starfruit>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ExHtAIaUOw1Sn6Y+VFYY"
Message-Id: <1068815832.1109.91.camel@localhost>
Mime-Version: 1.0
Date: Fri, 14 Nov 2003 13:17:00 -0000
X-SW-Source: 2003-q4/txt/msg00096.txt.bz2


--=-ExHtAIaUOw1Sn6Y+VFYY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 826

On Sat, 2003-11-15 at 00:04, Max Bowsher wrote:
> >
> http://msdn.microsoft.com/library/default.asp?url=3D/library/en-us/fileio=
/base/createfile.asp
> >
> > Look at the grey box :}.
>=20
> Exactly. CreateFile takes LPCTSTR - but you are calling CreateFileA, which
> takes LPCSTR.
>=20
> Granted, LPCTSTR =3D=3D LPCSTR when UNICODE is not defined - but if you a=
re
> relying on that, you don't need to bother with the "A" suffix on the
> function, either.

Ah, I'll look this up tomorrow. For now, I've done the change to not use
MAX_PATH throughout cygwin, and I've broken something. So, I'm figuring
out why :[. That said, I don't plan to rely on UNICODE not being
defined: this code should be the same no matter what options are passed.
Rob

--=20
GPG key available at: <http://members.aardvark.net.au/lifeless/keys.txt>.

--=-ExHtAIaUOw1Sn6Y+VFYY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/tNXXI5+kQ8LJcoIRAkrtAJ4hM1CT4lPDSt/IXq7ceSvpGvOr8wCgjCMT
HL4cDkbG+iIV9noPAoNaKmg=
=FZEW
-----END PGP SIGNATURE-----

--=-ExHtAIaUOw1Sn6Y+VFYY--
