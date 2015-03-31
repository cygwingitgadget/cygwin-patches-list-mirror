Return-Path: <cygwin-patches-return-8098-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63770 invoked by alias); 31 Mar 2015 19:20:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63754 invoked by uid 89); 31 Mar 2015 19:20:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 19:20:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3B63DA80A3F; Tue, 31 Mar 2015 21:19:58 +0200 (CEST)
Date: Tue, 31 Mar 2015 19:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix error mapping in gethostname
Message-ID: <20150331191958.GG15852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CANRwAThfiScOKXc2fOQKOcPLNnJYLSSzQoL5T0oP=eAAC8S+8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="kadn00tgSopKmJ1H"
Content-Disposition: inline
In-Reply-To: <CANRwAThfiScOKXc2fOQKOcPLNnJYLSSzQoL5T0oP=eAAC8S+8g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00053.txt.bz2


--kadn00tgSopKmJ1H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 644

On Mar 31 15:23, Renato Silva wrote:
> The gethostname function has a problem where a small buffer size will
> not produce an accurate errno. This is because the Windows error is
> not being appropriately mapped. This causes programs such as hostname
> from coreutils to fail because they are not informed about the long
> name.
>=20
> Changelog entry:
> 2015-03-31  Renato Silva
>     * net.cc: Fix buffer size error handling in cygwin_gethostname.

Good catch.  Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--kadn00tgSopKmJ1H
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGvNeAAoJEPU2Bp2uRE+g1DcP/2xxFlkhP7Vfc2HegFYlKUwD
2tVdS3EVOBgljUyfO6Zty5ABMfFqktK+xKuHsKMXU+0/6L+eOBPMeyRtgBf0+PhM
U/Rgi5RY+aclaCZhDkhGxPkmBYCo+tocyYOEqO3ZW6QT0K7RJiPEoEXFwpr6M5SV
WYnEMXBB8wChl5mOSkpyM3sJHvgjFeyyzcPTAbcd+JlwQZd7pGH2gI4KbZ54gFOV
U3/1iUITvmJ1/37UVcHnrnq0GcvLIh92xJAbr0Z6ySY7GHrJ5DFvGpAIp187na+c
rC9QBBk11rjvvMhqs+r+xlsOP4JGWWKjjDOgQb0WdmUKUt7PnqqD318W31VIyJVx
DKk1JwpsK0HvlnkRTP+ficuRKbXZbOSUtHv6p+n8OS7pd/JkTrIL+Fgp3E5EMBH0
wFIvKKBfG1xtA3vEsLXRFnuXBa4p+QGp7QiQ1oiJJ1UAuogEbHCEFC4v2zhM4ifb
XuizqHqezuw69jo+Xxnv9La3nRxysTI4UoFAOAaFkN2EU09cEImRZ6eQYRsz+iDC
JwH3BHK7slUkcDJlIyFSVvGZI0tOTWsndUTjboCEDFH6+YjqRgVQ2aQK1epsei7W
+JxohSEaWNgX9ELkg+Wfo48Z6ApHkbXyRDv3+oGDTI/FLh9GgmsAJ9DzYlK6SRYr
09ZRPULbndTiRfEh8wfO
=bhuF
-----END PGP SIGNATURE-----

--kadn00tgSopKmJ1H--
