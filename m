Return-Path: <cygwin-patches-return-4405-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29341 invoked by alias); 15 Nov 2003 22:11:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29300 invoked from network); 15 Nov 2003 22:11:36 -0000
Subject: Re: The increased path length changes
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Ron Parker <rdparker@butlermfg.com>
In-Reply-To: <20031115214637.GA6196@redhat.com>
References: <3FB4D81C.6010808@cygwin.com> <20031115170458.GA3376@redhat.com>
	 <1068928581.1109.135.camel@localhost>  <20031115214637.GA6196@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZpQndS46vLhaqNJFDz1y"
Message-Id: <1068934284.1109.200.camel@localhost>
Mime-Version: 1.0
Date: Sat, 15 Nov 2003 22:11:00 -0000
X-SW-Source: 2003-q4/txt/msg00124.txt.bz2


--=-ZpQndS46vLhaqNJFDz1y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 2096

On Sun, 2003-11-16 at 08:46, Christopher Faylor wrote:
> On Sun, Nov 16, 2003 at 07:36:21AM +1100, Robert Collins wrote:
> >...Ron claims said assignment is in place...
>=20
> I have no record of an assignment so if there is an assignment, it
> predates me.  I don't see any changes in the ChangeLog which would
> indicate the need for an assignment prior to this either.
>=20
> I believe that Ron did work on the original version of the Cygwin
> installer but that did not require an assignment.

Ah. Ron - do you have a copy of the assignment that was sent in? While
much of your patches are self-evident/mechanical, the unicode diff is
probably non trivial enough to require a copyright assignment from you,
even after it's been transformed on the way through.

Chris, The work I've been putting up is based on a set of patches Ron
sent me. I suspect that 03 may cause (c) issues. What do you think?:

> Here are 5 patches against cygwin 1.5.5-1:
>=20
> 01-add-cygwin-create-file.diff.gz
>         Adds cygwin_create_file and changes all CreateFile references
>  to use it.
>=20
> 02-add-cygwin-create-directory.diff.gz
>         Ditto for cygwin_create_directory.

these two are mechanical: simple search in replace, with the new thunks
one line calls to the original function.=20
=20
> 03-use-unicode.diff.gz
>         Implement calling CreateFileW and CreateDirectoryW for all
>  local file system files using the "\\?\" prefix.

This patch formed the basis for my development of IOThunkState. It was a
pair of 25 line functions replacements to the two thunks previously
introduced, which I refactored into IOThunkState to allow more code
reuse.

> 04-maxpath.diff.gz
>         Raise MAXPATH from 260 to 4096.

This was purely mechanical.

> xx-diagnostics.diff.gz
>         Diagnostic code for createfile.cc that I used when necessary.=20
>  It is even commented out in the diff.

This isn't being submitted at this point (it creates a log file with the
translated unicode text which is of no use outside testing).

Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-ZpQndS46vLhaqNJFDz1y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/tqSMI5+kQ8LJcoIRAtcPAJ4yPt9no+9/jRaAVN9XO1+yF3D6TQCfXnh0
QBIBI89VLJLpmJx2aHKqk90=
=Gu0s
-----END PGP SIGNATURE-----

--=-ZpQndS46vLhaqNJFDz1y--
