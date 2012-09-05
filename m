Return-Path: <cygwin-patches-return-7719-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16844 invoked by alias); 5 Sep 2012 13:47:14 -0000
Received: (qmail 16818 invoked by uid 22791); 5 Sep 2012 13:47:10 -0000
X-SWARE-Spam-Status: No, hits=-8.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_PGP_SIGNED,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-pz0-f43.google.com (HELO mail-pz0-f43.google.com) (209.85.210.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 Sep 2012 13:46:56 +0000
Received: by daku36 with SMTP id u36so378454dak.2        for <cygwin-patches@cygwin.com>; Wed, 05 Sep 2012 06:46:56 -0700 (PDT)
Received: by 10.68.242.42 with SMTP id wn10mr43906352pbc.105.1346852816218;        Wed, 05 Sep 2012 06:46:56 -0700 (PDT)
Received: from [219.92.162.192] (pbz-162-192.tm.net.my. [219.92.162.192])        by mx.google.com with ESMTPS id os1sm1470425pbc.31.2012.09.05.06.46.54        (version=TLSv1/SSLv3 cipher=OTHER);        Wed, 05 Sep 2012 06:46:55 -0700 (PDT)
Message-ID: <504757C5.80203@users.sourceforge.net>
Date: Wed, 05 Sep 2012 13:47:00 -0000
From: JonY <jon_y@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
References: <503982F3.9010004@gmail.com> <20120902102718.GC13401@calimero.vinschen.de> <50439CAE.6080603@gmail.com> <50441E6B.7060703@cwilson.fastmail.fm> <504479A3.6080609@users.sourceforge.net> <20120903103518.GK13401@calimero.vinschen.de> <50448E3E.208@users.sourceforge.net> <20120903112428.GN13401@calimero.vinschen.de>
In-Reply-To: <20120903112428.GN13401@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enigF9C3CF20C441FBEF9D245038"
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
X-SW-Source: 2012-q3/txt/msg00040.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF9C3CF20C441FBEF9D245038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 272

On 9/3/2012 19:24, Corinna Vinschen wrote:
> It differs a lot from the original source, so you might contemplate
> to send a follow up mail to the mingw-w64 devel with the attached
> patch.
>=20

It looks like mingw-w64 is already using it all along according to Kai.





--------------enigF9C3CF20C441FBEF9D245038
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 196

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iEYEARECAAYFAlBHV8gACgkQp56AKe10wHd1zQCffL02i0GAzzxQU4QND8mH7jVH
7sYAnjXNeeTKYjScCTQtnXRj72bhP6sJ
=LAJ3
-----END PGP SIGNATURE-----

--------------enigF9C3CF20C441FBEF9D245038--
