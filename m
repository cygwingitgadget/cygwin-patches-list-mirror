Return-Path: <cygwin-patches-return-10132-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16312 invoked by alias); 26 Feb 2020 20:16:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16287 invoked by uid 89); 26 Feb 2020 20:16:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-111.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 20:16:43 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MZTa2-1is9Pz0K8s-00WZtF for <cygwin-patches@cygwin.com>; Wed, 26 Feb 2020 21:16:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 84157A8276B; Wed, 26 Feb 2020 21:16:40 +0100 (CET)
Date: Wed, 26 Feb 2020 20:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Update dumper for bfd API changes
Message-ID: <20200226201640.GW4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200226200704.34424-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="YIleam+9adpUeYf+"
Content-Disposition: inline
In-Reply-To: <20200226200704.34424-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2020-q1/txt/msg00238.txt


--YIleam+9adpUeYf+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 472

On Feb 26 20:07, Jon Turney wrote:
> Update dumper for bfd API changes in binutils 2.34
>=20
> libbfd doesn't guarantee API stability, so we've just been lucky this
> hasn't broken more often.
>=20
> See binutils commit fd361982.
> ---
>  winsup/utils/dumper.cc   | 30 ++++++++++++++++++++++--------
>  winsup/utils/parse_pe.cc |  4 ++++
>  2 files changed, 26 insertions(+), 8 deletions(-)

Great, please push.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--YIleam+9adpUeYf+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5W0igACgkQ9TYGna5E
T6CDVg/+LmLVCv1VcFeRTSD4F+PYiK5kyo7jt06Id1dwN8hT8Wfz1xDdkZnzWSGi
epSk9RrvdTufgzPzDukLvx3MYTgrbclkfz8NkjUjaY7foiA7lRvNrd7t2Gl5pcoP
9ETOm2s/xNyT4TkhW2Kkl1QYtH2fgUp2BViF7c4oGH/OdfFVqwhiqndrr6ZE/33H
4p7MMb2h3v4Al19cmnf7NnJCKAJgHtMS+D0gxnMvf13k8aqsXA3dhETQDFCkINFQ
5jmtv+O3cWIEmOd6WplZqjHv7hkafR45jypeBHz2xsc/V//w93fQ6XugvZ/7MzBe
qyP4Il3o5tiUkDHvb+B6gOB4fE+ngGPOuhBCynpYOqKOW88U04grovSSZnQVtJ4O
uyqT01YqGkM1CyXzIgh23AANBMkM9UBptUIZKwc9GdwPLbCXk9LcKk/OOxyXbKSv
1nUbv3wNvs5M21Zcl2djyQgiBYLj+kilQEn1vTEMPQTkB4GRd5txS/AjpejwqrME
IQW9wPFWufqE6nPSjTmTkcC8IW30T53xDZR7Tom7+z6CM/sUMT5MHb0H12+4q6nv
lfETJM4cuFYl51azaIH1pFpbCb0uwrJPpn/v3r7+NXgbtaK3Ai7sm10JSLclPKR2
gTGuFI7gImelGcxL+ybe+gs0XUghxoxTojG0TOC/i26dBx/pdp0=
=B3i+
-----END PGP SIGNATURE-----

--YIleam+9adpUeYf+--
