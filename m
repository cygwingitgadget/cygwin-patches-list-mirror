Return-Path: <cygwin-patches-return-8979-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51578 invoked by alias); 20 Dec 2017 11:51:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51552 invoked by uid 89); 20 Dec 2017 11:51:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-100.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 20 Dec 2017 11:51:25 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 03419721BBD15	for <cygwin-patches@cygwin.com>; Wed, 20 Dec 2017 12:51:22 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A74EC5E034A	for <cygwin-patches@cygwin.com>; Wed, 20 Dec 2017 12:51:21 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2123CA805FC; Wed, 20 Dec 2017 12:51:22 +0100 (CET)
Date: Wed, 20 Dec 2017 11:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_internal methods to get/set thread name
Message-ID: <20171220115122.GF19986@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171220080832.2328-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20171220080832.2328-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00109.txt.bz2


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1709

Hi Mark,

A lot to discuss here.

First of all, can you please describe the scenario in which you'd want
to give a cygthread another name?  Why is the one given at
cygthread::create time not sufficient?

Also, why should we need another, non-standard way to read/write a
pthread name, other than pthread_getname_np/pthread_setname_np?  What is
that supposed to accomplish?  Is there really any real-world scenario
which you can't handle with the official entry points?

We really don't want to add more non-standard entry points than
absolutely necessary.  There are too many already, partially for
historic reasons.

On Dec 20 00:08, Mark Geisert wrote:
> Add support to cygwin_internal() for setting a cygthread name and getting=
 or setting a pthread name.  Also add support for getting the internal i/o =
handle for a given file descriptor.

Can you please break the log message in lines <=3D 72 chars?

> @@ -710,6 +743,14 @@ cygwin_internal (cygwin_getinfo_types t, ...)
>  	}
>  	break;
>=20=20
> +      case CW_GET_IO_HANDLE_FROM_FD:
> +	{
> +	  int fd =3D va_arg(arg, int);
> +	  fhandler_base *fh =3D cygheap->fdtab[fd];
> +	  res =3D (uintptr_t) (fh->get_io_handle ());
> +	}
> +	break;
> +
>        default:
>  	set_errno (ENOSYS);
>      }

Nope, we won't do that.  The functionality is already available via
_get_osfhandle included via <io.h>.

Also, note that this is, and always will be a kludge.  There are
scenarios in which more than one handle is attached to a descriptor
(e.g., ptys) and the function will return only one.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaOk65AAoJEPU2Bp2uRE+gPg0P/Rt2caeWxICD2vvbvMQ0POmk
d7EwxV4WAY0w/3BmknUadjJSEKzGJwdWX9QJxMLqOpf8WUrRe1kmEJnojLWG+TGP
6gqklLpXZdalpKhA2+fFNmeiehr2hwxMY4Hib3u3Gvy/U/LT8xIVQlB6oEtqzRcC
EBoIs8Axik4siljHyfeldPZI+7gQ8G2IHKvWpeDN6dOVjk95uYBPvCnIEWQMwL8B
IiQqWjYiT59slcfranEFl4GaoTXUjSPBau2DSyh4r0Ifj9I4cj31IJoEdGDoKPUK
Bg1ZGKamevXzRr941AROwRyX1FLJTZmDKHE1Hw/MTgeuZoPUsHcOBtYuIxymxtK5
Fj9/MTAKUqKEmz3Fx7M32/KBuiQmaQR3E6peeXC+TbEAHrLUyMfuc41eFd703rX8
V0F4IDEuBaCZ90OrRFWQWZ4uaoZ2gm+Frqvlg/U1kEPMneKOyPu0Bn93xXso+8Uq
h1EWGtBkAr7nQ3RLZBT9Ws0a/0H5MMdhgyAf2AklZQMuD/pNtCGLylYrqynZY/o5
6Oc2l59ejA+LoSD8H5qjvfg16gzQW6SWk8Iw/0G+RiERDX7g57TRQtl1ODpvFakV
ordKxGNYmu9NRD1q4i/TIK3pK+rxEYFg0w3A5crchyQ7A0o9Fopie2OlAUa7pP8g
im1/mtoDaEetICqcs67c
=gxYn
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
