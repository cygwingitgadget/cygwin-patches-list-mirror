Return-Path: <cygwin-patches-return-9264-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 94115 invoked by alias); 28 Mar 2019 20:13:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 94106 invoked by uid 89); 28 Mar 2019 20:13:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 20:13:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MfYHQ-1gTwyz3vWC-00g3Ji for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 21:13:17 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4CF68A80534; Thu, 28 Mar 2019 21:13:17 +0100 (CET)
Date: Thu, 28 Mar 2019 20:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Message-ID: <20190328201317.GZ4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190325230556.2219-1-kbrown@cornell.edu> <20190326083620.GI3471@calimero.vinschen.de> <1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu> <20190326190136.GC4096@calimero.vinschen.de> <20190327133059.GG4096@calimero.vinschen.de> <87k1gi3mle.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yEbVe0JFHWhrOjGA"
Content-Disposition: inline
In-Reply-To: <87k1gi3mle.fsf@Rainer.invalid>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00074.txt.bz2


--yEbVe0JFHWhrOjGA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1114

On Mar 28 19:01, Achim Gratz wrote:
> Corinna Vinschen writes:
> > Done.  I also pushed out new dev snapshots.
>=20
> No good deed goes unpunished=E2=80=A6
>=20
> Whith the 20190327 snapshot our main data processing application is
> broken.  It looks like it should almost work, it doesn't crash or
> anything, but the pipe that delivers a script+data into gnuplot seems to
> either skip or overwrite data and then gnuplot bails with a syntax
> error.  Depending on exactly which data I try to plot I get the first or
> first few plots out through the whole processing pipe (that ends in a
> PDF file), albeit sometimes with incomplete data.  Doing each of the
> steps manually (i.e. writing the gnuplot script into a file, then feed
> that into gnuplot, then the output from gnuplot inth ghostscript) does
> work correctly.  I have not yet been able to reduce this down to some
> simpler test case, so I had to roll back to the previous snapshot.  I
> still have it installed on the development system, though.

I'm pretty sure Ken would be happy about an STC.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--yEbVe0JFHWhrOjGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlydKt0ACgkQ9TYGna5E
T6BbSw//YlSSYSgWi0U3w82/2DaDPKW5Ix4pkj9SqKHjGAFV2PM1+g97BAhQdGog
y+B+jBVZyIlgxM6dhbXBWoyIbGn0BW0Dbpb0lMIX9chO1PhxFFCAqD+6/mYRq0hZ
qH4CBXB6P6pvemiXXSk9Xxvw6APtx7LPyA6TUyFsof93anRyDAnGOLzj+OMemEaA
i1i+Yt453VBF/pRucOdJNEFX2dncZBC/aXs6s7+1bZDSoDn5VzJgOFk5g8teWomJ
bZg/cikvMfdqYrLUjqIJI1sTCTl34MilRRvkKBQGbqD1LlCkjxVeaVGyTRBoVg7y
k1Gk1+etBUd/2XrU5/b99dQGuZTfzitVJ+inOpeqEuj35V4oloygMLd/2oz7MOce
MLnQDZDFac+rZLhhbq5h+yTe03Xtml8egUGmAOC9hvGVUzG8qdncRJA+NrnBWnPf
Lg28CgG+PbqCanDCeqB5wRJAoyw+uJExw2i/cYhOTBj3i5hl7HV0uT34E+kq/YU2
nrvpMQtKwlANCMzAeS2JCU13cQl2jolE84whZy1aGoGExDVTeLErrA+Ile6d5PQ4
peI6Sax72+BTorY+Vsn8l9ioR8WYe9e5AGNiQLZbtWOy8HdEObWLQTMIMdKhBSxi
b1KVvAZxrb4T+8Q1E4tTOsZh1Y67+XGlKqHPNR8fyZ4smnoi3Xk=
=JdtH
-----END PGP SIGNATURE-----

--yEbVe0JFHWhrOjGA--
