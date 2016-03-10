Return-Path: <cygwin-patches-return-8388-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32546 invoked by alias); 10 Mar 2016 19:48:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32534 invoked by uid 89); 10 Mar 2016 19:48:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-93.9 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, Maintainer, Geisert, geisert
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 10 Mar 2016 19:48:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 93FA8A805E1; Thu, 10 Mar 2016 20:48:54 +0100 (CET)
Date: Thu, 10 Mar 2016 19:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Support profiling of multi-threaded apps.
Message-ID: <20160310194854.GA3666@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56DFE128.6080308@maxrnd.com> <20160309224400.GA13258@calimero.vinschen.de> <Pine.BSF.4.63.1603091646490.69685@m0.truegem.net> <56E131C6.5080008@maxrnd.com> <20160310093933.GD13258@calimero.vinschen.de> <20160310094053.GE13258@calimero.vinschen.de> <Pine.BSF.4.63.1603101048110.25541@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1603101048110.25541@m0.truegem.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00094.txt.bz2


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1937

On Mar 10 11:11, Mark Geisert wrote:
> On Thu, 10 Mar 2016, Corinna Vinschen wrote:
> >On Mar 10 10:39, Corinna Vinschen wrote:
> >>On Mar 10 00:35, Mark Geisert wrote:
> >>>This is Version 4 incorporating review comments of Version 3.  This is=
 just
> >>>the code patch; a separate doc patch is forthcoming.
> >>
> >>Uhm...
> >>
> >>>+		long divisor =3D 1000*1000*1000; // covers positive pid_t values
> >>
> >>...still "long"?
> >>
> >>Was that an oversight or did you decide to keep it a long?  Either way,
> >>no reason to resend another patch version.  If you want an int32_t here,
> >>I fix that locally before pushing the patch.
>=20
> Oversight.  Now corrected like this in my local repository:
>=20
> -               long divisor =3D 1000*1000*1000; // covers positive pid_t=
 values
> +               int32_t divisor =3D 1000*1000*1000; // covers +ve pid_t v=
alues
>=20
> Hopefully this mailer won't fold those two lines.
>=20
> >
> >Oh, btw., do you have a sentence or two for the release text?  Just
> >a short description what's new or changed or fixed.  Have a look at
> >winsup/cygwin/release/2.5.0 for an informal howto.
>=20
> What's new:
> -----------
>=20
> - Environment variable GMON_OUT_PREFIX enables multiple gmon.out files to
>   preserve profiling data after fork or from multiple program runs.
>=20
> What changed:
> -------------
>=20
> - Profiling data, specifically pc sampling, now covers all threads of a
>   program and not just the main thread.
>=20
>=20
> OK with me if you prefer both sentences in one category or the other.  I
> hope to have the doc patch ready in the next day or two.
> Thanks,

Thanks to you!  I applied the patch and a slightly rearranged version of
the release message to the release file and the documentation.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4c+mAAoJEPU2Bp2uRE+gKqgP/0nLGtpME8oMsOyVXplh0nTy
+4y535vxNUBKHeXHp5XN//VaxTAVn7OZqzzz8O6D2E+vkzpq+MpjyI+3PnUyidd3
suzsRgcSns3wect1Q6wz3MkBgm+gAMPcDDNZiwwdYSUSS8NMYbolAsygf4dUUzUp
2W1+ki/mi5oA+vY4Ol9jRhpjmSDc1DJ4YJfl8YhIWy9DYl8SkiO9SUcXB2OSgzzP
IignGcBE7mqWnTYDRhAT1VwMsg0G9bcZVlQ/KsVfx2d+awl3HiXhcnfAWlcg9zj6
o6s1eLeQZzH+vXbdjvKQmvMRL9ASFH2g3BIsfxw0xZ7wLdy8qzyWbzbQURvRD518
rTlM5OreXDx9WjGQOO4ek0rZ1OmKrLV/pL9u7i3o+/PbxODpq+CqBZX7dcevQ9AV
X/4J+xO1PUOk0JT54PCBURScCTS/ITUKOedJE6IoRs8TuzJRtv7AjXcX+/Gz2Qff
LhJINwvqiqS+wp9JertAZJzg8Uknc6IV0g9eelCRNw5yRgY7BA5PdAksZMALLHPC
hNXkNG//VgD9veBpHJiauuMUogo7K4eDBjuslS9CQPFVMtFdsMYIicY9liRaUk+E
I9UENPi9uwatDlJHM7+QTq87TkECMwPjxmH3MwtWQHJiPCcdc+6+GDundeFuKrEH
Kbk70TG8v9USkJ9KpjG5
=JqY9
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
