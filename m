Return-Path: <cygwin-patches-return-8178-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37684 invoked by alias); 16 Jun 2015 17:49:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37674 invoked by uid 89); 16 Jun 2015 17:49:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jun 2015 17:49:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ABDA4A807DA; Tue, 16 Jun 2015 19:49:33 +0200 (CEST)
Date: Tue, 16 Jun 2015 17:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/8] winsup/doc: Convert utils.xml to using refentry
Message-ID: <20150616174933.GG31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-6-git-send-email-jon.turney@dronecode.org.uk> <20150615171147.GE26901@calimero.vinschen.de> <557FEC25.8030303@dronecode.org.uk> <20150616094501.GC31537@calimero.vinschen.de> <558003FD.8060208@dronecode.org.uk> <20150616124934.GD31537@calimero.vinschen.de> <55805DF6.5040004@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="USQ0BwiCE5W4XvtQ"
Content-Disposition: inline
In-Reply-To: <55805DF6.5040004@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00079.txt.bz2


--USQ0BwiCE5W4XvtQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1806

On Jun 16 18:33, Jon TURNEY wrote:
> On 16/06/2015 13:49, Corinna Vinschen wrote:
> >On Jun 16 12:09, Jon TURNEY wrote:
> >>On 16/06/2015 10:45, Corinna Vinschen wrote:
> >>>On Jun 16 10:28, Jon TURNEY wrote:
> >>>>On 15/06/2015 18:11, Corinna Vinschen wrote:
> >>>>>On Jun 15 13:36, Jon TURNEY wrote:
> >>>>>>Convert utils.xml from using a sect2 to using a refentry for each u=
tility
> >>>>>>program.
> >>>>>>
> >>>>>>Unfortunately, using refentry seems to tickle a bug in dblatex when=
 generating
> >>>>>>pdf, which appears to not escape \ properly in the latex for refent=
ry, so use
> >>>>>>fop instead.
> >>>>>
> >>>>>Uhm... wasn't Yaakov's patch from 2014-11-28 explicitely meant to dr=
op
> >>>>>the requirement to use fop andd thus java?
> >>>>>
> >>>>>Is there really no other way to handle that, rather than reverting to
> >>>>>fop?
> >>>>
> >>>>Now I try again --with-dblatex, it works fine, so that part of the pa=
tch can
> >>>>be removed.
> >>>>
> >>>>I can only guess I must have had some other markup error causing me
> >>>>problems, which has since been fixed.
> >>>
> >>>I'm relieved :}
> >>
> >>Approved with that change?
> >
> >Yep, thanks.
>=20
> Done.
>=20
> Note that the next time you build documentation for the website, you might
> need to take some special steps to add new .html files.

-v, please?

> and next time you build a package you might need to take some special ste=
ps
> to exclude /usr/share/man/

What special steps?  I assume a `make install' will install the
additional man pages now.  Wouldn't it make sense to install them as
part of the Cygwin package then, rather than as part of cygwin-doc?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--USQ0BwiCE5W4XvtQ
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgGGtAAoJEPU2Bp2uRE+goAMP/1TjeNJnR3exczsyiheKbV8N
peATrQuLcrKVwVy3D7MBr1Aqg8t84AZmD9FokbbjhJX/N9JXT/781QbO2Pd6jnQ7
Hhgva3GvCriLWsY9w01FMBfUSK9nbEVRh9wI44LY0u5Oq6Q/qTM/fVdt7HTD4kvE
HBw4eOAxwXyaqSYjVcd+lEqGWm8l6KWRazPB+XuvKG2iJa0k2VtbZpw3Gae1/lmj
En/w+jkHmEQaNwBbNcHEV+mz6mGKKfS/q4inkilAAjzB4YPFbd7hBhsbBKiKL8Qg
3AhPKhEYlfCq8Tw6yAAsgH8XzKDAKRh0UC8iv4+L3Lwoa/GdN8cR0IM5WTVTHkky
t9RcKweBEVb7rr0QFKv/PY3o8C+Ulae4B1oWkRq19f810PbmhYWty2T1p48v2VrR
rbR7263JCTUPXXBD6NIYIaMfOJpw7a2sJsk+oTzZpWoDP7KGA/u6H8o7Y4bqsmma
RenVemK6YAF5tK5yritEZxz+jECNDKlBmQXMevwk4SBYzUltT8lqyjNx+RIkMwDp
kQWeKgRpYBWHcRcrx3B4OwIXvWkvTmWfr27uI84Qcc5JEUWurc2RpiGQzSKpOGAL
SkYYWF1PWr3HIOCTjl1j9QjeqeleXBQowIbFKTy4/Sct331AWwz2B6xicHbriW+a
6DBFiNYXwH0WLVR1cBu9
=SWT6
-----END PGP SIGNATURE-----

--USQ0BwiCE5W4XvtQ--
