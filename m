Return-Path: <cygwin-patches-return-3222-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29992 invoked by alias); 24 Nov 2002 13:55:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29983 invoked from network); 24 Nov 2002 13:55:56 -0000
Subject: Re: [PATCH] Patch for MTinterface
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0211221554320.379-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0211221554320.379-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+x3vT69pbiQ+Rpib3Hds"
Date: Sun, 24 Nov 2002 05:55:00 -0000
Message-Id: <1038142635.23476.74.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q4/txt/msg00173.txt.bz2


--=-+x3vT69pbiQ+Rpib3Hds
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1215

On Sat, 2002-11-23 at 01:55, Thomas Pfaff wrote:
>=20
>=20
> On Tue, 5 Nov 2002, Robert Collins wrote:
>=20
> > Overall this looks good. What happens to non-cygwinapi created threads
> > now though? You mention you don't agree with the code, but I can't see
> > (from a brief look) how you correct it.
> >
> > BTW: I'm currently packing to move house, so don't expect much feedback
> > until late next week, or early the week after :[.
> >
>=20
> Ping

Pong. I've added the test cases to the test suite. In future please
follow the guidelines in testsuite/readme for test behaviour - running
$ ./testname || echo foo
should echo foo on failures - and neither of your test cases did that
initially.

Also, the initMainThread behaviour:
initMainThread (bool dosomething)
{
if (!dosomething)
  return;
...

I don't like. I'd rather we not call initMainThread than call it with a
boolean as above.

If dosomething was internal to the pthread class, so that initMainThread
became:
initMainThread()
{
  if (!dosomething)
    return;
...

I'd have no issue.

Anyway, thanks again for excellent work, and the patch has been
committed.

Rob

--=20
---
GPG key available at: http://users.bigpond.net.au/robertc/keys.txt.
---

--=-+x3vT69pbiQ+Rpib3Hds
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA94MypI5+kQ8LJcoIRAtLbAJsEcKMf95pflildCooDPox7SABoDwCdF8gj
NdJSBsen3+WLT7Hq4EchVUw=
=mdwp
-----END PGP SIGNATURE-----

--=-+x3vT69pbiQ+Rpib3Hds--
