Return-Path: <cygwin-patches-return-8667-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128132 invoked by alias); 9 Jan 2017 16:58:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128090 invoked by uid 89); 9 Jan 2017 16:58:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=cred, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Jan 2017 16:58:48 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 747E6721E280D	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2017 17:58:45 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 12B4D5E023C	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2017 17:58:44 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F15A6A804B0; Mon,  9 Jan 2017 17:58:43 +0100 (CET)
Date: Mon, 09 Jan 2017 16:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Return the correct value for getsockopt(SO_REUSEADDR) after setting setsockopt(SO_REUSEADDR, 1).
Message-ID: <20170109165843.GA27881@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170109163647.86144-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20170109163647.86144-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00008.txt.bz2


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1123

On Jan  9 17:36, Erik Bray wrote:
> ---
>  winsup/cygwin/net.cc | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
> index e4805d3..b02f9e3 100644
> --- a/winsup/cygwin/net.cc
> +++ b/winsup/cygwin/net.cc
> @@ -925,6 +925,14 @@ cygwin_getsockopt (int fd, int level, int optname, v=
oid *optval,
>  	  res =3D fh->getpeereid (&cred->pid, &cred->uid, &cred->gid);
>  	  __leave;
>  	}
> +      else if (optname =3D=3D SO_REUSEADDR && level =3D=3D SOL_SOCKET)
> +    {
> +      unsigned int *reuseaddr =3D (unsigned int *) optval;
> +      *reuseaddr =3D fh->saw_reuseaddr();
> +      *optlen =3D sizeof(*reuseaddr);
                        ^^^
                        space missing

> +      res =3D 0;
> +      __leave;
> +    }

Indentation of this block is wrong.

Still, good catch.  I fixed the above manually and applied the patch
as obvious (otherwise we're still needing your BSD sign-off).


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYc8FDAAoJEPU2Bp2uRE+gT1gP/AqachPRnSNUWnWgDrcpFdlx
YFUrVUiKsbIfAclNabHek7+skjRzJpWdZ8yxVoM8/7Yb2rejz0JiVxP2fDPeMxof
V9CWQc8AIrjYAf0KO3opXnYoZASythW6kXIqgJsfXLGSEjnup/OcFvikAB8RHpm2
7DO+bpx/Kk2RyAEiVw1kYdU/pHktnIxC/oVspwmrk5rmJTTsj0ejW3THk1qlHIIF
FsBBhAJcAj0kPQ7/sokZPeWMPDZ/EEwDx5WrQuKPbKjlzCn9WHw2mHP+uV4EyeNW
hbFNH4fzREKalCYq8fKO+iwS9hp022UCblLDrJZK+SsFpemr4ynOJY7zcq/nt7mJ
yVrtZqNnw1TWpxEvsSi+m5Y8TTXG2NEaJJ1dvRkAhqyYsg/7OTvq1tB/c9COb8+b
WwLABUYMOykQYLaImD3in9bzF68GJHVr58zXFd/cXdnM5icnpFAN7txM55eWU4Qg
RxS+O1FVrwhHo7bbcoExiipS+UzSD/UHKzek1CooFqyNI6VcEk0d8IdWlU5An1MD
I4mxEz69ligqtfUGY9icI/HBrfxZUrre1JWMHUUxBe3O8gb2+57gsH9o2a2yvMve
67fIWhCwDO9rI3utEPy/d3qu9lb7pB7BEXWlWpXHk9hbAOSKd6MV2KYrKWjLu+ua
+OUqvKdrp9XH5letStNg
=XDWl
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
