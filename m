Return-Path: <cygwin-patches-return-8375-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37191 invoked by alias); 4 Mar 2016 10:58:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37173 invoked by uid 89); 4 Mar 2016 10:58:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-95.2 required=5.0 tests=BAYES_05,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, 04.03.2016, forces, 04032016
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 04 Mar 2016 10:58:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B7DF2A80632; Fri,  4 Mar 2016 11:58:10 +0100 (CET)
Date: Fri, 04 Mar 2016 10:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
Message-ID: <20160304105810.GD8296@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de> <56D43D9B.5020602@dronecode.org.uk> <20160229125813.GE3525@calimero.vinschen.de> <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de> <56D466A6.1000003@redhat.com> <56D47828.1090208@patrick-bendorf.de> <56D48611.2040704@dronecode.org.uk> <20160304085606.GA8296@calimero.vinschen.de> <56D953E9.7040207@patrick-bendorf.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <56D953E9.7040207@patrick-bendorf.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00081.txt.bz2


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1080

On Mar  4 10:22, Patrick Bendorf wrote:
> hi corinna,
>=20
> i might find some time this weekend. this last few days were just
> too much to look into the issue.

Cool, thanks!


Corinna


> patrick
>=20
> Am 04.03.2016 um 09:56 schrieb Corinna Vinschen:
> >Patrick,
> >
> >On Feb 29 17:55, Jon Turney wrote:
> >>On 29/02/2016 16:56, Patrick Bendorf wrote:
> >>>thanks eric.
> >>>just changed and tested it.
> >>>hopefully the last patch for this matter.
> >>>
> >>>@corinna: as attachment to overcome previous problems.
> >>Unfortunately, this still isn't quite right, as it forces the 2nd invoc=
ation
> >>of the compiler to be with LC_ALL, so localized compiler error messages=
 will
> >>not be shown for actual compilation problems.
> >>
> >>So perhaps the setting of LC_ALL should be in the implicitly forked blo=
ck
> >>after the open('-|') ?
> >are you going to look into this by any chance?
> >
> >
> >Thanks,
> >Corinna
> >

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2WpCAAoJEPU2Bp2uRE+gJh0QAIJeb6hmJaFhcofS6MXtoDOq
iljUbAm+3+egGkjGo3CBpLYZaG6uYZDh9cDVMcTVlXHsvWValXkNsdRqDboTuEUy
k/4rtB8isF/GJNUP8be/saPRuiQ1HiUdNFowbZx7vBOaW5Cp7YxxbPZaVyhA2hPh
NHhzQ+6jVHGoSG9UvKY9w7MLcocQrgXUo/m0spAi6Eb1xu3SJNhuy9mn24QeNzBk
IpMmHul6bI/m/1GfoUqn65Ji2L2tASOjInlW7uj+JxR3Zb+GzkWcHKdXej7wU2Yh
q8S1QrCbwwtYpgKN9KBhFNHqOQhniBTIqwI34XtEA1k0rrqjKcpVN1XAlcm2jTpp
AZVU90PZcMXWfgnZ0czQZ3RJ8d8/l5PaZeLBD1uMepdiuNYi/EaLpU5x95e1f9tR
skHarzx/GRZ9KyVZuM/wjg9AlZ70GI5Ogq5wfnSGJncsChT3h5kiifi6Fd9q4joD
8UOw0s0Z3CEu3xeC1xKitZNivquyXuLyMtAKuqucnrVKVmYXHwXmyAPB5OFD8rLE
wZLGBBM7BQeG2xZfUC/iQ9NSi/26TJkDSZY1DrANtYs/Fjc013N0AniHfh1naHXE
lpfZ5gkwrzdLzkhD1JXvml/TbvylZ+hHd6OPtrGk684WLcplEzFaTxQ1DUcKAFru
BkDWtmrc8ibGE7UK5OYR
=mOlZ
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
