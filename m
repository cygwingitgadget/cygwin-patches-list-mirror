Return-Path: <cygwin-patches-return-8663-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9935 invoked by alias); 9 Jan 2017 14:43:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9870 invoked by uid 89); 9 Jan 2017 14:43:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=environ, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Jan 2017 14:43:12 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id A1A63721E280D	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2017 15:43:05 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id C7F525E0210	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2017 15:43:04 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AD621A8041E; Mon,  9 Jan 2017 15:43:04 +0100 (CET)
Date: Mon, 09 Jan 2017 14:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Add support for /proc/<pid>/environ
Message-ID: <20170109144304.GA13527@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170105173929.65728-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20170105173929.65728-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00004.txt.bz2


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1799

Hi Erik,

On Jan  5 18:39, erik.m.bray@gmail.com wrote:
> From: "Erik M. Bray" <erik.bray@lri.fr>
>=20
> Per this discussion started in this thread: https://cygwin.com/ml/cygwin/=
2016-11/msg00205.html
>=20
> I finally got around to finishing a patch for this feature. It supports b=
oth Cygwin and
> native Windows processes, more or less following the example of how /proc=
/<pid>/cmdline is
> implemented.
>=20
> Erik M. Bray (3):
>   Move the core environment parsing of environ_init into a new
>     win32env_to_cygenv function.
>   Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and
>     others.
>   Add a /proc/<pid>/environ proc file handler, analogous to
>     /proc/<pid>/cmdline.
>=20
>  winsup/cygwin/environ.cc          | 84 +++++++++++++++++++++------------=
---
>  winsup/cygwin/environ.h           |  2 +
>  winsup/cygwin/fhandler_process.cc | 22 ++++++++++
>  winsup/cygwin/pinfo.cc            | 89 +++++++++++++++++++++++++++++++++=
+++++-
>  winsup/cygwin/pinfo.h             |  4 +-
>  5 files changed, 163 insertions(+), 38 deletions(-)

Patch looks good basically, but I have a few nits:

- We need your 2-clause BSD license text per the "Before you get started"
  section of https://cygwin.com/contrib.html.  For the text see
  https://cygwin.com/git/?p=3Dnewlib-cygwin.git;a=3Dblob;f=3Dwinsup/CONTRIB=
UTORS

- While this appears to work nicely on other processes, it seems to be
  broken on the process itself.  Did you try `cat /proc/self/environ'?
  I'm getting a "Bad address" error when trying that.

- A few formatting issues, see my next replies.

Other than that, thanks for this nice addition!


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYc6F4AAoJEPU2Bp2uRE+g1iQP/1qZ02sShMGW8cFc4KrQ5Bcn
mhZktmwm1tj1ikvwQFreMstQWKKIWioOYtHeplkO0bzCKX8+bubeCetzUzgm1qjR
3BtHR7qm6j4BMSDiM15W6Efhq6mum5Rm0RnayoBjss60ds7OfwpdKnF78mH9L1EH
571lSKP+mtzu33d4sK6dEckHDgHctwtcPtS4rewgjc+UOPvYAsDa35obX+TgcmEP
K14eAXpafIsN6laemZUGs4vUp22DgtECNCRhbG3J+nrgdgtTqClS48e6FCmWXnZk
Uoo+vQqjFdsoZhYlp4wt06UvOAWiJ5ttbSFqx8LMQrA9BA0TYMq4NZPutley245Z
207KCvfuHGUI2s7F1SqKtgmeT8TyeLfOqIERQ5Dr+k2lc8psFxA8gpH2EuGKRvyY
5z6qB2I2ix1tpWFEO1tXAmatvgfAghYiWjYka/8hlo41GHyDuDoSw6EXg/WSM8YA
MCmC2bhLF+W6JFspaY12BN1TJ3/C7M7PJ6DdmN9h8jyW6oLwwPF7ZXoh0ZnrdJk2
a6/4RvoufHe3r16hqd7IYP/z/Tx94exOEnyQuIKmGEED1Mi8CH7hJSBO4Po6+GhS
XlbPKloDr3a/nHGqBIoWC4Z4pUhAWUSj3fhsoKN6TOa6hP9NeOOQwbsQPvu54VGl
XYTPfCB34y5GQOSO0/gA
=wDTO
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
