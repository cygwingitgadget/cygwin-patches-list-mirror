Return-Path: <cygwin-patches-return-8476-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 94033 invoked by alias); 21 Mar 2016 20:32:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 94022 invoked by uid 89); 21 Mar 2016 20:32:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:1067, handful, H*R:D*cygwin.com, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 20:32:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BD0A8A803F7; Mon, 21 Mar 2016 21:32:35 +0100 (CET)
Date: Mon, 21 Mar 2016 20:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/5] Add with-only-headers
Message-ID: <20160321203235.GM14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-5-git-send-email-pefoley2@pefoley.com> <20160321194758.GH14892@calimero.vinschen.de> <CAOFdcFMC60YLscHWDzsRz3q9cF1-KAc-d=CPhS5W_LeFRb83tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/jvaajy/zP2g41+Q"
Content-Disposition: inline
In-Reply-To: <CAOFdcFMC60YLscHWDzsRz3q9cF1-KAc-d=CPhS5W_LeFRb83tg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00182.txt.bz2


--/jvaajy/zP2g41+Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1073

On Mar 21 15:59, Peter Foley wrote:
> On Mon, Mar 21, 2016 at 3:47 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > On Mar 21 13:15, Peter Foley wrote:
> >> When cross-compiling a toolchan targeting cygwin, building cygwin1.dll
> >> requires libstdc++v3 to be built.
> >
> > Building cygwin1.dll doesn't require libstdc++-v3.  The Cygwin DLL is
> > never linked against it and never will be.  Only building the utils dir
> > requires libstdc++ and that would be fixed by not builing utils as in
> > your other patch, wouldn't it?
>=20
> Sorry for being unclear.
> Building cygwin1.dll requires the *headers* from libstdc++-v3.

Still hmm at this point.  AFAICS we only need the handful of definitions
for new and delete operators, nothing else.  Is there perhaps a way to
define this stuff by ourselves to avoid any requirement for libstdc++
headers for building the DLL?  Or is that just not feasible?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--/jvaajy/zP2g41+Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8FpjAAoJEPU2Bp2uRE+gsTAP/1deJUeoZlYZe3LmVN7zcdxo
i5qYafRxhuGPempzSyW++jYZ0ZR5DQBypbuiKpLgin/6dM3w6RaNvau33TGRTO9h
23641gQd4hUJqqMaTcqroCYzdNIUbqwh2FAxa/+KCHPqmi2o1w/y6zGHy16qb4bX
K7Sk00yxIE+gUPZaisGfRcFl7Rj+mKgxj+Eyxay/ipRrYljESRPoWVRtTs2v99BF
EcGvuYU01jPRcdvfgqPrNMaGl58QsKgXlZkHghPDfyJdcNLAIcqlO20TVMCny2Nn
Jy2Xr0Fe+0QnqjOZMxB/Q7Y8IJ2xvC05e1fBp7RCKs8Jkg/7WF4hbYMdq4xlwYIo
w8sx7/qeYtSGT6kfNU+alEdjZW55immfoDzSTfMoEYtreIkdLTen6tSL00fZ1Eat
s54lU7fBQhUeq7CavB6Ui7bqYSzkSeAHPJO6uNv+zVM+bxIhrTbJnL2C1IvJnHND
Jkzlf5DNje9T5Si6HDTGUjbnKUvARAAoG68AH//dBHMDtXe78eN8tQ9f9+YdU3jg
kRNaGi/XGMKJD5JJ7KNqxz9DGA2/em1vMj5+JZfAHGJzhPpvgmq78nQDjJYzT41R
kjoaUuoWrquR4Q94Lmgm/k10QMZZmgew/B6hs+F7Ty7PdIBp1ZIXfG4dawOvhpaX
XwvYW/pYrT8NoZ/du3Sv
=tWN6
-----END PGP SIGNATURE-----

--/jvaajy/zP2g41+Q--
