Return-Path: <cygwin-patches-return-4059-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21498 invoked by alias); 9 Aug 2003 21:50:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21451 invoked from network); 9 Aug 2003 21:50:33 -0000
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20030809161211.GB9514@redhat.com>
References: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu>
	 <20030809161211.GB9514@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-r0CDEEdBNNvLzEN8YBcn"
Message-Id: <1060465841.1475.34.camel@localhost>
Mime-Version: 1.0
Date: Sat, 09 Aug 2003 21:50:00 -0000
X-SW-Source: 2003-q3/txt/msg00075.txt.bz2


--=-r0CDEEdBNNvLzEN8YBcn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 734

On Sun, 2003-08-10 at 02:12, Christopher Faylor wrote:
> On Thu, Aug 07, 2003 at 06:50:10PM -0400, Igor Pechtchanski wrote:
> >Hi,
> >

> Also some kind of functionality which would allow cygcheck to query
> the same files as the web search would be really cool.  Something like
> a:
>=20
> cygcheck --whatprovides /usr/bin/ls.exe
>=20
> would be really useful.


Hmm, I think we're getting into stuff that setup should do itself. We
-do- have command line functionality...


> Another interesting thing would be to do some ntsec/mkpasswd/mkgroup
> type sanity checks or even to fix up common ntsec problems.

That sounds good for cygcheck.

Cheers,
Rob
--=20
GPG key available at: <http://members.aardvark.net.au/lifeless/keys.txt>.

--=-r0CDEEdBNNvLzEN8YBcn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/NWyxI5+kQ8LJcoIRAlpUAJ99IG0En4VlXMGd2Ogz8XTSqmuamACgrP+U
cG5T4Mz8dZ46bq+eyVmEKig=
=UqSv
-----END PGP SIGNATURE-----

--=-r0CDEEdBNNvLzEN8YBcn--
