Return-Path: <cygwin-patches-return-4065-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11766 invoked by alias); 10 Aug 2003 00:23:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11757 invoked from network); 10 Aug 2003 00:23:28 -0000
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20030810001228.GB13380@redhat.com>
References: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu>
	 <20030809161211.GB9514@redhat.com> <1060465841.1475.34.camel@localhost>
	 <20030810001228.GB13380@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-deVRaDHmCNJO7xiTiWKO"
Message-Id: <1060475027.12270.49.camel@localhost>
Mime-Version: 1.0
Date: Sun, 10 Aug 2003 00:23:00 -0000
X-SW-Source: 2003-q3/txt/msg00081.txt.bz2


--=-deVRaDHmCNJO7xiTiWKO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 658

On Sun, 2003-08-10 at 10:12, Christopher Faylor wrote:


> I don't see how that will ever be possible given the windows problems with
> stdio and GUI apps.  I guess we could make setup a console utility but
> that would result in the ugly black console box flashing up whenever
> you start setup.exe.

I was thinking of something like 'cygsetup' a console only version.
cygcheck could then call that for the setup-related stuff it does now,
and these extra features.

We still have teasing apart of the GUI and logic components to finish
before this becomes easy to do...


Rob
--=20
GPG key available at: <http://members.aardvark.net.au/lifeless/keys.txt>.

--=-deVRaDHmCNJO7xiTiWKO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/NZCTI5+kQ8LJcoIRAhyLAKC+VXNqAt9XtufBVOfAdHki2tx4uACeOOc1
Q7XWKVd6bpanVEWo7xStrPw=
=k7XD
-----END PGP SIGNATURE-----

--=-deVRaDHmCNJO7xiTiWKO--
