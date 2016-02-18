Return-Path: <cygwin-patches-return-8331-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43088 invoked by alias); 18 Feb 2016 11:29:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43071 invoked by uid 89); 18 Feb 2016 11:29:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=Hx-languages-length:1164, H*R:U*cygwin-patches, H*F:U*corinna-cygwin, HX-Envelope-From:sk:corinna
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Feb 2016 11:29:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3760DA803FA; Thu, 18 Feb 2016 12:29:23 +0100 (CET)
Date: Thu, 18 Feb 2016 11:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: gprof profiling of multi-threaded Cygwin programs
Message-ID: <20160218112923.GE8575@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C404FF.502@maxrnd.com> <56C5A401.8060604@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
In-Reply-To: <56C5A401.8060604@dronecode.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00037.txt.bz2


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1164

On Feb 18 10:59, Jon Turney wrote:
>=20
> Thanks for this.
>=20
> On 17/02/2016 05:28, Mark Geisert wrote:
> >There is a behavioral change that ought to be documented somewhere:  If
> >a gmon.out file exists when a profiled application exits, the app will
> >now dump its profiling info into another file gmon.outXXXXXX where
> >mkstemp() replaces the Xs with random alphanumerics.  I added this
> >functionality to allow a profiled program to fork() yet retain profiling
> >info for both parent and child.  The old behavior was to simply
> >overwrite any existing gmon.out file.
>=20
> Did you consider making the filename deterministic (e.g. based on pid or
> such) rather than random?
>=20
> With a random filename, if you have a process which forks more than once,
> working out which gmon.out* file corresponds to which process could be
> tricky.
>=20
> A brief search tells me that apparently glibc supports the (undocumented)
> GMON_OUT_PREFIX env var which enables a similar behaviour.

Good point.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxasTAAoJEPU2Bp2uRE+g02IP+wYTiV2WyGtYKqqf5VIhRNag
rVKNKthIDzY80ELpUQt4bPV1KnSU+6aErl40dJcWP1LL2qRvCH9paVe/GBot/rbQ
ojF5GspyM7pf4hT5tzR2iCjnQrUB1yziuqE4mArpUKUI3jhFZqkK086P5llkpJrp
+0826em0ckdpmNVrXd4V/0C8Sk3ZIDMh0F2dSFJq4cFd3NiwwHs07eCW+rFz8cro
qhcbyjaM54yPMt3TWCJ9E7jZUwhVvCgdgG7PQY8cwlC1+KE+WdsBrA9yfzmp6pNw
/2FGyD0qvaI0FesNo/2Y3CeTS75DWKck9dFd8Pcc4syTZ/t9G39+gcvAbRAT/AvH
qDrKu0Shj/sEL+LL9uUFBolTigz3sKX3UX4QB4tNOnT16pBxhXJIjjrsgHnCV/KE
E8pbxDBPUuF6UI4OXkae4CzqbFa68f2TYXiWbXALCb85LljTlhdkzIsPeCIibC7A
bpsLPbESMCTn3tpA7yKeXST9Ajv4aAmBeuNUUgQq8W4FKQ9zBCn/kLTJAOK4+6ZS
xt+CnOpZ4G9t0u0HmO5XmkTK125TwjW+SE7cqoed/zuWBWpfY9oHmhcgubgxhjPf
wg/rlj5bvm1dX3GQwmeSX3bSSHH2JcchJBRqNGcg5ufDNzOTlrYduS38m0tBRjhG
h07eGIrCsoGXPs+k0HqC
=rMN7
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
