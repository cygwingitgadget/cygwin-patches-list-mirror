Return-Path: <cygwin-patches-return-8602-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2284 invoked by alias); 14 Jul 2016 18:50:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2171 invoked by uid 89); 14 Jul 2016 18:50:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, our
X-HELO: calimero.vinschen.de
Received: from ipbcc0190b.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.25.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Jul 2016 18:50:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 001E1A80405; Thu, 14 Jul 2016 20:50:12 +0200 (CEST)
Date: Thu, 14 Jul 2016 18:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix 32-bit SSIZE_MAX
Message-ID: <20160714185012.GA24631@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1468443748-25335-1-git-send-email-eblake@redhat.com> <20160714150944.GB21341@calimero.vinschen.de> <5787DC61.5040109@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <5787DC61.5040109@redhat.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q3/txt/msg00010.txt.bz2


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1395

On Jul 14 12:39, Eric Blake wrote:
> On 07/14/2016 09:09 AM, Corinna Vinschen wrote:
> > On Jul 13 15:02, Eric Blake wrote:
> >> POSIX requires that SSIZE_MAX have the same type as ssize_t, but
> >> on 32-bit, we were defining it as a long even though ssize_t
> >> resolves to an int.  It also requires that SSIZE_MAX be usable
> >> via preprocessor #if, so we can't cheat and use a cast.
> >>
> >> If this were newlib, I'd have had to hack _intsup.h to probe the
> >> qualities of size_t (via gcc's __SIZE_TYPE__), similar to how we
> >> already probe the qualities of int8_t and friends, then cross our
> >> fingers that ssize_t happens to have the same rank (most systems
> >> do, but POSIX permits a system where they differ such as size_t
> >> being long while ssize_t is int).  Unfortunately gcc gives us
> >> neither __SSIZE_TYPE__ nor __SSIZE_MAX__.  On the other hand, our
> >> limits.h is specific to cygwin, we can just shortcut to the
> >> correct results rather than being generic to all possible ABI.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> ---
> >>  winsup/cygwin/include/limits.h | 10 +++++++++-
>=20
> > Looks good, please apply.
>=20
> And I remembered to update the release notes, too.

Thumbs up.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXh97kAAoJEPU2Bp2uRE+gOPIP/3fyyFtdy2c7/ABV7F58dj9/
pwC6wnSqqQHV9LFtv5JwKEJlskZxaDHpNknEI/JoPCX7FIoQkE4hxTRVB1r31Yuw
TnNJtW25CvTQiCZ8LPURebwbF9ciB4VLhFPnmq0ywL3ChFnsOu5jwffwnyMzE48g
H57nP/HtdRkilXG8CW4zaSYkmmj+xchHB0EeCy0UV/FvznVdzuRdAQdxO1cifUdq
Kq/TLPG6JxdNsLfc7Sh2U+e1q0yOMBfHxBqkSAVOM3KPo3wh6B7qRcJSbypeuwjK
m7+U6StC6/+pp/jSFs1mU7o1z/xXNDOC49Wi5/frCIGTY576X+aeHzCGtjmI7Zzs
zweYyUXOOfnvd9Af1L+LG8ffbeoJmWOQU48ryzwMN82goBP0N3I/WKzUeHb0qJfF
6Dy9+2/6ab67J1T7I1FR/Hgn8qhBsxpbf/LN9bo89I2QpkTmjwH1k54a+m0o/eaf
6583XB35tttwfhYuUXw1ChAklNfPJ1avNQKksFqswg9slzCZ4QjEa6Cnhg9nXFNB
5Yq3CGClik0l5Op2/P/F5gsjnpbTN4UTLDIvXZNR16P4IVWqZU2QsJLQVv5q++bR
GGDm8AXDHQu6MtB8U5Jg0C5E26JHMWFu8v4tUDFATasSAmIrKq7gjdPb1svHeEEP
1asTAgUhycPiXg+WBnO6
=qJ+p
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
