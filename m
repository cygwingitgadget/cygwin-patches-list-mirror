Return-Path: <cygwin-patches-return-4409-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3963 invoked by alias); 17 Nov 2003 11:31:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3939 invoked from network); 17 Nov 2003 11:31:34 -0000
Subject: Re: thunking, the next step
From: Robert Collins <rbcollins@cygwin.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
In-Reply-To: <20031117112126.GE18706@cygbert.vinschen.de>
References: <3FB4C443.2040301@cygwin.com>
	 <20031114155716.GA16485@redhat.com> <1068832363.1109.101.camel@localhost>
	 <20031114191010.GA22870@redhat.com>
	 <20031117112126.GE18706@cygbert.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2LDp2N87JZI+vdyGUuDp"
Message-Id: <1069068688.2287.219.camel@localhost>
Mime-Version: 1.0
Date: Mon, 17 Nov 2003 11:31:00 -0000
X-SW-Source: 2003-q4/txt/msg00128.txt.bz2


--=-2LDp2N87JZI+vdyGUuDp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1509

On Mon, 2003-11-17 at 22:21, Corinna Vinschen wrote:

> This would require a decision only on the first time
> a function is called.=20

There's more to it than that. you MUST NOT hand the A series call longer
paths than MAX_PATH, they /really/ don't like it. And, structures like
the FindNext* details change in definition when UNICODE is defined. I
was trying to avoid all that complexity, which is significant, by
staying in a thunk approach.

> Also we would need a fairly big change to path_conv.  It would have to
> create the POSIX path in ascii on 9x and in wide char on NT.  If the
> path name creation is done in wide char directly, we neither need a
> strlen, nor an explicit conversion from ascii to wide char.

I agree that moving a lot of the logic into path_conv would be a good
idea. This is orthogonal to whether we use :

> I think this method is preferable over the IOThunkState technique since
> it will have more or less no speed impact.  It also has the advantage,
> that the Cygwin code doesn't have to use all new function calls like
> "create_file" instead of using the "real" Win32 function calls directly.

I decided against redefining the 'real' calls because I figured some
areas may want to use the 'real' calls directly, and only the
auto-adjusting parts of cygwin should have the ansi/wide dichotomy.
There is some interesting reading on the issues in the win32 unicode
layer for win9x systems on msdn.

Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-2LDp2N87JZI+vdyGUuDp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/uLGPI5+kQ8LJcoIRAicHAKDR5BKdcqqVHcqJl/e7UpfVPdRAXgCePe1g
QY9G3ZMW8XBslEBF4JtBuQQ=
=Wlc2
-----END PGP SIGNATURE-----

--=-2LDp2N87JZI+vdyGUuDp--
