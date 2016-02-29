Return-Path: <cygwin-patches-return-8367-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115581 invoked by alias); 29 Feb 2016 13:45:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115568 invoked by uid 89); 29 Feb 2016 13:45:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.7 required=5.0 tests=BAYES_20,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=12,7, searches, cxx, 2.7.0
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Feb 2016 13:45:06 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3089FA8040B; Mon, 29 Feb 2016 14:45:04 +0100 (CET)
Date: Mon, 29 Feb 2016 13:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
Message-ID: <20160229134504.GF3525@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de> <56D43D9B.5020602@dronecode.org.uk> <20160229125813.GE3525@calimero.vinschen.de> <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de> <56D448D1.2040700@patrick-bendorf.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <56D448D1.2040700@patrick-bendorf.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00073.txt.bz2


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1099

On Feb 29 14:34, Patrick Bendorf wrote:
> sorry, now it's based on current git head. and hopefully without formatti=
ng
> issues.
>=20
> /winsup/
> * ccwrap: change locale to 'C' as ccwrap searches for literal strings
> "search starts here" and "End of search list" which may be localized.
>=20
> ---
>  winsup/ccwrap | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/winsup/ccwrap b/winsup/ccwrap
> index 2f1fd3a..0c6a170 100755
> --- a/winsup/ccwrap
> +++ b/winsup/ccwrap
> @@ -12,11 +12,7 @@ if ($ARGV[0] ne '++') {
>      $cxx =3D 1;
>  }
>  die "$0: $ccorcxx environment variable does not exist\n" unless exists
> $ENV{$ccorcxx};
> -if (`uname -o` =3D~ /cygwin/i) {
> -    $ENV{'LANG'} =3D 'C.UTF-8';
> -} else {
> -    $ENV{'LANG'} =3D 'C';
> -}
> +$ENV{'LANG'} =3D 'C';
>  my @compiler =3D split ' ', $ENV{$ccorcxx};
>  if ("@ARGV" !~ / -nostdinc/o) {
>      my $fd;
> --
> 2.7.0

Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1EtfAAoJEPU2Bp2uRE+gRoEP/RyFSHvcjpdvEW7Y9nVToHg1
Xh7jFHN++fk+aaUiKtwQhDHz93UeHiC0FrWiAhVn6XZKWLWUiEXUEAbAwtiSHgk9
qmxEUO4ZovhnawQp6y7hqgdsIopIjGj51NWLL3gYY7JwbaDzc+I80iQ7ew/CIdi4
UyW4vXiZstgn9mCnb01mrDKtNsxJhTCNwbsV8t9p4rDk+r2c1wnxlqxc/Y/hLJPj
XED9zuKfMkMYVW71RFYq06fAt9871JQAacC5Lv+LENJmWwQwDkHpMxMh9+OURDF/
uQCbaX7tKwx5rBy36Az9Xh/CDVuWwqrwBBSrKMsG/2wP7wcjoD3Z/WwYo/HqgpXC
iFYKIA2Bdy001ROGuEz7OCj2l4pKXZb/P91Yh8wJIy0EI+XBRF94VLnTD6/vKKZ+
c/3YUAGDYuVfyuyxHIYyg1i4Mig07usL6Fj0oNB6SMKATUl/HsiNna8UY81nQm4c
D0xGTfiX3TbTRWWJ0rWAzuMDlgnIkITLUhu7uzy3CVoS6JdkXNdKCoIpY1STT/FT
elX4TjOaRraWwZmvm45RVXkehLuIeDYDvogY45YNh0nT22Eg4/K+r5TR7KdNvW1+
Jaj/QUaLfukvN75BlHIeDvl3Fc99xgcxyDlvUb9kgRFMWKoMZiX2QeUID/wCCoYr
QqyCsfDC1vJxmrfbuBOM
=GVSX
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
