Return-Path: <cygwin-patches-return-8401-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86305 invoked by alias); 15 Mar 2016 09:22:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86287 invoked by uid 89); 15 Mar 2016 09:22:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=H*c:MHH, HX-Envelope-From:sk:corinna, ACK, H*R:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Mar 2016 09:22:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2D1D4A80527; Tue, 15 Mar 2016 10:22:14 +0100 (CET)
Date: Tue, 15 Mar 2016 09:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define byteswap.h inlines as macros
Message-ID: <20160315092214.GA24361@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458011636-8548-1-git-send-email-yselkowi@redhat.com> <20160315090349.GA7819@calimero.vinschen.de> <56E7D285.7090800@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <56E7D285.7090800@cygwin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00107.txt.bz2


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 812

On Mar 15 04:14, Yaakov Selkowitz wrote:
> On 2016-03-15 04:03, Corinna Vinschen wrote:
> >On Mar 14 22:13, Yaakov Selkowitz wrote:
> >>The bswap_* "functions" are macros in glibc, so they may be tested for
> >>by the preprocessor (e.g. #ifdef bswap_16).
> >ACK.
> >
> >While we're at it, what about converting the types to implicit types
> >(__uint16_t, __uint32_t, __uint64_t).
>=20
> glibc uses short/int/long long for these, so I think we should leave them.

bits/byteswap.h uses __uint64_t, but you're right for the smaller types.

> >Also, do we want to convert the inline code to use the x86 bswap instruc=
tions?
>=20
> Possibly, but SHTDI.

Yes.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW59RFAAoJEPU2Bp2uRE+gGz4P+gLsnuez0gKIUqTrSEnrthmb
V6pUZfHT0Wx4iSUsIBAmiIwcE4ihFg3GWx5EQUjvDWaLFww4PHmuNfbwAtAXAILE
wXRZU0gIMYOv3ba5KthCpLDvCGM5znSc8zeV+VvMxzg43MBe5o+QJPAgvAVOmzc9
PVFjco3Jsb5MFKAx4NQoavQvOm6xQTsBxPXe/XY8AJxbWaDXD5scuaLMqAtBHZLI
9o3Q6ui4wdWJtiw87wuTwMKhJbUq2FdNKylAVXnib1xR1AdnPBlDKmgssavga5dQ
9DohFnAVmZF9JZDuPcTZ7ZEnwwLxmvFCelOUcUqq5ZlScYTdyPEjQgYgzUGFcsbI
Utz2Dw/k5rX/fm6ErzG864G4LRdggIjsq/C0KuKzz7QGyail6m+0pxy1thnp93mt
CaQqt5W1FZuHkg4MUU/g5BwJ873tTYbjRk007nQDiBtZncBLaq11tkSSVReSRRAq
ynkPD7NedMzpxnzdjblDN8/B4OncsbtcQrxhBXV765BTB6cWPPeBpZkOObhCm+7N
xHXsX8l+hTsfW7sg2lcBAhDOLgOtgheybLhdRfdX51+zKgixpiXMAPvDMT1GKyO+
VJ7lx/10XjBD0GB1n4DUj5/E/5z9TgZNYlrMd1mOUovgZb1HerTGMolm0ss7LV32
2dYB7sxA3eZw1npsgYNF
=p61l
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
