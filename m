Return-Path: <cygwin-patches-return-3742-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26662 invoked by alias); 23 Mar 2003 01:02:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26650 invoked from network); 23 Mar 2003 01:02:17 -0000
Subject: Re: Patched doc/setup-net.sgml
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
In-Reply-To: <Pine.GSO.4.44.0303221949580.561-100000@slinky.cs.nyu.edu>
References: <Pine.GSO.4.44.0303221949580.561-100000@slinky.cs.nyu.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HtHx4+lVJSsaXT6M7EU7"
Organization: 
Message-Id: <1048381334.905.69.camel@localhost>
Mime-Version: 1.0
Date: Sun, 23 Mar 2003 01:02:00 -0000
X-SW-Source: 2003-q1/txt/msg00391.txt.bz2


--=-HtHx4+lVJSsaXT6M7EU7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1990

On Sun, 2003-03-23 at 11:55, Igor Pechtchanski wrote:
> On 23 Mar 2003, Robert Collins wrote:
>=20
> > [snip]
> > * For most users, the Direct Connection method of downloading is the
> > best choice.
> >
> > IMO the IE5 method is best. I've been considering making it the default.
> > The IE5 method will leverage your IE5 cache and or organisational proxy
> > server for performance. It will also honour browser auto-configuration
> > scripts.
>=20
> This doesn't work for me.  I'm still trying to figure out why, but since
> the possibility is there, better err on the side of caution.

Mouse button scrolling doesn't work for some users. We don't disable it
for them. Setup was failing to setup ntsec just recently, but we didn't
err on caution there. I see no reason to err on caution here,
particularly when the benefits are huge.

> > * setup.ini
> > setup actually downloads setup.bz2 these days, setup.ini is a suported
> > legacy config file. I don't know if you want to mention that or not.
>=20
> It's stored locally as setup.ini, though, isn't it?

In setups *private*, just to *change without notice* local package dir
yes. User programs MUST NOT consider whats there canonical unless the
authors sit on this list and track as setup changes. It's certainly not
something to tell folk about during the installation!

> > [snip]
> > * packages are divided into categories
> > you might want to say 'grouped into', or 'categorized by'. divided into
> > could suggest literal division of individual packages to a non english
> > reader - i.e. /bin files go into the foo package :].
>=20
> How about "Packages are assigned categories, and one package may belong to
> multiple categories".

Also good. Possibly we need a more user orientated flavour..
"Packages are grouped into categories by the author, and can be found
under any of those categories in the 'categories' hierarchical chooser
view"  ?

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-HtHx4+lVJSsaXT6M7EU7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+fQeWI5+kQ8LJcoIRAt+6AKDLphqrV8WZmiIgd82lRB+o5yOWPgCbBzN2
N2etiExgi6iJE4ppbRgjypE=
=LID9
-----END PGP SIGNATURE-----

--=-HtHx4+lVJSsaXT6M7EU7--
