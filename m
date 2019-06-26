Return-Path: <cygwin-patches-return-9469-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98232 invoked by alias); 26 Jun 2019 09:27:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98223 invoked by uid 89); 26 Jun 2019 09:27:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-117.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=suddenly
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Jun 2019 09:27:48 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M6VRf-1hdZF21WVV-006tdI for <cygwin-patches@cygwin.com>; Wed, 26 Jun 2019 11:27:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9DC36A807CF; Wed, 26 Jun 2019 11:27:44 +0200 (CEST)
Date: Wed, 26 Jun 2019 09:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Build cygwin-console-helper with correct compiler
Message-ID: <20190626092744.GT5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190625075441.1209-1-mark@maxrnd.com> <20190625112703.GH5738@calimero.vinschen.de> <e820c2e7-074c-f285-ec37-22ef18f12ff4@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Content-Disposition: inline
In-Reply-To: <e820c2e7-074c-f285-ec37-22ef18f12ff4@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00176.txt.bz2


--yaap9KN+GmBP785v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3174

On Jun 26 01:48, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > On Jun 25 00:54, Mark Geisert wrote:
> > > ---
> > >   winsup/utils/Makefile.in | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
> > > index b64f457e7..cebf39572 100644
> > > --- a/winsup/utils/Makefile.in
> > > +++ b/winsup/utils/Makefile.in
> > > @@ -64,7 +64,7 @@ MINGW_BINS :=3D ${addsuffix .exe,cygcheck cygwin-co=
nsole-helper ldh strace}
> > >   # List all objects to be compiled in MinGW mode.  Any object not on=
 this
> > >   # list will will be compiled in Cygwin mode implicitly, so there is=
 no
> > >   # need for a CYGWIN_OBJS.
> > > -MINGW_OBJS :=3D bloda.o cygcheck.o dump_setup.o ldh.o path.o strace.o
> > > +MINGW_OBJS :=3D bloda.o cygcheck.o cygwin-console-helper.o dump_setu=
p.o ldh.o path.o strace.o
> > >   MINGW_LDFLAGS:=3D-static
> > >   CYGCHECK_OBJS:=3Dcygcheck.o bloda.o path.o dump_setup.o
> > > --=20
> > > 2.21.0
> >=20
> > Careful!  This leads to a warning when building on 64 bit:
> >=20
> >    cygwin-console-helper.cc: In function 'int main(int, char**)':
> >    cygwin-console-helper.cc:8:48: warning: cast to pointer from integer=
 of different size [-Wint-to-pointer-cast]
> >     HANDLE h =3D (HANDLE) strtoul (argv[1], &end, 0);
> >                                                  ^
> >    cygwin-console-helper.cc:10:41: warning: cast to pointer from intege=
r of different size [-Wint-to-pointer-cast]
> >     h =3D (HANDLE) strtoul (argv[2], &end, 0);
> >                                           ^
> >=20
> > Note that strtoul returns an unsigned long.  Mingw compiles
> > for native Windows, which is LLP64 rather than LP64:
> >=20
> >    mingw:sizeof(long) =3D=3D 4
> >    cygwin:sizeof(long) =3D=3D 8
> >=20
> > This needs fixing as well (use strtoull).
>=20
> I appreciate the comments.  These warnings have "always" been present.

I don't see any warning in terms of building cygwin-console-helper in=20
the current state.  However, it suddenly occured to me that, even without
a warning, this was always wrong.  The compiler generates code for 8 byte
long and the linker links against libs expecting 4 byte longs.

The fact that this works is ... not exactly magic, but first, the
arguments and return values are in registers anyway, and second, HANDLEs
are only using the lower 4 bytes even though they are 8 bytes in size.

> I didn't make clear the reason for this one-line patch to Makefile.in: A
> 'make -j 6' over the Cygwin source tree would sometimes fail because the
> link step for cygwin-console-helper uses a different gcc than the compile
> step did in parallel builds.

Huh, really?  I'm building with make -j42 on a 32 core machine, but I
never saw this problem.

>   Can you accept this patch as-is for what it
> does for builds?

Yes, we can do that, but it might be a good idea to order the patches
so that the *first* patch fixes the actual problem in cygwin-console-helper
and the *second* patch fixes the Makefile.  Consider this patch approved,
I just wait for the other one, ok?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0TOpAACgkQ9TYGna5E
T6CnZA/+IlB3rFD70QPZJKU5hDS+SN26nTkLdHJowd3BYaokWYdsmf/vyZHhwQU9
hxVVzzSzCxTPUXgWve8twIw1bWM/7TKOHnWv8XrFKZrsK6obQQXSRSvX4ynLneh8
V8aM73X3zfH8GOVNbKXqb3ef6UAunmQFCE315/IO11nClF233WAM160ZDL3gaES7
5egYGJh46lR8oeVp+XJLgrgggsY8Dplx862EuFf361c5SqS1b7q14URyNa6UaNuf
7vQq2OscSnopqM8WoeG86TMghtBxS1i1OhK2pJEswPj+IfJm5n+rQntIRH1PNlpA
Wx//FQ/n89c4+SVZKWwjvz8yQm2UGz8xogNRSK3Al1Zxspjj03MnN6EivoqsrTuA
QVc/C/HTiekIrYpltv2gzXNZAhmccsBuBjbpcM1DoMgx43QT2sbITPmjS3xczP21
LVTrqDytFWeF5xmRat4X5otPqvdEnbmEMIEDlynQWSTc8/xZFYZDPk6zxZ+CuqEi
16atDkRvnmtnNgwOVM9AQdKyA/Nd+ew9sPqmmZy2EFJQtklBEZEjaGcbbCvmp2Qi
6df7d1IGe3MvJl7CCCIbHJo3XQD/limqHVCbc1JBpVU+8tLd1SGWomd5MRNMS0BW
jEBx1mgJ3UwJhCTYaM7UCv/pjKpO7Qq1ztsurKaGqHt7aqVLDbU=
=GOSx
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--
