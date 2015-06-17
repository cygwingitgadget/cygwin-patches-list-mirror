Return-Path: <cygwin-patches-return-8194-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73910 invoked by alias); 17 Jun 2015 21:15:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73892 invoked by uid 89); 17 Jun 2015 21:15:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=no version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 17 Jun 2015 21:15:54 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])	by mx1.redhat.com (Postfix) with ESMTPS id 40FA9351E68	for <cygwin-patches@cygwin.com>; Wed, 17 Jun 2015 21:15:53 +0000 (UTC)
Received: from [10.3.113.115] (ovpn-113-115.phx2.redhat.com [10.3.113.115])	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5HLFque023036	for <cygwin-patches@cygwin.com>; Wed, 17 Jun 2015 17:15:53 -0400
Message-ID: <5581E384.9030608@redhat.com>
Date: Wed, 17 Jun 2015 21:15:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Hide sethostname() in unistd.h
References: <55804E7D.3060504@t-online.de>	 <20150616174551.GF31537@calimero.vinschen.de>	 <558107F2.3030809@t-online.de>	 <20150617084626.GI31537@calimero.vinschen.de>	 <5581D7C4.1000207@t-online.de> <1434574654.11212.4.camel@cygwin.com>
In-Reply-To: <1434574654.11212.4.camel@cygwin.com>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="p0Ckb5end4BIEtgNolmCBChUv8Io342bE"
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00095.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p0Ckb5end4BIEtgNolmCBChUv8Io342bE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1100

On 06/17/2015 02:57 PM, Yaakov Selkowitz wrote:
> On Wed, 2015-06-17 at 22:25 +0200, Christian Franke wrote:
>> Busybox does not use autoconf or similar. It requires manual platform=20
>> specific configuration which does not yet support a missing=20
>> sethostname(). After adding HAVE_SETHOSTNAME manually and some other=20
>> minor additions, busybox (which many commands enabled) compiles and=20
>> works reasonably.
>> Would ITP make sense ?
>=20
> TBH I'm not sure.  Presuming you're discussing the single-executable
> build (so as not to clobber coreutils etc.), there is still the question
> of (not) matching the heavily-patched coreutils wrt .exe handling etc.
> What do you think the use case would be?

Portability testing is one thing - I often compare how
bash/dash/zsh/mksh handle a shell construct, and adding busybox sh into
the mix adds another perspective.  But yeah, I don't see busybox
becoming the default source of these apps, so much as an alternative
implementation.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--p0Ckb5end4BIEtgNolmCBChUv8Io342bE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 604

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVgeOEAAoJEKeha0olJ0NqGuMH+gOCFWU9iPmd7xag6o5iJGxF
UGQaRerVW0vkYykipY2JNlgfyTWk3MOcFU3dwrPLt1lyj39WaFmm49nczJqATOEI
i4CEqnFdX4D3YdappkgVU/7C2wm3PRYOSV5mLP3uvFfBPBUI2wvM8BWQaMemRV1T
UIau2Vc8054IuEq7RjEOv08UBhiJdmcZUgPdjCyEtgOMaBM14CqOXOGu/Z7FHY10
paJTDMJfIShE8fT+kAxWy2QA8vKVkGUWnV0GjpqO9mstrcwUyZ4WIM6+p1Thu8uB
D4QBgQTqV23aszIDzDHZOy76PUM+WkkvimkAHOyXzvJHVWSK1rQTnbPPBKoISgQ=
=x02+
-----END PGP SIGNATURE-----

--p0Ckb5end4BIEtgNolmCBChUv8Io342bE--
