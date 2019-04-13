Return-Path: <cygwin-patches-return-9337-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86476 invoked by alias); 13 Apr 2019 08:20:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85923 invoked by uid 89); 13 Apr 2019 08:20:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, plug
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 13 Apr 2019 08:20:28 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Ml3ym-1gaPyQ0dP2-00lRXA for <cygwin-patches@cygwin.com>; Sat, 13 Apr 2019 10:20:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 379B8A8041F; Sat, 13 Apr 2019 10:20:25 +0200 (CEST)
Date: Sat, 13 Apr 2019 08:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190413082025.GG4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com> <20190401145658.GA6331@calimero.vinschen.de> <20190401155636.GN3337@calimero.vinschen.de> <837bc171-eb6f-681e-5167-103f5e9e8523@ssi-schaefer.com> <20190403122216.GX3337@calimero.vinschen.de> <20190412174031.GC4248@calimero.vinschen.de> <877ebyxs8i.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TSQPSNmi3T91JED+"
Content-Disposition: inline
In-Reply-To: <877ebyxs8i.fsf@Rainer.invalid>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00044.txt.bz2


--TSQPSNmi3T91JED+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1587

On Apr 13 09:46, Achim Gratz wrote:
> Corinna Vinschen writes:
> > Nick Clifton, one of the binutils maintainers, made the following
> > suggestion in PM:
> >
> > Allow the ld flag --enable-auto-image-base to take a filename as
> > argument.
> >
> > The idea: The file is used by ld to generate the start address
> > for the next built DLL.  Mechanism:
> >
> > 1.1. If ld links a DLL and if the file given to --enable-auto-image-base
> >      doesn't exist, ld will give the DLL the start address of the
> >      auto image base range.
> >
> > 1.2: Next time, if ld links a DLL and if the file given to
> >      --enable-auto-image-base exists, it will use the address in that
> >      file as the start address for th just built DLL.
> >
> > 2. It will store that address, plus the size of the DLL, rounded up to
> >    64K, in that file.
> >
> > 3. If the auto image base range is at an end, ld will wrap back to
> >    the start address of the auto image base range.
>=20
> Sounds OK if the goal is just to avoid collisions, but it would really
> be nicer if there was some way to plug this together with the rebase
> database from the start.

No, that's contrary to the idea.  The solution should be self-sufficient
within binutils.  We don't want to add any reliance to external tools.

The linker uses a DLL address space which does not collide with rebased
DLLs in 64 bit, so this only occurs during developement, and none of the
built DLLs can collide with system DLLs.  I do not much care for 32 bit,
it's a lost case anyway.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--TSQPSNmi3T91JED+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyxm8kACgkQ9TYGna5E
T6AO0A//a7DwQS6bRpCzP+/hyg/vJ3veNypW0pXBSQ7gz3BE99L7PGqRzT5IWUFf
DoUs5/4Ppun92BcOtvL1Nbs2/fRZydmqCEWTfH+nQ7et+TbxwqT+vfWxy72r/tNa
2QrOKG6L7tFyu8kI8QBRZXMZVvR6tgNah3/z3Dcc/jPmDBnTN1848X3vO3yUiAg1
mpnWWc4QlmtFGfDUqnk1/J7GjdnigBh0DviF32DCJnl+RDVUinqUHf2eSKTJFBVA
JUGuyIFntd+2etxQddLRYfi5Xt0sGQ2cJSAdUAU1b4NhhTCHOTgIb1phkZ58Lw5y
X5VeIVArJWDyhl6rAH3NckkIckzPvg0YdSj2KA9/CEH1nqjj4ilGLppM4/D8D1Ad
0Ui3STN7JLjcLj3otmQ2YM55z87CiUmJUgzAwjWAoJ3p1XCjAkoyJzM8sbHdM9vd
vi4c0TKgoYv0NZqbYGgDxHKPmxxC4wWlFd1Y+8cDiZzKcJXiDvbSY4aPc/Gaw02e
sbcDvoAua06VmeNdA5KqL4jXZMtLAXlGyNdlhaKYqDCXtOjJ/JT1Oe1Z95Ba6oTb
3jxEY+l481BryOk/u9Qn7pKXZOOHa8AH4wrbgjsRawtVbRm4KlOIPDOelvZEmBoq
Ob+C4VbBW7ptyAlSpqiPZKdWs97gK/v9GcY3As8HafXnnlM7XVE=
=seRJ
-----END PGP SIGNATURE-----

--TSQPSNmi3T91JED+--
