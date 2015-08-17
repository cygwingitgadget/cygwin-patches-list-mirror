Return-Path: <cygwin-patches-return-8239-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29526 invoked by alias); 17 Aug 2015 09:06:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29515 invoked by uid 89); 17 Aug 2015 09:06:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Aug 2015 09:06:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9CF39A807C8; Mon, 17 Aug 2015 11:06:18 +0200 (CEST)
Date: Mon, 17 Aug 2015 09:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkglobals: Fix EOL detection
Message-ID: <20150817090618.GI25127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGHpTBLBua-DJQ1tBapYd_6ypdWGMW+ehAq4r7k_TA44Tn_Oxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
In-Reply-To: <CAGHpTBLBua-DJQ1tBapYd_6ypdWGMW+ehAq4r7k_TA44Tn_Oxg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00021.txt.bz2


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 329

On Aug 17 10:41, Orgad Shaneh wrote:
> When globals.cc has CRLF line endings, winsup.h is not removed, and
> compilation fails for duplicate definitions.

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV0aQKAAoJEPU2Bp2uRE+gDCoP/RIADSM+EDeGw6fGaFgVZH02
vOKgajkXeYuXP1Cr1ukiKiHSJfIlDfr+QcqZfW3Ln0AJ7rGGTmxsM3KoGu6i0v6x
22j77yNS/j3WfVYeB44yTtmQulV1E7Gp1RUn8HBX3Zdm5Il/riUpEA302goMZpKQ
poFH4uF7NItQ7UZFP/2wHJRvl8zFx5W+tZrD2MRvNq1mSePNqQwii+0hq9nd1SQN
ZXDRbMjYjzUXUQDHd0brlGXKIWeEWXKpEh0kp+Qcsxw/O0+GcEO7n6O3rxUEV3KZ
0MIGZcpqSY0QtK86vYiiVFL9Bkqhbc92ydp/ERQS4EoOOXSfxlAb83nZvzuuI4Hx
p7QsAVL1t2ThHWVT/yCd/zIYkJwYAvjIaKBkcQbRUOm1ugavoLQc87ttAzojvqVz
D2MYN/X/BZRS4TLDydKcd7WAMu4H3d3KlJujv+uHzxqO3avc3ppv+RHxT/T4mFDp
Ba7hKpEyIeTrAa9ng8LTDuSjnJpEL/uCbxLfnGS6nz58J0rtY9KcGqE6zmYmMPjx
MQbpX1V0Qv0uwdbWwhKJme/LKQRmQNdlJxHkbe8NBS5CGiJoIYGCRV62kWFi6Puh
rzTrx6zPQ5grUKK+VjLPlDv7gIDSOzMa/1GdduSch3yGqdPnzgPLO6NfhQ9RZ8AC
kkEGSwECdshvEuRCqLUD
=tdzq
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--
