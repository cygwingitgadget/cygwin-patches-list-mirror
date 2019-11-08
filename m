Return-Path: <cygwin-patches-return-9819-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49335 invoked by alias); 8 Nov 2019 15:21:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49303 invoked by uid 89); 8 Nov 2019 15:21:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Nov 2019 15:21:19 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MaIvV-1iNR9T1G9F-00WFAY for <cygwin-patches@cygwin.com>; Fri, 08 Nov 2019 16:21:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 91A64A8038A; Fri,  8 Nov 2019 16:21:13 +0100 (CET)
Date: Fri, 08 Nov 2019 15:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console, pty: Prevent error in legacy console mode.
Message-ID: <20191108152113.GD3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191106162929.739-1-takashi.yano@nifty.ne.jp> <20191108092230.GY3372@calimero.vinschen.de> <20191108210131.4f7cce83de5a957e97e8aa1f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="p2u4WfPhYOuYlOsk"
Content-Disposition: inline
In-Reply-To: <20191108210131.4f7cce83de5a957e97e8aa1f@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00090.txt.bz2


--p2u4WfPhYOuYlOsk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 486

On Nov  8 21:01, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Fri, 8 Nov 2019 10:22:30 +0100
> Corinna Vinschen wrote:
> > Pushed, albeit I'm still missing a bit of description here.  Just a one
> > liner is a bit low on info during `git log'.  I'd really appreciate more
> > descriptive log messages...
>=20
> Oh! Does "log message" mean git commit message? I misundersood that
> it meant strace log message. Sorry.

Yeah I meant git commit message.  Sorry for being unclear.


Corinna

--p2u4WfPhYOuYlOsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3Fh+kACgkQ9TYGna5E
T6BVdA/9E3rl8SpJFJWz5zXRyxEeX6/B3d9cVRNh3DZEm5oIEqGuMq/KjMoGj6nI
kenvV8NXqzaJLCQ9doPv85LC+jUP1y0DNQyEzEDZl9vwfSGlHlYiYWqLhxuE6CUc
MGwgOtS4w8dZOyD9IInNYqvhbfuzIRE33VWvIjSuYuv7aeYbVBqZ3XAmk96C/qSJ
WBy4PpYCOaXaRXivdvJ0M+kjaDu6aXi8Ja3CxB3Yh1V5Gkq3DheyVWfE+sjer64p
AcRNEnw6t7tsXEb/ziQeJ6T7+WHU++1VjMfrEdyaGRbTxh4/EEkU563FpMU3abwA
W5MSyRKS3I7DEgpcRbi8pJrWSOeHYzSfZtHH/t0SHqUOAHG/JVWh5BOgbfl7yYlJ
Ju8fYPqHTp0BoMrw2bN02G8v8I/p/I5wmeOoklG/nS8SJEVfnXhi1xgwGbkMuDJD
DcVaDtYmKTAzjp13kGrxVbKJBWiTSIvGIdU2oPpl3WDsNBiinJV1g67r5rkLulPH
7OVMU40y3lRS7DsnDKWcOue2potZpwkRVoUWjivCzFKE751JvgDza/SDcdmLiwLm
VWIguEZeEe2bcTFhn4vw6m509psOkZdIospuMQWS9Tx8iOJKCwyJbZmMzqxQnEmb
z0qUeSDXD+CXCDnQTpOUXtZ3zt512FB2mTKBsQG6RMxol5Z8b5I=
=H+rE
-----END PGP SIGNATURE-----

--p2u4WfPhYOuYlOsk--
