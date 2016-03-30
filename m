Return-Path: <cygwin-patches-return-8500-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88536 invoked by alias); 30 Mar 2016 12:11:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87575 invoked by uid 89); 30 Mar 2016 12:11:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 30 Mar 2016 12:11:48 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 94D04A80909; Wed, 30 Mar 2016 14:11:46 +0200 (CEST)
Date: Wed, 30 Mar 2016 12:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/3] Add option to not build mingw programs when cross compiling.
Message-ID: <20160330121146.GH3793@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-4-git-send-email-pefoley2@pefoley.com> <20160321193052.GG14892@calimero.vinschen.de> <CAOFdcFM-9XOAEPhSWbED_eiECu-UeWW2FBkg-u8jo40+0FwAjA@mail.gmail.com> <20160321195845.GL14892@calimero.vinschen.de> <CAOFdcFMJon17kNFhOVBccrrUJH0PmD6Vsf75FO9QTAv+qf_d0A@mail.gmail.com> <56F0A4A9.7050305@cygwin.com> <1458740052-19618-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <1458740052-19618-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00206.txt.bz2


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 506

On Mar 23 09:34, Peter Foley wrote:
> Add an option to not require a mingw compiler when bootstrapping a cross =
toolchain.
> Defaults to existing behavior.
> Also update some obsolete macros.

Applied with changes.  The below check was skewed.

> +if test "x$with_mingw_progs" !=3D xyes; then
> +    AC_CONFIG_SUBDIRS([utils lsaauth])
> +fi

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW+8KCAAoJEPU2Bp2uRE+gM40P/j4NHZ3nCYpfyarDkkmzSisq
ci+pD8rnsEDFJk+MGNvT7nAECV+4XTU3RN0+s6oRvV0+h3r18N3WXKwLiBj8wIjq
tY1WzR0R0VZXOMdqhWbqBORzRV+UbbzBtA7BGV+AXj8ejIa5HuHYCQDraCofqdEY
Cix3WqO9d7Xk+bFJo2GkAxYYMM21ed34Sm1iqWYjnaJaEpFBdAe9XXzoXH9heXh6
UFdZwccnBHYuIVGB1hoXcTtH9wO9zn0rGME2fWw8hRTh+JTe+/Gxvgnh6sw2SIw4
7DqpusjXWoGRXf+Ri/hX6BZlP6MECBvSSypmNOKrPEA3r4VWkfkNvHH0drhY8fmZ
Q7FDmfjim9JOTIZgjKQwsttZSIw05OLZIZUh7wTf4v+Y9fcFR37gM+ndS4mznRph
QJdlYpA2+hbFfeBhWSc1fBxPoapUrnIoWWqAcnaWBTAtcyDp2dAy3W12zsSCkDrA
wjeAaTJNHCnPa7MrKKxmpjCRE14rJ7wfkg9scyxnMV3AeoX8FobCqH6G/4J5AAE2
aEucZsTLCkNwu5ayy0BliAmaxgitK56BIAouQBqlOsUvDvvdI/XCcpo8qGQIFDpm
I7F7oQ/d+VA8XZg7+iboMXuSoMocGbUGGkBjKvRvOyz0sXis/2COxN7buJTdXKHF
GfZhEGh5t4HLPtaSp4Zr
=G0i1
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
