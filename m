Return-Path: <cygwin-patches-return-7913-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29359 invoked by alias); 4 Dec 2013 11:36:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29339 invoked by uid 89); 4 Dec 2013 11:36:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,RDNS_NONE,URIBL_BLOCKED autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from Unknown (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Dec 2013 11:36:34 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3D01B1A0677; Wed,  4 Dec 2013 12:36:26 +0100 (CET)
Date: Wed, 04 Dec 2013 11:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
Message-ID: <20131204113626.GB29444@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52437121.1070507@redhat.com> <20131204093238.GA28314@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20131204093238.GA28314@calimero.vinschen.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q4/txt/msg00009.txt.bz2


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2380

On Dec  4 10:32, Corinna Vinschen wrote:
> Hi guys,
>=20
>=20
> I'm not quite sure yet *why* this happens, but this change in
> dtable::find_unused_handle...
>=20
> On Sep 25 17:26, Eric Blake wrote:
> > [...]
> > diff --git i/winsup/cygwin/dtable.cc w/winsup/cygwin/dtable.cc
> > index 2501a26..c2982a8 100644
> > --- i/winsup/cygwin/dtable.cc
> > +++ w/winsup/cygwin/dtable.cc
> > @@ -233,7 +233,7 @@ dtable::find_unused_handle (int start)
> >  	if (fds[i] =3D=3D NULL)
> >  	  return i;
> >      }
> > -  while (extend (NOFILE_INCR));
> > +  while (extend (MAX (NOFILE_INCR, start - size)));
> >    return -1;
> >  }
>=20
> ...introduced the problem reported in
> http://cygwin.com/ml/cygwin/2013-12/msg00072.html
>=20
> The problem is still present in the current sources.
>=20
> If I apply this change...
>=20
> Index: dtable.cc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
> retrieving revision 1.275
> diff -u -p -r1.275 dtable.cc
> --- dtable.cc	1 Dec 2013 19:17:56 -0000	1.275
> +++ dtable.cc	4 Dec 2013 09:26:01 -0000
> @@ -223,7 +223,8 @@ dtable::delete_archetype (fhandler_base=20
>  int
>  dtable::find_unused_handle (size_t start)
>  {
> -  size_t extendby =3D (start >=3D size) ? 1 + start - size : NOFILE_INCR;
> +  //size_t extendby =3D (start >=3D size) ? 1 + start - size : NOFILE_IN=
CR;
> +  size_t extendby =3D NOFILE_INCR;
>=20=20
>    /* This do loop should only ever execute twice. */
>    int res =3D -1;
>=20
>=20
> ..., which essentially reverts the original change from Eric, the
> problem is fixed.
>=20
> Off the top of my head I don't understand why Eric's as well as cgf's
> solution (which are not equivalent) both introduce this problem, but
> always using NOFILE_INCR works, so I publish it here for discussion.
>=20
> I'm off for a doc appointment now, maybe I have some clue while sitting
> in the anteroom.

Not really.  Btw., this helps to fix the problem as well:

  size_t extendby =3D (start >=3D size) ? MAX (1 + start - size, NOFILE_INC=
R)
				    : NOFILE_INCR;


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature
Content-length: 836

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSnxO6AAoJEPU2Bp2uRE+gb5cQAKWBXjo7411al/HL4oTdrIrO
izpbylqUHb4xPwdNbQiKtmK1g82j3J5wxk/VbZgTWPJCljpKbgL8vsUdCD2KUsAr
D1BFKZTglZZvCEPwhcZGzmXXftSjHqb0uXLv8o2hZAieQyabE80jpIJWZvvURWAQ
UXbe3Bvxdi7Y/65I8PkAhpwgdg1cTKbqyuNBeJb+LkE1hkcc1BgWSZ+4hTvx44RD
JHsFCzd3ZguMyyRGz6oQRxm7X+MUTqkU3N3eWY/OIHmx+2eEECjirH41saiwrlxi
kJ9+M68BpYk95gw+9qzjyzehMYV5bTIwA4p3wEiZjoW7RmZFGeYpLeuzutl+8HZr
jjK1Pk2g3gctWiJPPVFAT5f5FdhiEIArDUH8v8TCeVHea+U7xd1W8LeZjgDhwe9E
Jjxih4SGgtSI3HqWzLJzpKIMKTn5tHTQWoL/Db+XQTiflo9LLyoE3yO9eD9MwoEX
JHOgrFbyQ1vzLO0mk8sidGW7R+G7i8wCpGu9Nt0H5+4qJ/KV8v0u7HQ7VGLBMn4g
xKHmGJdgJVY+Bo7UupXAEbhR2R1LY+x5pxEH7lWTy4ixGEwzAMWGZYFyx3D8E9FB
R+fb4BFD9skA4BqrWyJEyxJiEozjDJLaChWp9lLaGr68iE7qQY5CLkZABKyBIxuP
ULXVFBHbnRrpNXYrVhZ8
=MLLB
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
