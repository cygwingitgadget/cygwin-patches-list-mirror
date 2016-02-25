Return-Path: <cygwin-patches-return-8358-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117061 invoked by alias); 25 Feb 2016 09:09:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117019 invoked by uid 89); 25 Feb 2016 09:09:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=Geisert, geisert, tied, profiling
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 25 Feb 2016 09:09:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6F013A805F5; Thu, 25 Feb 2016 10:09:09 +0100 (CET)
Date: Thu, 25 Feb 2016 09:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
Message-ID: <20160225090909.GA27880@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C820D8.4010203@maxrnd.com> <56CAF4A3.5060806@dronecode.org.uk> <Pine.BSF.4.63.1602222322100.88046@m0.truegem.net> <20160223111423.GB5618@calimero.vinschen.de> <Pine.BSF.4.63.1602250040380.66582@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1602250040380.66582@m0.truegem.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00064.txt.bz2


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1923

On Feb 25 00:47, Mark Geisert wrote:
> On Tue, 23 Feb 2016, Corinna Vinschen wrote:
> >On Feb 22 23:36, Mark Geisert wrote:
> >>On Mon, 22 Feb 2016, Jon Turney wrote:
> >>>There doesn't seem to be anything specific to profiling about this, so=
 it
> >>>could be written in a more generic way, as "call a callback function f=
or
> >>>each thread".
> >>
> >>I saw your later conversation with Corinna on the list re why
> >>cygwin_internal() is involved now.  (I too had stumbled over the
> >>cygwin1.dll/libgmon.a gap when I started this work.)  Given the necessi=
ty of
> >>the separation, does it still make sense to write a generic per-thread
> >>callback mechanism and then make use of it for this patch, or is that
> >>overkill?  I can't tell.
> >
> >One problem with a generic solution is to generalize the arguments to
> >the called function.  IMHO, keep it as is for now.  If we ever need to
> >make this generic we can still do it.
>=20
> OK.
>=20
> >>>>+	if ((prefix =3D getenv("GMON_OUT_PREFIX")) !=3D NULL) {
> >>>
> >>>setup-env.xml might be an appropriate place to mention this environment
> >>>variable.
> >>
> >>I am now writing a gprof.xml that will be tied into the existing
> >>programming.xml.  I plan to document GMON_OUT_PREFIX in gprof.xml.  Do =
you
> >>think that's sufficient?
> >
> >A single paragraph in setup-env.xml pointing to gprof.xml might be
> >helpful, I think.
>=20
> Alright, I can do that as part of the separate doc patch that I'm working.
>=20
> I ran into an issue while testing the profiling of programs that fork() b=
ut
> don't exec().  So it may be a short while before I can send ver 3. Just F=
YI.

Ok, no worries.  If you want to discuss something, we also have the
#cygwin-developers IRC channel on freenode.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzsS1AAoJEPU2Bp2uRE+gSawQAIqz0wWqkr/L9Pt0P+lCJG9r
nqFARSwQf4jtzbxHjrio9ujF+XGYe4hoA7w5xYL6qIOHNcUjZOxcF0a3g5JFTRE2
BMQGiyfOdP6cnbuQdKYnQ4I0Ufc0oxm8G/OPKQBeQ72B2nK0UO9dfFCUGmM0mIIz
Mc/i4x6kgEJ16SDklrqfd4U3YKHDYOIZgw3jx81EQhvWFNVhS7XqfwM+SyUgr1OW
khtyQhO0BQqlQiFf8ibvQyFe/ZuJ+evWUOyXBQjZvyPUwIBsCVv4/4LEQT+U2pFl
mJ6Gztk1cjPY9hciTlTtJhtDBsPJbDWetKCcytyz7hPMbfmjEBSRnazJHNoL/MKC
2adqN3WiAtKhcuF7yUdZtZ+xyv3C25VvEungUpP/awy2Xjv0HbE+TI9MmUH6gSZU
neYIOPgPSvbwxrXTgpMtonXgSYtc34B66/ExRU98LFCQaL7kgCVCl0FFLJj8VlXi
IZi+ERQuKOcrfJJDIfwE3wV7uegwx7SKDhcZPfsOhgHZQkt1JwKvlTMDQ7CNUh00
ebhf6bWLX8zV9qqotqjbXTgxu9hoN6MCPoEcmNMKuyPsjmE7SiCrE42XfxWn5EL0
F8JY8ymhXPFCqLCpXyTWy4QBEWSMqkUo0544pfncMoLhfRe8ta/01yZjkN0fHpwd
tN5xxeBJloxv/4A+/iyO
=Duht
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
