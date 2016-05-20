Return-Path: <cygwin-patches-return-8566-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124617 invoked by alias); 20 May 2016 11:20:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124600 invoked by uid 89); 20 May 2016 11:20:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=excluding, highresolution, high-resolution, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc04766.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.71.102) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 May 2016 11:20:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5F26AA803E0; Fri, 20 May 2016 13:20:00 +0200 (CEST)
Date: Fri, 20 May 2016 11:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] Use high-resolution timebases for select().
Message-ID: <20160520112000.GB15115@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1463613259-2899-1-git-send-email-cgull@glup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <1463613259-2899-1-git-send-email-cgull@glup.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00041.txt.bz2


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1105

On May 18 19:14, cgull@glup.org wrote:
> From: John Hood <cgull@glup.org>
>=20
> * select.h: Change prototype for select_stuff::wait() for larger
>   microsecond timeouts.
> * select.cc (pselect): Convert from old cygwin_select().
>   Implement microsecond timeouts.
>   (cygwin_select): Rewrite as a wrapper on pselect().
>   (select): Implement microsecond timeouts.
>   (select_stuff::wait): Implement microsecond timeouts with a timer
>   object.

I was just about applying this patch when I noticed a problem.  It's not
a biggy, but you're using standard printf format specifiers while our
debug printf statements use a somewhat different set, i.e:

> +	    select_printf ("to NULL, us %lld", us);

There's no %lld in our debug printf stuff.  That would have to be %D
with uppercase D.

Have a look at smallprint.cc line 94ff, please.

I fixed that locally and applied your patches, excluding the debug
additions from patch 3 for now.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPvLgAAoJEPU2Bp2uRE+gSYIQAJ0o9lfkXo2ejmNiKB600asY
NHKF69MjmGrvgN5cfz+iaYTaqcyjkEqJ5uUSpGAKn7okfAsyJp5b1k7qJ4C9ciVP
zRCYWNcjGMR97QNSHmC4jXHNcnjHyM8FAi0+wqQhfhzQ1vn8lpzLfaaDsjP2+SQx
3mVvRebTdNd9O1pCeyvyQRy4jlazeHw68yKvY3y1lMGdJ3k/Gq4ahT5flA5ZuV2z
5PdmCRp9q2d9EdDCX2j0fssK/DnL0/EftS9rwfXghoVpb8K8/cWhN1B34ly862Ih
R63UbOrc/lTk/jffewYN+ZXp7yVJL6zIP7oCIkGSy6jaI1s/XIWg8/FxeuydgkJd
NTPrOYesjr98FzxOOLWsRtQf2jPKgVLYGHxmAdZtUjJJTridFBC1MFn9UC9aJ5J5
fWuxcqgCNn93lY73Of+lzB1tyVE8micuBxYyJGAw4HHyPl0zAl2C8ZEZxAp7prQm
Gs7zg6alom7LzCCiGu6rN8v/KPQeMvpEeVuShM7TTEG0iUZO2+zItsIqnmd/Axjk
6gOzEE4OpBOi6sluq0AdtSU9wt34Q2XMo9EBwCZvCgkB5eLONaawwujOqUt5P62I
+DNYHScAVTmzKpyzYIGewsJYOsJ6hIhAWDO+uwQ2CM8rKMyjY9iuDKynwZJtaG2d
fFro6iyI8VesKD51QWLp
=sJjV
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
