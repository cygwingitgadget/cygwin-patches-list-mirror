Return-Path: <cygwin-patches-return-8386-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 34057 invoked by alias); 10 Mar 2016 09:40:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 34046 invoked by uid 89); 10 Mar 2016 09:40:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-93.9 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, Maintainer, Geisert, geisert
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 10 Mar 2016 09:40:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 58954A805DE; Thu, 10 Mar 2016 10:40:53 +0100 (CET)
Date: Thu, 10 Mar 2016 09:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Support profiling of multi-threaded apps.
Message-ID: <20160310094053.GE13258@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56DFE128.6080308@maxrnd.com> <20160309224400.GA13258@calimero.vinschen.de> <Pine.BSF.4.63.1603091646490.69685@m0.truegem.net> <56E131C6.5080008@maxrnd.com> <20160310093933.GD13258@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <20160310093933.GD13258@calimero.vinschen.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00092.txt.bz2


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 888

On Mar 10 10:39, Corinna Vinschen wrote:
> On Mar 10 00:35, Mark Geisert wrote:
> > This is Version 4 incorporating review comments of Version 3.  This is =
just
> > the code patch; a separate doc patch is forthcoming.
>=20
> Uhm...
>=20
> > +		long divisor =3D 1000*1000*1000; // covers positive pid_t values
>=20
> ...still "long"?
>=20
> Was that an oversight or did you decide to keep it a long?  Either way,
> no reason to resend another patch version.  If you want an int32_t here,
> I fix that locally before pushing the patch.

Oh, btw., do you have a sentence or two for the release text?  Just
a short description what's new or changed or fixed.  Have a look at
winsup/cygwin/release/2.5.0 for an informal howto.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4UElAAoJEPU2Bp2uRE+gWsYP/0So3J4ud5v0NTAAHOMUgHMa
CezhrhPiPAT6VM+5IePH/qOG7b3UqhRU3V7Yzt3Y7NxUaACkU0wvxJks42xYXUyH
1iQ3juE069CZ1CENhm72Yz5yiBsR5Bm56LRRDePpAiVaZtkGGaGoyl8/8/UmozGI
7ZZE9xhbzfiyaUWBZmHEp1N93btIf8mWPDIfqYiIamPj/P9u2lzjPAoVZ3Li0GXU
akoqWN4P+YnKxxKpxuF7CZa4AlkEHMLyxSYZh98L/ZSwM6Ae+EnBTeFnViC6EbAR
R7R1qZ022L9PyVTGGFqQun+tjXcTEPBIpEOnlFEgB6i7DsciHK+jg+JrHinj39n6
sHtyAHZsoj0qS3+aA/Es9ctKBpMBq6XimIX+ae5J/BMHO2Xcw5Wzfsk2t0IZfJxy
abT02/D2RbLO95kXJSNVF8m1IT0eVnRzVquXLSx6+bsBMN/hJXVebpZJiJzJN2eu
ahlxseiY7AEFJYT7JFb6IK0RMLGzZXeDRyIqufCXHASgJ2x/w+qeu/qfeBJNf00N
qAoXwpd7JEvX1Yx0e5CUqeyZ1n9X87APRc4GwIjhUjtJdD3MKDxsOzE9wJxGvCjt
+GfXLPbI7/U/WLUjMIp0W61MA4Gp0tDQeHVBXLIODEjwC5PqcWi3oBSWqbRFYMr3
32aVDIf4OyRxNtrY8pr1
=h+rT
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
