Return-Path: <cygwin-patches-return-8883-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18948 invoked by alias); 25 Oct 2017 12:11:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18383 invoked by uid 89); 25 Oct 2017 12:11:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-123.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:U*cygwin-patches, H*R:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Oct 2017 12:11:47 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 77920721E280C	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 14:11:39 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 778A35E049B	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 14:11:38 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 62FECA818DD; Wed, 25 Oct 2017 14:11:38 +0200 (CEST)
Date: Wed, 25 Oct 2017 12:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: Fix parsing of file names containing colons
Message-ID: <20171025121138.GF22429@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171025112316.13004-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <20171025112316.13004-1-kbrown@cornell.edu>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00013.txt.bz2


--rQ2U398070+RC21q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1377

Hi Ken,

On Oct 25 07:23, Ken Brown wrote:
> Up to now the function winsup/utils/dump_setup.cc:base skips past
> colons when parsing file names.  As a result, a line like
>=20
>   foo foo-1:2.3-4.tar.bz2 1
>=20
> in /etc/setup/installed.db would cause 'cygcheck -cd foo' to report 4
> as the installed version of foo insted of 1:2.3-4.  This is not an
> issue now, but it will become an issue when version numbers are
> allowed to contain epochs.
> ---
>  winsup/utils/dump_setup.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/utils/dump_setup.cc b/winsup/utils/dump_setup.cc
> index 320d69fab..3922b18f8 100644
> --- a/winsup/utils/dump_setup.cc
> +++ b/winsup/utils/dump_setup.cc
> @@ -56,7 +56,7 @@ base (const char *s)
>    const char *rv =3D s;
>    while (*s)
>      {
> -      if ((*s =3D=3D '/' || *s =3D=3D ':' || *s =3D=3D '\\') && s[1])
> +      if ((*s =3D=3D '/' || *s =3D=3D '\\') && s[1])

I think this is a simplified way to test for the colon in paths like
C:/foo/bar.  Nothing else makes sense in this context.

I'm not sure how much we care, but maybe we shoulkd fix the test to
ignore the colon only if it's the second character in the incoming
string?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ8H96AAoJEPU2Bp2uRE+g4XYP/3kWVQm2Zl3+sQjf4zIvvZ4Z
m3SzcsveOXDPJfYFsHPBVIdgTNg2NTj/uGgPYOmzCohpYrr7DBxlGZceNz4xEpox
JTgNrRyTTG0JjchJF0/RPIFJ4wwArfSMwxAo8KEVqqTNIR0SE2cYwpGCSR937jPJ
ndC9t8U/3f69tsbkF50DQa9hQq5Duz07y4MnW3jaAksmv52mpJ3hR02RfeqOtCQJ
/sJX2kkXBY94v8+72WphjAxJZiiapYyqY3gVpif6uJceafif0tSTjUjMu4mFih/0
u43D+smUXC/g5CGz/v4YaNqiaoXqizELIdDgFwIY+BQ73K5/733pNkIcxehvpn9V
j4ZqBCDZIFN5yHzG7ZNAs8ecV1cgv7AVxW1OEx0Z5Wt9v1wtlVlYY95vSpK+V8AX
kzu2SetrpIRaE7gJAq/1+yv4Tw6dyoTW6lKypQIOVh+j4Y2psGYM1LKIPt3GCXIU
Z61iAeZK5MLYt4At3Yr5t63ZloPut1oWwpOosAZDEJ65A08+5ZOdhBR78A9CooOq
oVwajPGPF78HGgc7ORQcNyo27ooOF16qwg+aYwwglIWqxpjiaVUW66e1RknN/F5c
I76o93Gwow3G6vcvmTydrNoCv6A6EMIFafQjNBKUwK2aZcfv9sxWLx1rt+gUkYci
ewYTgu3Aw6wQAgC9oGfd
=KD+4
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
