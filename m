Return-Path: <cygwin-patches-return-4403-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21640 invoked by alias); 15 Nov 2003 20:36:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21624 invoked from network); 15 Nov 2003 20:36:24 -0000
Subject: Re: The increased path length changes
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20031115170458.GA3376@redhat.com>
References: <3FB4D81C.6010808@cygwin.com> <20031115170458.GA3376@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m9w1eICoUp8TOzqKFZkH"
Message-Id: <1068928581.1109.135.camel@localhost>
Mime-Version: 1.0
Date: Sat, 15 Nov 2003 20:36:00 -0000
X-SW-Source: 2003-q4/txt/msg00122.txt.bz2


--=-m9w1eICoUp8TOzqKFZkH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1576

On Sun, 2003-11-16 at 04:04, Christopher Faylor wrote:
> Btw, I am wondering a few things about these patches.
>=20
> 1) Does Ron Parker have an assignment on file with Red Hat?  I can't
> find one, if so.  This will be a requirement if the patches are
> accepted.  The mechanical change that was just checked in is ok but
> any more substantial changes will need an assignment.

Here is a fragment of our discussion (in the list which happens to need
such long path support) about cygwin & assignments:
http://mail.gnu.org/archive/html/gnu-arch-users/2003-09/msg01390.html
http://mail.gnu.org/archive/html/gnu-arch-users/2003-09/msg01399.html

In the second Ron claims said assignment is in place...

> 2) Why is one of the files you're submitting copyrighted to Robert Collins
> and Ron Parker?  What's up with that?  Technically, I suppose I shouldn't
> even be looking at the file.  I guess it's lucky that I only had time
> to look at the copyright statement.

It's copyright both because both of us have written substantial parts of
it. Ron got the ball rolling and I started sheparding it through: adding
the needed things such as inlining, the factored IOThunkState conversion
and the like. I'm out of the habit of creating new cygwin files though,
and very much in the habit of working on unassigned GPL code where you
simply add new copyrights once you make substantial changes..... it's
coming back to me as I type:
=20=20=20
 that file should be (c) RedHat, 'Written by Ron & Rob' - right?

Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-m9w1eICoUp8TOzqKFZkH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/to5FI5+kQ8LJcoIRAh71AKCtbHAHLvhvOYO+AhNR/qtTUGa+sgCfSt4V
lUTa62Byth776DUXfPhqpfE=
=T4Dq
-----END PGP SIGNATURE-----

--=-m9w1eICoUp8TOzqKFZkH--
