Return-Path: <cygwin-patches-return-8526-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27834 invoked by alias); 1 Apr 2016 12:16:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27229 invoked by uid 89); 1 Apr 2016 12:16:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:1096, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Apr 2016 12:16:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B7A32A8060E; Fri,  1 Apr 2016 14:16:01 +0200 (CEST)
Date: Fri, 01 Apr 2016 12:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add without-library-checks
Message-ID: <20160401121601.GB16660@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459442026-4544-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <1459442026-4544-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00001.txt.bz2


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1096

On Mar 31 12:33, Peter Foley wrote:
> When cross-compiling a toolchan targeting cygwin, building cygwin1.dll
> requires libgcc.
> However, building libgcc requires the cygwin headers to be
> installed.
> Configuring cygwin requries the mingw-crt libraries, which require the
> cygwin headers to be installed.
> Work around this circular dependency by adding a
> --without-library-checks configure option to skip cygwin's configure chec=
ks
> for valid mingw-crt libraries.
> Since the mingw-crt libraries only require the cygwin headers to be
> installed, this allows us to successfully configure cygwin so that we
> can only install the headers without trying to build any
> libraries.

Can we please fold the --without-mingw-progs and --without-library-checks
into a single option?  Given the task is basically the same, the option
name should reflect something along the lines of "cross-build",
"bootstrap", and "stage 1", IMO.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/maBAAoJEPU2Bp2uRE+glMEP/j7N+QluMEo+jFExB9mXPg9f
2DrWT/DOTHtozWIbERuiNptxrkG+7kVVVLNGopHKTqYLfE3/WiOOxxo52aOUUZ7z
gSPzIZ6l7DHR7V/yWqBTyvdQ7Zt1o8UBZV3L6KlCFqUMiXUihPF7iyjpQbEhe9VQ
tTTxH5IrgouD6t3x3hh8FYEkHJXlkBf7VBGcIMGiA4nBMkTE8J5yXSlyhQlCJDB4
BgP2VdiyyJyNhQ2sQhAy1GzKFmX2I4EWqaYBlF0QB6byILBX4XvCYF9IFmyGJSDc
seGLex8EZ7gcY56fipAMWkZ8yuKRVWhT+rHBhmLXKMFNB+hF1qe4FTl9GmfiiO4g
n6w4rhAAqX0z+TGRutShELVBv+ynOrzjisyUUkbtQah3uSaunnTqXpYx7IiQd+wY
8KPAXKgGoFnulpmXoW1ZcpH8c80c+RnjJqJevh5olt8aeCAh0xn/8EyH39JrBQ91
XtHGXqdGxNhDHwXRFzcLa2tcA7zeIWwtQNP/9qGJwhWM+3uBKX2LCZCM6cZEc2CO
aYWoItJVMDKDOFDGscuGCp6OwZ+sEg0YPWRSiRHjyHp6twpoFeoE+zlI6eVv74Qx
jtyT4GJdnotnAjo3038ARqAmWqko+24J9ia3//JbiWesqTZzGVwAzDRDl8WI2ogs
n5Id172YWvKUcN0IHfoW
=m2CW
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
