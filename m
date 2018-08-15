Return-Path: <cygwin-patches-return-9175-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45375 invoked by alias); 15 Aug 2018 14:54:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45360 invoked by uid 89); 15 Aug 2018 14:54:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Aug 2018 14:54:52 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LyUBK-1ftx2i0j5C-015tJl for <cygwin-patches@cygwin.com>; Wed, 15 Aug 2018 16:54:50 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9720BA805A5; Wed, 15 Aug 2018 16:54:49 +0200 (CEST)
Date: Wed, 15 Aug 2018 14:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Keep the denormal-operand exception masked; modify FE_ALL_EXCEPT accordingly.
Message-ID: <20180815145449.GJ3747@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1534330763-2755-1-git-send-email-houder@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9Wosya/OiUJZ+2ov"
Content-Disposition: inline
In-Reply-To: <1534330763-2755-1-git-send-email-houder@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00070.txt.bz2


--9Wosya/OiUJZ+2ov
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1953

On Aug 15 12:59, J.H. van de Water wrote:
> By excluding the denormal-operand exception from FE_ALL_EXCEPT, it will n=
ot
> be possible anymore to UNmask this exception by means of the API defined =
by
> /usr/include/fenv.h
>=20
> Note: terminology has changed since IEEE Std 854-1987; denormalized numbe=
rs
> are called subnormal numbers nowadays.
>=20
> This modification has basically been motivated by the fact that it is also
> not possible on Linux to manipulate the denormal-operand exception by mea=
ns
> of the interface as defined by /usr/include/fenv.h. This has been the sta=
te
> of affairs on Linux since 2001 (Andreas Jaeger).
>=20
> The exceptions required by the standard (IEEE Std 754), in case they can =
be
> supported by the implementation, are:
> FE_INEXACT, FE_UNDERFLOW, FE_OVERFLOW, FE_DIVBYZERO and FE_INVALID.
>=20
> Although it is allowed to define additional exceptions, there is no reason
> to support the "denormal-operand exception" in this case (fenv.h), because
> the subnormal numbers can be handled almost as fast the normalized numbers
> by the hardware of the x86/x86_64 architecture. Said differently, a reason
> to trap on the input of subnormal numbers does not exist. At least that is
> what William Kahan and others at Intel asserted around 2000.
> (that is William Kahan of the K-C-S draft, the precursor to the standard)
>=20
> This commit modifies winsup/cygwin/include/fenv.h as follows:
>  - redefines FE_ALL_EXCEPT from 0x3f to 0x3d
>  - removes the definition for FE_DENORMAL
>  - introduces __FE_DENORM (0x2) (enum in Linux also uses __FE_DENORM)
>  - introduces FE_ALL_EXCEPT_X86 (0x3f), i.e. ALL x86/x86_64 FP exceptions

Shouldn't FE_ALL_EXCEPT_X86 be defined locally in fenv.cc only?
I don't see that Linux exports that definition.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--9Wosya/OiUJZ+2ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlt0PrkACgkQ9TYGna5E
T6BgfA//TPtFCBPqqLdEb1Y+444At1rNg9bgQo3x+JDTlN64fhbfymcXLt6LCh4V
IpwPI+MhqTwkkYE/3jo8HhjGVoU1AMPZkHQqAP8CboA/BSnNofY3P1clzRqZys/t
QyKrPF8+BBT0lW1orIJ+GWY2v4NtnAF3WBaEqLMuXD/oyscZgSoQhBUpxGHZpb4z
ayFI4/qN/lcCH25ZfPKElY34fI6PUn1vkLIJ+ScEcUlUmkGQZ8MfpPO3dhtEhkE+
dnpOHtinEqwQW5VOq//SU8MTjt+/tgqQMpeXJyPrOzjn5d3Cntz8l1v1e0rlLhm7
4b75DD9O1OzAOvXyoCRElkFzfDs4+Znh244nkJ/Gu8hVit+WmwnmGKT+9BfS83FO
CJJZDzDl7X3n7PHexkZADgkMxmeh0eDLuAmgpCnmFRP5j4SM4qlMgR+W+CM3nQbq
BxFqQoRt0qnXg4K10TCKxGesTeuAXt0Hho8HVGh5NafKfZquC1MehLa7yfT8g+8W
O5nyt0a7H6A9BS5GzRlET8ivimGlnmuxpCKV+FUdWFSB6cXG1URdSWJfeRLeOjxv
REulp/u08v3D7rEGykrCdQyx3mNuyUJQ4Qpmf9Goru1ZpneVf9zMvgRvYMCvf6Ju
HANhcTHjJcw+WY50gZJY0l3b0KFlfZ60xIPxaEdjXfVRn9XDBbM=
=AAaO
-----END PGP SIGNATURE-----

--9Wosya/OiUJZ+2ov--
