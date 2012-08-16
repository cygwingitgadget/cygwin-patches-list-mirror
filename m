Return-Path: <cygwin-patches-return-7704-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12980 invoked by alias); 16 Aug 2012 15:24:51 -0000
Received: (qmail 12964 invoked by uid 22791); 16 Aug 2012 15:24:50 -0000
X-SWARE-Spam-Status: No, hits=-10.3 required=5.0	tests=AWL,BAYES_00,KHOP_PGP_SIGNED,KHOP_RCVD_UNTRUST,KHOP_THREADED,RCVD_IN_DNSWL_HI,RCVD_IN_HOSTKARMA_W,RP_MATCHES_RCVD,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 16 Aug 2012 15:24:32 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7GFOWIm022244	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Thu, 16 Aug 2012 11:24:32 -0400
Received: from [10.3.113.46] (ovpn-113-46.phx2.redhat.com [10.3.113.46])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7GFOVrx009042	for <cygwin-patches@cygwin.com>; Thu, 16 Aug 2012 11:24:32 -0400
Message-ID: <502D10AF.1040501@redhat.com>
Date: Thu, 16 Aug 2012 15:24:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard pasting with small read() buffer
References: <502ABB77.2080502@towo.net> <20120816093334.GB20051@calimero.vinschen.de> <502CE384.8050709@towo.net> <20120816123033.GH17546@calimero.vinschen.de> <502D0199.6040203@towo.net>
In-Reply-To: <502D0199.6040203@towo.net>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig86230794468F486BB14938ED"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00025.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig86230794468F486BB14938ED
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-length: 802

On 08/16/2012 08:20 AM, Thomas Wolff wrote:

>>> MB_CUR_MAX does not work because its value is 1 at this point
>> So what about MB_LEN_MAX then?  There's no problem using a multiplier,
>> but a symbolic constant is always better than a numerical constant.
> I've now used _MB_LEN_MAX from newlib.h, rather than MB_LEN_MAX from
> limits.h (note the "_" distinction :) ),
> because the latter, by its preceding comment, reserves the option to be
> changed into a dynamic function in the future, which could then possibly
> have the same problems as MB_CUR_MAX.

POSIX requires MB_LEN_MAX to be a constant, only MB_CUR_MAX can be
dynamic.  We cannot change MB_LEN_MAX to be dynamic in the future.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig86230794468F486BB14938ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 620

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJQLRCvAAoJEKeha0olJ0Nq95AH/ijYKXfDxTUQjrz1PePucVd2
u2g8XIcICqBjJwBq9I3pKRMxEEsUGn9/58+q4jtY89ZIz93N0AGL4CjCz1GKx+Iy
H/ViFlT2bQIRTsO00K4JNr3vZ9ZtgQQfBUN6sUCvQWTFewNvThb8JDKtQTwQAnon
/oc3cIeltjs6EkDoTrgWN6Rr7Bd4HgvVoLda6kkM49DYTroit5TB1Dr1QhwBPnSp
xsX4YlqR3+MuM05Wu4jvLScJHOgMEkH480o50Oyw5iUQoT38EMOG8Oq/XVtEmpy1
vzI0I9URV64640pOvtn62p0Iqegk1JWzyCYYNQmgAc/8Sp5QeH3giqCMIWKuYR0=
=JqJX
-----END PGP SIGNATURE-----

--------------enig86230794468F486BB14938ED--
