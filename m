Return-Path: <cygwin-patches-return-9768-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76314 invoked by alias); 21 Oct 2019 08:18:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76301 invoked by uid 89); 21 Oct 2019 08:18:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-118.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Apart, H*F:D*cygwin.com, USB, device
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Oct 2019 08:18:48 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MVv8f-1iTn043TCX-00Rmxi for <cygwin-patches@cygwin.com>; Mon, 21 Oct 2019 10:18:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7AA26A8073B; Mon, 21 Oct 2019 10:18:44 +0200 (CEST)
Date: Mon, 21 Oct 2019 08:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
Message-ID: <20191021081844.GH16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87mudvwnrl.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <87mudvwnrl.fsf@Rainer.invalid>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00039.txt.bz2


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1316

Hi Achim,

On Oct 20 15:27, Achim Gratz wrote:
>=20
> This was requested on IRC.
>=20
> >From a80b1c9ba67f94237948e85ad2dee744cdfbdcad Mon Sep 17 00:00:00 2001
> From: Achim Gratz <Stromeko@Stromeko.DE>
> Date: Sun, 20 Oct 2019 15:23:04 +0200
> Subject: [PATCH] Cygwin: provide more COM devices
>=20
> * winsup/cygwin/devices.cc: Add another 64 COM devices since Windows
>   likes to create lots of these over time (one per identifiable device
>   and USB port).
> ---
>  winsup/cygwin/devices.cc | 64 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
> index 2e31ca366..7a57459d8 100644
> --- a/winsup/cygwin/devices.cc
> +++ b/winsup/cygwin/devices.cc
> @@ -798,6 +798,70 @@ const _RDATA _device dev_storage[] =3D
>    {"/dev/ttyS61", BRACK(FHDEV(DEV_SERIAL_MAJOR, 61)), "\\??\\COM62", exi=
sts_ntdev, S_IFCHR, true},
> [...]

That's not the right way to patch this.  devices.cc gets generated from
devices.in by the gendevices script which in turn calls shilka from the
cocom package.  Apart from the struct members you added here, it will
also add some code.  Which, unfortunately, raise the size of devices.cc,
especially troubling the 32 bit version.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2taeQACgkQ9TYGna5E
T6D4WQ//UJwmbVHm1NbW0UmMIwE4KABHhPFBr33J37JtFL5MOlYOtdn1Y0j7/f8j
SyuFNs/U154UxePFhhkDDI1AJPtGOF+W7BSwN24Gk1Jtkx2oAbP3tnmpBc5PUiLW
iblKxDu/X/ZQLsblYxOXCz4YZeel5lFxGSL3UnnN6O3c04nuuuVFoEuET0T/5rYf
2GK/OpM8rHsOb1gZnHrIXcYtM3aMpoLwoavqfJhk8D1kcPtSdiD8UZ6I5NMQDgNN
YFhQ7Cl6QkemEgecKtHTDtAvkjTvSSNZf160ua4g2HRGkpRaI65Fv07j662rMnM4
od1CXd9kqaJ096OeibcZkkTJjgHDVooTmFh8vv+dFTAxTQPFWI1KcIIMFiYZROlq
ECb92wR3Cra8UH9iFB5BD6lVpNU3+rcqIkEHsSmLsjHSbUrCXLHY022HqGMEEjo4
qSFehhxjbz8hY4HsJ4FkZjaTbqacaISXSRGIisd1nal2cRM+036xB/v/t4VsyFBJ
nyNEHi7xwAdd++PTR+T3Ja6juyJxhmcSufNTNPJ1qk0V0ZADlhYJiUieGN0EhnFC
k9nJzZtExfRq6C+N79OqJE/ng9XpqB1J80anaSy5eqaYnoB/kqdhO+IEiH1MVYs6
CvR6rPBbK3tw9mAQBXl2hLxo0doN0XgVHqZgQxZLfg6RDWaOttA=
=GIqC
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
