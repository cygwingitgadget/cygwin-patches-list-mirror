Return-Path: <cygwin-patches-return-9301-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88176 invoked by alias); 3 Apr 2019 12:26:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88166 invoked by uid 89); 3 Apr 2019 12:26:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:572, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 03 Apr 2019 12:26:52 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MulyX-1guoeI16e3-00rnXl for <cygwin-patches@cygwin.com>; Wed, 03 Apr 2019 14:26:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5554AA8034C; Wed,  3 Apr 2019 14:26:48 +0200 (CEST)
Date: Wed, 03 Apr 2019 12:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190403122648.GY3337@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com> <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> <87sgv65eyc.fsf@Rainer.invalid> <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca> <87pnq9jupk.fsf@Rainer.invalid> <a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca> <878sww93g9.fsf@Rainer.invalid> <97aec921-d9b1-3b0e-de7a-d492832ba481@SystematicSw.ab.ca> <236d3269-1b0b-9da0-9816-ed84e489f73e@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="o6aug3O60clXg2rj"
Content-Disposition: inline
In-Reply-To: <236d3269-1b0b-9da0-9816-ed84e489f73e@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00008.txt.bz2


--o6aug3O60clXg2rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 499

On Apr  3 12:38, Michael Haubenwallner wrote:
> Furthermore, with so called "Stacked Prefix", it is possible to have a se=
cond
> level of Gentoo Prefix, so what I'm after is some option to tell the reba=
se
> utility which database to record dll base addresses into, and which multi=
ple(!)
> databases take into account while performing a rebase.

rebase is OSS.  There's nothing keeping you from providing patches
to make your scenario work ;)


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--o6aug3O60clXg2rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlykpogACgkQ9TYGna5E
T6A82xAAlll520DH4iZxgtbXjpCaPsmPCp6O7zhM57ZhPPvVGUYf7v9FAKOTU0+Z
q3n/j0QlADC7TGf6KN8frLcs0EEIOYuky58Op/TWONqFJDUdiGg7OehDKSpgjauR
MzfY7mDrgVTBWVmrJRDEoMr7rOGUbQLSmWOqDo11hWdtcMP3F4UEHk43T7CK2EUe
pDhbx/8fw1DYOW9beUee0PRgPzEclgN7yvr0y/4MRWVzO5kz+KBCdkS/mYATTNOa
6csEjB1malj5vaIpaohMHedF03/yCtF0cYd+D8UYLjJegQRA3HAXk2flZ2pVZvV+
IPSMy6lkfCx9YKYwnHD8HZaTMwNGSdwxionU3225ZQGNQ57/CMs11YZKZZASp8v2
aO7LTRq3lgt/ep+FZ1T2rcMpc0QjAjZG52N3O+S4Zc76yirG4MDYMo+Y79Mk+Y9z
KTHEPeMA8u5q28abNx7ff12KTXFObpWquCmwAj/ZdJHiAgdReAqM0hJ0pc0Zpe1X
LK72XqMwnNMT4UWz6VAhUvD8whrILoJ5SYv5yJ9cnUaexnzBqTe37QkPygK/g4CM
bv6yX1Sn5shEH6Jtu5wwLe3Ewgf2n7dlYlphYKKpsm8RMeC/a1Pi9z67/VPhJmZu
8e4tcEp8CvwwqwEEf87PmmHcfMr/wDIO0MLbXtmUTnfq+hqntoI=
=mRW6
-----END PGP SIGNATURE-----

--o6aug3O60clXg2rj--
