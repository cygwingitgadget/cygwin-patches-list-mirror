Return-Path: <cygwin-patches-return-8013-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23912 invoked by alias); 4 Aug 2014 19:51:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23895 invoked by uid 89); 4 Aug 2014 19:51:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Aug 2014 19:51:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 50B4C8E0773; Mon,  4 Aug 2014 21:51:02 +0200 (CEST)
Date: Mon, 04 Aug 2014 19:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: docs: improve package maintainer instructions
Message-ID: <20140804195102.GA23439@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53DCE738.3090406@redhat.com> <1407117639.2942.3.camel@yselkowitz.redhat.com> <20140804091439.GE2578@calimero.vinschen.de> <53DFDEDC.1000305@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <53DFDEDC.1000305@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q3/txt/msg00008.txt.bz2


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1834

On Aug  4 13:28, Eric Blake wrote:
> On 08/04/2014 03:14 AM, Corinna Vinschen wrote:
>=20
> > I'm fine with the changes, barring Yaakov's nits.
>=20
> I fixed those.
>=20
> >=20
> > However, while we're at it shouldn't we change from "cygport is the
> > accepted way to make Cygwin packages" to "cygport is the required way to
> > make new Cygwin packages and the (strongly) recommended way for package
> > updates"?  I for one think it's time to switch to a single packaging
> > method.  After all, you don't have rpm packages in Debian or apt
> > packages in Fedora.  This will also greatly simplify to set up an
> > automated build system for Cygwin packages at one point.
>=20
> Agreed; so here's what I added in before pushing my patch:
>=20
> @@ -283,9 +288,12 @@ etc...
>    <li>Ensure that your package handles being installed on binary and
> text mounts correctly. </li>
>  </ul>
>=20
> -<p>While you could make a package satisfying these requirements by
> hand, the
> -accepted way to make Cygwin packages is using the cygport tool, which
> -automatically handles most of the above issues for you.</p>
> +<p>While older packages exist which satisfy these requirements by hand, =
the
> +only accepted way to make a new Cygwin package is using the cygport
> tool, which
> +automatically handles most of the above issues for you.  It is also
> +strongly recommended to convert existing packages to cygport when
> +updating them; ask on the <tt>cygwin-apps</tt> list if you need help
> +converting an existing package to use cygport.</p>
>=20
>  <h2><a id=3D"making_srcpackage" name=3D"making_srcpackage">Making a pack=
age
> with cygport</a></h2>

Sounds good!



Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT3+QmAAoJEPU2Bp2uRE+gdq4P/RlwlTRSi9fwg66zDECTixq9
b3ODwwHqkYQg+RNaWkzp3QNIJqn77uwM87T8y98o2E01BF77JHILBrcZxY6bZojI
VUQ/CwkFGwikaRcWARcfwwjXFsVc7E0+hVsxj9i/wmvqoR0OywonipiFIpSqxM71
9QSgSHTwM9T4X0gfsYtxldklUYU1z5Yxo+jRcubM8pPskGfXBcqPQ51PmwFBgLb6
ZOQ7xmQpH9ik83EjaidkgtbiWqqkLayny5k2Yr0UAPrX15t91fQQXs2T0xXxQYTI
R1hhHEI2nd8tlaZ1BjOwjrf/N5PorIwv8jsTEG45J6Uc1pHoo27qLyfvNzMk/2CJ
joU3gG8BH+6B9W0lsPlhSJJwd6LwNNejzFiazG+CbmRbdbhrgSoQP/cQaqbK9bo5
UjGcLYhvOhGyKUYCAdHYXMaejHku8v3PDbXZp+pk0UOabPtCziX8q6CkBweFCmep
sk/7HiVxUzLM3dVgMrxgCkX4In4uTi5j1ZYfjMVmD6gqNUENXsXrvB7CCM3LdIuy
htRL82uV3CF3Q1OoBHY8S72abN7F4XY8Fw3rs8JfxVc09WwRfvAZiPOqbTWeHhST
oW1AAV70wfNX05ELpinTAe6RWGDS7SuPKA4VBehG3VUngBRXlRcm7roP2QkBPqil
OF+Grgv8DOYlFJ/tFVSC
=4hXh
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
