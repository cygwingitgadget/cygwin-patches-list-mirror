Return-Path: <cygwin-patches-return-8079-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20523 invoked by alias); 30 Mar 2015 10:45:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20510 invoked by uid 89); 30 Mar 2015 10:45:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Mar 2015 10:45:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3AB8DA80982; Mon, 30 Mar 2015 12:45:07 +0200 (CEST)
Date: Mon, 30 Mar 2015 10:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: add GNU basename(3)
Message-ID: <20150330104507.GI29875@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427347509-7940-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <1427347509-7940-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00034.txt.bz2


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 480

On Mar 26 00:25, Yaakov Selkowitz wrote:
> winsup/cygwin/
> * common.din (__gnu_basename): Export.
> * path.cc (__gnu_basename): New function.
>=20
> winsup/doc/
> * posix.xml (std-gnu): Add basename.
> (std-notes): Add note about two forms of basename.

Patch is ok.  Please apply after applying the newlib patch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGSkzAAoJEPU2Bp2uRE+gK0sQAKNcshQmwFykRsdZjTdI8YdV
0QIZYZDFDt9l3IaMlGZo9Ooi9dhl0XvGox2zCnaxWWDfbBmwXxdeajtQ1gFuP3NU
Y56td5cviAGAEDz3q81jyiK0L+Vd8Tr0yvPKJSIFckGA/iPn8Je893ADqAqPtjSh
jBeu2s1Sq36OCeC1mbuy5zfHh4LM9jg9siAlLqLk3R4lQj1WOyhu5CcSw9BO51/j
JgQUR7VZcCCXgSF7gO+gjp1DsC58XS7RXgjFtfldnRbzIch9Yd+98GtOr+FCkhJi
NDL+hMXzE+nnHKdn+hsSOs0jpVlR+u8QquFV1Lj1jS+huceKTCsRkF75SYQgc8UB
lNckUYHUYGnPikkgvAULHhtEpfo7QGDW0Syb9CXwpjHXHdGQJAJ32q3Zz+tVUnCB
s2yCo6OH+pNQ2R1MjJt9ymfgm24IHduWnD2CB3w/MTy2qUfRh7FYjyHkNKOMMvEJ
kCvHn8ZbTmYk+8s/IRdJVjztmeX51MifJcV5PYqpHxLKRlMqdAksTnhFuy+sdPYe
UUnkLOx+KWKGR/eGouHRT8YO4Ghzq7IbqPksJaaN80CPp50HxO+Cxjxm01lvH21M
Ne4zLtNIDfUhHmX6l4PfYxIvRRNGpS9W9t5ywlRg7KoH8IEtIeI5hoLzj/u6BkpD
FQJJLNHdkoTjRQMuD54M
=5tF8
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
