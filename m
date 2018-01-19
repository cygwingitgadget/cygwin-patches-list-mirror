Return-Path: <cygwin-patches-return-9010-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66679 invoked by alias); 19 Jan 2018 10:20:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66666 invoked by uid 89); 19 Jan 2018 10:20:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 10:20:02 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 1DE08721E2823	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 11:20:00 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id D50F15E0091	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 11:19:59 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D297FA8095C; Fri, 19 Jan 2018 11:19:59 +0100 (CET)
Date: Fri, 19 Jan 2018 10:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/3] catgets APIs, gencat tool
Message-ID: <20180119101959.GI18814@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180119055837.13016-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline
In-Reply-To: <20180119055837.13016-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00018.txt.bz2


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 562

On Jan 18 23:58, Yaakov Selkowitz wrote:
> This adds FreeBSD-derived implementations to replace the glibc-derived
> standalone implementation shipped in the catgets package. An integrated
> implementation avoids the need to remember to install libcatgets-devel and
> modify the build to link with -lcatgets.

Do you want this in 2.10?  Otherwise I'd wait with adding new features
until after the release.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlphxk8ACgkQ9TYGna5E
T6CneA/+Irv8SBrdOORcbI83WU+kz70wKBha79GXbzGBg7KIwL/8WJItb7/zyDDV
4TtHZMO2+XlOen8WpKdQfQP0HTzmG5HgyVVdQmTPpro8gNZAOWSaXZihkwKTSPET
A9ND1g2nCykmGtbmbrIO3kcbsG8AhN90E8kJo+gmtrqEaX/HfO0Gf/xuDhig+ezN
kqjoGhrfzD7gnxPPxboImwBcBxIgl31ADwr9UsiV9pKgRZTcxx/MKzqb21SBq/1W
+N3QHo68dHrcoaeuvEJOKXsjZviq6gkKAWdihZFQvjnobPUK8kXYphG9AnsXdiLu
TF42qdWBxuQKHXTp339gyfDp6Iua6QczY9p9cPbEhjZk4VaDRwU/IB5zr96rA+LW
6Lp0TYv0dfCVayPgNy0mfTLRJtbyP0l0LWZXOemvP9Em1Dp1omAUvF7NnWgvLv5M
SbV5lcktY9FqbbdFj7MEVum2fn3rMIJ1ch7fkoAvcDdqMqlvBCeT6yqQpepQMmml
sgOkCUe8gmdvcGM5M/EEs7SmbXyCUwAlB9B4sB5dxRDvXQihMQRLU9ZskgELx06E
Ado3vijTSSLzV43CguRWLblx22Xgb+WKRsDgmAIH973Gp3OTARyL0UrUVfOy7BtG
8VaTtEdrwjHhSjbh6geduxToe64yRQzQuHGzLkEIUEK6PxHGryc=
=wHzI
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
