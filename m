Return-Path: <cygwin-patches-return-4435-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30424 invoked by alias); 21 Nov 2003 12:23:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30414 invoked from network); 21 Nov 2003 12:23:03 -0000
Subject: Re: thunking, the next step
From: Robert Collins <rbcollins@cygwin.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
In-Reply-To: <20031121110223.GB8815@cygbert.vinschen.de>
References: <3FB4C443.2040301@cygwin.com>
	 <20031114155716.GA16485@redhat.com> <1068832363.1109.101.camel@localhost>
	 <20031114191010.GA22870@redhat.com>
	 <20031117112126.GE18706@cygbert.vinschen.de>
	 <1069068688.2287.219.camel@localhost>
	 <20031117120229.GH18706@cygbert.vinschen.de>
	 <1069361541.1117.42.camel@localhost>
	 <20031121110223.GB8815@cygbert.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I5HU30A64qyZc3uxDc8W"
Message-Id: <1069417379.18254.76.camel@localhost>
Mime-Version: 1.0
Date: Fri, 21 Nov 2003 12:23:00 -0000
X-SW-Source: 2003-q4/txt/msg00154.txt.bz2


--=-I5HU30A64qyZc3uxDc8W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1720

On Fri, 2003-11-21 at 22:02, Corinna Vinschen wrote:
> >=20
> > Ok. Well for now, I'm going to leave the thunks in place, until / if
> > they become nothing more than if (unicode) ...W() else A(). That said,
> > all the calls we are thunking require kernel mode transitions, so I
> > really don't believe that the thunking will add any overhead on it's
> > own: the context switch going into kernel will obliterate the much
> > smaller overhead of checking which call we want to make.
>=20
> I don't think so.  You can't take the kernel into account, really, since
> it spends its time either case.

Well, thats irrelevant anyway. I've already committed to moving the
duplication of tests out of the call path.

> Anyway, *sic* I don't like the thunking.  It's fairly intrusive to the
> code.  It adds another complexity level to a lot of functions which seems
> pretty unnecessary.  It also adds a lot of decisions which are made on
> runtime over and over again, even though actually it would be sufficient
> from a logical level to make this decision once.  Or at least only once
> per Win32 function call.=20=20

Those decisions can live elsewhere - see above. For now, it provides me
a clean way to tell what has been fixed, and what not - and to insert
tracing and debugging statements at *one* place in the code (per win32
function) rather than at multiple places.

> Btw., what does "thunk" mean literally?  While I know its meaning in the
> software context, I can't find a simple translation.  I looked up three
> dictionaries to no avail.

http://www.jargon.8hz.com/jargon_35.html  - see thunk, and meaning 3 is
what I've been using.

Rob

--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-I5HU30A64qyZc3uxDc8W
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/vgOiI5+kQ8LJcoIRAgIDAJ9fWpQeYo6d2aeqkxIJWoDV5mMFlQCgqd3I
+9LmyDvz2GWnhJF8sqH0SYQ=
=b28D
-----END PGP SIGNATURE-----

--=-I5HU30A64qyZc3uxDc8W--
