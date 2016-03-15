Return-Path: <cygwin-patches-return-8403-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31799 invoked by alias); 15 Mar 2016 10:04:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31786 invoked by uid 89); 15 Mar 2016 10:04:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, ACK, H*R:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Mar 2016 10:04:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6E774A80527; Tue, 15 Mar 2016 11:04:50 +0100 (CET)
Date: Tue, 15 Mar 2016 10:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define byteswap.h inlines as macros
Message-ID: <20160315100450.GA3650@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458011636-8548-1-git-send-email-yselkowi@redhat.com> <20160315090349.GA7819@calimero.vinschen.de> <56E7D285.7090800@cygwin.com> <20160315092214.GA24361@calimero.vinschen.de> <56E7D8D5.1080205@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <56E7D8D5.1080205@cygwin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00109.txt.bz2


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1041

On Mar 15 04:41, Yaakov Selkowitz wrote:
> On 2016-03-15 04:22, Corinna Vinschen wrote:
> >On Mar 15 04:14, Yaakov Selkowitz wrote:
> >>On 2016-03-15 04:03, Corinna Vinschen wrote:
> >>>On Mar 14 22:13, Yaakov Selkowitz wrote:
> >>>>The bswap_* "functions" are macros in glibc, so they may be tested for
> >>>>by the preprocessor (e.g. #ifdef bswap_16).
> >>>ACK.
> >>>
> >>>While we're at it, what about converting the types to implicit types
> >>>(__uint16_t, __uint32_t, __uint64_t).
> >>
> >>glibc uses short/int/long long for these, so I think we should leave th=
em.
> >
> >bits/byteswap.h uses __uint64_t, but you're right for the smaller types.
>=20
> I was looking at a cross-glibc, so that must be a recent change (unless
> you're not looking at x86_64).

F23 x86_64, but never mind, it's just a style issue.  Personally I'd
prefer the explicitly sized types for clearness.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW595CAAoJEPU2Bp2uRE+gE3wP/1UYS3+sby7It8YHkSFBtXtG
kaWtzxf+307/KjbGFCjAzdrM5nlIs5dv7Xg9n3Q1OwDtlKGgAO7VmG1ZYAsW7Tst
MEQSm1O5mo1b2+5TjnQZVqwFgzOocsikyDHj71POW1WwO90BogltgLu8wNwlh+Po
EMmZxm0KcthgG+AN7oRbs0Z6EOUuiiRM3RzlQ4STAf6JanvYeU6R/zKHtLWZ/u3l
ABCGgAhtRI2K8cg8rG9lnJMN3Je75xiIEAfUJpiiQaIvkMFrUw3RN7m1/hydfe3h
G/8qKCZvCw+FoL7lyHV5Q9lKKded0JAVxXAiSGS5GKNkSjcsQbp3Pa8TPDltrOvA
569IALmiIVLPhCxN1qkkGi49EmLUQtgP5FloOBCXjEIPIQJZ+qa1y0XOwg6XY3PE
gS+HaKGUiwC1H3du7eA6WBuVzPO4I/eePwpgNtq2+MYn32YnMIQpl1mcK9rPwwC5
NLd19LI0UCMWfUcgojHv2ymNGzqza9LkpZxrblf0AmvEGQ6UKtPaMJWb+kpnyYTB
UDnsZsSZMlZZkIJZ+Wxe/2etm1c5Xoj2aEW1WoHJLrUeellZxFsIGc+M88gez5ZA
My2C/c/GVF+//FjY3QrofoWqIBaQqhxWJCrOBA/RgsgajbnEk5FVfDuiOiU2jdm6
9IsD8QOwqvIFIGWkkncP
=rT9I
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
