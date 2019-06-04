Return-Path: <cygwin-patches-return-9433-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33261 invoked by alias); 4 Jun 2019 07:42:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33252 invoked by uid 89); 4 Jun 2019 07:42:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Jun 2019 07:42:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MEUaQ-1hMVbv0Z6w-00G3iO; Tue, 04 Jun 2019 09:41:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5D602A8061B; Tue,  4 Jun 2019 09:41:36 +0200 (CEST)
Date: Tue, 04 Jun 2019 07:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ben <cygwin@wijen.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkdir: always check-for-existence
Message-ID: <20190604074136.GQ3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ben <cygwin@wijen.net>, cygwin-patches@cygwin.com
References: <60c1e83d-59f1-6b7a-80e8-05bf41cc6947@wijen.net> <20190603193414.GO3437@calimero.vinschen.de> <dff7bebf-9fee-462e-0b77-fced83963d29@wijen.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="bvgsfYmVhxWy/2TA"
Content-Disposition: inline
In-Reply-To: <dff7bebf-9fee-462e-0b77-fced83963d29@wijen.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00140.txt.bz2


--bvgsfYmVhxWy/2TA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1876

Hi Ben,

On Jun  3 22:07, Ben wrote:
> When creating a directory which already exists, NtCreateFile will correct=
ly
> return 'STATUS_OBJECT_NAME_COLLISION'.
>=20
> However when creating a directory and all its parents a normal use would
> be to start with mkdir(=E2=80=98/cygdrive/c=E2=80=99) which translates to=
 =E2=80=98C:\=E2=80=99 for which
> it'll
> instead return =E2=80=98STATUS_ACCESS_DENIED=E2=80=99.
>=20
> So we better check for existence prior to calling NtCreateFile.
> ---
> =C2=A0winsup/cygwin/dir.cc | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
> index f43eae461..b757851d5 100644
> --- a/winsup/cygwin/dir.cc
> +++ b/winsup/cygwin/dir.cc
> @@ -331,8 +331,10 @@ mkdir (const char *dir, mode_t mode)
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 debug_printf ("got %d error from build_fh=
_name", fh->error ());
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 set_errno (fh->error ());
> =C2=A0=C2=A0=C2=A0 =C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (fh->exists ())
> +=C2=A0=C2=A0 =C2=A0set_errno (EEXIST);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (has_dot_last_component (dir=
, true))
> -=C2=A0=C2=A0 =C2=A0set_errno (fh->exists () ? EEXIST : ENOENT);
> +=C2=A0=C2=A0 =C2=A0set_errno (ENOENT);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (!fh->mkdir (mode))
> =C2=A0=C2=A0=C2=A0 =C2=A0res =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delete fh;
>=20
> --=20
> 2.21.0

I was just trying to apply your patch but it fails to apply cleanly.
Can you please check your indentation?  The `else' lines are indented
more than the lines in between and TABs are missing.

Maybe your MUA breaks the output?  If all else fails, you could attach
your patch as plain/text attachement to your mail, usually that's left
alone by the MUA.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--bvgsfYmVhxWy/2TA
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz2ILAACgkQ9TYGna5E
T6DO0A//UgZgFDxoeZNvvbFnLxXY8kXPCulmLYDux2BffxXw7Bd8jZJWRmzbPC+T
DFLJWu4ntDrEN7pw6DxUyBZBdnd/kf+rqZjqcSq+yT+T6Sc6XpcRKV2yIpxnoNNx
vJGNbsveW2OzJgwG0N9VYz/xNmfbRZunjd9/7ZF/bJT3D77LPpCuudb2Pg3MU/Im
H1ManZQY0r2DZG9h6uv3IFbS0tv4nadlaEFjyY4r8dNX4EGxgIoI5T7Yb0ji4UOy
aS4fThhZBWfT1zQa7pPCZZBasbg8LsXUPqxLOf+ZXTxRozJBFqT0SSCFGG0Ow3vV
XEIQEST83H9p+RAMzb2EXgVXIkQaLKAX4qFnjU/nNMiRig177Aknrm6qazvtVtO5
b++HEOGyYe8yFxF7RGX/Vj1SdZcUmAUGcqgBwSk07AI/CTzwfVnaRh/7VOFYceGS
Lx9CqgqTdiB45yWpXUhfPb4uNPP3DlMGVnHtTcIKW25UAJMjLzx+/9bkKnC5MxtW
EzA2701JJt41vq/LtrwMFsd+mLrDByCxZH/1jWRoDfxMY+iMoLVl9oEpu04lBK0k
DxXroUya3HZFwri90M91AYkAPEAtdPsiENp7V6UrIx+1IMxEO7/AVeeBNZcI589F
0/6YUb9oOpYZ4OpBr/sbXreaNuJmn9LLW3Gkax2CoXdLqJyRURY=
=1HJo
-----END PGP SIGNATURE-----

--bvgsfYmVhxWy/2TA--
