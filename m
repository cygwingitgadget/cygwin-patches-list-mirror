Return-Path: <cygwin-patches-return-8368-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115638 invoked by alias); 29 Feb 2016 15:41:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115616 invoked by uid 89); 29 Feb 2016 15:41:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=12,7, searches, cxx, lc_all
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 29 Feb 2016 15:41:28 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (Postfix) with ESMTPS id 656D664369	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 15:41:27 +0000 (UTC)
Received: from [10.3.113.120] (ovpn-113-120.phx2.redhat.com [10.3.113.120])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1TFfQda024787	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 10:41:27 -0500
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
To: cygwin-patches@cygwin.com
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de> <56D43D9B.5020602@dronecode.org.uk> <20160229125813.GE3525@calimero.vinschen.de> <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de>
From: Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
Message-ID: <56D466A6.1000003@redhat.com>
Date: Mon, 29 Feb 2016 15:41:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="iNDXmi9Ivscsk7hR5FgrDabNxDuvDaLEJ"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00074.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iNDXmi9Ivscsk7hR5FgrDabNxDuvDaLEJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1108

On 02/29/2016 06:19 AM, patrick bendorf wrote:
> after some discussion on irc and the list i'm resubmitting a simpler
> version of the patch.
> setting the locale on cygwin to 'C.UTF-8' is not needed, so i'm always
> setting it to 'C' which is sufficient for the build process and the most
> simple fix.
>=20
> /winsup/
> * ccwrap: change locale to 'C' as ccwrap searches for literal strings
> "search starts here" and "End of search list" which may be localized.
> ---
>  winsup/ccwrap | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/ccwrap b/winsup/ccwrap
> index 7580e7a..0c6a170 100755
> --- a/winsup/ccwrap
> +++ b/winsup/ccwrap
> @@ -12,6 +12,7 @@ if ($ARGV[0] ne '++') {
>      $cxx =3D 1;
>  }
>  die "$0: $ccorcxx environment variable does not exist\n" unless exists
> $ENV{$ccorcxx};
> +$ENV{'LANG'} =3D 'C';

This won't work if I have LC_ALL set in my environment.  If you want to
force the locale, you want to set LC_ALL (highest priority), not LANG
(lowest priority).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iNDXmi9Ivscsk7hR5FgrDabNxDuvDaLEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 604

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJW1GamAAoJEKeha0olJ0NqQUQH/163QKLa79LlRoeRj+AhSnU9
5LR84Mm1yGIOv/p8wQD+KZuhU+COYo7gMLY0RaOeEeeh0NW608OWSUn0rzLT6uNc
2vlYhNQprgi0tRFULnteqbxg1dPJ0L+x+odneZu0yenOmWgU474Yw4oQSK4on3PC
44K8SOguAtQfVVju0DgTKMw7hjqFWAiLzuoP+VT/zz5cpCtv8EoAYMLXuthJ1sjh
5AEU+JMTYmc9fwykPfxkjnDlyzlhSgAEYrYs5ORHhbnC8CCLnOn0HRQOXmH5RZ7v
653tIsaU4D0687k/+t6jAHS0RFpx20MxU5ZAKd3RGNZHYB8czxoZghODN2oXSX8=
=ASfl
-----END PGP SIGNATURE-----

--iNDXmi9Ivscsk7hR5FgrDabNxDuvDaLEJ--
