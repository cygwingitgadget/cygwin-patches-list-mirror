Return-Path: <cygwin-patches-return-7715-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2406 invoked by alias); 3 Sep 2012 09:34:51 -0000
Received: (qmail 2280 invoked by uid 22791); 3 Sep 2012 09:34:50 -0000
X-SWARE-Spam-Status: No, hits=-8.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_PGP_SIGNED,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 03 Sep 2012 09:34:36 +0000
Received: by iabz25 with SMTP id z25so8063147iab.2        for <cygwin-patches@cygwin.com>; Mon, 03 Sep 2012 02:34:36 -0700 (PDT)
Received: by 10.50.220.194 with SMTP id py2mr10191282igc.15.1346664876122;        Mon, 03 Sep 2012 02:34:36 -0700 (PDT)
Received: from [219.92.162.192] (pbz-162-192.tm.net.my. [219.92.162.192])        by mx.google.com with ESMTPS id n5sm18525660igw.13.2012.09.03.02.34.34        (version=TLSv1/SSLv3 cipher=OTHER);        Mon, 03 Sep 2012 02:34:35 -0700 (PDT)
Message-ID: <504479A3.6080609@users.sourceforge.net>
Date: Mon, 03 Sep 2012 09:34:00 -0000
From: JonY <jon_y@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
References: <503982F3.9010004@gmail.com> <20120902102718.GC13401@calimero.vinschen.de> <50439CAE.6080603@gmail.com> <50441E6B.7060703@cwilson.fastmail.fm>
In-Reply-To: <50441E6B.7060703@cwilson.fastmail.fm>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig58014B49A9ADA94C8E790EFF"
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
X-SW-Source: 2012-q3/txt/msg00036.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58014B49A9ADA94C8E790EFF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 688

On 9/3/2012 11:05, Charles Wilson wrote:
> On 9/2/2012 1:51 PM, Jin-woo Ye wrote:
>> Now it is clear that this patch would be needed other relevant projects
>> such as mingw, mingw-w64. thanks for your effort on simplified one.
>=20
> Yes, while it is not required that all of those systems stay exactly in
> sync, there has been some effort in ensuring that the pseudo-reloc
> implementation used by all three remains very similar if not identical.
>=20
> Please bring this patch to the attention of the mingw.org and
> mingw64.sf.net people, if it's not too much trouble.
>=20
> --
> Chuck
>=20
>=20
>=20

Original message already forwarded to mingw-w64 devel list. Thanks
Jin-woo Ye.


--------------enig58014B49A9ADA94C8E790EFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 196

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iEYEARECAAYFAlBEeaYACgkQp56AKe10wHclpQCeOs6k9TgHsQ7HM5Ey/kvkbTSn
X0wAn2MbME9M1gePlNhbTFLXdqNELsmr
=dRM3
-----END PGP SIGNATURE-----

--------------enig58014B49A9ADA94C8E790EFF--
