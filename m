Return-Path: <cygwin-patches-return-8703-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30298 invoked by alias); 28 Feb 2017 15:23:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30255 invoked by uid 89); 28 Feb 2017 15:23:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=cable, Hx-languages-length:1752, snip, personal
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Feb 2017 15:23:39 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 9B9E2721E2822	for <cygwin-patches@cygwin.com>; Tue, 28 Feb 2017 16:23:35 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 0C3435E046F	for <cygwin-patches@cygwin.com>; Tue, 28 Feb 2017 16:23:35 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E788EA8039B; Tue, 28 Feb 2017 16:23:34 +0100 (CET)
Date: Tue, 28 Feb 2017 15:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Preserve order of dlopen'd modules in dll_list::topsort
Message-ID: <20170228152334.GA13542@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000001d28f84$0fce9ea0$2f6bdbe0$@cl.cam.ac.uk> <20170227104625.GA3536@calimero.vinschen.de> <000301d2911c$d89a0510$89ce0f30$@cl.cam.ac.uk> <20170228102913.GB3536@calimero.vinschen.de> <000301d291b8$94dd3260$be979720$@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <000301d291b8$94dd3260$be979720$@cl.cam.ac.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00044.txt.bz2


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1775

Hi David,

On Feb 28 11:48, David Allsopp wrote:
> Corinna Vinschen wrote:
> > On Feb 27 17:13, David Allsopp wrote:
> > > Corinna Vinschen wrote:
> > > > On Feb 25 16:27, David Allsopp wrote:
> > > > > This patch (below - I hope I have managed to format this email
> > > > > correctly) alters the behaviour of dll_list::topsort to preserve
> > > > > the order of dlopen'd units.
> > > > > [...]
> > > > > This patch is licensed under 2-clause BSD as per
> > > > > winsup/CONTRIBUTORS, Copyright (c) 2017, MetaStack Solutions Ltd.
> >=20
> > Do you really want to make it (c) MetaStack?
>=20
> Oh, I was assuming that there would just be an implied mapping! Simple is=
 best (MetaStack is just me, anyway!), so the previous patch and this fixup=
 may be merged as my personal copyright, yes.
>=20
> <snip>
> >   if (loaded_dlls > 0)
> >     dlopen_deps =3D (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (dll*));
> >   while ((d =3D d->next))
> >     {
> >       [...]
> >     }
> >   if (dlopen_deps)
> >     cfree (dlopen_deps);
> >=20
> > Do you want to tweak your patch accordingly?
>=20
> That's much neater - attached is a fixup (which obviously looks a lot cle=
arer with git diff --ignore-all-space)

Applied and pushed.  I took the liberty to add two formatting tweaks,
as well as most of the description of your OP for the log message,
and squashed this into a single patch.

I'll uploaded new developer snapshots to https://cygwin.com/snapshots/
containing your patch for testing today.  This might take a while since
I have trouble with my cable provider and my upload speed is currently
almost 0 :-P


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtZX2AAoJEPU2Bp2uRE+g/XsQAKRGTQIqiaPY9gWcJmRm/dvh
PT8gpeVGdj0cfjwWSukAgmnBjIVRZGavKfLC+SxwUmffTFB7m559tE5z08P6T6nh
71sJzmPkC3Iw8qA0e5dYpdH9GEFLePHRbST6G47WLbeXW/18bKVt4m4DdqXnGPKw
hIW0SiUkMhylJmS65OGkDrCQNIxIV5JUXASWi9Uwo1buMVdp2X9tP37/eqRvoNrD
7/ugqT+hF83mQTncCbpXbhgyq45HEz9OIFHO0mM9fIFotJvvQAUqx0/dSp8LgwvK
fcSyFYyuLbA+p9zr0JVulgEMedaptWesakEjWGSAfGx5hQJHOmDt0JThXmQO4UQh
Swq1KjUw/AJpzIZU5PP5VqPt2r1XDYzDSb6D8+rreo8wc/UlN1gNRNeKyL7mQ96q
My93AtiREuJZPx0OJqxFAWd9MnC2nBzgU9wWD0bWog74B7l2/URMOPGnd8A/+Bef
CgBMSheU56TTSRsFsFprHSTGWsZGH0c3LJu9yGQOW64DGdj0sr3xgUwCzBjnrE68
z0KXabrPt+OtMLS/O6sggRfwPWMuOlC8Z+uzG1Mz8Bu2i09H/XZbV/IicdN2+r3v
CSK9JHEQ7/5sXvi6s31t6wJa93ftpZacI6mKyHal5pjPOpBhr5Nnkf5cMdubp5ZU
acFUnsvu4MmtRwra5iLm
=ckHq
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
