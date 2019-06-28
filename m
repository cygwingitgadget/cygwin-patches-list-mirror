Return-Path: <cygwin-patches-return-9477-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30070 invoked by alias); 28 Jun 2019 15:14:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30061 invoked by uid 89); 28 Jun 2019 15:14:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Jun 2019 15:14:01 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mc06b-1iH1bd1uiF-00dT4j for <cygwin-patches@cygwin.com>; Fri, 28 Jun 2019 17:13:58 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 611E3A80734; Fri, 28 Jun 2019 17:13:57 +0200 (CEST)
Date: Fri, 28 Jun 2019 15:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: Fix return value of sched_getaffinity
Message-ID: <20190628151357.GG5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190626091641.GS5738@calimero.vinschen.de> <20190626094456.57224-1-mark@maxrnd.com> <20190627071305.GB5738@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="dnBRaVjvtun1Q0Od"
Content-Disposition: inline
In-Reply-To: <20190627071305.GB5738@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00184.txt.bz2


--dnBRaVjvtun1Q0Od
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 753

On Jun 27 09:13, Corinna Vinschen wrote:
> On Jun 26 02:44, Mark Geisert wrote:
> > Have sched_getaffinity() interface like glibc's, and provide an
> > undocumented internal interface __sched_getaffinity_sys() like the Linux
> > kernel's sched_getaffinity() for benefit of taskset(1).
>=20
> I put this patch on hold until the problems with using the
> RTEMS headers are fixed.  Basically the patch is fine, but
> *if* we introduce our own headers, it might be a good idea
> to move the definition of __sched_getaffinity_sys into our
> own headers.

Patch pushed with a minor change.  I moved the dseclaration of
__sched_getaffinity_sys into the new winsup/cygwin/include/sys/cpuset.h
header.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--dnBRaVjvtun1Q0Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0WLrUACgkQ9TYGna5E
T6Cnvg//eXJEjZ2xuWjcj07jaUB7BkvTn42JmWxmXX9E4iGEi8yVzmEYbgGry5nh
EGZ/AMmKlGu5/qea5tSMiKZq2iKt+BWahDfk7ZsTxCa3u3I8xHzQj1QRalGpRife
JnFck4DshhgKLxaNElHwInO4X22Ax/5xeksP0Kr3iGgKx89fPATZmpSOfbpQqSmS
AOubsijfYL4p+VEOlzv+QeSg7orU+jQicJMHGltBNcZ27epjMCmCCNIMjE2RJ+pb
XuhxXmafgznsyoUj7TpBOkMLxp0H1PVgZfujHcflkb3Kq2lE52yFrQbGihtO68Qi
7bwPouRjX6hxlEfDBZf9bPibD9YbZQKWp9wPHkjGFKRGfK4uTOGPxJp+NLtYg1lz
lTxsCl0MHEOXrWcWFxvgoxOGcc+bj+FJq3lZkwq+RWay2PleQPn3TAEJvCxhE7qM
XzcpoYgvY19niU/wQoPm8fikuE8n2Kn3e+c0TxhxQSnvs4k4nzdZAyIw6S/DgOb7
5LoLg4rg01Xdj/N4MIpgVAtksq2ZFSbzDv617895ZVcScd4MLqFIkQmmuRlmE/jN
kLR9a1XV5YsfCwe4QCtruQbevPj1EbY3g/UbPRTozYRwANzYS9+xhT37fr/kmfvB
58hAPqLRyaaESY1xNCuxULY0Q9p2sPx9vRdIQNwKLbuvFi9Rb64=
=aPO5
-----END PGP SIGNATURE-----

--dnBRaVjvtun1Q0Od--
